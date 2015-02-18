# P-values

## Introduction to P-values
[Watch this video before beginning](http://youtu.be/Ky68x_7iK6c?list=PLpl-gQkQivXiBmGyzLrUjzsblmQsLtkzJ)

P-values are the most common measure of statistical significance.
Their ubiquity, along with concern over their interpretation and use
makes them controversial among statisticians.
The following manuscripts are interesting reads about P-values.

* [http://warnercnr.colostate.edu/~anderson/thompson1.html](http://warnercnr.colostate.edu/~anderson/thompson1.html)
* [Also see *Statistical Evidence: A Likelihood Paradigm* by Richard Royall](http://www.crcpress.com/product/isbn/9780412044113)
* [*Toward Evidence-Based Medical Statistics. 1: The P Value Fallacy* by Steve Goodman](https://scholar.google.com/scholar?q=towards+evidence+based+medical+statistics+the+p-value+fallacy&hl=en&as_sdt=0&as_vis=1&oi=scholart&sa=X&ei=uOTjVNHdG4anggSMlYOwBQ&ved=0CBsQgQMwAA)
* The hilariously titled: [*The Earth is Round (p < .05)* by Cohen.](http://www.scopus.com/record/display.url?eid=2-s2.0-0039802908&origin=inward&txGid=BBE363C58BE8785BFF9E71AB60004733.ZmAySxCHIBxxTXbnsoe5w%3a2)
* Some positive comments
  * [simply statistics](http://simplystatistics.org/2012/01/06/p-values-and-hypothesis-testing-get-a-bad-rap-but-we/)
  * [normal deviate](http://normaldeviate.wordpress.com/2013/03/14/double-misunderstandings-about-p-values/)
  * [Error statistics](http://errorstatistics.com/2013/06/14/p-values-cant-be-trusted-except-when-used-to-argue-that-p-values-cant-be-trusted/)


## What is a P-value?

The central idea of a P-value is to assume that the null hypothesis is true and
calculate how unusual it would be to see data as extreme as was seen
in favor of the alternative hypothesis. The formal definition is:

A **P-value** is the probability of observing data as or more extreme in
favor of the alternative that was actually obtained, where the probability
is calculated assuming that the null hypothesis is true.


A P-value then requires a few steps.
1. Decide on a statistic that evaluates support of the null or alternative hypothesis.
2. Decide on a distribution of that statistic under the null hypothesis (null distribution).
3. Calculate the probability of obtaining a statistic as or more extreme as was observed
using the distribution in 2.

The way to interpret P-values is as follows. If the P-value is small, then either $H_0$ is true and we have observed a rare event or $H_0$ is false (or possibly the null model is incorrect).

Let's do a quick example. Suppose that you get a $T$ statistic of 2.5
for 15 degrees of freedom  testing {$$}H_0:\mu = \mu_0{/$$}
versus {$$}H_a : \mu > \mu_0{/$$}.
What's the probability of getting a $T$ statistic as large as 2.5?

{title="P-value calculation in R.", line-numbers=off,lang=r}
~~~
> pt(2.5, 15, lower.tail = FALSE)
[1] 0.01225
~~~

Therefore, the probability of seeing evidence as extreme or more extreme than that actually obtained under {$$}H_0{/$$} is 0.0123. So, (assuming our model is correct)
either we observed data that was pretty unlikely under the null, or the null
hypothesis if false.

## The attained significance level

Recall in a previous chapter that our
test statistic was 2 for {$$}H_0 : \mu_0  = 30{/$$} versus {$$}H_a:\mu > 30{$$}
using a normal test ({$$}n{/$$} was 100). Notice that we rejected the one
sided test when {$$}\alpha = 0.05{/$$}, would we reject if {$$}\alpha = 0.01{/$$},
how about 0.001?

The smallest value for alpha that you still reject the null hypothesis is called
the *attained significance level*.
This is mathematically equivalent, but philosophically a little different from,
the *P-value*. Whereas the P-value is interpreted in the terms of how
probabilistically extreme our test statistic is under the null, the attained
significance level merely conveys what the smallest level of {$$}\alpha{/$$}
that one could reject at.


This equivalence makes P-values very convenient to convey. The reader of
the results can perform the test at whatever {$$}\alpha{/$$} he or she
choses. This is especially useful in multiple testing circumstances.

Here's the two rules for performing hypothesis tests with P-values.
* If the P-value for a test is less than {$$}\alpha{/$$} you reject the null hypothesis
* For two sided hypothesis test, double the smaller of the two one
  sided hypothesis test Pvalues


## Binomial P-value example
Suppose a friend has 8 children, 7 of which are girls and none are twins.
If each gender has an independent 50% probability for each birth,
what's the probability of getting 7 or more girls out of 8 births?

This calculation is a P-value where the statistic is the number of girls
and the null distribution is a fair coin flip for each gender. We want to test
{$$}H_0: p=0.5{/$$} versus {$$}H_a: p > 0.5{/$$}, where {$$}p{/$$} is the
probability of having a girl for each birth.

Recall here's the calculation:

{title="Example of a Binomial P-value calculation in R.", line-numbers=off,lang=r}
~~~
> pbinom(6, size = 8, prob = 0.5, lower.tail = FALSE)
[1] 0.03516
~~~

Since our P-value is less than 0.05 we would reject at a 5% error rate. Note,
however, if we were doing a two sided test, we would have to double the P-value
and thus would then fail to reject.

## Poisson example
[Watch this video before beginning.](http://youtu.be/Tcw2OVyEX3s?list=PLpl-gQkQivXiBmGyzLrUjzsblmQsLtkzJ )

Suppose that a hospital has an infection rate of
10 infections per 100 person/days at risk (rate of 0.1)
during the last monitoring period. Assume that an infection rate of 0.05
is an important benchmark.

Given a Poisson model, could the observed rate being larger than
0.05 be attributed to chance? We want to test {$$}H_0: \lambda = 0.05{/$$}
where {$$}\lambda{/$$} is the rate of infections per person day so that
5 would be the rate per 100 days. Thus we want to know if 9 events per
100 person/days is unusual
with respect to a Poisson distribution with a rate of 5 events per 100.
Consider $H_a: \lambda > 0.05$.

{title="Poisson P-value calculation.", line-numbers=off,lang=r}
~~~
> ppois(9, 5, lower.tail = FALSE)
[1] 0.03183
~~~

Again, since this P-value is less than 0.05 we reject the null hypothesis.
The P-value would be 0.06 for  two sided hypothesis (double) and so we would
fail to reject in that case.
