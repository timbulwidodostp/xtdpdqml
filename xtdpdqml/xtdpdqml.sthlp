{smcl}
{* *! version 1.3.1  08aug2016}{...}
{* *! Sebastian Kripfganz, www.kripfganz.de}{...}
{cmd:help xtdpdqml}{right: ({browse "http://www.stata-journal.com/article.html?article=st0463":SJ16-4: st0463})}
{hline}

{title:Title}

{p2colset 5 17 19 2}{...}
{p2col :{bf:xtdpdqml} {hline 2}}Quasi-maximum likelihood linear dynamic panel-data estimation{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{phang}
Fixed-effects (FE) model

{p 8 16 2}{cmd:xtdpdqml} {depvar} [{indepvars}] {ifin} [{cmd:, fe} {it:{help xtdpdqml##feoptions:FE_options}}]

{phang}
Random-effects (RE) model

{p 8 16 2}{cmd:xtdpdqml} {depvar} [{indepvars}] {ifin}{cmd:,} {cmd:re} [{it:{help xtdpdqml##reoptions:RE_options}}]


{marker feoptions}{...}
{synoptset 20 tabbed}{...}
{synopthdr:FE_options}
{synoptline}
{syntab:Model}
{synopt:{opt pro:jection()}}projection variables; may be specified more than once{p_end}
{synopt:{opt sta:tionary}}assume stationarity of all variables{p_end}
{synopt:{opt nocons:tant}}suppress constant term{p_end}

{syntab:SE/Robust}
{synopt :{opth vce(vcetype)}}{it:vcetype} may be {opt oim}, {opt opg}, or {opt r:obust}{p_end}

{syntab:Reporting}
{synopt:{opt mlp:arams}}display all maximum likelihood (ML) parameter estimates{p_end}
{synopt:{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
INCLUDE help shortdes-coeflegend
{synopt :{opt nohe:ader}}suppress output header{p_end}
{synopt :{opt notab:le}}suppress coefficient table{p_end}
{synopt :{opt f:irst}}show only the first equation{p_end}
{synopt :{opt neq(#)}}show only the first {it:#} equations{p_end}
{synopt :{it:{help xtdpdqml##display_options:display_options}}}control
INCLUDE help shortdes-displayoptall

{syntab:Maximization}
{synopt:{opt from(init_specs)}}initial values for the coefficients{p_end}
{synopt:{opt sto:reinit(name)}}store initial generalized method of moments
(GMM) estimation results{p_end}
{synopt:{opth initv:al(numlist)}}initial values for the variance parameters{p_end}
{synopt:{opt initi:ter(#)}}update initial values with {it:#} iterations{p_end}
{synopt:{opt conc:entration}}maximize the concentrated log-likelihood function{p_end}
{synopt:{opt method(method)}}log-likelihood evaluator method; seldom used{p_end}
{synopt:{it:{help xtdpdqml##maximize_options:maximize_options}}}control the maximization process; seldom used{p_end}
{synoptline}
{p2colreset}{...}

{marker reoptions}{...}
{synoptset 20 tabbed}{...}
{synopthdr:RE_options}
{synoptline}
{syntab:Model}
{synopt:{opt pro:jection()}}projection variables; may be specified more than once{p_end}
{synopt:{opt sta:tionary}}assume stationarity of all variables{p_end}
{synopt:{opt noef:fects}}drop the unit-specific error component from the model{p_end}
{synopt:{opt nocons:tant}}suppress constant term{p_end}

{syntab:SE/Robust}
{synopt :{opth vce(vcetype)}}{it:vcetype} may be {opt oim}, {opt opg}, or {opt r:obust}{p_end}

{syntab:Reporting}
{synopt:{opt mlp:arams}}display all ML parameter estimates{p_end}
{synopt:{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
INCLUDE help shortdes-coeflegend
{synopt :{opt nohe:ader}}suppress output header{p_end}
{synopt :{opt notab:le}}suppress coefficient table{p_end}
{synopt :{opt f:irst}}show only the first equation{p_end}
{synopt :{opt neq(#)}}show only the first {it:#} equations{p_end}
{synopt :{it:{help xtdpdqml##display_options:display_options}}}control
INCLUDE help shortdes-displayoptall

{syntab:Maximization}
{synopt:{opt from(init_specs)}}initial values for the coefficients{p_end}
{synopt:{opt sto:reinit(name)}}store initial GMM estimation results{p_end}
{synopt:{opth initv:al(numlist)}}initial values for the variance parameters{p_end}
{synopt:{opt method(method)}}log-likelihood evaluator method; seldom used{p_end}
{synopt:{it:{help xtdpdqml##maximize_options:maximize_options}}}control the maximization process; seldom used{p_end}
{synoptline}
{p2colreset}{...}

{p 4 6 2}
You must {cmd:xtset} your data before using {cmd:xtdpdqml}; see {helpb xtset:[XT] xtset}.{p_end}
{p 4 6 2}
{it:depvar}, {it:indepvars}, and all {it:varlists} may contain time-series operators; see {help tsvarlist}.{p_end}
{p 4 6 2}
See {help xtdpdqml postestimation} for features available after estimation.{p_end}


{marker description}{...}
{title:Description}

{pstd}
{cmd:xtdpdqml} implements the unconditional quasi-maximum likelihood estimator
of Bhargava and Sargan (1983) for linear dynamic panel models with RE and the
estimator of Hsiao, Pesaran, and Tahmiscioglu (2002) for linear dynamic panel
models with FE when the number of cross sections is large and the time
dimension is fixed.  In the FE case, the estimator maximizes the transformed
likelihood function after a first-difference transformation of the model.


{marker options}{...}
{title:Options}

{dlgtab:Model}

{phang}
{cmd:projection(}{varlist} [{cmd:,} {opt l:eads(#)} {opt nodi:fference}
{cmd:omit}]{cmd:)} specifies the exogenous variables that are used in the
initial-observations projection.  {opt leads(#)} restricts the number of
leads.  The default is {cmd:leads(.)}, which means that all available leads
are used.  In the FE model, first differences of {it:varlist} are used unless
{cmd:nodifference} is specified.  By default, all {it:indepvars} are used
unless {it:varlist} is excluded with {opt omit}.  You may specify as many sets
of projection variables as you need.  The options {opt nodifference} and
{cmd:omit} are seldom used.

{phang}
{opt stationary} assumes that the process of {it:depvar} started in the
infinite past, that the autoregressive coefficient is less than unity in
absolute value (which is not enforced), and that all {it:indepvars} are
stationary as well (in first differences if an FE model is fit).  As a
consequence, the initial-observations parameters are restricted to equal their
long-run values if there are no time-varying {it:indepvars}, and the constant
term in the initial-observations equation is restricted to 0 (unless an RE
model with constant term is fit).  By default, none of the parameter
restrictions are imposed.

{phang}
{opt noeffects} restricts the variance of the unit-specific error component in
the RE model to be 0.

{phang}
{opt noconstant}; see 
{helpb estimation options##noconstant:[R] estimation options}.  In the FE
model, the constant term is estimated with the two-stage approach of Kripfganz
and Schwarz (2015) unless the {opt mlparams} option is specified.

{dlgtab:SE/Robust}

INCLUDE help vce_roo

{pmore}
{cmd:vce(oim)}, the default, uses the observed information matrix.

{pmore}
{cmd:vce(opg)} uses the sum of the outer product of the gradient vectors.
This option is seldom used.

{pmore}
{cmd:vce(robust)} uses the sandwich estimator.

{dlgtab:Reporting}

{phang}
{opt mlparams} reports all quasi-maximum likelihood parameter estimates
including the model coefficients, the initial-observations coefficients, and
the variance parameters.  By default, only the model coefficients are
reported.

{phang}
{opt level(#)}; see {helpb estimation options##level():[R] estimation options}.

{phang}
{opt coeflegend}; see {helpb estimation options##coeflegend:[R] estimation options}.

{phang}
{opt noheader} suppresses display of the header above the coefficient table
that displays the number of observations.

{phang}
{opt notable} suppresses display of the coefficient table.

{phang}
{opt first} in combination with {opt mlparams} displays a coefficient table
reporting results for the first equation only and makes it appear as if only
one equation was estimated.

{phang}
{opt neq(#)} in combination with {opt mlparams} displays a coefficient table
reporting results for the first {it:#} equations.  {cmd:neq(1)} is equivalent
to {opt first}.  {cmd:neq(2)} displays the model coefficients and the
initial-observations coefficients.

{marker display_options}{...}
INCLUDE help displayopts_list

{dlgtab:Maximization}

{phang}
{opt from(init_specs)} specifies initial values for the coefficients; see
{helpb maximize:[R] maximize}.  By default, initial values are taken from GMM
estimation; see {helpb xtdpd:[XT] xtdpd}.

{phang}
{opt storeinit(name)} stores the initial GMM estimation results; see 
{helpb estimates_store:[R] estimates store}.

{phang}
{opth initval(numlist)} specifies initial values for the variance parameters.
In the FE model, at most two numbers are allowed.  The first entry refers to
the variance of the idiosyncratic error component, and the second entry refers
to the initial-observations variance relative to that of the idiosyncratic
component.  By default, the first parameter is computed from the residuals
given the initial coefficient values specified with the {opt from()} option,
and the last parameter is computed from the first-order condition of the
maximization problem given all other parameters.  In the RE model, at most
four numbers are allowed.  The first entry refers to the variance of the
unit-specific error component, the second entry refers to the variance of the
idiosyncratic error component, the third entry refers to the
initial-observations variance, and the fourth entry refers to the covariance
of the initial observations with the unit-specific error component relative to
the initial-observations variance.  Missing values are allowed to request the
default initialization.  This option is seldom used.

{phang}
{opt inititer(#)} specifies the number of iterations used to update the
initial values before maximizing the log-likelihood function of the
transformed fixed-effects model.  {cmd:inititer(0)}, the default, uses the
initial values for the coefficients and variance parameters as specified with
the {opt from()} and {opt initval()} options.  {cmd:inititer(1)} starts the
maximization with the minimum distance estimates given the estimate of the
initial-observations variance parameter from the previous step.  From the
second iteration onward, the analytical first-order condition for the
initial-observations variance parameter is evaluated at the parameter values
from the previous iteration step. Subsequently, new minimum distance estimates
are obtained for the other parameters given the updated value of the
initial-observations variance parameter.

{phang}
{opt concentration} specifies that the concentrated log-likelihood function of
the transformed FE model with the initial-observations variance as single
parameter should be maximized.  All other parameter estimates are obtained
from the analytical first-order conditions given the optimal value of the
initial-observations variance parameter.  By default, maximization is done
over all parameters simultaneously.  A concentrated log-likelihood function is
not available with the {opt stationary} option when the model is a pure
autoregressive process without additional {it:indepvars}.

{phang}
{opt method(method)} specifies the evaluator method for the log-likelihood
function, where {it:method} is one of {cmd:d0}, {cmd:d1}, or {cmd:d2} (or the
respective long form); see {helpb ml##method:[R] ml}.  The default is
{cmd:method(d2)}.  This option is seldom used.

{phang}{marker maximize_options}
{it:maximize_options}: {opt tech:nique(algorithm_spec)}, {opt iter:ate(#)},
[{cmdab:no:}]{opt lo:g}, {opt showstep}, {opt showtol:erance}, 
{opt tol:erance(#)}, {opt ltol:erance(#)}, {opt nrtol:erance(#)}, and 
{opt nonrtol:erance}; see {helpb maximize:[R] maximize}.  These options are
seldom used.  Supported {it:algorithm_spec}s are {cmd:nr}, {cmd:dfp}, and
{cmd:bfgs} (and combinations).  {cmd:iterate(0)} may be used to evaluate the
log-likelihood function at the initial parameter values.


{marker remarks}{...}
{title:Remarks}

{pstd}
See Kripfganz (2016) for background information about the implemented
estimators.

{pstd}
Unbalanced panels are supported, but groups with interior missing values
(gaps) are dropped from the estimation sample.

{pstd}
Hayakawa and Pesaran (2015) show for the FE model that the estimator is still
consistent with cross-sectional heteroskedasticity.  Robust standard errors in
this case are obtained with {cmd:vce(robust)}.

{pstd}
The minimum distance estimator of Hsiao, Pesaran, and Tahmiscioglu (2002) for
the FE model can be obtained by setting {cmd:inititer(1)} and evaluating the
log-likelihood function at the initial values, {cmd:iterate(0)}.  However, in
contrast to the maximum likelihood estimates, the resulting
variance-covariance matrix of this estimator is inconsistent because it
assumes that the true value of the initial-observations variance parameter is
known while instead an estimate is used.

{pstd}
It can occur that the initial values for the optimization are not feasible.
In the FE model, specifying {cmd:inititer(2)} or higher solves the problem.
Alternatively, the option {cmd:initval()} may help, in particular choosing its
second value (b) such that the following inequality holds for each group:

{pmore2}
b > (T - 1) / T

{pstd}
where T refers to the time length excluding the initial observations.  In the
RE model, specifying different initial values for the variance parameters with
the {cmd:initval()} option may help, in particular increasing the first or
second value, or decreasing the third or fourth value, such that the following
inequality holds for each group:

{pmore2}
b + (a - c * d^2) * T > 0

{pstd}
where a, b, c, and d refer to the first, second, third, and fourth element
specified with the {cmd:initval()} option, respectively.  When the option
{cmd:stationary} is invoked, this condition might not be sufficient to yield
feasible initial values.  In such a situation, further increasing b can be
helpful.


{marker example}{...}
{title:Example}

{pstd}
Setup{p_end}
{phang2}{bf:{stata webuse abdata:. webuse abdata}}{p_end}

{pstd}
Fit an FE model and store the initial GMM results{p_end}
{phang2}{bf:{stata xtdpdqml n w k yr1978-yr1984, storeinit(init_gmm):. xtdpdqml n w k yr1978-yr1984, storeinit(init_gmm)}}{p_end}

{pstd}
Display the initial GMM estimation results{p_end}
{phang2}{bf:{stata estimates replay init_gmm:. estimates replay init_gmm}}{p_end}

{pstd}
Fit an RE model with initial values from the FE estimation and alternative
starting values for the variance parameters{p_end}
{phang2}{bf:{stata matrix b_fe = e(b):. matrix b_fe = e(b)}}{p_end}
{phang2}{bf:{stata xtdpdqml n w k yr1978-yr1984, re from(b_fe) initval(.1 .2 .2 .3):. xtdpdqml n w k yr1978-yr1984, re from(b_fe) initval(.1 .2 .2 .3)}}{p_end}


{marker results}{...}
{title:Stored results}

{pstd}
{cmd:xtdpdqml} stores the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(N_g)}}number of groups{p_end}
{synopt:{cmd:e(g_min)}}smallest group size{p_end}
{synopt:{cmd:e(g_avg)}}average group size{p_end}
{synopt:{cmd:e(g_max)}}largest group size{p_end}
{synopt:{cmd:e(k_aux)}}number of ancillary parameters in {cmd:e(b)}{p_end}
{synopt:{cmd:e(k_eq)}}number of equations in {cmd:e(b)}{p_end}
{synopt:{cmd:e(ll)}}log likelihood{p_end}
{synopt:{cmd:e(rank)}}rank of the Hessian matrix from the {cmd:ml} optimization{p_end}
{synopt:{cmd:e(ic)}}number of iterations{p_end}
{synopt:{cmd:e(converged)}}{cmd:1} if converged, {cmd:0} otherwise{p_end}
{synopt:{cmd:e(stationary)}}{cmd:1} if option {cmd:stationary} specified{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:xtdpdqml}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}
{synopt:{cmd:e(depvar)}}name of dependent variable{p_end}
{synopt:{cmd:e(vce)}}{it:vcetype} specified in {cmd:vce()}{p_end}
{synopt:{cmd:e(vcetype)}}title used to label Std. Err.{p_end}
{synopt:{cmd:e(ml_method)}}type of {cmd:ml} method{p_end}
{synopt:{cmd:e(ivar)}}variable denoting groups{p_end}
{synopt:{cmd:e(tvar)}}variable denoting time{p_end}
{synopt:{cmd:e(properties)}}{cmd:b V}{p_end}
{synopt:{cmd:e(predict)}}program used to implement {cmd:predict}{p_end}
{synopt:{cmd:e(model)}}{cmd:fe} or {cmd:re}{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:e(b)}}coefficient vector{p_end}
{synopt:{cmd:e(ilog)}}iteration log (up to 20 iterations){p_end}
{synopt:{cmd:e(gradient)}}gradient vector{p_end}
{synopt:{cmd:e(V)}}variance-covariance matrix of the estimators{p_end}
{synopt:{cmd:e(V_modelbased)}}model-based variance; not always saved{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks estimation sample{p_end}
{p2colreset}{...}


{marker references}{...}
{title:References}

{phang}
Bhargava, A., and J. D. Sargan. 1983.  Estimating dynamic random effects
models from panel data covering short time periods.  {it:Econometrica} 51:
1635-1659.

{phang}
Hayakawa, K., and M. H. Pesaran. 2015.  Robust standard errors in transformed
likelihood estimation of dynamic panel data models with cross-sectional
heteroskedasticity.  {it:Journal of Econometrics} 188: 111-134.

{phang}
Hsiao, C., M. H. Pesaran, and A. K. Tahmiscioglu. 2002.  Maximum likelihood
estimation of fixed effects dynamic panel data models covering short time
periods.  {it:Journal of Econometrics} 109: 107-150.

{phang}
Kripfganz, S. 2016.  {browse "http://www.stata-journal.com/article.html?article=st0463":Quasi-maximum likelihood estimation of linear dynamic short-T panel-data models}. 
{it:Stata Journal} 16: 1013-1038.

{phang}
Kripfganz, S., and C. Schwarz. 2015.  Estimation of linear dynamic panel data
models with time-invariant regressors.  ECB Working Paper 1838, European
Central Bank.


{marker author}{...}
{title:Author}

{pstd}
Sebastian Kripfganz{break}
University of Exeter Business School{break}
Exeter, UK{break}
S.Kripfganz@exeter.ac.uk


{title:Also see}

{p 4 14 2}Article:  {it:Stata Journal}, volume 16, number 4: {browse "http://www.stata-journal.com/article.html?article=st0463":st0463}{p_end}

{p 7 14 2}
Help:  {help xtdpdqml postestimation} (if installed),
{manhelp maximize R},
{manhelp ml R},
{manhelp sem_command SEM:sem},
{manhelp xtabond XT},
{manhelp xtdpd XT},
{manhelp xtdpdsys XT},
{manhelp xtivreg XT},
{manhelp xtreg XT},
{manhelp xtregar XT},
{manhelp xtset XT}{p_end}
