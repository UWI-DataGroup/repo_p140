** HEADER -----------------------------------------------------
**  DO-FILE METADATA
    //  algorithm name			2_pdf_cvd.do
    //  project:				BNR
    //  analysts:				Jacqueline CAMPBELL
    //  date first created      04-JUN-2019
    // 	date last modified	    04-JUN-2019
    //  algorithm task			Generating CVD pdf reports
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
    log using "`logpath'\2_pdf_p1appraisals_2019_cvd.smcl", replace
** HEADER -----------------------------------------------------


**************************************
** DATA PREPARATION  
**************************************
** LOAD the prepared dataset
use "`datapath'\version01\2-working\2019_p1appraisals_figs_cvd_CFABSTF" ,clear


				***************************
				*	    PDF REPORT  	  *
				*	   QUANTITY CVD	 	  *
				***************************

putpdf clear
putpdf begin

//Create a paragraph
putpdf paragraph
putpdf text ("Quantity Report: "), bold
putpdf text ("BNR-CVD"), bgcolor("blue") font(Helvetica,10,"yellow")
putpdf paragraph
putpdf text ("Appraisal Period: 1"), font(Helvetica,10)
putpdf paragraph
putpdf text ("Date Prepared: 04 June 2019"),  font(Helvetica,10)
putpdf paragraph
putpdf text ("Prepared by: JC using EI7 2018 & 2019 dbs"),  font(Helvetica,10)
putpdf paragraph, halign(center)
putpdf text ("QUANTITY - CF"), bold font(Helvetica,20,"blue")
putpdf paragraph
qui sum cftot
local sum : display %3.0f `r(sum)'
putpdf text ("CF entered TOTAL: `sum'"), bold font(Helvetica,15)
putpdf paragraph
qui sum cfuptot
local sum : display %3.0f `r(sum)'
putpdf text ("CF updated TOTAL: `sum'"), bold font(Helvetica,15)
putpdf paragraph, halign(center)
putpdf text ("QUANTITY - ABS"), bold font(Helvetica,20,"red")
putpdf paragraph
qui sum abstot
local sum : display %3.0f `r(sum)'
putpdf text ("ABS entered TOTAL: `sum'"), bold font(Helvetica,15)
putpdf paragraph
qui sum parttot
local sum : display %3.0f `r(sum)'
putpdf text ("PARTIAL entered TOTAL: `sum'"), bold font(Helvetica,15)
putpdf paragraph
qui sum distot
local sum : display %3.0f `r(sum)'
putpdf text ("DISCHARGE entered TOTAL: `sum'"), bold font(Helvetica,15)
putpdf paragraph
qui sum fu1tot
local sum : display %3.0f `r(sum)'
putpdf text ("28-DAY entered TOTAL: `sum'"), bold font(Helvetica,15)
putpdf paragraph
qui sum fu1timetot
local sum : display %3.0f `r(sum)'
putpdf text ("28-DAY entered [ON TIME] TOTAL: `sum'"), bold font(Helvetica,15)
putpdf paragraph
qui sum fu1latetot
local sum : display %3.0f `r(sum)'
putpdf text ("28-DAY entered [LATE-CONTACT DELAYS] TOTAL: `sum'"), bold font(Helvetica,15)
putpdf paragraph
qui sum fu2tot
local sum : display %3.0f `r(sum)'
putpdf text ("1-YR entered TOTAL: `sum'"), bold font(Helvetica,15)
putpdf paragraph
qui sum fu2timetot
local sum : display %3.0f `r(sum)'
putpdf text ("1-YR entered [ON TIME] TOTAL: `sum'"), bold font(Helvetica,15)
putpdf paragraph
qui sum fu2latetot
local sum : display %3.0f `r(sum)'
putpdf text ("1-YR entered [LATE-CONTACT DELAYS] TOTAL: `sum'"), bold font(Helvetica,15)
putpdf paragraph


				*****************************
				*	    PDF REPORT  	    *
				* QUANTITY (CATEGORIES) CVD *
				*		TRACKING FORM	    *
				*****************************

putpdf paragraph
putpdf paragraph, halign(center)
putpdf text ("QUANTITY - TF: visited"), bold font(Helvetica,20,"purple")
putpdf paragraph
qui sum awardtot
local sum : display %3.0f `r(sum)'
putpdf text ("A-WARDS visited TOTAL: `sum'"), bold font(Helvetica,15)
putpdf paragraph
qui sum bwardtot
local sum : display %3.0f `r(sum)'
putpdf text ("B-WARDS visited TOTAL: `sum'"), bold font(Helvetica,15)
putpdf paragraph
qui sum cwardtot
local sum : display %3.0f `r(sum)'
putpdf text ("C-WARDS visited TOTAL: `sum'"), bold font(Helvetica,15)
putpdf paragraph
qui sum aetot
local sum : display %3.0f `r(sum)'
putpdf text ("A&E visited TOTAL: `sum'"), bold font(Helvetica,15)
putpdf paragraph
qui sum drectot
local sum : display %3.0f `r(sum)'
putpdf text ("DEATH REC visited TOTAL: `sum'"), bold font(Helvetica,15)
putpdf paragraph
qui sum mrectot
local sum : display %3.0f `r(sum)'
putpdf text ("MED REC visited TOTAL: `sum'"), bold font(Helvetica,15)
putpdf paragraph
qui sum sunittot
local sum : display %3.0f `r(sum)'
putpdf text ("STROKE UNIT visited TOTAL: `sum'"), bold font(Helvetica,15)
putpdf paragraph
qui sum icutot
local sum : display %3.0f `r(sum)'
putpdf text ("HDU/ICU visited TOTAL: `sum'"), bold font(Helvetica,15)
putpdf paragraph, halign(center)
putpdf text ("QUANTITY - TF: activities"), bold font(Helvetica,20,"deeppink")
putpdf paragraph
qui sum aeacttot
local sum : display %3.0f `r(sum)'
putpdf text ("A&E activities TOTAL: `sum'"), bold font(Helvetica,15)
putpdf paragraph
qui sum drecacttot
local sum : display %3.0f `r(sum)'
putpdf text ("DEATH REC activities TOTAL: `sum'"), bold font(Helvetica,15)
putpdf paragraph
qui sum mrecacttot
local sum : display %3.0f `r(sum)'
putpdf text ("MED REC activities TOTAL: `sum'"), bold font(Helvetica,15)
putpdf paragraph


