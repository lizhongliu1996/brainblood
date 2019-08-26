library(lmerTest)
region <- c("ISLAND", "NSHORE", "NSHELF", "SSHORE", "SSHELF",
            "TSS1500", "TSS200", "UTR5", "EXON1", "GENEBODY", "UTR3")
DataPath <- "Results/coMethAllRegions/"

# 1. read data 
pfcResidual <- readRDS("~/brainblood/Data/Clean/pfcResidual.RDS")
bloodResidual <- readRDS("~/brainblood/Data/Clean/bloodResidual.RDS")

# 2.compute median methylation for each coMethylated cluster
for(i in 1:11){
  regiontype <- region[i]
  pfcList <- readRDS(paste0(DataPath,"pfc_CoRegion-",regiontype,".rds"))
  cpgName <- unlist(pfcList)
  pfcWithinCoRegion <- pfcResidual[cpgName,]
  pfcCoRegionMedian <- apply(pfcWithinCoRegion,2,median)
  saveRDS(pfcCoRegionMedian, paste0(DataPath,"pfcCoRegionMedian-",regiontype,".rds"))
}

# 3.for each blood co-methylated cluster that overlaps with a brain 
# co-methylation cluster, run the coMeth_randCoef model
for(i in 1:11){
  regiontype <- region[i]
  overlapList <- readRDS(paste0(DataPath,"overlap_cluster-",regiontype,".rds"))
  cpgName <- unlist(overlapList)
  bloodOverlap <- bloodResidual[cpgName,]
  bloodOverlap$phenoID <- rownames(bloodOverlap)
  
  pfcMedian <- readRDS(paste0(DataPath,"pfcCoRegionMedian-",regiontype,".rds"))
  pfcMedian_df <- data.frame(Sample = names(pfcMedian), median = pfcMedian)
  rownames(pfcMedian) <- "pfcMedian"
  
  ##reshape data
  bloodTransp_df <- reshape(
    bloodOverlap,
    varying = colnames(bloodOverlap)[-ncol(bloodOverlap)],
    v.names = "beta",
    direction = "long",
    times = colnames(bloodOverlap)[-ncol(bloodOverlap)],
    timevar = "Sample"
  )
  
  #### try to merge blood with pfc with different sample names based on csv file below
  pfc_blood_stage_samples <- read.csv("Data/Raw/pfc.blood.stage.samples.csv")
  bloodPheno_df <- merge(bloodTransp_df, pfcMedian_df, by = "Sample")
  
  apply(bloodPFC_Overall, 2, function(x){
    lmer(,data = )
    }
  
    
    )
  
}