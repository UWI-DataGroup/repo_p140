** HEADER -----------------------------------------------------
**  DO-FILE METADATA
    //  algorithm name			1_figures_cvd.do
    //  project:				BNR
    //  analysts:				Jacqueline CAMPBELL
    //  date first created      04-JUN-2019
    // 	date last modified	    04-JUN-2019
    //  algorithm task			Analysing, creating CVD dataset
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
    log using "`logpath'\1_figures_p1appraisals_2019_cvd.smcl", replace
** HEADER -----------------------------------------------------


**************************
** QUANTITY: CF datasets
** PERIOD 1 (JAN-JUN) 2019
**************************
** Create 2018 & 2019 CF dataset
use "`datapath'\version01\2-working\2018_CF" ,clear
rename pid pid2018
gen dbyr=2018

append using "`datapath'\version01\2-working\2019_CF", keep(pid cfdoa cfda)
rename pid pid2019
replace dbyr=2019 if dbyr==.

** TOTAL records - CF (casefinding) table
preserve
drop if pid2018 <3 | pid2019 <3
drop if cfdoa<d(01jan2019) | cfdoa>d(30jun2019)
contract pid2018 pid2019 cfda cfdoa dbyr, freq(count) percent(percentage)
total count //968
egen cftot=total(count)
egen cfcs=total(count) if cfda==17
egen cfarob=total(count) if cfda==18
egen cfmf=total(count) if cfda==19
egen cfnr=total(count) if cfda==20
collapse cftot cfcs cfarob cfmf cfnr
gen cfcsper=cfcs/cftot*100
gen cfarobper=cfarob/cftot*100
gen cfmfper=cfmf/cftot*100
gen cfnrper=cfnr/cftot*100
save "`datapath'\version01\2-working\cvd_CF_figs1.dta" ,replace
restore


**************************
** QUANTITY: ABS datasets
** PERIOD 1 (JAN-JUN) 2019
**************************
** Create 2018 & 2019 ABS dataset
use "`datapath'\version01\2-working\2018_ABS" ,clear
rename pidABS pidABS2018
gen dbyr=2018

append using "`datapath'\version01\2-working\2019_ABS", keep(pidABS adoa absda ddoa dda fu1doa fu1da sfu1date hfu1date fu1day fu2doa fu2da sfu2date hfu2date fu2day)
rename pidABS pidABS2019
replace dbyr=2019 if dbyr==.

** TOTAL records - ABS (abstracting) table
preserve
drop if pidABS2018 <3 | pidABS2019 <3
drop if adoa<d(01jan2019) | adoa>d(30jun2019)
contract pidABS2018 pidABS2019 absda adoa dbyr, freq(count) percent(percentage)
total count //409
egen abstot=total(count)
egen abscs=total(count) if absda==17
egen absarob=total(count) if absda==18
egen absmf=total(count) if absda==19
egen absnr=total(count) if absda==20
collapse abstot abscs absarob absmf absnr
gen abscsper=abscs/abstot*100
gen absarobper=absarob/abstot*100
gen absmfper=absmf/abstot*100
gen absnrper=absnr/abstot*100
save "`datapath'\version01\2-working\cvd_ABS1_figs1.dta" ,replace
restore

** TOTAL records - DIS (discharge) table
preserve
drop if pidABS2018 <3 | pidABS2019 <3
drop if ddoa<d(01jan2019) | ddoa>d(30jun2019)
contract pidABS2018 pidABS2019 dda ddoa dbyr, freq(count) percent(percentage)
total count //392
egen distot=total(count)
egen discs=total(count) if dda==17
egen disarob=total(count) if dda==18
egen dismf=total(count) if dda==19
egen disnr=total(count) if dda==20
collapse distot discs disarob dismf disnr
gen discsper=discs/distot*100
gen disarobper=disarob/distot*100
gen dismfper=dismf/distot*100
gen disnrper=disnr/distot*100
save "`datapath'\version01\2-working\cvd_DIS_figs1.dta" ,replace
restore

