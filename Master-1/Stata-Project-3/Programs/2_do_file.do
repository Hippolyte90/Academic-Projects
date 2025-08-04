
*
* Import country-level GDP per capita
********************************************************************************

clear

import excel "Data\Source\P_Data_Extract_From_World_Development_Indicators", sheet("Data") cellrange(A1:AB268) allstring firstrow clear

drop CountryCode SeriesName SeriesCode

br

* Reshape

reshape long YR, i(CountryName) j(years) string

* Remove the missing values 

* replace ".." by missing values

replace YR ="" if strpos(YR, "..") > 0 


drop if missing(CountryName) | missing(YR)

* Rename variable

rename CountryName country
rename YR gdp_per_capital

*
* Convert gdp_per_capital to numeric

destring gdp_per_capital, replace

sort country years


* save the temporal data set

save "Data\Temp\gdp_wave6_7", replace


*
* 
*  Average growth rate of per capita GDP over the five years after the survey.

********************************************************************************
* For wave 6

clear

use "Data\Temp\gdp_wave6_7", clear

br

gen gdp_t5 = .

bysort country (years): replace gdp_t5 = gdp_per_capital[_n+5] if years <= "2018"

*Average growth rate

gen growth_rate = (gdp_t5 / gdp_per_capital)^(1/5) - 1

gen growth_rate_pct = growth_rate * 100

* Keep the survey period

keep if years >= "2010" & years <= "2014"


* Remove missing values


drop if missing(growth_rate_pct) 

drop growth_rate gdp_t5 gdp_per_capital


save "Data\Temp\gdp_rate_wave6", replace

br


* For wave 7
******************************************************************************

clear

use "Data\Temp\gdp_wave6_7", clear

br


gen gdp_t5 = .

bysort country (years): replace gdp_t5 = gdp_per_capital[_n+5] if years <= "2018"

*Average growth rate

gen growth_rate = (gdp_t5 / gdp_per_capital)^(1/5) - 1

gen growth_rate_pct = growth_rate * 100

* Keep the survey period

keep if years >= "2017" & years <= "2022"


* Remove missing values


drop if missing(growth_rate_pct) 

drop growth_rate gdp_t5 gdp_per_capital 


save "Data\Temp\gdp_rate_wave7", replace

br

********************************************************************************
********************************************************************************

*
* Import the wave 6 data set 
********************************************************************************
clear

use "Data\Source\WV6_Data_stata_v20201117", clear

br

/*
3. Using countries that are present in both waves of the World Values Survey, construct a
 country-year data set with the following variables:
 • Measures of trust in people and of trust in institutions (army, police, court), and a
 synthetic index of measures of trust in institutions.
 • Ameasure of education.
 • Average growth rate of per capita GDP over the five years after the survey.
 
 */
 
 
 *
 * Keep the concerning variables
 ********************************
 
 keep V262 V2 V24 V109 V113 V114 V248
 
 * Convert to string
 
 foreach var of varlist V262 V2 V24 V109 V113 V114 V248 {
    decode `var', gen(`var'_str)
}

