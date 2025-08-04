* 2.
***********************************


clear

*
* Set work directory
**********************
cd "C:\Users\sodji\OneDrive - Aix-Marseille Université\Bureau\Cours amu\Second semestre\Stata_learning\learning_stata_problem_1"

*
*Import the data set of the round1
**********************************
import excel "Data\Source\Presidentielle_2017_Resultats_Communes_Tour_1.xls", sheet("Feuil1") cellrange(A4:CQ35500) firstrow allstring clear
br

*
*Number of registered voters and turnout at each round for each French departement
**********************************************************************************
*********
*Round 1
*********
keep Codedudépartement Libellédudépartement Inscrits Votants  
rename Codedudépartement code
rename Libellédudépartement departement
rename Inscrits inscrits1_par_departement
rename Votants votants1_par_departement
destring inscrits1_par_departement-votants1_par_departement, replace
collapse (sum) inscrits1_par_departement votants1_par_departement, by(code departement)fast
tostring code, replace
sort code
br

* sauver round1
****************
save "Data\Temp\round1.dta", replace

**********
*Round 2
**********
clear

*Import the data set of the round2
**********************************

import excel "Data\Source\Presidentielle_2017_Resultats_Communes_Tour_2_c.xls",  sheet("Feuil1") cellrange(A4:AF35723) firstrow allstring clear
br

keep Codedudépartement Libellédudépartement Inscrits Votants  
rename Codedudépartement code
rename Libellédudépartement departement
rename Inscrits inscrits2_par_departement
rename Votants votants2_par_departement
destring inscrits2_par_departement-votants2_par_departement, replace
collapse (sum) inscrits2_par_departement votants2_par_departement, by(code departement)fast
tostring code, replace
sort code
br

* save round2
****************
save "Data\Temp\round2.dta", replace


************************************************************************
* Macron and Le Pen vote shares at round 2  for each French département
************************************************************************
clear

*Import the data set of the round2
**********************************

import excel "Data\Source\Presidentielle_2017_Resultats_Communes_Tour_2_c.xls",  sheet("Feuil1") cellrange(A4:AF35723) firstrow allstring clear
br

keep Codedudépartement Libellédudépartement Voix AD  
rename Codedudépartement code
rename Libellédudépartement departement
rename Voix Voix_Macron_round2
rename AD Voix_LePen_round2
destring Voix_Macron_round2-Voix_LePen_round2, replace
collapse (sum) Voix_Macron_round2 Voix_LePen_round2, by(code departement)fast
tostring code, replace
sort code
br

* save round2 vote shares 
*************************
save "Data\Temp\round2_part_vote.dta", replace

***************************************************************************
* Change in turnout between the two rounds for each French département
***************************************************************************
clear


*Import the first two data set of the round1 and round2
********************************************************
use "Data\Temp\round1.dta", clear

* merge round1 and round2
merge 1:1 code departement using "Data\Temp\round2.dta"

* Check result of merging  
tab _merge

drop _merge
* create the new variabe that contain the change in turnout 

gen change_rounds1_2 = votants1_par_departement - votants2_par_departement

* merge with round2_part_vote
merge 1:1 code departement using "Data\Temp\round2_part_vote.dta"

drop _merge
br

* save the finaly data set 

save "Data\Final\round1_2-round2_part_vote.dta", replace

save "Data\Temp\round1_2-round2_part_vote-copie.dta", replace

br

