** TOTAL records - FU 1 (28-d follow up) table
preserve
drop if pidABS2018 <3 | pidABS2019 <3
drop if fu1doa<d(01jan2019) | fu1doa>d(30jun2019)
contract pidABS2018 pidABS2019 fu1doa fu1da sfu1date hfu1date fu1day dbyr, freq(count) percent(percentage)
total count //284
egen fu1tot=total(count)
egen fu1mf=total(count) if fu1da==19
egen fu1timetot=count(fu1da) if fu1doa!=. & sfu1date!=. & fu1doa > d(31dec2018) & fu1doa < d(01jul2019) & fu1doa <= sfu1date ///
		| fu1doa!=. & sfu1date!=. & fu1doa > d(31dec2018) & fu1doa < d(01jul2019) & fu1doa-1==sfu1date ///
		| fu1doa!=. & sfu1date!=. & fu1doa > d(31dec2018) & fu1doa < d(01jul2019) & fu1doa-2==sfu1date ///
		| fu1doa!=. & sfu1date!=. & fu1doa > d(31dec2018) & fu1doa < d(01jul2019) & fu1doa+1==sfu1date ///
		| fu1doa!=. & sfu1date!=. & fu1doa > d(31dec2018) & fu1doa < d(01jul2019) & fu1doa+2==sfu1date ///
		| fu1doa!=. & hfu1date!=. & fu1doa > d(31dec2018) & fu1doa < d(01jul2019) & fu1doa <= hfu1date ///
		| fu1doa!=. & hfu1date!=. & fu1doa > d(31dec2018) & fu1doa < d(01jul2019) & fu1doa-1==hfu1date ///
		| fu1doa!=. & hfu1date!=. & fu1doa > d(31dec2018) & fu1doa < d(01jul2019) & fu1doa-2==hfu1date ///
		| fu1doa!=. & hfu1date!=. & fu1doa > d(31dec2018) & fu1doa < d(01jul2019) & fu1doa+1==hfu1date ///
		| fu1doa!=. & hfu1date!=. & fu1doa > d(31dec2018) & fu1doa < d(01jul2019) & fu1doa+2==hfu1date
egen fu1timemf=count(fu1da) if fu1da==19 & fu1doa!=. & sfu1date!=. & fu1doa > d(31dec2018) & fu1doa < d(01jul2019) & fu1doa <= sfu1date ///
		| fu1doa!=. & sfu1date!=. & fu1doa > d(31dec2018) & fu1doa < d(01jul2019) & fu1doa-1==sfu1date ///
		| fu1doa!=. & sfu1date!=. & fu1doa > d(31dec2018) & fu1doa < d(01jul2019) & fu1doa-2==sfu1date ///
		| fu1doa!=. & sfu1date!=. & fu1doa > d(31dec2018) & fu1doa < d(01jul2019) & fu1doa+1==sfu1date ///
		| fu1doa!=. & sfu1date!=. & fu1doa > d(31dec2018) & fu1doa < d(01jul2019) & fu1doa+2==sfu1date ///
		| fu1doa!=. & hfu1date!=. & fu1doa > d(31dec2018) & fu1doa < d(01jul2019) & fu1doa <= hfu1date ///
		| fu1doa!=. & hfu1date!=. & fu1doa > d(31dec2018) & fu1doa < d(01jul2019) & fu1doa-1==hfu1date ///
		| fu1doa!=. & hfu1date!=. & fu1doa > d(31dec2018) & fu1doa < d(01jul2019) & fu1doa-2==hfu1date ///
		| fu1doa!=. & hfu1date!=. & fu1doa > d(31dec2018) & fu1doa < d(01jul2019) & fu1doa+1==hfu1date ///
		| fu1doa!=. & hfu1date!=. & fu1doa > d(31dec2018) & fu1doa < d(01jul2019) & fu1doa+2==hfu1date
egen fu1latetot=count(fu1day) if fu1day==2 & fu1doa > d(31dec2018) & fu1doa < d(01jul2019)
egen fu1latemf=count(fu1day) if fu1da==19 & fu1day==2 & fu1doa > d(31dec2018) & fu1doa < d(01jul2019)
collapse fu1tot fu1mf fu1timetot fu1timemf fu1latetot fu1latemf 
gen fu1mfper=fu1mf/fu1tot*100
gen fu1timemfper=fu1timemf/fu1mf*100
gen fu1latenummf=fu1mf-fu1timemf
gen fu1latemfper=fu1latemf/fu1latenummf*100
save "`datapath'\version01\2-working\cvd_FU1_figs1.dta" ,replace
restore

