********************************************************************************
*  3. Answer the following questions:
* a) Check up the number of registered voters change betweem the two rounds.

clear

* chemin

cd "C:\Users\sodji\OneDrive - Aix-Marseille Université\Bureau\Cours amu\Second semestre\Stata_learning\learning_stata_problem_1\Data\Temp"

*
*Import the data set 
********************
use round1_2-round2_part_vote-copie.dta, clear


* Calculate the change in number of registered

gen change_registered1_2 = inscrits1_par_departement - inscrits2_par_departement

br
* Average change

summarize change_registered1_2

* The average change is 128.7925.

* b)  The départements in which Le Pen received the 5 highest vote shares:

summarize Voix_LePen_round2
display r(sum)

* calculate the proportion by department
gen prop_Voix_LePen_round2 = Voix_LePen_round2/r(sum)


* sorted
 gsort  -prop_Voix_LePen_round2 
 
* Le Pen received the 5 highest vote shares in departement such as: Nord, Pas-de-Calais, Bouches-du-Rhome, Var, Seine-Maritime.

* c) 

 clear
 
 use round1_2-round2_part_vote-copie.dta, clear
 
 br
 
 summarize change_rounds1_2
display r(sum)

gen prop_change_rounds1_2 = change_rounds1_2/r(sum)


* sorted
 gsort  -prop_change_rounds1_2 
 
 * The département in witch turnout vary the most between the two round is Paris
 
 * 
 *sort in ascending order 
 
 gsort  prop_change_rounds1_2 
 
 * The  3 départements in which turnout varied the less are: Martinique, Guadeloupe and La Réunion.
 
 
 * d) National (aggregate) result of the (second round) vote,
 
 * Total vote
  clear
 
 use round1_2-round2_part_vote-copie.dta, clear
 br
 
 gen total_voix = Voix_Macron_round2 + Voix_LePen_round2
summarize total_voix
  display r(sum)

 
 *  Percentage vote for Macron 
 
 gen perct_Macron = Voix_Macron_round2/ r(sum)
 
 * Percentage vote for Le Pen
 
 gen perct_LePen = Voix_LePen_round2/r(sum)
 
 
 *National aggregate vote of Macron
 summarize perct_Macron
 display r(sum)*100
 
 * 
 *Macron get 66 % for second round 
 ***************************************
 
 * National aggregate vote of Le Pen
 
 summarize perct_LePen
  display r(sum)*100

 * 
 *Le Pen get almost 34 % for second round 
 *****************************************
 
 
 
 