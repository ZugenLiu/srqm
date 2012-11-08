* What: SRQM Session 6 (new: 9b)
* Who:  F. Briatte and I. Petev
* When: 2011-10-12


* =========
* = SETUP =
* =========


* Required commands.
foreach p in catplot fre tab_chi {
	cap which `p'
	if _rc==111 cap noi ssc install `p' // install from online if missing
}

* Log results.
cap log using "Replication/week6.log", replace


* ===========
* = DATASET =
* ===========


* Data: Eurobarometer, Wave 71.1 (2009).
use "Datasets/ebm2009.dta", clear

* Survey weights.
ren v8 popweight
ren v38 ctyweight
gen wgt=popweight*ctyweight
svyset [pw=wgt] // survey weights set to overall European population

* Country codes.
ren v7 ccode


* ================
* = DESCRIPTIONS =
* ================


* DV: Mitigation of crisis through European currency
* --------------------------------------------------

fre v493
ren v493 mitig4

* Estimate weighted proportions.
svy: prop mitig4

* Visualization over 4-point scale.
catplot mitig4, over(ccode, sort(4)des) asyvars percent(ccode) stack ///
	legend(rows(1)) scale(.7) scheme(burd4) name(mitig4, replace) 

* Binary recoding of the DV.
recode mitig4 (1/2=1 "Agree") (3/4=0 "Disagree") (else=.), gen(mitig01)
la var mitig01 "Euro mitigated crisis"
fre mitig01

* You can read the frequency of the positive value in a binary variable by 
* inspecting its mean. In this case, the mean gives the fraction of respondents
* that agrees with the survey question. Be careful, however: when the sample
* is unweighted, proportions can be misleading.

* Visualization as a fraction.
gr dot mitig01 if !mi(mitig01), over(ccode, sort(1)des) /// 
	yti("Euro mitigated crisis (% who agree)") ///
	legend(rows(1)) scale(.7) name(mitig01, replace)

* Subset to respondents from Ireland, Greece, East and West Germany.
keep if inlist(ccode,8,11,14,4)