** TOTAL records - FU 2 (1-yr follow up) table
preserve
drop if pidABS2018 <3 | pidABS2019 <3
drop if fu2doa<d(01jan2019) | fu2doa>d(30jun2019)
contract pidABS2018 pidABS2019 fu2doa fu2da sfu2date hfu2date fu2day dbyr, freq(count) percent(percentage)
total count //237
egen fu2tot=total(count)
egen fu2mf=total(count) if fu2da==19
egen fu2timetot=count(fu2da) if fu2doa!=. & sfu2date!=. & fu2doa > d(31dec2018) & fu2doa < d(01jul2019) & fu2doa <= sfu2date ///
		| fu2doa!=. & sfu2date!=. & fu2doa > d(31dec2018) & fu2doa < d(01jul2019) & fu2doa-1==sfu2date ///
		| fu2doa!=. & sfu2date!=. & fu2doa > d(31dec2018) & fu2doa < d(01jul2019) & fu2doa-2==sfu2date ///
		| fu2doa!=. & sfu2date!=. & fu2doa > d(31dec2018) & fu2doa < d(01jul2019) & fu2doa+1==sfu2date ///
		| fu2doa!=. & sfu2date!=. & fu2doa > d(31dec2018) & fu2doa < d(01jul2019) & fu2doa+2==sfu2date ///
		| fu2doa!=. & hfu2date!=. & fu2doa > d(31dec2018) & fu2doa < d(01jul2019) & fu2doa <= hfu2date ///
		| fu2doa!=. & hfu2date!=. & fu2doa > d(31dec2018) & fu2doa < d(01jul2019) & fu2doa-1==hfu2date ///
		| fu2doa!=. & hfu2date!=. & fu2doa > d(31dec2018) & fu2doa < d(01jul2019) & fu2doa-2==hfu2date ///
		| fu2doa!=. & hfu2date!=. & fu2doa > d(31dec2018) & fu2doa < d(01jul2019) & fu2doa+1==hfu2date ///
		| fu2doa!=. & hfu2date!=. & fu2doa > d(31dec2018) & fu2doa < d(01jul2019) & fu2doa+2==hfu2date
egen fu2timemf=count(fu2da) if fu2da==19 & fu2doa!=. & sfu2date!=. & fu2doa > d(31dec2018) & fu2doa < d(01jul2019) & fu2doa <= sfu2date ///
		| fu2doa!=. & sfu2date!=. & fu2doa > d(31dec2018) & fu2doa < d(01jul2019) & fu2doa-1==sfu2date ///
		| fu2doa!=. & sfu2date!=. & fu2doa > d(31dec2018) & fu2doa < d(01jul2019) & fu2doa-2==sfu2date ///
		| fu2doa!=. & sfu2date!=. & fu2doa > d(31dec2018) & fu2doa < d(01jul2019) & fu2doa+1==sfu2date ///
		| fu2doa!=. & sfu2date!=. & fu2doa > d(31dec2018) & fu2doa < d(01jul2019) & fu2doa+2==sfu2date ///
		| fu2doa!=. & hfu2date!=. & fu2doa > d(31dec2018) & fu2doa < d(01jul2019) & fu2doa <= hfu2date ///
		| fu2doa!=. & hfu2date!=. & fu2doa > d(31dec2018) & fu2doa < d(01jul2019) & fu2doa-1==hfu2date ///
		| fu2doa!=. & hfu2date!=. & fu2doa > d(31dec2018) & fu2doa < d(01jul2019) & fu2doa-2==hfu2date ///
		| fu2doa!=. & hfu2date!=. & fu2doa > d(31dec2018) & fu2doa < d(01jul2019) & fu2doa+1==hfu2date ///
		| fu2doa!=. & hfu2date!=. & fu2doa > d(31dec2018) & fu2doa < d(01jul2019) & fu2doa+2==hfu2date
egen fu2latetot=count(fu2day) if fu2day==2 & fu2doa > d(31dec2018) & fu2doa < d(01jul2019)
egen fu2latemf=count(fu2day) if fu2da==19 & fu2day==2 & fu2doa > d(31dec2018) & fu2doa < d(01jul2019)
collapse fu2tot fu2mf fu2timetot fu2timemf fu2latetot fu2latemf 
gen fu2mfper=fu2mf/fu2tot*100
gen fu2timemfper=fu2timemf/fu2tot*100
gen fu2latenummf=fu2mf-fu2timemf
gen fu2latemfper=fu2latemf/fu2latenummf*100
save "`datapath'\version01\2-working\cvd_FU2_figs1.dta" ,replace
restore


