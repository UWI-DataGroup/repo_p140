** HEADER -----------------------------------------------------
**  DO-FILE METADATA
    //  algorithm name			1_figures_cancer.do
    //  project:				BNR
    //  analysts:				Jacqueline CAMPBELL
    //  date first created      30-MAY-2019
    // 	date last modified	    30-MAY-2019
    //  algorithm task			Analysing, creating cancer dataset
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
    log using "`logpath'\1_figures_p1appraisals_2019_cancer.smcl", replace
** HEADER -----------------------------------------------------


**************************************
** DATA PREPARATION  
**************************************
** LOAD the prepared dataset
use "`datapath'\version02\2-working\2019_p1appraisals_cancer_PT.dta" ,clear

**************************
** QUANTITY: PATIENT TABLE
** PERIOD 1 (JAN-JUN) 2019
**************************
rename RegistryNumber pid
rename PTDataAbstractor ptda
**rename PTCasefindingDate ptdoa
rename PatientUpdatedBy ptupda
**rename PatientUpdateDate ptupdate

drop if PTCasefindingDate==99999999
nsplit PTCasefindingDate, digits(4 2 2) gen(ptdoayear ptdoamonth ptdoaday)
gen ptdoa=mdy(ptdoamonth, ptdoaday, ptdoayear)
format ptdoa %dD_m_CY
drop PTCasefindingDate ptdoayear ptdoamonth ptdoaday

drop if PatientUpdateDate==99999999|PatientUpdateDate==.
nsplit PatientUpdateDate, digits(4 2 2) gen(ptupdateyear ptupdatemonth ptupdateday)
gen ptupdate=mdy(ptupdatemonth, ptupdateday, ptupdateyear)
format ptupdate %dD_m_CY
drop PatientUpdateDate ptupdateyear ptupdatemonth ptupdateday

replace ptupda="13" if ptupda=="kirt"
replace ptupda="14" if ptupda=="tamisha"


** TOTAL records - PATIENT table
preserve
drop if ptdoa<d(01jan2019) | ptdoa>d(30jun2019)
contract pid ptda ptdoa, freq(count) percent(percentage)
total count //779
egen pttot=total(count)
egen ptkwg=total(count) if ptda=="13"
egen ptth=total(count) if ptda=="14"
collapse pttot ptkwg ptth
gen ptkwgper=ptkwg/pttot*100
gen ptthper=ptth/pttot*100
save "`datapath'\version02\2-working\2019_p1appraisals_cancer_PT_figs1.dta" ,replace
restore

** TOTAL updates - PATIENT table
preserve
drop if ptupdate<d(01jan2019) | ptupdate>d(30jun2019)
contract pid ptupda ptupdate, freq(count) percent(percentage)
total count //1749
egen ptuptot=total(count)
egen ptupkwg=total(count) if ptupda=="13"
egen ptupth=total(count) if ptupda=="14"
collapse ptuptot ptupkwg ptupth
gen ptupkwgper=ptupkwg/ptuptot*100
gen ptupthper=ptupth/ptuptot*100
save "`datapath'\version02\2-working\2019_p1appraisals_cancer_PT_figs2.dta" ,replace
restore

preserve
use "`datapath'\version02\2-working\2019_p1appraisals_cancer_PT_figs1.dta" ,replace
append using "`datapath'\version02\2-working\2019_p1appraisals_cancer_PT_figs2.dta"
collapse pttot ptkwg ptth ptkwgper ptthper ptuptot ptupkwg ptupth ptupkwgper ptupthper
save "`datapath'\version02\2-working\2019_p1appraisals_cancer_PT_stats.dta" ,replace
restore


**************************
** QUANTITY: TUMOUR TABLE
** PERIOD 1 (JAN-JUN) 2019
**************************
** LOAD the prepared dataset
use "`datapath'\version02\2-working\2019_p1appraisals_cancer_TT.dta" ,clear

rename TumourID tid
**rename UpdateDate ttupdate
rename TumourUpdatedBy ttupda
rename TTDataAbstractor ttda
**rename TTAbstractionDate ttdoa

drop if TTAbstractionDate==99999999
nsplit TTAbstractionDate, digits(4 2 2) gen(ttdoayear ttdoamonth ttdoaday)
gen ttdoa=mdy(ttdoamonth, ttdoaday, ttdoayear)
format ttdoa %dD_m_CY
drop TTAbstractionDate ttdoayear ttdoamonth ttdoaday

