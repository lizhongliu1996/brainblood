##### this is a function to get identifying contiguous regions with given max gap
library(bumphunter)
library(dplyr)

CloseByCpGs <- function(cpg_corr_df, cpg_locations_df, maxGap, clusterLength){
  
  ##1. merge correlation with location
  cpg_corr_df$cpg <- rownames(cpg_corr_df)
  cpg_locations_df$cpg <- as.character(cpg_locations_df$cpg)
  
  cpg_corr_loci_df <- left_join(
    cpg_corr_df, 
    cpg_locations_df, 
    by="cpg"
  )
    
  cpg_corr_loci_df <- cpg_corr_loci_df[order(cpg_corr_loci_df$chr, cpg_corr_loci_df$mapinfo),]
  
  #remove na
  cpg_corr_loci_df <- cpg_corr_loci_df[complete.cases(cpg_corr_loci_df), ]
  
  ##2. use makecluster to get close by cpgs
  cpg_corr_loci_df$cluster <- clusterMaker(cpg_corr_loci_df$chr, cpg_corr_loci_df$mapinfo, maxGap = maxGap)
  
  #subset cluster >= 3 cpgs
  count <- as.data.frame(table(cpg_corr_loci_df$cluster))
  logic <- count$Freq >= clusterLength
  count_sub <- count[logic, ]
  row <- as.numeric(as.character(count_sub$Var1))
  bool <- cpg_corr_loci_df$cluster %in% row
  cpg_corr_loci_subset_df <- cpg_corr_loci_df[bool,]
  rownames(cpg_corr_loci_subset_df) <- NULL
  
  cpg_corr_loci_subset_df
}