preserve
use "`datapath'\version01\2-working\cvd_ABS1_figs1.dta" ,replace
append using "`datapath'\version01\2-working\cvd_DIS_figs1.dta"
append using "`datapath'\version01\2-working\cvd_FU1_figs1.dta"
append using "`datapath'\version01\2-working\cvd_FU2_figs1.dta"
collapse abstot abscs absarob absmf absnr abscsper absarobper absmfper absnrper ///
         distot discs disarob dismf disnr discsper disarobper dismfper disnrper ///
         fu1tot fu1mf fu1mfper fu1timetot fu1timemf fu1timemfper fu1latetot fu1latemf fu1latemfper ///
         fu2tot fu2mf fu2mfper fu2timetot fu2timemf fu2timemfper fu2latetot fu2latemf fu2latemfper
save "`datapath'\version01\2-working\cvd_ABS_figs1.dta" ,replace
restore


**************************
** QUANTITY: TF datasets
** PERIOD 1 (JAN-JUN) 2019
**************************
** Create 2018 & 2019 TF dataset
use "`datapath'\version01\2-working\2018_TF" ,clear
rename tid tid2018
gen dbyr=2018

append using "`datapath'\version01\2-working\2019_TF", keep(tid tda tdoa aidpartial cfupdate ///
         A1 A2 A3 A4 A5 A6 A7 A8 A9 A10 A11 A12 ///
         B1 B2 B3 B4 B5 B6 B7 B8 B9 B10 B11 B12 C1 C2 C3 C4 C5 C6 C7 C8 C9 C10 C11 C12 ///
         ae cunit drec hdu mrec sunit micu sicu ///
         wardadmbk wardrndbk wardnoterv wardbklog wardpabs wardfabs ///
         aebklogrv aenoterv aefabs aecdrv ///
         drnoterv drbklogrv drfabs drdisabs drcdrv drledger drdoabk ///
         mrbklogrv mrfabs mrdisabs mrcdrv mrdisnoterv)
rename tid tid2019
replace dbyr=2019 if dbyr==.

** TOTAL records - TF (tracking) table
preserve
drop if tid2018 <2 | tid2019 <2
drop if tdoa<d(01jan2019) | tdoa>d(30jun2019)
contract tid2018 tid2019 tda tdoa aidpartial cfupdate ///
         A1 A2 A3 A4 A5 A6 A7 A8 A9 A10 A11 A12 ///
         B1 B2 B3 B4 B5 B6 B7 B8 B9 B10 B11 B12 C1 C2 C3 C4 C5 C6 C7 C8 C9 C10 C11 C12 ///
         ae cunit drec hdu mrec sunit micu sicu ///
         wardadmbk wardrndbk wardnoterv wardbklog wardpabs wardfabs ///
         aebklogrv aenoterv aefabs aecdrv ///
         drnoterv drbklogrv drfabs drdisabs drcdrv drledger drdoabk ///
         mrbklogrv mrfabs mrdisabs mrcdrv mrdisnoterv ///
         dbyr, freq(count) percent(percentage)
