** HEADER -----------------------------------------------------
**  DO-FILE METADATA
    //  algorithm name			0_master_cvd.do
    //  project:				BNR
    //  analysts:				Jacqueline CAMPBELL
    //  date first created      04-JUN-2019
    // 	date last modified	    04-JUN-2019
    //  algorithm task			Importing, merging CVD datasets
    //  status                  Completed
    //  objectve                To have one dataset for appraisal stats

    ** General algorithm set-up
    version 15
    clear all
    macro drop _all
    set more off

    ** Initialising the STATA log and allow automatic page scrolling
    capture {
            program drop _all
    	drop _all
    	log close
    	}

    ** Set working directories: this is for DATASET and LOGFILE import and export
    ** DATASETS to encrypted SharePoint folder
    local datapath "X:/The University of the West Indies/DataGroup - repo_data/data_p140"
    ** LOGFILES to unencrypted OneDrive folder (.gitignore set to IGNORE log files on PUSH to GitHub)
    local logpath X:/OneDrive - The University of the West Indies/repo_datagroup/repo_p140

    ** Close any open log file and open a new log file
    capture log close
    log using "`logpath'\0_master_p1appraisals_2019_cvd.smcl", replace
** HEADER -----------------------------------------------------

**************************************
** DATA PREPARATION  
**************************************
/*
	Process for generating appraisal stats and reports:
        (1) FIRST, don't forget to check raw data (excel) to ensure there are no blank ID fields:
                - pid (CF)
                - pidABS (ABS)
                - tid (TF)
                - aidpartial (has ony numeric values) (TF)
                - cfupdate (has ony numeric values) (TF)
		(2) Create datasets 
				dofile: 0_master_cvd
		(3) Analyse datasets 
				dofile: 1_figures_cvd
		(4) Output pdf report
				dofile: 2_pdf_cvd
 */
 
*********************
** CREATE DATASETS **
*********************

** 2018 CF
import excel using  "`datapath'\version01\1-input\2019-05-31_CF_2018_DMPC_AH.xlsx", firstrow
save "`datapath'\version01\2-working\2018_CF.dta" ,replace
clear

** 2019 CF
import excel using  "`datapath'\version01\1-input\2019-05-31_CF_2019_DMPC_AH.xlsx", firstrow
save "`datapath'\version01\2-working\2019_CF.dta" ,replace
clear

** 2018 ABS
import excel using  "`datapath'\version01\1-input\2019-05-31_ABS_2018_DMPC_AH.xlsx", firstrow
save "`datapath'\version01\2-working\2018_ABS.dta" ,replace
clear

** 2019 ABS
import excel using  "`datapath'\version01\1-input\2019-05-31_ABS_2019_DMPC_AH.xlsx", firstrow
save "`datapath'\version01\2-working\2019_ABS.dta" ,replace
clear

** 2018 TF
import excel using  "`datapath'\version01\1-input\2019-06-04_TF_2018_DMPC_JC.xlsx", firstrow
save "`datapath'\version01\2-working\2018_TF.dta" ,replace
clear

** 2019 TF
import excel using  "`datapath'\version01\1-input\2019-06-04_TF_2019_DMPC_JC.xlsx", firstrow
save "`datapath'\version01\2-working\2019_TF.dta" ,replace
clear


** 1st dofile: analyse data
do "`logpath'\1_figures_cvd.do"

** 2nd dofile: create pdf reports
do "`logpath'\2_pdf_cvd.do"
