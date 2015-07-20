#Introduction

## Before beginning
This book is designed as a companion to the [Statistical Inference](https://www.coursera.org/course/statinference)
Coursera class as part of the [Data Science Specialization](https://www.coursera.org/specialization/jhudatascience/1?utm_medium=courseDescripTop), a
ten course program offered by three faculty, Jeff Leek, Roger Peng and Brian Caffo,
at the Johns Hopkins University Department of Biostatistics.

The videos associated with this book
[can be watched in full here](https://www.youtube.com/watch?v=WkOinijQmPU&list=PLpl-gQkQivXiBmGyzLrUjzsblmQsLtkzJ),
though the relevant links to specific videos are placed at the appropriate
locations throughout.


Before beginning, we assume that you have a working knowledge
of the R programming language. If not, there is a wonderful Coursera class
by Roger Peng, [that can be found here](https://www.coursera.org/course/rprog).

The entirety of the book is on GitHub [here](https://github.com/bcaffo/LittleInferenceBook).
Please submit pull requests if you find errata! In addition the course notes can be found
also on GitHub [here](https://github.com/bcaffo/courses/tree/master/06_StatisticalInference).
While most code is in the book, *all* of the code for every figure and analysis in the
book is in the R markdown files files (.Rmd) for the respective lectures.

Finally, we should mention `swirl` (statistics with interactive R programming).
`swirl` is an intelligent tutoring system developed by Nick Carchedi, with contributions
by Sean Kross and Bill and Gina Croft. It offers a way to learn R in R.
Download `swirl` [here](http://swirlstats.com). There's a swirl
[module for this course!](https://github.com/swirldev/swirl_courses#swirl-courses).
Try it out, it's probably the most effective way to learn.

## Statistical inference defined

[Watch this video before beginning.](http://youtu.be/WkOinijQmPU?list=PLpl-gQkQivXiBmGyzLrUjzsblmQsLtkzJ)

We'll define statistical inference as the process of generating conclusions about
a population from a noisy sample. Without statistical inference we're simply
living within our data. With statistical inference, we're trying to generate
new knowledge.

Knowledge and parsimony,
(using simplest reasonable models to explain complex phenomena), go hand in hand.
Probability models will serve as our parsimonious description of the world.
The use of probability models as the connection between our data and a
populations represents the most effective way to obtain inference.

### Motivating example: who's going to win the election?

In every major election, pollsters would like to know, ahead of the
actual election, who's going to win. Here, the target of
estimation (the estimand) is clear, the percentage of people in
a particular group (city, state, county, country or other electoral
grouping) who will vote for each candidate.

We can not poll everyone. Even if we could, some polled
may change their vote by the time the election occurs.
How do we collect a reasonable subset of data and quantify the
uncertainty in the process to produce a good guess at who will win?


### Motivating example, predicting the weather

When a weatherman tells you the probability that it will rain tomorrow is
70%, they're trying to use historical data
to predict tomorrow's weather - and to actually attach a probability to it.
That probability refers to population.

### Motivating example, brain activation

An example that's very close to the research I do is trying to predict what
areas of the brain activate when a person is put in the fMRI scanner. In
that case, people are doing a task while in the scanner. For example, they
might be tapping their finger. We'd like to compare when they are
tapping their finger to when they are not tapping their finger and try to
figure out what areas of the brain are associated with the finger tapping.


## Summary notes

These examples illustrate many of the difficulties of trying
to use data to create general conclusions about a population.

Paramount among our concerns are:

* Is the sample representative of the population that we'd like to draw inferences about?
* Are there known and observed, known and unobserved or unknown and unobserved variables that contaminate our conclusions?
* Is there systematic bias created by missing data or the design or conduct of the study?
* What randomness exists in the data and how do we use or adjust for it? Here randomness can either be explicit via randomization
or random sampling, or implicit as the aggregation of many complex unknown processes.
* Are we trying to estimate an underlying mechanistic model of phenomena under study?

Statistical inference requires navigating the set of assumptions and
tools and subsequently thinking about how to draw conclusions from data.

## The goals of inference

You should recognize the goals of inference. Here we list five
examples of inferential goals.

1. Estimate and quantify the uncertainty of an estimate of
a population quantity (the proportion of people who will
  vote for a candidate).
2. Determine whether a population quantity
  is a benchmark value ("is the treatment effective?").
3. Infer a mechanistic relationship when quantities are measured with
  noise ("What is the slope for Hooke's law?")
4. Determine the impact of a policy? ("If we reduce pollution levels,
  will asthma rates decline?")
5. Talk about the probability that something occurs.


## The tools of the trade

Several tools are key to the use of statistical inference. We'll only
be able to cover a few in this class, but you should recognize them anyway.

1. *Randomization*: concerned with balancing unobserved variables that may confound inferences of interest.
2. *Random sampling*: concerned with obtaining data that is representative
of the population of interest.
3. *Sampling models*: concerned with creating a model for the sampling
process, the most common is so called "iid".
4. *Hypothesis testing*: concerned with decision making in the presence of uncertainty.
5. *Confidence intervals*: concerned with quantifying uncertainty in
estimation.
6. *Probability models*: a formal connection between the data and a population of interest. Often probability models are assumed or are
approximated.
7. *Study design*: the process of designing an experiment to minimize biases and variability.
8. *Nonparametric* bootstrapping: the process of using the data to,
  with minimal probability model assumptions, create inferences.
9. *Permutation*, randomization and exchangeability testing: the process
of using data permutations to perform inferences.

## Different thinking about probability leads to different styles of inference

We won't spend too much time talking about this, but there are several different
styles of inference. Two broad categories that get discussed a lot are:

1. *Frequency probability*: is the long run proportion of
 times an event occurs in independent, identically distributed
 repetitions.
2. *Frequency style inference*: uses frequency interpretations of probabilities
to control error rates. Answers questions like "What should I decide
given my data controlling the long run proportion of mistakes I make at
a tolerable level."
3. *Bayesian probability*: is the probability calculus of beliefs, given that beliefs follow certain rules.
4. *Bayesian style inference*: the use of Bayesian probability representation
of beliefs to perform inference. Answers questions like "Given my subjective beliefs and the objective information from the data, what
should I believe now?"

Data scientists tend to fall within shades of gray of these and various other schools of inference.
Furthermore, there are so many shades of gray between the styles of inferences
that it is hard to pin down most modern statisticians as either Bayesian or
frequentist. In this class, we will primarily focus on basic sampling models,
basic probability models and frequency style analyses
to create standard inferences. This is the most popular style of inference by far.

Being data scientists,  we will also consider some inferential strategies that  
rely heavily on the observed data, such as permutation testing
and bootstrapping. As probability modeling will be our starting point, we first build
up basic probability as our first task.

## Exercises

1. The goal of statistical inference is to?
  - Infer facts about a population from a sample.
  - Infer facts about the sample from a population.
  - Calculate sample quantities to understand your data.
  - To torture Data Science students.
2. The goal of randomization of a treatment in a randomized trial is to?
  - It doesn't really do anything.
  - To obtain a representative sample of subjects from the population of interest.
  - Balance unobserved covariates that may contaminate the comparison between the treated and control groups.
  - To add variation to our conclusions.
3. Probability is a?
  - Population quantity that we can potentially estimate from data.
  - A data quantity that does not require the idea of a population.