putpdf save "`datapath'\version01\3-output\2019-06-04_appraisals_2019p1_quant_CVD.pdf", replace
putpdf clear


				***************************
				*	    PDF REPORT  	  *
				*	   QUANTITY CS	 	  *
				***************************

putpdf clear
putpdf begin

//Create a paragraph
putpdf paragraph
putpdf text ("Quantity Report: "), bold
putpdf text ("CS"), bgcolor("blue") font(Helvetica,10,"yellow")
putpdf paragraph
putpdf text ("Appraisal Period: 1"), font(Helvetica,10)
putpdf paragraph
putpdf text ("Date Prepared: 04 June 2019"),  font(Helvetica,10)
putpdf paragraph
putpdf text ("Prepared by: JC using EI7 2018 & 2019 dbs"),  font(Helvetica,10)
putpdf paragraph, halign(center)
putpdf text ("QUANTITY - CF"), bold font(Helvetica,20,"blue")
putpdf paragraph
qui sum cftot
local sum : display %3.0f `r(sum)'
putpdf text ("CF entered TOTAL: `sum'")
putpdf paragraph
qui sum cfcs
local sum : display %3.0f `r(sum)'
putpdf text ("CF entered CS: `sum'")
putpdf paragraph
qui sum cfcsper
local sum : display %2.0f `r(sum)'
putpdf text ("CF entered CS: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum cfuptot
local sum : display %3.0f `r(sum)'
putpdf text ("CF updated TOTAL: `sum'")
putpdf paragraph
qui sum cfupcs
local sum : display %3.0f `r(sum)'
putpdf text ("CF updated CS: `sum'")
putpdf paragraph
qui sum cfupcsper
local sum : display %2.0f `r(sum)'
putpdf text ("CF updated CS: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph, halign(center)
putpdf text ("QUANTITY - ABS"), bold font(Helvetica,20,"red")
putpdf paragraph
qui sum abstot
local sum : display %3.0f `r(sum)'
putpdf text ("ABS entered TOTAL: `sum'")
putpdf paragraph
qui sum abscs
local sum : display %3.0f `r(sum)'
putpdf text ("ABS entered CS: `sum'")
putpdf paragraph
qui sum abscsper
local sum : display %2.0f `r(sum)'
putpdf text ("ABS entered CS: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum parttot
local sum : display %3.0f `r(sum)'
putpdf text ("PARTIAL entered TOTAL: `sum'")
putpdf paragraph
qui sum partcs
local sum : display %3.0f `r(sum)'
putpdf text ("PARTIAL entered CS: `sum'")
putpdf paragraph
qui sum partcsper
local sum : display %2.0f `r(sum)'
putpdf text ("PARTIAL entered CS: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum distot
local sum : display %3.0f `r(sum)'
putpdf text ("DISCHARGE entered TOTAL: `sum'")
putpdf paragraph
qui sum discs
local sum : display %3.0f `r(sum)'
putpdf text ("DISCHARGE entered CS: `sum'")
putpdf paragraph
qui sum discsper
local sum : display %2.0f `r(sum)'
putpdf text ("DISCHARGE entered CS: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph

				****************************
				*	    PDF REPORT  	   *
				* QUANTITY (CATEGORIES) CS *
				*		TRACKING FORM	   *
				****************************

putpdf paragraph, halign(center)
putpdf text ("QUANTITY - TF: visited"), bold font(Helvetica,20,"purple")
putpdf paragraph
qui sum awardtot
local sum : display %3.0f `r(sum)'
putpdf text ("A-WARDS visited TOTAL: `sum'")
putpdf paragraph
qui sum awardcs
local sum : display %3.0f `r(sum)'
putpdf text ("A-WARDS visited CS: `sum'")
putpdf paragraph
qui sum awardcsper
local sum : display %2.0f `r(sum)'
putpdf text ("A-WARDS visited CS: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum bwardtot
local sum : display %3.0f `r(sum)'
putpdf text ("B-WARDS visited TOTAL: `sum'")
putpdf paragraph
qui sum bwardcs
local sum : display %3.0f `r(sum)'
putpdf text ("B-WARDS visited CS: `sum'")
putpdf paragraph
qui sum bwardcsper
local sum : display %2.0f `r(sum)'
putpdf text ("B-WARDS visited CS: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum cwardtot
local sum : display %3.0f `r(sum)'
putpdf text ("C-WARDS visited TOTAL: `sum'")
putpdf paragraph
qui sum cwardcs
local sum : display %3.0f `r(sum)'
putpdf text ("C-WARDS visited CS: `sum'")
putpdf paragraph
qui sum cwardcsper
local sum : display %2.0f `r(sum)'
putpdf text ("C-WARDS visited CS: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum aetot
local sum : display %3.0f `r(sum)'
putpdf text ("A&E visited TOTAL: `sum'")
putpdf paragraph
qui sum aecs
local sum : display %3.0f `r(sum)'
putpdf text ("A&E visited CS: `sum'")
putpdf paragraph
qui sum aecsper
local sum : display %2.0f `r(sum)'
putpdf text ("A&E visited CS: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum drectot
local sum : display %3.0f `r(sum)'
putpdf text ("DEATH REC visited TOTAL: `sum'")
putpdf paragraph
qui sum dreccs
local sum : display %3.0f `r(sum)'
putpdf text ("DEATH REC visited CS: `sum'")
putpdf paragraph
qui sum dreccsper
local sum : display %2.0f `r(sum)'
putpdf text ("DEATH REC visited CS: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum mrectot
local sum : display %3.0f `r(sum)'
putpdf text ("MED REC visited TOTAL: `sum'")
putpdf paragraph
qui sum mreccs
local sum : display %3.0f `r(sum)'
putpdf text ("MED REC visited CS: `sum'")
putpdf paragraph
qui sum mreccsper
local sum : display %2.0f `r(sum)'
putpdf text ("MED REC visited CS: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum sunittot
local sum : display %3.0f `r(sum)'
putpdf text ("STROKE UNIT visited TOTAL: `sum'")
putpdf paragraph
qui sum sunitcs
local sum : display %3.0f `r(sum)'
putpdf text ("STROKE UNIT visited CS: `sum'")
putpdf paragraph
qui sum sunitcsper
local sum : display %2.0f `r(sum)'
putpdf text ("STROKE UNIT visited CS: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum icutot
local sum : display %3.0f `r(sum)'
putpdf text ("HDU/ICU visited TOTAL: `sum'")
putpdf paragraph
qui sum icucs
local sum : display %3.0f `r(sum)'
putpdf text ("HDU/ICU visited CS: `sum'")
putpdf paragraph
qui sum icucsper
local sum : display %2.0f `r(sum)'
putpdf text ("HDU/ICU visited CS: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph, halign(center)
putpdf text ("QUANTITY - TF: activities"), bold font(Helvetica,20,"deeppink")
putpdf paragraph
qui sum aeacttot
local sum : display %3.0f `r(sum)'
putpdf text ("A&E activities TOTAL: `sum'")
putpdf paragraph
qui sum aeactcs
local sum : display %3.0f `r(sum)'
putpdf text ("A&E activities CS: `sum'")
putpdf paragraph
qui sum aeactcsper
local sum : display %2.0f `r(sum)'
putpdf text ("A&E activities CS: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum drecacttot
local sum : display %3.0f `r(sum)'
putpdf text ("DEATH REC activities TOTAL: `sum'")
putpdf paragraph
qui sum drecactcs
local sum : display %3.0f `r(sum)'
putpdf text ("DEATH REC activities CS: `sum'")
putpdf paragraph
qui sum drecactcsper
local sum : display %2.0f `r(sum)'
putpdf text ("DEATH REC activities CS: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum mrecacttot
local sum : display %3.0f `r(sum)'
putpdf text ("MED REC activities TOTAL: `sum'")
putpdf paragraph
qui sum mrecactcs
local sum : display %3.0f `r(sum)'
putpdf text ("MED REC activities CS: `sum'")
putpdf paragraph
qui sum mrecactcsper
local sum : display %2.0f `r(sum)'
putpdf text ("MED REC activities CS: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph


putpdf save "`datapath'\version01\3-output\2019-06-04_appraisals_2019p1_quant_CS.pdf", replace
putpdf clear


				***************************
				*	    PDF REPORT  	  *
				*	   QUANTITY AROB	  *
				***************************