total count //358
egen parttot=sum(aidpartial) if aidpartial!=. & aidpartial >0
egen partcs=sum(aidpartial) if tda==17 & aidpartial!=. & aidpartial >0
egen partarob=sum(aidpartial) if tda==18 & aidpartial!=. & aidpartial >0
egen partmf=sum(aidpartial) if tda==19 & aidpartial!=. & aidpartial >0
egen partnr=sum(aidpartial) if tda==20 & aidpartial!=. & aidpartial >0
egen cfuptot=sum(cfupdate) if cfupdate!=. & cfupdate >0
egen cfupcs=sum(cfupdate) if tda==17 & cfupdate!=. & cfupdate >0
egen cfuparob=sum(cfupdate) if tda==18 & cfupdate!=. & cfupdate >0
egen cfupmf=sum(cfupdate) if tda==19 & cfupdate!=. & cfupdate >0
egen cfupnr=sum(cfupdate) if tda==20 & cfupdate!=. & cfupdate >0
egen awardtot=count(A1) if A1=="Yes"|A2=="Yes"|A3=="Yes"|A4=="Yes"|A5=="Yes"|A6=="Yes"
egen awardcs=count(A1) if tda==17 & (A1=="Yes"|A2=="Yes"|A3=="Yes"|A4=="Yes"|A5=="Yes"|A6=="Yes")
egen awardarob=count(A1) if tda==18 & (A1=="Yes"|A2=="Yes"|A3=="Yes"|A4=="Yes"|A5=="Yes"|A6=="Yes")
egen awardmf=count(A1) if tda==19 & (A1=="Yes"|A2=="Yes"|A3=="Yes"|A4=="Yes"|A5=="Yes"|A6=="Yes")
egen awardnr=count(A1) if tda==20 & (A1=="Yes"|A2=="Yes"|A3=="Yes"|A4=="Yes"|A5=="Yes"|A6=="Yes")
egen bwardtot=count(B3) if B3=="Yes"|B4=="Yes"|B5=="Yes"|B6=="Yes"|B7=="Yes"|B8=="Yes"
egen bwardcs=count(B3) if tda==17 & (B3=="Yes"|B4=="Yes"|B5=="Yes"|B6=="Yes"|B7=="Yes"|B8=="Yes")
egen bwardarob=count(B3) if tda==18 & (B3=="Yes"|B4=="Yes"|B5=="Yes"|B6=="Yes"|B7=="Yes"|B8=="Yes")
egen bwardmf=count(B3) if tda==19 & (B3=="Yes"|B4=="Yes"|B5=="Yes"|B6=="Yes"|B7=="Yes"|B8=="Yes")
egen bwardnr=count(B3) if tda==20 & (B3=="Yes"|B4=="Yes"|B5=="Yes"|B6=="Yes"|B7=="Yes"|B8=="Yes")
egen cwardtot=count(C5) if C5=="Yes"|C6=="Yes"|C8=="Yes"|C9=="Yes"|C10=="Yes"|C11=="Yes"|C12=="Yes"
egen cwardcs=count(C5) if tda==17 & (C5=="Yes"|C6=="Yes"|C8=="Yes"|C9=="Yes"|C10=="Yes"|C11=="Yes"|C12=="Yes")
egen cwardarob=count(C5) if tda==18 & (C5=="Yes"|C6=="Yes"|C8=="Yes"|C9=="Yes"|C10=="Yes"|C11=="Yes"|C12=="Yes")
egen cwardmf=count(C5) if tda==19 & (C5=="Yes"|C6=="Yes"|C8=="Yes"|C9=="Yes"|C10=="Yes"|C11=="Yes"|C12=="Yes")
egen cwardnr=count(C5) if tda==20 & (C5=="Yes"|C6=="Yes"|C8=="Yes"|C9=="Yes"|C10=="Yes"|C11=="Yes"|C12=="Yes")
egen aetot=count(ae) if ae=="Yes"
egen aecs=count(ae) if tda==17 & ae=="Yes"
egen aearob=count(ae) if tda==18 & ae=="Yes"
egen aemf=count(ae) if tda==19 & ae=="Yes"
egen aenr=count(ae) if tda==20 & ae=="Yes"
egen drectot=count(drec) if drec=="Yes"
egen dreccs=count(drec) if tda==17 & drec=="Yes"
egen drecarob=count(drec) if tda==18 & drec=="Yes"
egen drecmf=count(drec) if tda==19 & drec=="Yes"
egen drecnr=count(drec) if tda==20 & drec=="Yes"
egen mrectot=count(mrec) if mrec=="Yes"
egen mreccs=count(mrec) if tda==17 & mrec=="Yes"
egen mrecarob=count(mrec) if tda==18 & mrec=="Yes"
egen mrecmf=count(mrec) if tda==19 & mrec=="Yes"
egen mrecnr=count(mrec) if tda==20 & mrec=="Yes"
egen sunittot=count(sunit) if sunit=="Yes"
egen sunitcs=count(sunit) if tda==17 & sunit=="Yes"
egen sunitarob=count(sunit) if tda==18 & sunit=="Yes"
egen sunitmf=count(sunit) if tda==19 & sunit=="Yes"
egen sunitnr=count(sunit) if tda==20 & sunit=="Yes"
egen icutot=count(hdu) if hdu=="Yes"|micu=="Yes"|sicu=="Yes"
egen icucs=count(hdu) if tda==17 & (hdu=="Yes"|micu=="Yes"|sicu=="Yes")
egen icuarob=count(hdu) if tda==18 & (hdu=="Yes"|micu=="Yes"|sicu=="Yes")
egen icumf=count(hdu) if tda==19 & (hdu=="Yes"|micu=="Yes"|sicu=="Yes")
egen icunr=count(hdu) if tda==20 & (hdu=="Yes"|micu=="Yes"|sicu=="Yes")
egen wardacttot=count(wardadmbk) if wardadmbk=="Yes"|wardrndbk=="Yes"|wardnoterv=="Yes"|wardbklog=="Yes"|wardpabs=="Yes"|wardfabs=="Yes"
egen wardactcs=count(wardadmbk) if tda==17 & (wardadmbk=="Yes"|wardrndbk=="Yes"|wardnoterv=="Yes"|wardbklog=="Yes"|wardpabs=="Yes"|wardfabs=="Yes")
egen wardactarob=count(wardadmbk) if tda==18 & (wardadmbk=="Yes"|wardrndbk=="Yes"|wardnoterv=="Yes"|wardbklog=="Yes"|wardpabs=="Yes"|wardfabs=="Yes")
egen wardactmf=count(wardadmbk) if tda==19 & (wardadmbk=="Yes"|wardrndbk=="Yes"|wardnoterv=="Yes"|wardbklog=="Yes"|wardpabs=="Yes"|wardfabs=="Yes")
egen wardactnr=count(wardadmbk) if tda==20 & (wardadmbk=="Yes"|wardrndbk=="Yes"|wardnoterv=="Yes"|wardbklog=="Yes"|wardpabs=="Yes"|wardfabs=="Yes")
egen aeacttot=count(aebklogrv) if aebklogrv=="Yes"|aenoterv=="Yes"|aefabs=="Yes"|aecdrv=="Yes"
egen aeactcs=count(aebklogrv) if tda==17 & (aebklogrv=="Yes"|aenoterv=="Yes"|aefabs=="Yes"|aecdrv=="Yes")
egen aeactarob=count(aebklogrv) if tda==18 & (aebklogrv=="Yes"|aenoterv=="Yes"|aefabs=="Yes"|aecdrv=="Yes")
egen aeactmf=count(aebklogrv) if tda==19 & (aebklogrv=="Yes"|aenoterv=="Yes"|aefabs=="Yes"|aecdrv=="Yes")
egen aeactnr=count(aebklogrv) if tda==20 & (aebklogrv=="Yes"|aenoterv=="Yes"|aefabs=="Yes"|aecdrv=="Yes")
egen drecacttot=count(drledger) if drledger=="Yes"|drnoterv=="Yes"|drbklogrv=="Yes"|drdoabk=="Yes"|drfabs=="Yes"|drdisabs=="Yes"|drcdrv=="Yes"
egen drecactcs=count(drledger) if tda==17 & (drledger=="Yes"|drnoterv=="Yes"|drbklogrv=="Yes"|drdoabk=="Yes"|drfabs=="Yes"|drdisabs=="Yes"|drcdrv=="Yes")
egen drecactarob=count(drledger) if tda==18 & (drledger=="Yes"|drnoterv=="Yes"|drbklogrv=="Yes"|drdoabk=="Yes"|drfabs=="Yes"|drdisabs=="Yes"|drcdrv=="Yes")
egen drecactmf=count(drledger) if tda==19 & (drledger=="Yes"|drnoterv=="Yes"|drbklogrv=="Yes"|drdoabk=="Yes"|drfabs=="Yes"|drdisabs=="Yes"|drcdrv=="Yes")
egen drecactnr=count(drledger) if tda==20 & (drledger=="Yes"|drnoterv=="Yes"|drbklogrv=="Yes"|drdoabk=="Yes"|drfabs=="Yes"|drdisabs=="Yes"|drcdrv=="Yes")
egen mrecacttot=count(mrdisnoterv) if mrdisnoterv=="Yes"|mrbklogrv=="Yes"|mrfabs=="Yes"|mrdisabs=="Yes"|mrcdrv=="Yes"
egen mrecactcs=count(mrdisnoterv) if tda==17 & (mrdisnoterv=="Yes"|mrbklogrv=="Yes"|mrfabs=="Yes"|mrdisabs=="Yes"|mrcdrv=="Yes")
egen mrecactarob=count(mrdisnoterv) if tda==18 & (mrdisnoterv=="Yes"|mrbklogrv=="Yes"|mrfabs=="Yes"|mrdisabs=="Yes"|mrcdrv=="Yes")
egen mrecactmf=count(mrdisnoterv) if tda==19 & (mrdisnoterv=="Yes"|mrbklogrv=="Yes"|mrfabs=="Yes"|mrdisabs=="Yes"|mrcdrv=="Yes")
egen mrecactnr=count(mrdisnoterv) if tda==20 & (mrdisnoterv=="Yes"|mrbklogrv=="Yes"|mrfabs=="Yes"|mrdisabs=="Yes"|mrcdrv=="Yes")

