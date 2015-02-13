
# Variation
[Watch this video before beginning.](http://youtu.be/oLQVU-VRiHo?list=PLpl-gQkQivXiBmGyzLrUjzsblmQsLtkzJ)

## The variance
Recall that the mean of distribution was a measure of its center.
The variance, on the other hand, is a measure of *spread*.
To get a sense, the plot below shows a series of increasing
variances.
![Distributions with increasing variance](images/variances.png)

We saw another example
of how variances changed in the last chapter when we looked at the distribution of averages; they were always centered
at the same spot as the original distribution, but are less spread out.
Thus, it is less likely for sample means to be far away from the population
mean than it is for individual observations. (This is why the sample mean is
  a better estimate than the population mean.)

If {$$}X{/$$} is a random variable with mean {$$}\mu{/$$}, the variance of
{$$}X{/$$} is defined as

{$$}
Var(X) = E[(X - \mu)^2] = E[X^2] - E[X]^2
{/$$}

The rightmost equation is the shortcut formula that is almost always used
for calculating variances in practice.  
Thus the variance is the expected (squared) distance from the mean.  
Densities with a higher variance are more spread out than densities with
a lower variance. The square root of the variance is called the
**standard deviation**. The main benefit of working with standard deviations
is that they have the same units as the data, whereas the variance has the
units squared.

In this class, we'll only cover a few basic examples for calculating a variance.
Otherwise, we're going to use the idea. Also remember, what we're talking
about is the population variance. It measures how spread out the population
of interest is, unlike the sample variance which measures how spread out the
observed data are. Just like the sample mean estimates the
population mean, the sample variance will estimate the population variance.



### Example

What's the variance from the result of a toss of a die?
First recall that {$$}E[X] = 3.5{/$$}, as we discussed in the previous lecture.
Then let's calculate the other bit of information that we need, {$$}E[X^2]{/$$}.

{$$}E[X^2] = 1 ^ 2 \times \frac{1}{6} + 2 ^ 2 \times \frac{1}{6} + 3 ^ 2 \times \frac{1}{6} + 4 ^ 2 \times \frac{1}{6} + 5 ^ 2 \times \frac{1}{6} + 6 ^ 2 \times \frac{1}{6} = 15.17{/$$}

Thus now we can calculate the variance as:

{$$}Var(X) = E[X^2] - E[X]^2 \approx 2.92.{/$$}


## Example

What's the variance from the result of the toss of a
(potentially biased) coin with probability of heads (1) of {$$}p{/$$}?

First recall that
{$$}E[X] = 0 \times (1 - p) + 1 \times p = p.{/$$}

Secondly, recall that since {$$}X{/$$} is either 0 or 1,
{$$}X^2 = X{/$$}. So we know that:

{$$}E[X^2] = E[X] = p{/$$}

Thus we can now calculate the variance of a coin flip as
{$$}Var(X) = E[X^2] - E[X]^2 = p - p^2 = p(1 - p).{/$$}

This is a well known formula, so it's worth committing
to memory. It's interesting to note that this function is
maximized at {$$}p = 0.5{/$$}.

{title="Plotting the binomial variance", line-numbers=off,lang=r}
~~~
p = seq(0 , 1, length = 1000)
y = p * (1 - p)
plot(p, y, type = "l", lwd = 3, frame = FALSE)
~~~

![Plot of the binomial variance](images/binomialVariance.png)

## The sample variance
The sample variance is the estimator of the population
variance. Recall that the population variance is the
expected squared deviation around the population mean.
The sample variance is (almost) the average squared deviation
of observations around the sample mean. It is given by

{$$}
S^2 = \frac{\sum_{i=1} (X_i - \bar X)^2}{n-1}
{/$$}

The sample standard deviation is the square root of the sample variance.

The sample variance is almost, but not quite, the average squared deviation from
the sample mean since we divide by {$$}n-1{/$$} instead of
{$$}n{/$$}. Why do we do this you might ask? To answer that question
we have to think in the terms of simulations. Remember that the
sample variance is a random variable, thus it has a distribution
and that distribution has an associated population mean. That
mean is the population variance that we're trying to estimate
if we divide by {$$}(n-1){/$$} rather than {$$}n{/$$}.

Moreover, as we collect more data, the distribution of the
sample variance gets more concentrated around the population
variance that it's estimating.

## Simulation experiments
### Simulating from a population with variance 1
Let's try simulating collections of standard normals and taking the variance.
If we repeat this over and over, we get a sense of the distribution of
sample variances variances.

![Simulation of variances of samples of standard normals](images/normalVariances.png)

Notice that these histograms are always centered in the same spot, 1. In
other words, the sample variance is an unbiased estimate of the population
variances. Notice also that they get more concentrated around the 1 as
more data goes into them. Thus, sample variances comprised of more observations
are less variable than sample variances comprised of fewer.

### Variances of x die rolls
Let's try the same thing, now only with die rolls instead of simulating standard
normals. In this experiment, we simulated samples of die rolls, took the
variance and then repeated that process over and over. What is plotted
are histograms of the collections of sample variances.



<!--

---

## Recall the mean
- Recall that the average of random sample from a population
is itself a random variable
- We know that this distribution is centered around the population
mean, $E[\bar X] = \mu$
- We also know what its variance is $Var(\bar X) = \sigma^2 / n$
- This is very useful, since we don't have repeat sample means
to get its variance; now we know how it relates to
the population variance
- We call the standard deviation of a statistic a standard error

---
## To summarize
- The sample variance, $S^2$, estimates the population variance, $\sigma^2$
- The distribution of the sample variance is centered around $\sigma^2$
- The variance of the sample mean is $\sigma^2 / n$
  - Its logical estimate is $s^2 / n$
  - The logical estimate of the standard error is $S / \sqrt{n}$
- $S$, the standard deviation, talks about how variable the population is
- $S/\sqrt{n}$, the standard error, talks about how variable averages of random samples of size $n$ from the population are

---
## Simulation example
Standard normals have variance 1; means of $n$ standard normals
have standard deviation $1/\sqrt{n}$


```r
nosim <- 1000
n <- 10
sd(apply(matrix(rnorm(nosim * n), nosim), 1, mean))
```

```
## [1] 0.3156
```

```r
1 / sqrt(n)
```

```
## [1] 0.3162
```


---
## Simulation example
Standard uniforms have variance $1/12$; means of
random samples of $n$ uniforms have sd $1/\sqrt{12 \times n}$



```r
nosim <- 1000
n <- 10
sd(apply(matrix(runif(nosim * n), nosim), 1, mean))
```

```
## [1] 0.09017
```

```r
1 / sqrt(12 * n)
```

```
## [1] 0.09129
```


---
## Simulation example
Poisson(4) have variance $4$; means of
random samples of $n$ Poisson(4) have sd $2/\sqrt{n}$



```r
nosim <- 1000
n <- 10
sd(apply(matrix(rpois(nosim * n, 4), nosim), 1, mean))
```

```
## [1] 0.6219
```

```r
2 / sqrt(n)
```

```
## [1] 0.6325
```


---
## Simulation example
Fair coin flips have variance $0.25$; means of
random samples of $n$ coin flips have sd $1 / (2 \sqrt{n})$



```r
nosim <- 1000
n <- 10
sd(apply(matrix(sample(0 : 1, nosim * n, replace = TRUE),
                nosim), 1, mean))
```

```
## [1] 0.1587
```

```r
1 / (2 * sqrt(n))
```

```
## [1] 0.1581
```

---
## Data example

```r
library(UsingR); data(father.son);
x <- father.son$sheight
n<-length(x)
```

---
## Plot of the son's heights
<img src="assets/fig/unnamed-chunk-9.png" title="plot of chunk unnamed-chunk-9" alt="plot of chunk unnamed-chunk-9" style="display: block; margin: auto;" />

---
## Let's interpret these numbers

```r
round(c(var(x), var(x) / n, sd(x), sd(x) / sqrt(n)),2)
```

```
## [1] 7.92 0.01 2.81 0.09
```

<img src="assets/fig/unnamed-chunk-11.png" title="plot of chunk unnamed-chunk-11" alt="plot of chunk unnamed-chunk-11" style="display: block; margin: auto;" />


---
## Summarizing what we know about variances
- The sample variance estimates the population variance
- The distribution of the sample variance is centered at
what its estimating
- It gets more concentrated around the population variance with larger sample sizes
- The variance of the sample mean is the population variance
divided by $n$
  - The square root is the standard error
- It turns out that we can say a lot about the distribution of
averages from random samples,
even though we only get one to look at in a given data set
-->
