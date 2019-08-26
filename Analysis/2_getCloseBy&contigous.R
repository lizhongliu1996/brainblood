#### this is the script to get closebyCpGs and contiguous cpgs 
##1. load data
cpg_correlation <- readRDS("Data/Clean/cpg_correlation_df.RDS")
cpg.locations <- readRDS("Data/Intermediate/cpg.locations.RDS")

##2. get close by cpgs  
source('R/getCloseByCpGs.R')
CloseBy_df <- CloseByCpGs(
  cpg_corr_df = cpg_correlation, 
  cpg_locations_df = cpg.locations,
  maxGap = 250,
  clusterLength = 3
)

saveRDS(CloseBy_df,"Results/CloseBy_gap250_df.rds")

##3. get contiguous cpgs with given corr threshold
source('R/getContiguousCpGs.R')
contiguous_df <- ContiuCpGs(
  CloseByCpGs = CloseBy_df,
  threshold = 0.05,
  segment_length = 3,
  absolute = "FALSE"
)

saveRDS(contiguous_df,"Results/Contigus_thre0.05_length3_df.rds")