collapse parttot partcs partarob partmf partnr cfuptot cfupcs cfuparob cfupmf cfupnr ///
         awardtot awardcs awardarob awardmf awardnr bwardtot bwardcs bwardarob bwardmf bwardnr ///
         cwardtot cwardcs cwardarob cwardmf cwardnr aetot aecs aearob aemf aenr ///
         drectot dreccs drecarob drecmf drecnr mrectot mreccs mrecarob mrecmf mrecnr ///
         sunittot sunitcs sunitarob sunitmf sunitnr icutot icucs icuarob icumf icunr ///
         wardacttot wardactcs wardactarob wardactmf wardactnr aeacttot aeactcs aeactarob aeactmf aeactnr ///
         drecacttot drecactcs drecactarob drecactmf drecactnr mrecacttot mrecactcs mrecactarob mrecactmf mrecactnr

gen partcsper=partcs/parttot*100
gen partarobper=partarob/parttot*100
gen partmfper=partmf/parttot*100
gen partnrper=partnr/parttot*100
gen cfupcsper=cfupcs/cfuptot*100
gen cfuparobper=cfuparob/cfuptot*100
gen cfupmfper=cfupmf/cfuptot*100
gen cfupnrper=cfupnr/cfuptot*100
gen awardcsper=awardcs/awardtot*100
gen awardarobper=awardarob/awardtot*100
gen awardmfper=awardmf/awardtot*100
gen awardnrper=awardnr/awardtot*100
gen bwardcsper=bwardcs/bwardtot*100
gen bwardarobper=bwardarob/bwardtot*100
gen bwardmfper=bwardmf/bwardtot*100
gen bwardnrper=bwardnr/bwardtot*100
gen cwardcsper=cwardcs/cwardtot*100
gen cwardarobper=cwardarob/cwardtot*100
gen cwardmfper=cwardmf/cwardtot*100
gen cwardnrper=cwardnr/cwardtot*100
gen aecsper=aecs/aetot*100
gen aearobper=aearob/aetot*100
gen aemfper=aemf/aetot*100
gen aenrper=aenr/aetot*100
gen dreccsper=dreccs/drectot*100
gen drecarobper=drecarob/drectot*100
gen drecmfper=drecmf/drectot*100
gen drecnrper=drecnr/drectot*100
gen mreccsper=mreccs/mrectot*100
gen mrecarobper=mrecarob/mrectot*100
gen mrecmfper=mrecmf/mrectot*100
gen mrecnrper=mrecnr/mrectot*100
gen sunitcsper=sunitcs/sunittot*100
gen sunitarobper=sunitarob/sunittot*100
gen sunitmfper=sunitmf/sunittot*100
gen sunitnrper=sunitnr/sunittot*100
gen icucsper=icucs/icutot*100
gen icuarobper=icuarob/icutot*100
gen icumfper=icumf/icutot*100
gen icunrper=icunr/icutot*100
gen wardactcsper=wardactcs/wardacttot*100
gen wardactarobper=wardactarob/wardacttot*100
gen wardactmfper=wardactmf/wardacttot*100
gen wardactnrper=wardactnr/wardacttot*100
gen aeactcsper=aeactcs/aeacttot*100
gen aeactarobper=aeactarob/aeacttot*100
gen aeactmfper=aeactmf/aeacttot*100
gen aeactnrper=aeactnr/aeacttot*100
gen drecactcsper=drecactcs/drecacttot*100
gen drecactarobper=drecactarob/drecacttot*100
gen drecactmfper=drecactmf/drecacttot*100
gen drecactnrper=drecactnr/drecacttot*100
gen mrecactcsper=mrecactcs/mrecacttot*100
gen mrecactarobper=mrecactarob/mrecacttot*100
gen mrecactmfper=mrecactmf/mrecacttot*100
gen mrecactnrper=mrecactnr/mrecacttot*100
save "`datapath'\version01\2-working\cvd_TF_figs1.dta" ,replace
restore