* Remove the repeated variable

 drop V262 V2 V24 V109 V113 V114 V248
 
 * Replace each category with its attributes.
 * Recode V24_str
 
 replace V24_str = "1" if strpos(V24_str, "Most people can be trusted") > 0 
 replace V24_str = "2" if strpos(V24_str, "Need to be very careful") > 0 
 replace V24_str = "-5" if strpos(V24_str, "DE,SE: Inapplicable;RU: Inappropiate response;SG:Missing;HT: Dropped out survey") > 0 
 replace V24_str = "-4" if strpos(V24_str, "Not asked in survey") > 0 
 replace V24_str = "-3" if strpos(V24_str, "Not applicable") > 0 
 replace V24_str = "-2" if strpos(V24_str, "No answer") > 0 
 replace V24_str = "-1" if strpos(V24_str, "Don´t know") > 0 

 * Recode V109_str
 
 replace V109_str = "1" if strpos(V109_str, "A great deal") > 0 
 replace V109_str = "2" if strpos(V109_str, "Quite a lot") > 0 
 replace V109_str = "3" if strpos(V109_str, "Not very much") > 0 
 replace V109_str = "4" if strpos(V109_str, "None at all") > 0 
 replace V109_str = "-5" if strpos(V109_str, "HT: Dropped out survey; RU,DE: Inappropriate response") > 0 
 replace V109_str = "-4" if strpos(V109_str, "Not asked in survey") > 0 
 replace V109_str = "-3" if strpos(V109_str, "Not applicable") > 0 
 replace V109_str = "-2" if strpos(V109_str, "No answer") > 0 
 replace V109_str = "-1" if strpos(V109_str, "Don´t know") > 0 

 * Recode V113_str
 
 replace V113_str = "1" if strpos(V113_str, "A great deal") > 0 
 replace V113_str = "2" if strpos(V113_str, "Quite a lot") > 0 
 replace V113_str = "3" if strpos(V113_str, "Not very much") > 0 
 replace V113_str = "4" if strpos(V113_str, "None at all") > 0 
 replace V113_str = "-5" if strpos(V113_str, "AM,DE,SE:Inapplicable ; RU:Inappropriate response; HT: Dropped out survey") > 0 
 replace V113_str = "-4" if strpos(V113_str, "Not asked in survey") > 0 
 replace V113_str = "-3" if strpos(V113_str, "Not applicable") > 0 
 replace V113_str = "-2" if strpos(V113_str, "No answer") > 0 
 replace V113_str = "-1" if strpos(V113_str, "Don´t know") > 0 

 
 * Recode V114_str
 
 replace V114_str = "1" if strpos(V114_str, "A great deal") > 0 
 replace V114_str = "2" if strpos(V114_str, "Quite a lot") > 0 
 replace V114_str = "3" if strpos(V114_str, "Not very much") > 0 
 replace V114_str = "4" if strpos(V114_str, "None at all") > 0 
 replace V114_str = "-5" if strpos(V114_str, "DE,SE:Inapplicable ; RU:Inappropriate response; HT: Dropped out survey") > 0 
 replace V114_str = "-4" if strpos(V114_str, "Not asked in survey") > 0 
 replace V114_str = "-3" if strpos(V114_str, "Not applicable") > 0 
 replace V114_str = "-2" if strpos(V114_str, "No answer") > 0 
 replace V114_str = "-1" if strpos(V114_str, "Don´t know") > 0 

 * Recode V248_str
 
 replace V248_str = "1" if strpos(V248_str, "No formal education") > 0 
 replace V248_str = "2" if strpos(V248_str, "Incomplete primary school") > 0 
 replace V248_str = "3" if strpos(V248_str, "Complete primary school") > 0 
 replace V248_str = "4" if strpos(V248_str, "Incomplete secondary school: technical/ vocational type") > 0 
 replace V248_str = "5" if strpos(V248_str, "Complete secondary school: technical/ vocational type") > 0 
 replace V248_str = "6" if strpos(V248_str, "Incomplete secondary school: university-preparatory type") > 0 
 replace V248_str = "7" if strpos(V248_str, "Complete secondary school: university-preparatory type") > 0 
 replace V248_str = "8" if strpos(V248_str, "Some university-level education, without degree") > 0 
 replace V248_str = "9" if strpos(V248_str, "University - level education, with degree") > 0 
 replace V248_str = "-5" if strpos(V248_str, "AU: Inapplicable (No-school education) DE,SE:Inapplicable ; SG: Refused; ZA:Other; Missing") > 0 
 replace V248_str = "-4" if strpos(V248_str, "Not asked in survey") > 0 
 replace V248_str = "-3" if strpos(V248_str, "Not applicable") > 0 
 replace V248_str = "-2" if strpos(V248_str, "No answer") > 0 
 replace V248_str = "-1" if strpos(V248_str, "Don´t know") > 0 

 *
 ** Rename the variables
 *****************************************
ren V262_str years
ren V2_str country
ren V24_str trust_people
ren V109_str trust_army
ren V113_str trust_police
ren V114_str trust_court
ren V248_str education_level

* Reconvert to numeric without "years" and "country"
 
 local string "years country" 
 
 foreach vars of varlist * {
        if strpos("`string'", "`vars'") == 0 { 
            destring `vars', replace force
        }
    }
 
* Trust institutions index

gen trust_institutions_index = (trust_army + trust_police + trust_court)/3

order years country trust_people trust_army trust_police trust_court trust_institutions_index education_level, first



* Regroup by country 
collapse (mean) trust_people trust_army trust_police trust_court trust_institutions_index education_level, by(country years)

* merge by country with gdp rate 

merge 1:m years country using "Data\Temp\gdp_rate_wave6"


drop _merge

* Remove missing values

drop if missing(growth_rate_pct) | missing(years) | missing(trust_people)

br

* Save the data set

save "Data\Temp\combine_wave6_gdprate", replace

*
* Import the wave 7 data set 
********************************************************************************
********************************************************************************

clear

use "Data\Source\WVS_Cross-National_Wave_7_stata_v6_0", clear

br


*
 * Keep the concerning variables
 ********************************
 
 keep A_YEAR B_COUNTRY Q57 Q65 Q69 Q70 Q275
 
 * Convert to string
 
 foreach var of varlist A_YEAR B_COUNTRY Q57 Q65 Q69 Q70 Q275 {
    decode `var', gen(`var'_str)
}

