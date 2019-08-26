##### this is a function to get identifying contiguous regions with given correlation threshold
##### it returns a df with high correlation contiguous segments
library(bumphunter)
ContiuCpGs <- function(CloseByCpGs, threshold, segment_length,
                      absolute = FALSE){
  
  ##filter by correlation threhold values
  if (absolute == "FALSE"){
    CloseByCpGs$keep <- ifelse(CloseByCpGs$pVal <= threshold, 1, 0)
  } else {
    CloseByCpGs$keep <- ifelse(abs(CloseByCpGs$pVal) >= threshold, 1, 0)
  }
  
  CloseByCpGs$int <- 1:nrow(CloseByCpGs)
  
  ##use function getSegment to identify contiguous regions
  Segment <- getSegments(
    CloseByCpGs$keep,
    f = CloseByCpGs$cluster,
    cutoff = 1
  )
  
  #fliter >= n cpgs, find cluster number
  seg <- Segment$upIndex
  num <- which(lengths(seg) >= segment_length)
  segment_fliter <- seg[num]
  names(segment_fliter) <- num
  
  #### match
  Contigous_segment <- NULL
  for(i in 1:length(segment_fliter)){
    we <- segment_fliter[[i]]
    g <- CloseByCpGs$int %in% we
    goo <- CloseByCpGs[g,]
    goo <- list(goo)
    names(goo) <- c(paste0("segment",i))
    Contigous_segment <- rbind(Contigous_segment,goo)
  }
  Contigous <- do.call(rbind, Contigous_segment)
  
  ###change cluster number
  asdf <- split(Contigous, Contigous$cluster)
  for(i in 1:length(asdf)){
    asdf[[i]]$cluster<-i
  }
  Contigous <- do.call(rbind,asdf)
  
  contigous_segments <- Contigous[c("Spearman", "pVal", "cpg", "chr", "mapinfo", "cluster")]
  
  rownames(contigous_segments) <- NULL
  
  contigous_segments
}