### this is the script that use comethDMR to select co-methylated clusters 
library(coMethDMR)
region <- c("ISLAND", "NSHORE", "NSHELF", "SSHORE", "SSHELF",
            "TSS1500", "TSS200", "UTR5", "EXON1", "GENEBODY", "UTR3")
DataPath <- "Results/coMethAllRegions/"
#1. read data 
pfcResidual <- readRDS("Data/Clean/pfcResidual.RDS")
bloodResidual <- readRDS("Data/Clean/bloodResidual.RDS")

#2. find co-methylated clusters for pfc samples
for(i in 1:11){
  regiontype <- region[i]
  # a <- Sys.time()
  pfc_CoRegion <- CoMethAllRegions (
    betaMatrix = pfcResidual,
    method = "spearman",
    regionType = regiontype,
    arrayType = "450k",
    returnAllCpGs = FALSE
  )
  # Sys.time() - a 
  # Time difference of 55.85305 mins
  saveRDS(pfc_CoRegion,paste0(DataPath,"pfc_CoRegion-",regiontype,".rds"))
}

#3. find co-methylated clusters for blood samples
for(i in 1:11) {
  regiontype <- region[i]
  # b <- Sys.time()
  blood_CoRegion <- CoMethAllRegions (
    betaMatrix = bloodResidual,
    method = "spearman",
    regionType = regiontype,
    arrayType = "450k",
    returnAllCpGs = FALSE
  )
  # Sys.time() - b 
  # Time difference of 56.35012 mins
  saveRDS(blood_CoRegion,paste0(DataPath,"blood_CoRegion-",regiontype,".rds"))
}

#4. Match each blood co-methylation cluster with brain co-methylation cluster
for (i in 1:11){
  regiontype <- region[i]
  pfcList <- readRDS(paste0(DataPath,"pfc_CoRegion-",regiontype,".rds"))
  bloodList <- readRDS(paste0(DataPath,"blood_CoRegion-",regiontype,".rds"))
  overlap <- intersect(pfcList, bloodList)
  ###intersect match elements by elements between two lists
  names(overlap) <- intersect(names(pfcList), names(bloodList))
  saveRDS(overlap, paste0(DataPath,"overlap_cluster-",regiontype,".rds"))
}
