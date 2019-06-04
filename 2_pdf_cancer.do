** HEADER -----------------------------------------------------
**  DO-FILE METADATA
    //  algorithm name			2_pdf_cancer.do
    //  project:				BNR
    //  analysts:				Jacqueline CAMPBELL
    //  date first created      30-MAY-2019
    // 	date last modified	    30-MAY-2019
    //  algorithm task			Generating cancer pdf reports
    //  status                  Completed
    //  objectve                To have pdf reports for appraisal stats by team, by DA

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
    log using "`logpath'\2_pdf_p1appraisals_2019_cancer.smcl", replace
** HEADER -----------------------------------------------------

** LOAD dataset
use "`datapath'\version02\2-working\2019_p1appraisals_cancer_PTTTST_stats.dta"

				***************************
				*	    PDF REPORT  	  *
				*	   QUANTITY: KWG 	  *
				***************************

putpdf clear
putpdf begin

//Create a paragraph
putpdf paragraph
putpdf text ("Quantity Report"), bold
putpdf paragraph
putpdf text ("Appraisal Period: 1"), font(Helvetica,10)
putpdf paragraph
putpdf text ("Date Prepared: 30 May 2019"),  font(Helvetica,10)
putpdf paragraph
putpdf text ("Prepared by: JC using Stata & main CR5"),  font(Helvetica,10)
putpdf paragraph
putpdf text ("KWG"), bgcolor("pink") font(Helvetica,10)
putpdf paragraph, halign(center)
putpdf text ("QUANTITY"), bold font(Helvetica,20,"blue")
putpdf paragraph
qui sum pttot
local sum : display %3.0f `r(sum)'
putpdf text ("TOTAL entered in Patient Table(PT): `sum'")
putpdf paragraph
qui sum ptkwg
local sum : display %3.0f `r(sum)'
putpdf text ("TOTAL entered in PT by KWG: `sum'")
putpdf paragraph
qui sum ptkwgper
local sum : display %2.0f `r(sum)'
putpdf text ("TOTAL entered in PT by KWG: `sum'%"), bold bgcolor("yellow")
putpdf paragraph
qui sum ptuptot
local sum : display %3.0f `r(sum)'
putpdf text ("TOTAL updated in Patient Table(PT): `sum'")
putpdf paragraph
qui sum ptupkwg
local sum : display %3.0f `r(sum)'
putpdf text ("TOTAL updated in PT by KWG: `sum'")
putpdf paragraph
qui sum ptupkwgper
local sum : display %2.0f `r(sum)'
putpdf text ("TOTAL updated in PT by KWG: `sum'%"), bold bgcolor("yellow")
putpdf paragraph
qui sum tttot
local sum : display %3.0f `r(sum)'
putpdf text ("TOTAL entered in Tumour Table(TT): `sum'")
putpdf paragraph
qui sum ttkwg
local sum : display %3.0f `r(sum)'
putpdf text ("TOTAL entered in TT by KWG: `sum'")
putpdf paragraph
qui sum ttkwgper
local sum : display %2.0f `r(sum)'
putpdf text ("TOTAL entered in TT by KWG: `sum'%"), bold bgcolor("yellow")
putpdf paragraph
qui sum ttuptot
local sum : display %3.0f `r(sum)'
putpdf text ("TOTAL updated in Tumour Table(TT): `sum'")
putpdf paragraph
qui sum ttupkwg
local sum : display %3.0f `r(sum)'
putpdf text ("TOTAL updated in TT by KWG: `sum'")
putpdf paragraph
qui sum ttupkwgper
local sum : display %2.0f `r(sum)'
putpdf text ("TOTAL updated in TT by KWG: `sum'%"), bold bgcolor("yellow")
putpdf paragraph
qui sum sttot
local sum : display %3.0f `r(sum)'
putpdf text ("TOTAL entered in Source Table(ST): `sum'")
putpdf paragraph
qui sum stkwg
local sum : display %3.0f `r(sum)'
putpdf text ("TOTAL entered in ST by KWG: `sum'")
putpdf paragraph
qui sum stkwgper
local sum : display %2.0f `r(sum)'
putpdf text ("TOTAL entered in ST by KWG: `sum'%"), bold bgcolor("yellow")
putpdf paragraph