drop if UpdateDate==99999999|UpdateDate==.
nsplit UpdateDate, digits(4 2 2) gen(ttupdateyear ttupdatemonth ttupdateday)
gen ttupdate=mdy(ttupdatemonth, ttupdateday, ttupdateyear)
format ttupdate %dD_m_CY
drop UpdateDate ttupdateyear ttupdatemonth ttupdateday

replace ttupda="13" if ttupda=="kirt"
replace ttupda="14" if ttupda=="tamisha"


** TOTAL records - TUMOUR table
preserve
drop if ttdoa<d(01jan2019) | ttdoa>d(30jun2019)
contract tid ttda ttdoa, freq(count) percent(percentage)
total count //758
egen tttot=total(count)
egen ttkwg=total(count) if ttda=="13"
egen ttth=total(count) if ttda=="14"
collapse tttot ttkwg ttth
gen ttkwgper=ttkwg/tttot*100
gen ttthper=ttth/tttot*100
save "`datapath'\version02\2-working\2019_p1appraisals_cancer_TT_figs1.dta" ,replace
restore

** TOTAL updates - TUMOUR table
preserve
drop if ttupdate<d(01jan2019) | ttupdate>d(30jun2019)
contract tid ttupda ttupdate, freq(count) percent(percentage)
total count //1915
egen ttuptot=total(count)
egen ttupkwg=total(count) if ttupda=="13"
egen ttupth=total(count) if ttupda=="14"
collapse ttuptot ttupkwg ttupth
gen ttupkwgper=ttupkwg/ttuptot*100
gen ttupthper=ttupth/ttuptot*100
save "`datapath'\version02\2-working\2019_p1appraisals_cancer_TT_figs2.dta" ,replace
restore

preserve
use "`datapath'\version02\2-working\2019_p1appraisals_cancer_TT_figs1.dta" ,replace
append using "`datapath'\version02\2-working\2019_p1appraisals_cancer_TT_figs2.dta"
collapse tttot ttkwg ttth ttkwgper ttthper ttuptot ttupkwg ttupth ttupkwgper ttupthper
save "`datapath'\version02\2-working\2019_p1appraisals_cancer_TT_stats.dta" ,replace
restore

**************************
** QUANTITY: SOURCE TABLE
** PERIOD 1 (JAN-JUN) 2019
**************************
** LOAD the prepared dataset
use "`datapath'\version02\2-working\2019_p1appraisals_cancer_ST.dta" ,clear

rename SourceRecordID sid
rename STDataAbstractor stda
**rename STSourceDate stdoa

drop if STSourceDate==99999999
nsplit STSourceDate, digits(4 2 2) gen(stdoayear stdoamonth stdoaday)
gen stdoa=mdy(stdoamonth, stdoaday, stdoayear)
format stdoa %dD_m_CY
drop STSourceDate stdoayear stdoamonth stdoaday


** TOTAL records - SOURCE table
preserve
drop if stdoa<d(01jan2019) | stdoa>d(30jun2019)
contract sid stda stdoa, freq(count) percent(percentage)
total count //1282
egen sttot=total(count)
egen stkwg=total(count) if stda=="13"
egen stth=total(count) if stda=="14"
collapse sttot stkwg stth
gen stkwgper=stkwg/sttot*100
gen stthper=stth/sttot*100
save "`datapath'\version02\2-working\2019_p1appraisals_cancer_ST_stats.dta" ,replace
restore


** Create one dataset with totals for PATIENT, TUMOUR, SOURCE tables
preserve
use "`datapath'\version02\2-working\2019_p1appraisals_cancer_PT_stats.dta" ,replace
append using "`datapath'\version02\2-working\2019_p1appraisals_cancer_TT_stats.dta"
append using "`datapath'\version02\2-working\2019_p1appraisals_cancer_ST_stats.dta"
collapse pttot ptkwg ptth ptkwgper ptthper ptuptot ptupkwg ptupth ptupkwgper ptupthper ///
		 tttot ttkwg ttth ttkwgper ttthper ttuptot ttupkwg ttupth ttupkwgper ttupthper ///
		 sttot stkwg stth stkwgper stthper
save "`datapath'\version02\2-working\2019_p1appraisals_cancer_PTTTST_stats.dta" ,replace
restore
