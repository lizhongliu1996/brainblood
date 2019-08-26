raw data is located at Raw folder, processing data is located at intergenic folder,
processed data is located at Clean folder, r script of how to get clean data 
from raw data is located at Scripts folder.
The GSE43414 csv file is downloaded at
 "https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE43414"
the phenotype data is the same as GSE59685

Run scripts 1_split_data.R to get dasen_pfc and blood data in intermediate folder
Run scripts 2_cal_celltype.R to get pfc_pron and blood_pron in intermediate folder
Run scripts 3_removeEffects.R to get pfcResidual and bloodResidual in Clean folder