* Discrete histograms of the DV, faceted by country.
hist mitig4, by(ccode, note("")) discrete percent yti("") ///
	xti("Euro mitigated crisis (% who agree)") ///
	xla(1 `" "Strongly" "agree" "' 4 `" "Strongly" "disagree" "') ///
	name(mitig4_subset, replace)


* IV: Sex
* -------

ren v644 sex
recode sex (1=0 "Male") (2=1 "Female"), gen(female)
la var female "Gender"

* Crosstabulations:
tab mitig4 female       // raw frequencies
tab mitig4 female, cell // cell percentages

* Conditional probabilities:
tab mitig4 female, col nof    // column percentages
tab mitig4 female, row nof    // rows percentages

* Significance tests:
tab mitig4 female, exp chi2   // Chi-squared test (with expected frequencies)
tab mitig4 female, exp chi2 V // Cramer's V (requires an acute accent on 'e')

* Chi-squared residuals:
tabchi mitig4 female, r noo noe // raw residuals
tabchi mitig4 female, p noo noe // Pearson residuals

* Fisher's exact test
tab mitig4 female, exact


* Notes on association tests
* --------------------------

* - The Chi-squared test does not operate through the normal distribution to
* determine statistical significance. The degrees of freedom of the crosstab are
* used against a different distribution that expresses different assumptions, of
* which an important one is that the accuracy of the test is insatisfactory when
* cell counts fall under 5-10 (depending on what you want to call accuracy).

* - The general idea of nonparametric tests is that they harness a different
* set of properties in the sample than the total number of observations n, using
* instead the properties of table cells in different ways. Cramer's V is a means
* to reinject n in the equation: it measures the strength of association as read
* in a Chi-squared tests, from -1 to 1 on 2x2 tables, and from 0 to 1 otherwise.

* - A further refinement of the Chi-squared test is to read its residuals, i.e.
* the substraction of observed - expected frequencies in each cell. To relate
* the residuals to the overall table, we divide them by a square root of table
* dimensions to obtain Pearson residuals, where extreme values point the cells
* contributing most to the association.

* - Last, Fisher's exact test expresses yet other properties that make it exact
* from a statistical perspective, for very uninteresting reasons that I'll skip.
* It primarily applies to 2x2 tables, and fails on tables with high dimensions.
* You can try to use it as an alternative to the Chi-squared test when you have
* both low cell counts and low dimensions, i.e. low 'r x c' (rows by columns).


* IV: Age
* -------

ren v645 age
ren v646 age4

* Mean age in each age group.
tab age4, summ(age)

* Conditional probabilities:
tab mitig4 age4, col nof    // column percentages
tab mitig4 age4, row nof    // rows percentages


* IV: Education
* -------------

ren v642 edu
recode edu ///
	(1/15=1 "15- yrs") ///
	(16/19=2 "16-19 yrs") ///
	(20/max=3 "20+ yrs") ///
	(98=.), gen(edu4)
la var edu4 "Education"

* Mean age at each educational level.
tab edu4, summ(age)

* Conditional probabilities:
tab mitig4 edu4, col nof    // column percentages
tab mitig4 edu4, row nof    // rows percentages

* Significance tests:
tab mitig4 edu4, exp chi2 V


* IV: Occupation
* --------------

ren v767 pro

* Visualization with categories ordered by descending order.
gr dot mitig4, over(pro, sort(1) des)

* Isolating student respondents with a binary variable.
gen student = (pro==8)

* Conditional probabilities:
tab mitig4 student, col nof    // column percentages
tab mitig4 student, row nof    // rows percentages

* Significance tests:
tab mitig4 edu4, exp chi2 V


* IV: Left-right political positioning
* ------------------------------------

fre v638-v640 // multiple choices here
ren v640 pol5 // using the version with med dimensions (warning, large tables)

* Visualization over five political groups, using the dummy version of the DV.
gr bar mitig01, over(pol5)

* Hacked scatterplot (shows line instead of bars).
bys pol5: egen mean_mitig01 = mean(mitig01)
sc mean_mitig01 pol5, sort(pol5) c(l) ms(i) xla(minmax) ///
	yline(.48) yti("% agreeing that euro mitigated crisis") ///
	xla(1 "Left" 5 "Right") xti("Left-right placement") ///
	by(ccode, note("Horizontal line at sample average.")) ///
	name(mitig01_pol5, replace)

* Conditional probabilities:
tab mitig01 pol5, col nof    // column percentages
tab mitig01 pol5, row nof    // rows percentages

* Significance tests:
tab mitig01 pol5, exp chi2 V
tab pol5, gen(pol5_)
prtest mitig01, by(pol5_1)
prtest mitig01, by(pol5_2)
prtest mitig01, by(pol5_3)
prtest mitig01, by(pol5_4)
prtest mitig01, by(pol5_5)


* IV: Perception of European Union
* --------------------------------

recode v182 (1=1 "Benefited") (2=0 "Not benefited"), gen(eum) // create a dummy

* Conditional probabilities:
tab mitig4 eum, col nof    // column percentages
tab mitig4 eum, row nof    // rows percentages

* Significance tests:
tab mitig4 eum, exp chi2 V exact // reminder: Cramer's V is [-1,1] on 2x2 tables
tabchi mitig4 eum, p noo noe     // Pearson residuals

* Save the crosstabulated frequencies to a matrix.
tab mitig4 eum, col matcell(odds)

* Explanatory statement.
di as txt _n ///
	"Respondents who think that their country benefited from EU membership are" _n ///
	"about " round((odds[2,1]*odds[1,2])/(odds[2,2]*odds[1,1]),.1) " times " ///
	"more likely to think that the euro mitigated the crisis" _n ///
	"than respondents who think that their country has not benefited from it." 

* Quick demonstration of odds and odds ratios (more next week).
tabodds mitig01 eum
tabodds mitig01 eum, or

* Hacked scatterplot (shows line instead of bars).
bys pol5: egen mean_eum = mean(eum)
sc mean_eum pol5, sort(pol5) c(l) ms(i) xla(minmax) ///
	yline(.72) yti("% agreeing that euro mitigated crisis") ///
	xla(1 "Left" 5 "Right") xti("Left-right placement") ///
	by(ccode, note("Horizontal line at sample average.")) ///
	name(eum_pol5, replace)


* ========
* = EXIT =
* ========


* Close log (if opened).
cap log close

* We are done. Just quit the application, have a nice week, and see you soon :)
* exit, clear