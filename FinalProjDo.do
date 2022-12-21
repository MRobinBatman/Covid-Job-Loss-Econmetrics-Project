//Created by Michael Roberts
cd "C:\Users\Micha\OneDrive\School\College\USC 2020\Spring 2021\Econ 436\Final Project"
capture log close
set logtype text
log using "FinalProj", replace

clear all
set more off
insheet using CPS_COVID2.csv

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

tab metro, generate (metro_dum)
tab classwkr, generate (classwkr_dum)
tab covidunaw, generate (covidunaw_dum)
tab whyunemp, generate (whyunemp_dum)
generate age2 = age^2
gen dumetro =1 if metro > 1
replace dumetro =0 if  2> metro >0
xtset statefip 
gen mettele = dumetro*covidtelew
//reg covidunaw metro_dum2 metro_dum3  metro_dum4 metro_dum5 classwkr_dum1 classwkr_dum3 classwkr_dum4 classwkr_dum5 age age2 sex, robust

//reg covidunaw metro_dum2 metro_dum3 metro_dum4 metro_dum5 classwkr_dum1 classwkr_dum3 classwkr_dum4 classwkr_dum5 age age2 sex hispanic white black asian whyunemp_dum2 whyunemp_dum3 whyunemp_dum4 whyunemp_dum5 whyunemp_dum6, robust

//xtreg covidunaw metro_dum2 metro_dum3  metro_dum4 metro_dum5 classwkr_dum1 classwkr_dum2 classwkr_dum3 classwkr_dum4 classwkr_dum5 age age2 sex hispanic black asian somecoll ba mastersplus, robust fe

//last>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//xtreg covidunaw metro_dum2 metro_dum3 metro_dum4 metro_dum5 classwkr_dum1 classwkr_dum3 classwkr_dum4 classwkr_dum5 age age2 sex  hispanic black asian whyunemp_dum2 whyunemp_dum3 whyunemp_dum4 whyunemp_dum5 whyunemp_dum6, robust fe

//1>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\
//xtreg covidunaw metro_dum2 metro_dum3  metro_dum4 metro_dum5 age age2 sex hispanic black asian somecoll ba mastersplus, robust fe


//tabout covidunaw dumetro age sex  hispanic white black asian otherrace hs somecoll ba mastersplus whyunemp_dum1 whyunemp_dum2 whyunemp_dum3 whyunemp_dum4 whyunemp_dum5 whyunemp_dum6 using tabfin.doc

xtreg covidunaw dumetro age age2 sex hispanic black asian otherrace somecoll ba mastersplus, robust fe
eststo modelA

xtreg covidunaw dumetro age age2 sex hispanic black asian otherrace somecoll ba mastersplus classwkr_dum1  classwkr_dum3 classwkr_dum4 classwkr_dum5, robust fe 

eststo modelB
test classwkr_dum1 classwkr_dum3 classwkr_dum4 classwkr_dum5

xtreg covidunaw dumetro age age2 sex hispanic black asian otherrace somecoll ba mastersplus classwkr_dum1 classwkr_dum3 classwkr_dum4 classwkr_dum5 covidtelew, robust fe 
eststo modelC

xtreg covidunaw dumetro age age2 sex hispanic black asian otherrace somecoll ba mastersplus classwkr_dum1 classwkr_dum3 classwkr_dum4 classwkr_dum5 covidtelew mettele, robust fe
eststo modelD
test covidtelew mettele
sum covidunaw dumetro age sex white hispanic black asian otherrace hs somecoll ba mastersplus classwkr_dum1 classwkr_dum2 classwkr_dum3 classwkr_dum4 classwkr_dum5 covidtelew

esttab modelA modelB modelC modelD, star stats(N r2 r2_a)


//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
save Finalp.dta, replace
log close