putpdf clear
putpdf begin

//Create a paragraph
putpdf paragraph
putpdf text ("Quantity Report: "), bold
putpdf text ("AROB"), bgcolor("blue") font(Helvetica,10,"yellow")
putpdf paragraph
putpdf text ("Appraisal Period: 1"), font(Helvetica,10)
putpdf paragraph
putpdf text ("Date Prepared: 04 June 2019"),  font(Helvetica,10)
putpdf paragraph
putpdf text ("Prepared by: JC using EI7 2018 & 2019 dbs"),  font(Helvetica,10)
putpdf paragraph, halign(center)
putpdf text ("QUANTITY - CF"), bold font(Helvetica,20,"blue")
putpdf paragraph
qui sum cftot
local sum : display %3.0f `r(sum)'
putpdf text ("CF entered TOTAL: `sum'")
putpdf paragraph
qui sum cfarob
local sum : display %3.0f `r(sum)'
putpdf text ("CF entered AROB: `sum'")
putpdf paragraph
qui sum cfarobper
local sum : display %2.0f `r(sum)'
putpdf text ("CF entered AROB: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum cfuptot
local sum : display %3.0f `r(sum)'
putpdf text ("CF updated TOTAL: `sum'")
putpdf paragraph
qui sum cfuparob
local sum : display %3.0f `r(sum)'
putpdf text ("CF updated AROB: `sum'")
putpdf paragraph
qui sum cfuparobper
local sum : display %2.0f `r(sum)'
putpdf text ("CF updated AROB: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph, halign(center)
putpdf text ("QUANTITY - ABS"), bold font(Helvetica,20,"red")
putpdf paragraph
qui sum abstot
local sum : display %3.0f `r(sum)'
putpdf text ("ABS entered TOTAL: `sum'")
putpdf paragraph
qui sum absarob
local sum : display %3.0f `r(sum)'
putpdf text ("ABS entered AROB: `sum'")
putpdf paragraph
qui sum absarobper
local sum : display %2.0f `r(sum)'
putpdf text ("ABS entered AROB: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum parttot
local sum : display %3.0f `r(sum)'
putpdf text ("PARTIAL entered TOTAL: `sum'")
putpdf paragraph
qui sum partarob
local sum : display %3.0f `r(sum)'
putpdf text ("PARTIAL entered AROB: `sum'")
putpdf paragraph
qui sum partarobper
local sum : display %2.0f `r(sum)'
putpdf text ("PARTIAL entered AROB: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum distot
local sum : display %3.0f `r(sum)'
putpdf text ("DISCHARGE entered TOTAL: `sum'")
putpdf paragraph
qui sum disarob
local sum : display %3.0f `r(sum)'
putpdf text ("DISCHARGE entered AROB: `sum'")
putpdf paragraph
qui sum disarobper
local sum : display %2.0f `r(sum)'
putpdf text ("DISCHARGE entered AROB: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph

				******************************
				*	    PDF REPORT  	     *
				* QUANTITY (CATEGORIES) AROB *
				*		TRACKING FORM	     *
				******************************

putpdf paragraph, halign(center)
putpdf text ("QUANTITY - TF: visited"), bold font(Helvetica,20,"purple")
putpdf paragraph
qui sum awardtot
local sum : display %3.0f `r(sum)'
putpdf text ("A-WARDS visited TOTAL: `sum'")
putpdf paragraph
qui sum awardarob
local sum : display %3.0f `r(sum)'
putpdf text ("A-WARDS visited AROB: `sum'")
putpdf paragraph
qui sum awardarobper
local sum : display %2.0f `r(sum)'
putpdf text ("A-WARDS visited AROB: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum bwardtot
local sum : display %3.0f `r(sum)'
putpdf text ("B-WARDS visited TOTAL: `sum'")
putpdf paragraph
qui sum bwardarob
local sum : display %3.0f `r(sum)'
putpdf text ("B-WARDS visited AROB: `sum'")
putpdf paragraph
qui sum bwardarobper
local sum : display %2.0f `r(sum)'
putpdf text ("B-WARDS visited AROB: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum cwardtot
local sum : display %3.0f `r(sum)'
putpdf text ("C-WARDS visited TOTAL: `sum'")
putpdf paragraph
qui sum cwardarob
local sum : display %3.0f `r(sum)'
putpdf text ("C-WARDS visited AROB: `sum'")
putpdf paragraph
qui sum cwardarobper
local sum : display %2.0f `r(sum)'
putpdf text ("C-WARDS visited AROB: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum aetot
local sum : display %3.0f `r(sum)'
putpdf text ("A&E visited TOTAL: `sum'")
putpdf paragraph
qui sum aearob
local sum : display %3.0f `r(sum)'
putpdf text ("A&E visited AROB: `sum'")
putpdf paragraph
qui sum aearobper
local sum : display %2.0f `r(sum)'
putpdf text ("A&E visited AROB: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum drectot
local sum : display %3.0f `r(sum)'
putpdf text ("DEATH REC visited TOTAL: `sum'")
putpdf paragraph
qui sum drecarob
local sum : display %3.0f `r(sum)'
putpdf text ("DEATH REC visited AROB: `sum'")
putpdf paragraph
qui sum drecarobper
local sum : display %2.0f `r(sum)'
putpdf text ("DEATH REC visited AROB: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum mrectot
local sum : display %3.0f `r(sum)'
putpdf text ("MED REC visited TOTAL: `sum'")
putpdf paragraph
qui sum mrecarob
local sum : display %3.0f `r(sum)'
putpdf text ("MED REC visited AROB: `sum'")
putpdf paragraph
qui sum mrecarobper
local sum : display %2.0f `r(sum)'
putpdf text ("MED REC visited AROB: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum sunittot
local sum : display %3.0f `r(sum)'
putpdf text ("STROKE UNIT visited TOTAL: `sum'")
putpdf paragraph
qui sum sunitarob
local sum : display %3.0f `r(sum)'
putpdf text ("STROKE UNIT visited AROB: `sum'")
putpdf paragraph
qui sum sunitarobper
local sum : display %2.0f `r(sum)'
putpdf text ("STROKE UNIT visited AROB: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum icutot
local sum : display %3.0f `r(sum)'
putpdf text ("HDU/ICU visited TOTAL: `sum'")
putpdf paragraph
qui sum icuarob
local sum : display %3.0f `r(sum)'
putpdf text ("HDU/ICU visited AROB: `sum'")
putpdf paragraph
qui sum icuarobper
local sum : display %2.0f `r(sum)'
putpdf text ("HDU/ICU visited AROB: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph, halign(center)
putpdf text ("QUANTITY - TF: activities"), bold font(Helvetica,20,"deeppink")
putpdf paragraph
qui sum aeacttot
local sum : display %3.0f `r(sum)'
putpdf text ("A&E activities TOTAL: `sum'")
putpdf paragraph
qui sum aeactarob
local sum : display %3.0f `r(sum)'
putpdf text ("A&E activities AROB: `sum'")
putpdf paragraph
qui sum aeactarobper
local sum : display %2.0f `r(sum)'
putpdf text ("A&E activities AROB: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum drecacttot
local sum : display %3.0f `r(sum)'
putpdf text ("DEATH REC activities TOTAL: `sum'")
putpdf paragraph
qui sum drecactarob
local sum : display %3.0f `r(sum)'
putpdf text ("DEATH REC activities AROB: `sum'")
putpdf paragraph
qui sum drecactarobper
local sum : display %2.0f `r(sum)'
putpdf text ("DEATH REC activities AROB: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum mrecacttot
local sum : display %3.0f `r(sum)'
putpdf text ("MED REC activities TOTAL: `sum'")
putpdf paragraph
qui sum mrecactarob
local sum : display %3.0f `r(sum)'
putpdf text ("MED REC activities AROB: `sum'")
putpdf paragraph
qui sum mrecactarobper
local sum : display %2.0f `r(sum)'
putpdf text ("MED REC activities AROB: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph


putpdf save "`datapath'\version01\3-output\2019-06-04_appraisals_2019p1_quant_AROB.pdf", replace
putpdf clear


				***************************
				*	    PDF REPORT  	  *
				*	   QUANTITY MF	 	  *
				***************************

