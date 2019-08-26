###### This is a file to introduce the work flow of brain blood project.


### Preprocess ###

 1. First we download data from GSE43414 GEO, including dasen normalization 
    mvalue and pheno data, also including the cg probe annotation file from 
    UCSC and we match pfc sample with blood data, they all located in 
    "Data/Raw folder"
 2. Then we spilt data from Data/Raw folder from giant matrix, running 
    "1_split_data" from "Data/Scripts" folder subset to it into two files: 
    dasen_pfc_df and dasen_blood_df in "Data/Intermediate" folder
 3. Running "2_cal_celltype" from "Data/Scripts" folder to get celltype 
    proportion of pfc and blood, they are in "Data/Intermediate" folder
    named "blood_prop_RPC" and "pfc_prop_neurons" 
 4. Running "3_removeEffects" from "Data/Scripts" to remove confounder effects
    of brain and blood Mvalue, calculated residuals are at "Data/Clean" folder


### Analysis ###

 1. Run scripts "1_overall_cor" from Analysis folder to calculate correlation
    between pfc and blood, results are at "Results/cpg_cirrelation_df"
 2. Run scripts "2_getCloseBy&contigous" from Analysis folder which use two
    functions from R folder: "getCloseByCpGs" and "getContiguousCpGs" which use
    wrappers fuction "clusterMaker" and "getSegment" from package bumphunter to get
    closeBy cpg and contiguous cpg cluster, results are at Results folder, 
    which are "CloseBy_gap250_df" and "Contigus_thre0.05_length3_df"
 3. Run scripts "3_1_coMeth_regions" from Analysis folder, which use function 
  coMethAllRegions from CoMethDMR package to find cluster for pfc and blood,
    also find the overlap cgs between those two, results are at 
    "Results/coMethAllRegions" folder.
 4. Run scripts "3_2_coMeth_regions" from Analysis folder, which calculate 
    first calculate pfc median cluster mvalue and then use the overlap cg 
    blood value to fit the randCoef Model: BloodMvalues ~ medianBrainMvalues