* Remove the repeated variable

 drop A_YEAR B_COUNTRY Q57 Q65 Q69 Q70 Q275
 
 * Replace each category with its attributes.
 
 * Recode Q57_str
 
 replace Q57_str = "1" if strpos(Q57_str, "Most people can be trusted") > 0 
 replace Q57_str = "2" if strpos(Q57_str, "Need to be very careful") > 0 
 replace Q57_str = "-5" if strpos(Q57_str,"Missing") > 0 
 replace Q57_str = "-4" if strpos(Q57_str, "Not asked") > 0 
 replace Q57_str = "-3" if strpos(Q57_str, "Not applicable") > 0 
 replace Q57_str = "-2" if strpos(Q57_str, "No answer") > 0 
 replace Q57_str = "-1" if strpos(Q57_str, "Don´t know") > 0 
 
 
 * Recode Q65_str
 
 replace Q65_str = "1" if strpos(Q65_str, "A great deal") > 0 
 replace Q65_str = "2" if strpos(Q65_str, "Quite a lot") > 0 
 replace Q65_str = "3" if strpos(Q65_str, "Not very much") > 0 
 replace Q65_str = "4" if strpos(Q65_str, "None at all") > 0 
 replace Q65_str = "-5" if strpos(Q65_str, "Missing; Not available") > 0 
 replace Q65_str = "-4" if strpos(Q65_str, "Not asked") > 0 
 replace Q65_str = "-2" if strpos(Q65_str, "No answer") > 0 
 replace Q65_str = "-1" if strpos(Q65_str, "Don´t know") > 0 

 
  * Recode Q69_str
 
 replace Q69_str = "1" if strpos(Q69_str, "A great deal") > 0 
 replace Q69_str = "2" if strpos(Q69_str, "Quite a lot") > 0 
 replace Q69_str = "3" if strpos(Q69_str, "Not very much") > 0 
 replace Q69_str = "4" if strpos(Q69_str, "None at all") > 0 
 replace Q69_str = "-5" if strpos(Q69_str, "Missing; Not available") > 0 
 replace Q69_str = "-4" if strpos(Q69_str, "Not asked") > 0 
 replace Q69_str = "-2" if strpos(Q69_str, "No answer") > 0 
 replace Q69_str = "-1" if strpos(Q69_str, "Don´t know") > 0 

 
  * Recode Q70_str
 
 replace Q70_str = "1" if strpos(Q70_str, "A great deal") > 0 
 replace Q70_str = "2" if strpos(Q70_str, "Quite a lot") > 0 
 replace Q70_str = "3" if strpos(Q70_str, "Not very much") > 0 
 replace Q70_str = "4" if strpos(Q70_str, "None at all") > 0 
 replace Q70_str = "-5" if strpos(Q70_str, "Missing; Not available") > 0 
 replace Q70_str = "-4" if strpos(Q70_str, "Not asked") > 0 
 replace Q70_str = "-2" if strpos(Q70_str, "No answer") > 0 
 replace Q70_str = "-1" if strpos(Q70_str, "Don´t know") > 0 

 
 * Recode Q275_str
 
  replace Q275_str = "0" if strpos(Q275_str, "Early childhood education (ISCED 0) / no education") > 0 
 replace Q275_str = "1" if strpos(Q275_str, "Primary education (ISCED 1)") > 0 
 replace Q275_str = "2" if strpos(Q275_str, "Lower secondary education (ISCED 2)") > 0 
 replace Q275_str = "3" if strpos(Q275_str, "Upper secondary education (ISCED 3)") > 0 
 replace Q275_str = "4" if strpos(Q275_str, "Post-secondary non-tertiary education (ISCED 4)") > 0 
 replace Q275_str = "5" if strpos(Q275_str, "Short-cycle tertiary education (ISCED 5)") > 0 
 replace Q275_str = "6" if strpos(Q275_str, "Bachelor or equivalent (ISCED 6)") > 0 
 replace Q275_str = "7" if strpos(Q275_str, "Master or equivalent (ISCED 7)") > 0 
 replace Q275_str = "8" if strpos(Q275_str, "Doctoral or equivalent (ISCED 8)") > 0 
 replace Q275_str = "-5" if strpos(Q275_str, "Missing; Not available") > 0 
 replace Q275_str = "-4" if strpos(Q275_str, "Not asked") > 0 
 replace Q275_str = "-2" if strpos(Q275_str, "No answer") > 0 
 replace Q275_str = "-1" if strpos(Q275_str, "Don´t know") > 0 

 
 *
 ** Rename the variables
 *****************************************
ren A_YEAR_str years
ren B_COUNTRY_str country
ren Q57_str trust_people
ren Q65_str trust_army
ren Q69_str trust_police
ren Q70_str trust_court
ren Q275_str education_level