** Create one dataset with totals for CF, ABS, TF tables
use "`datapath'\version01\2-working\cvd_CF_figs1.dta" ,replace
append using "`datapath'\version01\2-working\cvd_ABS_figs1.dta"
append using "`datapath'\version01\2-working\cvd_TF_figs1.dta"
collapse cftot cfcs cfarob cfmf cfnr cfcsper cfarobper cfmfper cfnrper ///
		 abstot abscs absarob absmf absnr abscsper absarobper absmfper absnrper ///
         distot discs disarob dismf disnr discsper disarobper dismfper disnrper ///
         fu1tot fu1mf fu1mfper fu1timetot fu1timemf fu1timemfper fu1latetot fu1latemf fu1latemfper ///
         fu2tot fu2mf fu2mfper fu2timetot fu2timemf fu2timemfper fu2latetot fu2latemf fu2latemfper ///
		 parttot partcs partarob partmf partnr partcsper partarobper partmfper partnrper ///
         cfuptot cfupcs cfuparob cfupmf cfupnr cfupcsper cfuparobper cfupmfper cfupnrper ///
         awardtot awardcs awardarob awardmf awardnr awardcsper awardarobper awardmfper awardnrper ///
         bwardtot bwardcs bwardarob bwardmf bwardnr bwardcsper bwardarobper bwardmfper bwardnrper ///
         cwardtot cwardcs cwardarob cwardmf cwardnr cwardcsper cwardarobper cwardmfper cwardnrper ///
         aetot aecs aearob aemf aenr aecsper aearobper aemfper aenrper ///
         drectot dreccs drecarob drecmf drecnr dreccsper drecarobper drecmfper drecnrper ///
         mrectot mreccs mrecarob mrecmf mrecnr mreccsper mrecarobper mrecmfper mrecnrper ///
         sunittot sunitcs sunitarob sunitmf sunitnr sunitcsper sunitarobper sunitmfper sunitnrper ///
         icutot icucs icuarob icumf icunr icucsper icuarobper icumfper icunrper ///
         wardacttot wardactcs wardactarob wardactmf wardactnr wardactcsper wardactarobper wardactmfper wardactnrper ///
         aeacttot aeactcs aeactarob aeactmf aeactnr aeactcsper aeactarobper aeactmfper aeactnrper ///
         drecacttot drecactcs drecactarob drecactmf drecactnr drecactcsper drecactarobper drecactmfper drecactnrper ///
         mrecacttot mrecactcs mrecactarob mrecactmf mrecactnr mrecactcsper mrecactarobper mrecactmfper mrecactnrper
