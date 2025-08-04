
clear

use "Data\Temp\data_quartile_graphics", clear

*
* Graphics

twoway (line gdp_per_capital years if quartile_trust == 1, lcolor(red)) ///
       (line gdp_per_capital years if quartile_trust == 2, lcolor(blue)) ///
       (line gdp_per_capital years if quartile_trust == 3, lcolor(green)) ///
       (line gdp_per_capital years if quartile_trust == 4, lcolor(orange)), title("GDP Evolution by Trust in Institutions Quartile") ///
       ytitle("GDP (Mean)") xtitle("Year") ///
	   xlabel(, grid) ylabel(, grid) ///
       legend(order(1 "Q1 (Lowest Trust)" 2 "Q2" 3 "Q3" 4 "Q4 (Highest Trust)")) ///
       note("Data: WVS Wave 6 and GDP dataset")

graph save "Output\Graphics\evolution_by_quartile.gph", replace // Save in gph format 

graph export "Output\Graphics\evolution_by_quartile.png", replace  //Save in PNG format		


*********************************************************************************
*********************************************************************************


* Bonous
****************************************************
* import dataset

*wave 7

clear

use "Data\Source\WVS_Cross-National_Wave_7_stata_v6_0", clear

br


*
 * Keep the concerning variables
 ********************************
 
 keep A_YEAR Q57 Q288
 
 * Convert to string
 
 foreach var of varlist A_YEAR Q57 Q288 {
    decode `var', gen(`var'_str)
}

* Remove the repeated variable

 drop A_YEAR Q57 Q288
 
 * Replace each category with its attributes.
 
 * Recode Q57_str
 
 replace Q57_str = "1" if strpos(Q57_str, "Most people can be trusted") > 0 
 replace Q57_str = "2" if strpos(Q57_str, "Need to be very careful") > 0 
 replace Q57_str = "-5" if strpos(Q57_str,"Missing") > 0 
 replace Q57_str = "-4" if strpos(Q57_str, "Not asked") > 0 
 replace Q57_str = "-3" if strpos(Q57_str, "Not applicable") > 0 
 replace Q57_str = "-2" if strpos(Q57_str, "No answer") > 0 
 replace Q57_str = "-1" if strpos(Q57_str, "Don´t know") > 0 
 
* Recode Q288_str
 
 replace Q288_str = "1" if strpos(Q288_str, "Lower step") > 0 
 replace Q288_str = "2" if strpos(Q288_str, "second step") > 0 
 replace Q288_str = "3" if strpos(Q288_str, "Third step") > 0 
 replace Q288_str = "4" if strpos(Q288_str, "Fourth step") > 0 
 replace Q288_str = "5" if strpos(Q288_str, "Fifth step") > 0 
 replace Q288_str = "6" if strpos(Q288_str, "Sixth step") > 0 
 replace Q288_str = "7" if strpos(Q288_str, "Seventh step") > 0 
 replace Q288_str = "8" if strpos(Q288_str, "Eigth step") > 0 
 replace Q288_str = "9" if strpos(Q288_str, "Nineth step") > 0 
 replace Q288_str = "10" if strpos(Q288_str, "Tenth step") > 0 
 replace Q288_str = "-5" if strpos(Q288_str, "Missing; Not available") > 0 
 replace Q288_str = "-4" if strpos(Q288_str, "Not asked") > 0 
 replace Q288_str = "-2" if strpos(Q288_str, "No answer") > 0 
 replace Q288_str = "-1" if strpos(Q288_str, "Don´t know") > 0 

 *
 ** Rename the variables
 *******************************************************************************
ren A_YEAR_str years
ren Q57_str trust_people
ren Q288_str income

* Reconvert to numeric without "years" and "country"
 
 local string "years" 
 
 foreach vars of varlist * {
        if strpos("`string'", "`vars'") == 0 { 
            destring `vars', replace force
        }
    }


	* Regroup income by trust_people and years in order to show the effect of income over trust_people. 
	
collapse(mean) income, by(years trust_people)


save "Data\Temp\income_trust_people_w6", replace

*
* Import the wave 6 dataset 
********************************************************************************
clear

use "Data\Source\WV6_Data_stata_v20201117", clear

br

keep V262 V24 V239



 foreach var of varlist V262 V24 V239 {
    decode `var', gen(`var'_str)
}