putpdf clear
putpdf begin

//Create a paragraph
putpdf paragraph
putpdf text ("Quantity Report: "), bold
putpdf text ("MF"), bgcolor("blue") font(Helvetica,10,"yellow")
putpdf paragraph
putpdf text ("Appraisal Period: 1"), font(Helvetica,10)
putpdf paragraph
putpdf text ("Date Prepared: 04 June 2019"),  font(Helvetica,10)
putpdf paragraph
putpdf text ("Prepared by: JC using EI7 2018 & 2019 dbs"),  font(Helvetica,10)
putpdf paragraph, halign(center)
putpdf text ("QUANTITY - CF"), bold font(Helvetica,20,"blue")
putpdf paragraph
qui sum cftot
local sum : display %3.0f `r(sum)'
putpdf text ("CF entered TOTAL: `sum'")
putpdf paragraph
qui sum cfmf
local sum : display %3.0f `r(sum)'
putpdf text ("CF entered MF: `sum'")
putpdf paragraph
qui sum cfmfper
local sum : display %2.0f `r(sum)'
putpdf text ("CF entered MF: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum cfuptot
local sum : display %3.0f `r(sum)'
putpdf text ("CF updated TOTAL: `sum'")
putpdf paragraph
qui sum cfupmf
local sum : display %3.0f `r(sum)'
putpdf text ("CF updated MF: `sum'")
putpdf paragraph
qui sum cfupmfper
local sum : display %2.0f `r(sum)'
putpdf text ("CF updated MF: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph, halign(center)
putpdf text ("QUANTITY - ABS"), bold font(Helvetica,20,"red")
putpdf paragraph
qui sum abstot
local sum : display %3.0f `r(sum)'
putpdf text ("ABS entered TOTAL: `sum'")
putpdf paragraph
qui sum absmf
local sum : display %3.0f `r(sum)'
putpdf text ("ABS entered MF: `sum'")
putpdf paragraph
qui sum absmfper
local sum : display %2.0f `r(sum)'
putpdf text ("ABS entered MF: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum parttot
local sum : display %3.0f `r(sum)'
putpdf text ("PARTIAL entered TOTAL: `sum'")
putpdf paragraph
qui sum partmf
local sum : display %3.0f `r(sum)'
putpdf text ("PARTIAL entered MF: `sum'")
putpdf paragraph
qui sum partmfper
local sum : display %2.0f `r(sum)'
putpdf text ("PARTIAL entered MF: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum distot
local sum : display %3.0f `r(sum)'
putpdf text ("DISCHARGE entered TOTAL: `sum'")
putpdf paragraph
qui sum dismf
local sum : display %3.0f `r(sum)'
putpdf text ("DISCHARGE entered MF: `sum'")
putpdf paragraph
qui sum dismfper
local sum : display %2.0f `r(sum)'
putpdf text ("DISCHARGE entered MF: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum fu1tot
local sum : display %3.0f `r(sum)'
putpdf text ("28-DAY entered TOTAL: `sum'")
putpdf paragraph
qui sum fu1mf
local sum : display %3.0f `r(sum)'
putpdf text ("28-DAY entered MF: `sum'")
putpdf paragraph
qui sum fu1mfper
local sum : display %2.0f `r(sum)'
putpdf text ("28-DAY entered MF: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum fu1timetot
local sum : display %3.0f `r(sum)'
putpdf text ("28-DAY entered [ON TIME] TOTAL: `sum'")
putpdf paragraph
qui sum fu1timemf
local sum : display %3.0f `r(sum)'
putpdf text ("28-DAY entered [ON TIME] MF: `sum'")
putpdf paragraph
qui sum fu1timemfper
local sum : display %2.0f `r(sum)'
putpdf text ("28-DAY entered [ON TIME] MF: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum fu1latetot
local sum : display %3.0f `r(sum)'
putpdf text ("28-DAY entered [LATE-CONTACT DELAYS] TOTAL: `sum'")
putpdf paragraph
qui sum fu1latemf
local sum : display %3.0f `r(sum)'
putpdf text ("28-DAY entered [LATE-CONTACT DELAYS] MF: `sum'")
putpdf paragraph
qui sum fu1latemfper
local sum : display %2.0f `r(sum)'
putpdf text ("28-DAY entered [LATE-CONTACT DELAYS] MF: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum fu2tot
local sum : display %3.0f `r(sum)'
putpdf text ("1-YR entered TOTAL: `sum'")
putpdf paragraph
qui sum fu2mf
local sum : display %3.0f `r(sum)'
putpdf text ("1-YR entered MF: `sum'")
putpdf paragraph
qui sum fu2mfper
local sum : display %2.0f `r(sum)'
putpdf text ("1-YR entered MF: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum fu2timetot
local sum : display %3.0f `r(sum)'
putpdf text ("1-YR entered [ON TIME] TOTAL: `sum'")
putpdf paragraph
qui sum fu2timemf
local sum : display %3.0f `r(sum)'
putpdf text ("1-YR entered [ON TIME] MF: `sum'")
putpdf paragraph
qui sum fu2timemfper
local sum : display %2.0f `r(sum)'
putpdf text ("1-YR entered [ON TIME] MF: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum fu2latetot
local sum : display %3.0f `r(sum)'
putpdf text ("1-YR entered [LATE-CONTACT DELAYS] TOTAL: `sum'")
putpdf paragraph
qui sum fu2latemf
local sum : display %3.0f `r(sum)'
putpdf text ("1-YR entered [LATE-CONTACT DELAYS] MF: `sum'")
putpdf paragraph
qui sum fu2latemfper
local sum : display %2.0f `r(sum)'
putpdf text ("1-YR entered [LATE-CONTACT DELAYS] MF: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph

				****************************
				*	    PDF REPORT  	   *
				* QUANTITY (CATEGORIES) MF *
				*		TRACKING FORM	   *
				****************************

putpdf paragraph, halign(center)
putpdf text ("QUANTITY - TF: visited"), bold font(Helvetica,20,"purple")
putpdf paragraph
qui sum awardtot
local sum : display %3.0f `r(sum)'
putpdf text ("A-WARDS visited TOTAL: `sum'")
putpdf paragraph
qui sum awardmf
local sum : display %3.0f `r(sum)'
putpdf text ("A-WARDS visited MF: `sum'")
putpdf paragraph
qui sum awardmfper
local sum : display %2.0f `r(sum)'
putpdf text ("A-WARDS visited MF: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum bwardtot
local sum : display %3.0f `r(sum)'
putpdf text ("B-WARDS visited TOTAL: `sum'")
putpdf paragraph
qui sum bwardmf
local sum : display %3.0f `r(sum)'
putpdf text ("B-WARDS visited MF: `sum'")
putpdf paragraph
qui sum bwardmfper
local sum : display %2.0f `r(sum)'
putpdf text ("B-WARDS visited MF: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum cwardtot
local sum : display %3.0f `r(sum)'
putpdf text ("C-WARDS visited TOTAL: `sum'")
putpdf paragraph
qui sum cwardmf
local sum : display %3.0f `r(sum)'
putpdf text ("C-WARDS visited MF: `sum'")
putpdf paragraph
qui sum cwardmfper
local sum : display %2.0f `r(sum)'
putpdf text ("C-WARDS visited MF: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum aetot
local sum : display %3.0f `r(sum)'
putpdf text ("A&E visited TOTAL: `sum'")
putpdf paragraph
qui sum aemf
local sum : display %3.0f `r(sum)'
putpdf text ("A&E visited MF: `sum'")
putpdf paragraph
qui sum aemfper
local sum : display %2.0f `r(sum)'
putpdf text ("A&E visited MF: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum drectot
local sum : display %3.0f `r(sum)'
putpdf text ("DEATH REC visited TOTAL: `sum'")
putpdf paragraph
qui sum drecmf
local sum : display %3.0f `r(sum)'
putpdf text ("DEATH REC visited MF: `sum'")
putpdf paragraph
qui sum drecmfper
local sum : display %2.0f `r(sum)'
putpdf text ("DEATH REC visited MF: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum mrectot
local sum : display %3.0f `r(sum)'
putpdf text ("MED REC visited TOTAL: `sum'")
putpdf paragraph
qui sum mrecmf
local sum : display %3.0f `r(sum)'
putpdf text ("MED REC visited MF: `sum'")
putpdf paragraph
qui sum mrecmfper
local sum : display %2.0f `r(sum)'
putpdf text ("MED REC visited MF: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum sunittot
local sum : display %3.0f `r(sum)'
putpdf text ("STROKE UNIT visited TOTAL: `sum'")
putpdf paragraph
qui sum sunitmf
local sum : display %3.0f `r(sum)'
putpdf text ("STROKE UNIT visited MF: `sum'")
putpdf paragraph
qui sum sunitmfper
local sum : display %2.0f `r(sum)'
putpdf text ("STROKE UNIT visited MF: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum icutot
local sum : display %3.0f `r(sum)'
putpdf text ("HDU/ICU visited TOTAL: `sum'")
putpdf paragraph
qui sum icumf
local sum : display %3.0f `r(sum)'
putpdf text ("HDU/ICU visited MF: `sum'")
putpdf paragraph
qui sum icumfper
local sum : display %2.0f `r(sum)'
putpdf text ("HDU/ICU visited MF: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph, halign(center)
putpdf text ("QUANTITY - TF: activities"), bold font(Helvetica,20,"deeppink")
putpdf paragraph
qui sum aeacttot
local sum : display %3.0f `r(sum)'
putpdf text ("A&E activities TOTAL: `sum'")
putpdf paragraph
qui sum aeactmf
local sum : display %3.0f `r(sum)'
putpdf text ("A&E activities MF: `sum'")
putpdf paragraph
qui sum aeactmfper
local sum : display %2.0f `r(sum)'
putpdf text ("A&E activities MF: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum drecacttot
local sum : display %3.0f `r(sum)'
putpdf text ("DEATH REC activities TOTAL: `sum'")
putpdf paragraph
qui sum drecactmf
local sum : display %3.0f `r(sum)'
putpdf text ("DEATH REC activities MF: `sum'")
putpdf paragraph
qui sum drecactmfper
local sum : display %2.0f `r(sum)'
putpdf text ("DEATH REC activities MF: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum mrecacttot
local sum : display %3.0f `r(sum)'
putpdf text ("MED REC activities TOTAL: `sum'")
putpdf paragraph
qui sum mrecactmf
local sum : display %3.0f `r(sum)'
putpdf text ("MED REC activities MF: `sum'")
putpdf paragraph
qui sum mrecactmfper
local sum : display %2.0f `r(sum)'
putpdf text ("MED REC activities MF: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph


putpdf save "`datapath'\version01\3-output\2019-06-04_appraisals_2019p1_quant_MF.pdf", replace
putpdf clear

				***************************
				*	    PDF REPORT  	  *
				*	   QUANTITY NR	 	  *
				***************************