* Reconvert to numeric without "years" and "country"
 
 local string "years country" 
 
 foreach vars of varlist * {
        if strpos("`string'", "`vars'") == 0 { 
            destring `vars', replace force
        }
    }
 
* Trust institutions index

gen trust_institutions_index = (trust_army + trust_police + trust_court)/3


order years country trust_people trust_army trust_police trust_court trust_institutions_index education_level, first


* Regroup by country 
collapse (mean) trust_people trust_army trust_police trust_court trust_institutions_index education_level, by(country years)

* merge by country with gdp rate 

merge 1:m country using "Data\Temp\gdp_rate_wave7"


drop _merge

* Remove missing values

drop if missing(growth_rate_pct) | missing(years) | missing(trust_people)

br

* Save the data set

save "Data\Temp\combine_wave7_gdprate", replace

 
 *
 * Combination of datasets, the final data set
 ********************************************************************************
 ********************************************************************************
 clear
 
use "Data\Temp\combine_wave6_gdprate", clear
append using "Data\Temp\combine_wave7_gdprate"

save "Data\Final\wave_6_wave_7_gdprate", replace

br 

*
* 4 a)  Ordinary least squares, estimate the cross-section relationship between trust in people and in institutions
*****************************************************************************************

clear

use "Data\Final\wave_6_wave_7_gdprate", clear

br

*
* Ordinary least squares
* Model_1

regress trust_people trust_institutions growth_rate_pct
local SSE1 = e(rss)
display "SSE1 =`SSE1'"

*Exportation



outreg2 using "Output\Results\results_mod_1.xls", replace excel
outreg2 using"Output\Results\results_mod_1.tex", replace tex

*
* b) Estimate the same model, complemented with country-level fixed effects.
*

* Declare the data structure as a panel with the country variable.

encode country, gen(country_id)

xtset country_id

* Estimate the model with national fixed effects.
* Model_2


xtreg trust_people trust_institutions growth_rate_pct, fe

local SSE2 = e(rss)
display "SSE2 = `SSE2'"

* Exportation

outreg2 using "Output\Results\results_mod_2.xls", replace excel
outreg2 using"Output\Results\results_mod_2.tex", replace tex


* Statistics F

local F = ((3.713844060954037 -  0.1207968966485644)/67) / ( 0.1207968966485644/33)

display "F-statistic =  `F'"

* SSE = Sum of Squared Errors

*
*  c) Compare the two models (using relevant statistical tests)


/*
To compare the two models, we will use a global significance test to assess the significance of the added categorical variables. Here, we can only consider n-1 variables to avoid perfect multicollinearity, where n is the number of variables indicating the effect of each country.

The null hypothesis is:

H0: No fixed effects.

Ainsi, le modèle contraint est le modèle 1 et le non contraint est le modèle 2

The statistic is:

F = [(SCE1 - SCE2)/67]/[SCE2/33] ~~ Fisher (66,84) =   37.86  

This statistic is greater than the 5% quantile of the Fisher distribution with n=66 , m=84 degrees of freedom. Consequently, we reject H0. 

Model_2 is so the best than Model_1
*/


*
*  d) Addthe measure of education as supplementary explanatory variable in both models.

* Model_1

regress trust_people trust_institutions growth_rate_pct education_level

* Exportation

outreg2 using "Output\Results\results_mod_1_education.xls", replace excel
outreg2 using"Output\Results\results_mod_1_education.tex", replace tex

*Model_2


xtreg trust_people trust_institutions growth_rate_pct education_level, fe


* Exportation

outreg2 using "Output\Results\results_mod_2_education.xls", replace excel
outreg2 using"Output\Results\results_mod_2_education.tex", replace tex


/*

We observe that Model 2 remains better than Model 1. However, the measure of education is statistically significant only in Model 1.

*/


*
* 5. Draw the evolution of GDP overthe entire period for countries that are in each quartile of the distribution of the index of trust in institutions.
*

*
* Divide by quartile
********************************************************************************
clear

use "Data\Temp\combine_wave6_gdprate", clear

br


keep years country trust_institutions_index


* quartile split

xtile quartile_trust = trust_institutions_index, nquantiles(4)


*save to use after

save  "Data\Temp\countries_quartile", replace



* Import dataset for gdp 
********************************************************************************

clear

use "Data\Temp\gdp_wave6_7", clear

br


* merge with the first dataset using "country"

merge m:1 country using "Data\Temp\countries_quartile"

drop if missing(quartile_trust) 

drop  _merge trust_institutions_index

destring years, replace

* Regroupe by quartile

collapse (mean) gdp_per_capital, by(years quartile_trust)

sort quartile_trust years

save "Data\Temp\data_quartile_graphics", replace





