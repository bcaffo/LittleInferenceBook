# The bootstrap and resampling

## The bootstrap
[Watch this video before beginning.](http://youtu.be/0hNQx9nagq4?list=PLpl-gQkQivXiBmGyzLrUjzsblmQsLtkzJ)

The bootstrap is a tremendously useful tool for constructing confidence intervals and
calculating standard errors for difficult statistics.
For a classic example, how would one derive a confidence interval for the median?
The bootstrap procedure follows from the so called bootstrap principle

To illustrate the bootstrap principle, imagine a die roll. The image below shows the
mass function of a die roll on the left. On the right we show the empirical distribution
obtained by repeatedly averaging 50 independent die rolls. By this simulation, without
any mathematics, we have a good idea of what the distribution of averages of 50 die
rolls looks like.

![Image of true die roll distribution (left) and simulation of averages of 50 die rolls](images/bootstrapping1.png)

Now imagine a case where we didn't know whether or not the die was fair. We have a sample of
size 50 and we'd like to investigate the distribution of the average of 50 die rolls
*where we're not allowed to roll the die anymore*. This is more like a real data analysis, we only get one sample
from the population.

![Image of empirical die roll distribution (left) and simulates of averages of 50 die rolls from this distribution](images/bootstrapping2.png)

The bootstrap principle is to use the empirical mass function of the data to perform the simulation,
rather than the true distribution. That is, we simulate averages of 50 samples
from the histogram that we observe. With enough data, the empirical distribution should be a good estimate of the
true distribution and this should result in a good approximation of the sampling distribution.

That's the bootstrap principle: investigate the sampling distribution of a statistic by simulating repeated
realizations from the observed distribution.

If we could simulate from the true distribution, then we would know the exact sampling distribution of our statistic (if we
  ran our computer long enough.) However, since we only get to sample from that distribution once, we have to be
content with using the empirical distribution. This is the clever idea of the bootstrap.


### Example Galton's fathers and sons dataset

The code below creates resamples via draws of size n with replacement with the original data
 of the son's heights from Galton's data
and plots a histrogram of the median of each resampled dataset.

{title="Bootstrapping example", lang=r, line-numbers=off}
~~~
library(UsingR)
data(father.son)
x <- father.son$sheight
n <- length(x)
B <- 10000
resamples <- matrix(sample(x,
                           n * B,
                           replace = TRUE),
                    B, n)
resampledMedians <- apply(resamples, 1, median)
~~~

![Bootstrapping example for the median of sons' heights from Galton's ](images/bootstrapping3.png)

### The bootstrap principle

Suppose that I have a statistic that estimates some population parameter, but I don't know its sampling distribution.
The bootstrap principle suggests using the distribution defined by the data to approximate its sampling distribution


### The bootstrap in practice

In practice, the bootstrap principle is always carried out using simulation.
We will cover only a few aspects of bootstrap resampling.
The general procedure follows by first simulating complete data sets from the observed data with replacement.
This is approximately drawing from the sampling distribution of that statistic, at least as far as the data is
able to approximate the true population distribution. Calculate the statistic for each simulated data set
Use the simulated statistics to either define a confidence interval or take the standard deviation to calculate a standard error.

### Nonparametric bootstrap algorithm example

Bootstrap procedure for calculating confidence interval for the median from a data set of $n$ observations

  i. Sample $n$ observations **with replacement** from the observed data resulting in one simulated complete data set
  ii. Take the median of the simulated data set
  iii. Repeat these two steps $B$ times, resulting in $B$ simulated medians
  iv. These medians are approximately drawn from the sampling distribution of the median of $n$ observations; therefore we can
    - Draw a histogram of them
    - Calculate their standard deviation to estimate the standard error of the median
    - Take the $2.5^{th}$ and $97.5^{th}$ percentiles as a confidence interval for the median

### Example code

Consider our father/son data from before. Here is
the relevant code for doing the resampling.

{lang=r,line-numbers=off}
~~~
B <- 10000
resamples <- matrix(sample(x,
                           n * B,
                           replace = TRUE),
                    B, n)
medians <- apply(resamples, 1, median)
~~~

And here is some results.

{lang=r,line-numbers=off}
~~~
> sd(medians)
[1] 0.08424
~~~

Thus, 0.084 estimates the standard error of the median for this data set. It did this
by repeatedly sampling medians from the observed distribution and taking the standard deviation
of the resulting collection of medians. Taking the 2.5 and 97.5 percentiles gives us a
bootstrap 95% confidence interval for the median.

{lang=r,line-numbers=off}
~~~
> quantile(medians, c(.025, .975))
 2.5% 97.5%
68.43 68.81
~~~

We also always want to plot a histrogram or density estimate of our simulated statistic.

{lang=r,line-numbers=off}
~~~
g = ggplot(data.frame(medians = medians), aes(x = medians))
g = g + geom_histogram(color = "black", fill = "lightblue", binwidth = 0.05)
g
~~~

![Bootstrapping example for the median of sons' heights from Galton's ](images/bootstrapping3.png)

### Notes on the bootstrap

- The bootstrap is non-parametric.
- Better percentile bootstrap confidence intervals correct for bias.
- There are lots of variations on bootstrap procedures; the book "An Introduction to the Bootstrap"" by Efron and Tibshirani is a great place to start for both bootstrap and jackknife information.

## Group comparisons
Consider comparing two independent groups. Example, comparing sprays B and C.

{lang=r,line-numbers=off}
~~~
data(InsectSprays)
g = ggplot(InsectSprays, aes(spray, count, fill = spray))
g = g + geom_boxplot()
g
~~~

![Comparison of insect spray.](images/bootstrapping4.png)

## Permutation tests
-  Consider the null hypothesis that the distribution of the observations from each group is the same
-  Then, the group labels are irrelevant
- Consider a data from with count and spray
- Permute the spray (group) labels
- Recalculate the statistic
  - Mean difference in counts
  - Geometric means
  - T statistic
- Calculate the percentage of simulations where
the simulated statistic was more extreme (toward
the alternative) than the observed


## Variations on permutation testing
Data type | Statistic | Test name
---|---|---|
Ranks | rank sum | rank sum test
Binary | hypergeometric prob | Fisher's exact test
Raw data | | ordinary permutation test

- Also, so-called *randomization tests* are exactly permutation tests, with a different motivation.
- For matched data, one can randomize the signs
  - For ranks, this results in the signed rank test
- Permutation strategies work for regression as well
  - Permuting a regressor of interest
- Permutation tests work very well in multivariate settings


## Permutation test B v C

subdata <- InsectSprays[InsectSprays$spray %in% c("B", "C"),]
{title="Permutation distribution for the insect sprays dataset", lang=r,line-numbers=off}
~~~
y <- subdata$count
group <- as.character(subdata$spray)
testStat <- function(w, g) mean(w[g == "B"]) - mean(w[g == "C"])
observedStat <- testStat(y, group)
permutations <- sapply(1 : 10000, function(i) testStat(y, sample(group)))
~~~

Let's look at some of the results. First let's look at the observed statistic.

{lang=r,line-numbers=off}
~~~
> observedStat
[1] 13.25
~~~

{lang=r,line-numbers=off}
~~~
mean(permutations > observedStat)
[1] 0
~~~

## Histogram of permutations B v C

![Permutation distribution from the insectsprays dataset](images/bootstrapping4.png)

## Exercises
