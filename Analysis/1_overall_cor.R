### this is the script to calculate correlation between pfc and blood data among all cpgs
library(pathwayPCA)
#1. read data 
pfcResidual <- readRDS("Data/Clean/pfcResidual.RDS")
bloodResidual <- readRDS("Data/Clean/bloodResidual.RDS")

pfcResidual_t <- TransposeAssay(pfcResidual, omeNames = "rowNames")
bloodResidual_t <- TransposeAssay(bloodResidual, omeNames = "rowNames")

#2. write the function to calculate correlation
cpg_corr <- function(CpG1, CpG2, meth = "spearman") {
  corr <- cor.test(CpG1, CpG2, method = meth)
  data.frame(Spearman = corr$estimate, 
    pVal = corr$p.value
  )
}

#3. set parallel parameters
library(parallel)
totalCores <- parallel::detectCores(logical = FALSE)
threads <- totalCores - 4
cl <- makeCluster(threads)

clusterExport(cl, varlist = c("bloodResidual_t", "pfcResidual_t", "cpg_corr"))

#4. calculate cpg correlation
a1 <- Sys.time()
corrResSpear <- parLapply(cl, 1:ncol(bloodResidual_t), function(column) {
  cpg_corr(CpG1 = bloodResidual_t[,column], CpG2 = pfcResidual_t[,column])
})
Sys.time() - a1  # 1.044105 mins for 485k over 24 cores
stopCluster(cl)

correlation_df <- do.call(rbind, corrResSpear)
rownames(correlation_df) <- colnames(pfcResidual_t)
saveRDS(correlation_df, "Results/cpg_correlation_df.RDS")
