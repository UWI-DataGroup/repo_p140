** HEADER -----------------------------------------------------
**  DO-FILE METADATA
    //  algorithm name			0_master_cvd.do
    //  project:				BNR
    //  analysts:				Jacqueline CAMPBELL
    //  date first created      30-MAY-2019
    // 	date last modified	    30-MAY-2019
    //  algorithm task			Importing, merging cancer datasets
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
    log using "`logpath'\0_master_p1appraisals_2019_cancer.smcl", replace
** HEADER -----------------------------------------------------

/*
 To prepare cancer datasets:
 (1) import into excel the .txt files exported from CanReg5 and change the format from General to Text for the below fields in excel:
		- TumourIDSourceTable
		- SourceRecordID
		- STDataAbstractor
		- NFType
		- STReviewer
		- TumourID
		- PatientIDTumourTable
		- TTDataAbstractor
		- Parish
		- Topography
		- TTReviewer
		- RegistryNumber
		- PTDataAbstractor
		- PatientRecordID
		- RetrievalSource
		- FurtherRetrievalSource
		- PTReviewer
 (2) import the .xlsx file into Stata and save dataset in Stata
*/
import excel using "`datapath'\version02\1-input\2019-05-30_MAIN Exported Patient_excel_JC.xlsx", firstrow
save "`datapath'\version02\2-working\2019_p1appraisals_cancer_PT.dta" ,replace
clear

import excel using "`datapath'\version02\1-input\2019-05-30_MAIN Exported Tumour_excel_JC.xlsx", firstrow
save "`datapath'\version02\2-working\2019_p1appraisals_cancer_TT.dta" ,replace
clear

import excel using "`datapath'\version02\1-input\2019-05-30_MAIN Exported Source_excel_JC.xlsx", firstrow
save "`datapath'\version02\2-working\2019_p1appraisals_cancer_ST.dta" ,replace
clear

** 1st dofile: analyse data
do "`logpath'\1_figures_cancer.do"

** 2nd dofile: create pdf reports
do "`logpath'\2_pdf_cancer.do"