putpdf clear
putpdf begin

//Create a paragraph
putpdf paragraph
putpdf text ("Quantity Report: "), bold
putpdf text ("NR"), bgcolor("blue") font(Helvetica,10,"yellow")
putpdf paragraph
putpdf text ("Appraisal Period: 1"), font(Helvetica,10)
putpdf paragraph
putpdf text ("Date Prepared: 04 June 2019"),  font(Helvetica,10)
putpdf paragraph
putpdf text ("Prepared by: JC using EI7 2018 & 2019 dbs"),  font(Helvetica,10)
putpdf paragraph, halign(center)
putpdf text ("QUANTITY - CF"), bold font(Helvetica,20,"blue")
putpdf paragraph
qui sum cftot
local sum : display %3.0f `r(sum)'
putpdf text ("CF entered TOTAL: `sum'")
putpdf paragraph
qui sum cfnr
local sum : display %3.0f `r(sum)'
putpdf text ("CF entered NR: `sum'")
putpdf paragraph
qui sum cfnrper
local sum : display %2.0f `r(sum)'
putpdf text ("CF entered NR: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum cfuptot
local sum : display %3.0f `r(sum)'
putpdf text ("CF updated TOTAL: `sum'")
putpdf paragraph
qui sum cfupnr
local sum : display %3.0f `r(sum)'
putpdf text ("CF updated NR: `sum'")
putpdf paragraph
qui sum cfupnrper
local sum : display %2.0f `r(sum)'
putpdf text ("CF updated NR: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph, halign(center)
putpdf text ("QUANTITY - ABS"), bold font(Helvetica,20,"red")
putpdf paragraph
qui sum abstot
local sum : display %3.0f `r(sum)'
putpdf text ("ABS entered TOTAL: `sum'")
putpdf paragraph
qui sum absnr
local sum : display %3.0f `r(sum)'
putpdf text ("ABS entered NR: `sum'")
putpdf paragraph
qui sum absnrper
local sum : display %2.0f `r(sum)'
putpdf text ("ABS entered NR: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum parttot
local sum : display %3.0f `r(sum)'
putpdf text ("PARTIAL entered TOTAL: `sum'")
putpdf paragraph
qui sum partnr
local sum : display %3.0f `r(sum)'
putpdf text ("PARTIAL entered NR: `sum'")
putpdf paragraph
qui sum partnrper
local sum : display %2.0f `r(sum)'
putpdf text ("PARTIAL entered NR: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum distot
local sum : display %3.0f `r(sum)'
putpdf text ("DISCHARGE entered TOTAL: `sum'")
putpdf paragraph
qui sum disnr
local sum : display %3.0f `r(sum)'
putpdf text ("DISCHARGE entered NR: `sum'")
putpdf paragraph
qui sum disnrper
local sum : display %2.0f `r(sum)'
putpdf text ("DISCHARGE entered NR: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph

				****************************
				*	    PDF REPORT  	   *
				* QUANTITY (CATEGORIES) NR *
				*		TRACKING FORM	   *
				****************************

putpdf paragraph, halign(center)
putpdf text ("QUANTITY - TF: visited"), bold font(Helvetica,20,"purple")
putpdf paragraph
qui sum awardtot
local sum : display %3.0f `r(sum)'
putpdf text ("A-WARDS visited TOTAL: `sum'")
putpdf paragraph
qui sum awardnr
local sum : display %3.0f `r(sum)'
putpdf text ("A-WARDS visited NR: `sum'")
putpdf paragraph
qui sum awardnrper
local sum : display %2.0f `r(sum)'
putpdf text ("A-WARDS visited NR: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum bwardtot
local sum : display %3.0f `r(sum)'
putpdf text ("B-WARDS visited TOTAL: `sum'")
putpdf paragraph
qui sum bwardnr
local sum : display %3.0f `r(sum)'
putpdf text ("B-WARDS visited NR: `sum'")
putpdf paragraph
qui sum bwardnrper
local sum : display %2.0f `r(sum)'
putpdf text ("B-WARDS visited NR: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum cwardtot
local sum : display %3.0f `r(sum)'
putpdf text ("C-WARDS visited TOTAL: `sum'")
putpdf paragraph
qui sum cwardnr
local sum : display %3.0f `r(sum)'
putpdf text ("C-WARDS visited NR: `sum'")
putpdf paragraph
qui sum cwardnrper
local sum : display %2.0f `r(sum)'
putpdf text ("C-WARDS visited NR: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum aetot
local sum : display %3.0f `r(sum)'
putpdf text ("A&E visited TOTAL: `sum'")
putpdf paragraph
qui sum aenr
local sum : display %3.0f `r(sum)'
putpdf text ("A&E visited NR: `sum'")
putpdf paragraph
qui sum aenrper
local sum : display %2.0f `r(sum)'
putpdf text ("A&E visited NR: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum drectot
local sum : display %3.0f `r(sum)'
putpdf text ("DEATH REC visited TOTAL: `sum'")
putpdf paragraph
qui sum drecnr
local sum : display %3.0f `r(sum)'
putpdf text ("DEATH REC visited NR: `sum'")
putpdf paragraph
qui sum drecnrper
local sum : display %2.0f `r(sum)'
putpdf text ("DEATH REC visited NR: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum mrectot
local sum : display %3.0f `r(sum)'
putpdf text ("MED REC visited TOTAL: `sum'")
putpdf paragraph
qui sum mrecnr
local sum : display %3.0f `r(sum)'
putpdf text ("MED REC visited NR: `sum'")
putpdf paragraph
qui sum mrecnrper
local sum : display %2.0f `r(sum)'
putpdf text ("MED REC visited NR: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum sunittot
local sum : display %3.0f `r(sum)'
putpdf text ("STROKE UNIT visited TOTAL: `sum'")
putpdf paragraph
qui sum sunitnr
local sum : display %3.0f `r(sum)'
putpdf text ("STROKE UNIT visited NR: `sum'")
putpdf paragraph
qui sum sunitnrper
local sum : display %2.0f `r(sum)'
putpdf text ("STROKE UNIT visited NR: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum icutot
local sum : display %3.0f `r(sum)'
putpdf text ("HDU/ICU visited TOTAL: `sum'")
putpdf paragraph
qui sum icunr
local sum : display %3.0f `r(sum)'
putpdf text ("HDU/ICU visited NR: `sum'")
putpdf paragraph
qui sum icunrper
local sum : display %2.0f `r(sum)'
putpdf text ("HDU/ICU visited NR: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph, halign(center)
putpdf text ("QUANTITY - TF: activities"), bold font(Helvetica,20,"deeppink")
putpdf paragraph
qui sum aeacttot
local sum : display %3.0f `r(sum)'
putpdf text ("A&E activities TOTAL: `sum'")
putpdf paragraph
qui sum aeactnr
local sum : display %3.0f `r(sum)'
putpdf text ("A&E activities NR: `sum'")
putpdf paragraph
qui sum aeactnrper
local sum : display %2.0f `r(sum)'
putpdf text ("A&E activities NR: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum drecacttot
local sum : display %3.0f `r(sum)'
putpdf text ("DEATH REC activities TOTAL: `sum'")
putpdf paragraph
qui sum drecactnr
local sum : display %3.0f `r(sum)'
putpdf text ("DEATH REC activities NR: `sum'")
putpdf paragraph
qui sum drecactnrper
local sum : display %2.0f `r(sum)'
putpdf text ("DEATH REC activities NR: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph
qui sum mrecacttot
local sum : display %3.0f `r(sum)'
putpdf text ("MED REC activities TOTAL: `sum'")
putpdf paragraph
qui sum mrecactnr
local sum : display %3.0f `r(sum)'
putpdf text ("MED REC activities NR: `sum'")
putpdf paragraph
qui sum mrecactnrper
local sum : display %2.0f `r(sum)'
putpdf text ("MED REC activities NR: `sum'%"), bold font(Helvetica,15) bgcolor("yellow")
putpdf paragraph


putpdf save "`datapath'\version01\3-output\2019-06-04_appraisals_2019p1_quant_NR.pdf", replace
putpdf clear



save "`datapath'\version01\3-output\Appraisals_2019p1_report_BNRCVD.dta" ,replace
label data "BNR-CVD Appraisal Stats"
notes _dta :These data prepared for 2019 Period 1 (Jan-Jun) Appraisal