putpdf save "`datapath'\version02\3-output\2019-05-30_P1_2019_quantKWG.pdf", replace
putpdf clear


				***************************
				*	    PDF REPORT  	  *
				*	   QUANTITY: TH 	  *
				***************************

putpdf clear
putpdf begin

//Create a paragraph
putpdf paragraph
putpdf text ("Quantity Report"), bold
putpdf paragraph
putpdf text ("Appraisal Period: 1"), font(Helvetica,10)
putpdf paragraph
putpdf text ("Date Prepared: 30 May 2019"),  font(Helvetica,10)
putpdf paragraph
putpdf text ("Prepared by: JC using Stata & main CR5"),  font(Helvetica,10)
putpdf paragraph
putpdf text ("TH"), bgcolor("pink") font(Helvetica,10)
putpdf paragraph, halign(center)
putpdf text ("QUANTITY"), bold font(Helvetica,20,"blue")
putpdf paragraph
qui sum pttot
local sum : display %3.0f `r(sum)'
putpdf text ("TOTAL entered in Patient Table(PT): `sum'")
putpdf paragraph
qui sum ptth
local sum : display %3.0f `r(sum)'
putpdf text ("TOTAL entered in PT by TH: `sum'")
putpdf paragraph
qui sum ptthper
local sum : display %2.0f `r(sum)'
putpdf text ("TOTAL entered in PT by TH: `sum'%"), bold bgcolor("yellow")
putpdf paragraph
qui sum ptuptot
local sum : display %3.0f `r(sum)'
putpdf text ("TOTAL updated in Patient Table(PT): `sum'")
putpdf paragraph
qui sum ptupth
local sum : display %3.0f `r(sum)'
putpdf text ("TOTAL updated in PT by TH: `sum'")
putpdf paragraph
qui sum ptupthper
local sum : display %2.0f `r(sum)'
putpdf text ("TOTAL updated in PT by TH: `sum'%"), bold bgcolor("yellow")
putpdf paragraph
qui sum tttot
local sum : display %3.0f `r(sum)'
putpdf text ("TOTAL entered in Tumour Table(TT): `sum'")
putpdf paragraph
qui sum ttth
local sum : display %3.0f `r(sum)'
putpdf text ("TOTAL entered in TT by TH: `sum'")
putpdf paragraph
qui sum ttthper
local sum : display %2.0f `r(sum)'
putpdf text ("TOTAL entered in TT by TH: `sum'%"), bold bgcolor("yellow")
putpdf paragraph
qui sum ttuptot
local sum : display %3.0f `r(sum)'
putpdf text ("TOTAL updated in Tumour Table(TT): `sum'")
putpdf paragraph
qui sum ttupth
local sum : display %3.0f `r(sum)'
putpdf text ("TOTAL updated in TT by TH: `sum'")
putpdf paragraph
qui sum ttupthper
local sum : display %2.0f `r(sum)'
putpdf text ("TOTAL updated in TT by TH: `sum'%"), bold bgcolor("yellow")
putpdf paragraph
qui sum sttot
local sum : display %3.0f `r(sum)'
putpdf text ("TOTAL entered in Source Table(ST): `sum'")
putpdf paragraph
qui sum stth
local sum : display %3.0f `r(sum)'
putpdf text ("TOTAL entered in ST by TH: `sum'")
putpdf paragraph
qui sum stthper
local sum : display %2.0f `r(sum)'
putpdf text ("TOTAL entered in ST by TH: `sum'%"), bold bgcolor("yellow")
putpdf paragraph

putpdf save "`datapath'\version02\3-output\2019-05-30_P1_2019_quantTH.pdf", replace
putpdf clear


save "`datapath'\version02\3-output\2019_p1appraisals_cancer_pdf.dta" ,replace
label data "BNR-Cancer Appraisal Report"
notes _dta :These data prepared for 2019 Period 1 (Jan-Jun) Appraisal
