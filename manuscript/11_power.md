# Power

## Power
[Watch this video before beginning](http://youtu.be/-TsBOLiW4rQ?list=PLpl-gQkQivXiBmGyzLrUjzsblmQsLtkzJ)
and then
[watch this video as well.](http://youtu.be/GRS2b1aedmk?list=PLpl-gQkQivXiBmGyzLrUjzsblmQsLtkzJ)

Power is the probability of rejecting the null hypothesis when it is false.
Ergo, power (as its name would suggest) is a good thing; you want more power.
A type II error (a bad thing, as its name would suggest) is failing to reject
the null hypothesis when it's false; the probability of a type II error is
usually called {$$}\beta{/$$}. Note Power  {$$}= 1 - \beta{/$$}.

Let's go through an example of calculating power.
Consider our previous example involving RDI.
{$$}H_0: \mu = 30{/$$} versus {$$}H_a: \mu > 30{/$$}.
Then power is:

{$$}P\left(\frac{\bar X - 30}{s /\sqrt{n}} > t_{1-\alpha,n-1} ~;~ \mu = \mu_a \right).{/$$}

Note that this is a function that depends on the specific value of $\mu_a$!
Further notice that as {$$}\mu_a{/$$} approaches 30 the power approaches {$$}\alpha{/$$}.


Pushing this example further, we reject if

{$$}Z = \frac{\bar X - 30}{\sigma /\sqrt{n}} > z_{1-\alpha}{/$$}

Or, equivalently, if

{$$}\bar X > 30 + Z_{1-\alpha} \frac{\sigma}{\sqrt{n}}{/$$}

But, note that, under {$$}H_0 : \bar X \sim N(\mu_0, \sigma^2 / n){/$$}.
However, under {$$}H_a : \bar X \sim N(\mu_a, \sigma^2 / n){/$$}.

So in general for this test we we want:

{title="Power calculation for the sleep example in R", lang=r, line-numbers=off}
~~~
alpha = 0.05
z = qnorm(1 - alpha)
pnorm(mu0 + z * sigma/sqrt(n), mean = mua, sd = sigma/sqrt(n), lower.tail = FALSE)
~~~

Let's plug in the specific numbers for our example where:
{$$}\mu_a = 32{/$$}, {$$}\mu_0 = 30{/$$}, {$$}n =16{/$$}, {$$}\sigma = 4{/$$}.

{lang=r, line-numbers=off}
~~~
> mu0 = 30
> mua = 32
> sigma = 4
> n = 16
> z = qnorm(1 - alpha)
> pnorm(mu0 + z * sigma/sqrt(n), mean = mu0, sd = sigma/sqrt(n), lower.tail = FALSE)
[1] 0.05
> pnorm(mu0 + z * sigma/sqrt(n), mean = mua, sd = sigma/sqrt(n), lower.tail = FALSE)
[1] 0.6388
~~~

So, when we plug in {$$}\mu_0{\$$}, the value under the null hypothesis, we
get that the probability of rejection is 5%, as the test was designed. However,
when we plug in a value of 32, we get 64%. Therefore, the probability of
rejection is 64% when the true value of {$$}\mu{\$$} is 32. We could create
a curve of the power as a function of {$$}\mu_a{\$$}, as seen below.
We also varied the sample size to see how the curve depends on that.

![Plot of power as {$$}\mu_a{/$$} varies.](images/powerCurve.png)

The code below shows how to use manipulate to investigate power
as the various inputs change.

{title="Code for investigating power.", line-numbers=off, lang=r}
~~~
library(manipulate)
mu0 = 30
myplot <- function(sigma, mua, n, alpha) {
    g = ggplot(data.frame(mu = c(27, 36)), aes(x = mu))
    g = g + stat_function(fun = dnorm, geom = "line", args = list(mean = mu0,
        sd = sigma/sqrt(n)), size = 2, col = "red")
    g = g + stat_function(fun = dnorm, geom = "line", args = list(mean = mua,
        sd = sigma/sqrt(n)), size = 2, col = "blue")
    xitc = mu0 + qnorm(1 - alpha) * sigma/sqrt(n)
    g = g + geom_vline(xintercept = xitc, size = 3)
    g
}
manipulate(myplot(sigma, mua, n, alpha), sigma = slider(1, 10, step = 1, initial = 4),
    mua = slider(30, 35, step = 1, initial = 32), n = slider(1, 50, step = 1,
        initial = 16), alpha = slider(0.01, 0.1, step = 0.01, initial = 0.05))
~~~

## Question
[Watch this video before beginning.](http://youtu.be/3bWhP5MyuqI?list=PLpl-gQkQivXiBmGyzLrUjzsblmQsLtkzJ)

 When testing $H_a : \mu > \mu_0$, notice if power is $1 - \beta$, then

{$$}1 - \beta = P\left(\bar X > \mu_0 + z_{1-\alpha} \frac{\sigma}{\sqrt{n}} ; \mu = \mu_a \right){/$$}

where {$$}\bar X \sim N(\mu_a, \sigma^2 / n){/$$}. The
unknowns in the equation are: {$$}\mu_a{/$$}, {$$}\sigma{/$$}, {$$}n{/$$},
{$$}\beta{/$$} and the knowns are: {$$}\mu_0{/$$}, {$$}\alpha{/$$}.
Specify any 3 of the unknowns and you can solve for the remainder.

## Notes
- The calculation for {$$}H_a:\mu < \mu_0{/$$} is similar
- For {$$}H_a: \mu \neq \mu_0{/$$} calculate the one sided power using
  {$$}\alpha / 2{/$$} (this is only approximately right, it excludes the probability of
  getting a large TS in the opposite direction of the truth)
- Power goes up as {$$}\alpha{/$$} gets larger
- Power of a one sided test is greater than the power of the
  associated two sided test
- Power goes up as {$$}\mu_1{/$$} gets further away from $\mu_0$
- Power goes up as {$$}n{/$$} goes up
- Power doesn't need {$$}\mu_a{/$$}, {$$}\sigma{/$$} and {$$}n{/$$}, instead only {$$}\frac{\sqrt{n}(\mu_a - \mu_0)}{\sigma}{/$$}
  - The quantity {$$}\frac{\mu_a - \mu_0}{\sigma}{/$$} is called the *effect size*, the difference in the means in standard deviation units.
  - Being unit free, it has some hope of interpretability across settings.

## T-test power
[Watch this before beginning](http://youtu.be/1DiwutNpt5Y?list=PLpl-gQkQivXiBmGyzLrUjzsblmQsLtkzJ)

Consider calculating power for a Gossett's *t* test for our example where
we now assume that {$$}n=16{/$$}. The power is

{$$}
P\left(\frac{\bar X - \mu_0}{S /\sqrt{n}} > t_{1-\alpha, n-1} ~;~ \mu = \mu_a \right)
{/$$}

Calculating this requires the so-called non-central t distribution.
However, fortunately for us, the R function `r power.t.test` does this very well.
Omit (exactly) any one of the arguments and it solves for it. Our t-test
power again only relies on the effect size.

Let's do our example trying different options.

{title="Example of using 'power.t.test' in R.",lang=r,line-numbers=off}
~~~
# omitting the power and getting a power estimate
> power.t.test(n = 16, delta = 2/4, sd = 1, type = "one.sample", alt = "one.sided")$power
[1] 0.604
# illustrating that it depends only on the effect size, delta/sd
> power.t.test(n = 16, delta = 2, sd = 4, type = "one.sample", alt = "one.sided")$power
[1] 0.604
# same thing again
> power.t.test(n = 16, delta = 100, sd = 200, type = "one.sample", alt = "one.sided")$power
[1] 0.604
# specifying the power and getting n
> power.t.test(power = 0.8, delta = 2/4, sd = 1, type = "one.sample", alt = "one.sided")$n
[1] 26.14
# again illustrating that the effect size is all that matters
power.t.test(power = 0.8, delta = 2, sd = 4, type = "one.sample", alt = "one.sided")$n
[1] 26.14
# again illustrating that the effect size is all that matters
> power.t.test(power = 0.8, delta = 100, sd = 200, type = "one.sample", alt = "one.sided")$n
[1] 26.14
~~~