* Remove the repeated variable

 drop V262 V24 V239
 
 * Replace each category with its attributes.
 * Recode V24_str
 
 replace V24_str = "1" if strpos(V24_str, "Most people can be trusted") > 0 
 replace V24_str = "2" if strpos(V24_str, "Need to be very careful") > 0 
 replace V24_str = "-5" if strpos(V24_str, "DE,SE: Inapplicable;RU: Inappropiate response;SG:Missing;HT: Dropped out survey") > 0 
 replace V24_str = "-4" if strpos(V24_str, "Not asked in survey") > 0 
 replace V24_str = "-3" if strpos(V24_str, "Not applicable") > 0 
 replace V24_str = "-2" if strpos(V24_str, "No answer") > 0 
 replace V24_str = "-1" if strpos(V24_str, "Don´t know") > 0 

 * Recode V239_str
 
 replace V239_str = "1" if strpos(V239_str, "Lower step") > 0 
 replace V239_str = "2" if strpos(V239_str, "second step") > 0 
 replace V239_str = "3" if strpos(V239_str, "Third step") > 0 
 replace V239_str = "4" if strpos(V239_str, "Fourth step") > 0 
 replace V239_str = "5" if strpos(V239_str, "Fifth step") > 0 
 replace V239_str = "6" if strpos(V239_str, "Sixth step") > 0 
 replace V239_str = "7" if strpos(V239_str, "Seventh step") > 0 
 replace V239_str = "8" if strpos(V239_str, "Eigth step") > 0 
 replace V239_str = "9" if strpos(V239_str, "Nineth step") > 0 
 replace V239_str = "10" if strpos(V239_str, "Tenth step") > 0 
 replace V239_str = "-5" if strpos(V239_str, "- DE,SE:Inapplicable ; RU:Inappropriate response; BH: Missing; HT: Dropped out survey") > 0 
 replace V239_str = "-4" if strpos(V239_str, "Not asked") > 0 
 replace V239_str = "-3" if strpos(V239_str, "Not applicable") > 0 
 replace V239_str = "-2" if strpos(V239_str, "No answer") > 0 
 replace V239_str = "-1" if strpos(V239_str, "Don´t know") > 0 

 *
 ** Rename the variables
 *****************************************
ren V262_str years
ren V24_str trust_people
ren V239_str income


* Reconvert to numeric without "years" 
 
 local string "years" 
 
 foreach vars of varlist * {
        if strpos("`string'", "`vars'") == 0 { 
            destring `vars', replace force
        }
    }

	
	* Regroup income by trust_people and years
	
collapse(mean) income, by(years trust_people)


*
* Append the two dataset

append using "Data\Temp\income_trust_people_w6"

* Remove the missing values

drop if missing(trust_people)

* Descriptive statistics
***********************************

tab trust_people
sum income, detail


* Trust_people by income

tab income trust_people, row


* Plot the proportion of people who trust others by income

graph bar (mean) trust_people, over(income, label(angle(90))) ///
       title("Trust in People by Income") ///
       ytitle("Proportion of Trust in People") ///
       note("Source: World Values Survey")

	   * save graphics
graph save "Output\Graphics\trust_people_by_income.gph", replace 
graph export "Output\Graphics\trust_people_by_income.png", replace  		
   
* estimation 

* Ordinary least squares

regress trust_people income

* We remarque that income dont have significative effect on trust_people
* because the p-value is greater than 5%.

*Calculate the marginal effect of income on the probability of trusting others:

margins, dydx(income) atmeans

* Visualisation of relation

twoway (scatter trust_people income, jitter(3)) ///
       (lfit trust_people income), ///
       title("Confiance envers les autres vs. Revenu") ///
       ytitle("Confiance (Binaire)") xtitle("Décile de Revenu")

	   
	   * save graphics
graph save "Output\Graphics\trust_people_by_income_regression.gph", replace 
graph export "Output\Graphics\trust_people_by_income_regression.png", replace  		
   
	   
* This graph appear that there are not an specific relation betweem income and trust in people.