foreach x of varlist cftot cfcs cfarob cfmf cfnr cfcsper cfarobper cfmfper cfnrper ///
                     abstot abscs absarob absmf absnr abscsper absarobper absmfper absnrper ///
                     distot discs disarob dismf disnr discsper disarobper dismfper disnrper ///
                     fu1tot fu1mf fu1mfper fu1timetot fu1timemf fu1timemfper fu1latetot fu1latemf fu1latemfper ///
                     fu2tot fu2mf fu2mfper fu2timetot fu2timemf fu2timemfper fu2latetot fu2latemf fu2latemfper ///
                     parttot partcs partarob partmf partnr partcsper partarobper partmfper partnrper ///
                     cfuptot cfupcs cfuparob cfupmf cfupnr cfupcsper cfuparobper cfupmfper cfupnrper ///
                     awardtot awardcs awardarob awardmf awardnr awardcsper awardarobper awardmfper awardnrper ///
                     bwardtot bwardcs bwardarob bwardmf bwardnr bwardcsper bwardarobper bwardmfper bwardnrper ///
                     cwardtot cwardcs cwardarob cwardmf cwardnr cwardcsper cwardarobper cwardmfper cwardnrper ///
                     aetot aecs aearob aemf aenr aecsper aearobper aemfper aenrper ///
                     drectot dreccs drecarob drecmf drecnr dreccsper drecarobper drecmfper drecnrper ///
                     mrectot mreccs mrecarob mrecmf mrecnr mreccsper mrecarobper mrecmfper mrecnrper ///
                     sunittot sunitcs sunitarob sunitmf sunitnr sunitcsper sunitarobper sunitmfper sunitnrper ///
                     icutot icucs icuarob icumf icunr icucsper icuarobper icumfper icunrper ///
                     wardacttot wardactcs wardactarob wardactmf wardactnr wardactcsper wardactarobper wardactmfper wardactnrper ///
                     aeacttot aeactcs aeactarob aeactmf aeactnr aeactcsper aeactarobper aeactmfper aeactnrper ///
                     drecacttot drecactcs drecactarob drecactmf drecactnr drecactcsper drecactarobper drecactmfper drecactnrper ///
                     mrecacttot mrecactcs mrecactarob mrecactmf mrecactnr mrecactcsper mrecactarobper mrecactmfper mrecactnrper{
    replace `x' = 0 if missing(`x')
}
save "`datapath'\version01\2-working\2019_p1appraisals_figs_cvd_CFABSTF.dta" ,replace


