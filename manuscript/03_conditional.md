# Conditional probability

## Conditional probability, motivation
[Watch this video before beginning.](http://youtu.be/u6AH6qsSVA4?list=PLpl-gQkQivXiBmGyzLrUjzsblmQsLtkzJ)

Conditioning a central subject in statistics.
If we are given information about a random variable, it changes
the probabilities associated with it. For example,
the probability of getting a one when rolling a (standard) die
is usually assumed to be one sixth. If you were given the extra information
that the die roll was an odd number (hence 1, 3 or 5)
then *conditional on this new information*, the probability of a
one is now one third.

This is the idea of conditioning, taking away the randomness that we know
to have occurred. Consider another example, such as the result of a diagnostic
imaging test for lung cancer. What's the probability
that a person has cancer given a positive test? How does that probability
change under the knowledge that a patient has been a lifetime heavy smoker
and both of their parents had lung cancer? *Conditional* on this new information,
the probability has increased dramatically.

## Conditional probability, definition

We can formalize the definition of conditional probability so that the mathematics
matches our intuition.

Let {$$}B{/$$} be an event so that {$$}P(B) > 0{/$$}.
Then the conditional probability of an event {$$}A{/$$} given
that {$$}B{/$$} has occurred is:

{$$}
P(A ~|~ B) = \frac{P(A \cap B)}{P(B)}.
{/$$}

If {$$}A{/$$} and {$$}B{/$$} are unrelated in any way, or in other words
*independent*, (disccussed more later in the lecture), then

{$$}
P(A ~|~ B) = \frac{P(A) P(B)}{P(B)} = P(A)
{/$$}

That is, if the occurrence of {$$}B{/$$} offers no information about the
occurrence of {$$}A{/$$} - the probability conditional on the information
is the same as the probability without the information, we say that the
two events are independent.


### Example

Consider our die roll example again. Here we have that
{$$}B = \{1, 3, 5\}{/$$} and  {$$}A = \{1\}{/$$}

{$$}
P(\mbox{one given that roll is odd}) = P(A ~|~ B)
= \frac{P(A \cap B)}{P(B)}
= \frac{P(A)}{P(B)}
= \frac{1/6}{3/6} = \frac{1}{3}
{/$$}

Which exactly mirrors our intuition.


## Bayes' rule
[Watch this video before beginning](http://youtu.be/TfeaZ_26iQk?list=PLpl-gQkQivXiBmGyzLrUjzsblmQsLtkzJ)

Baye's rule is a famous result in statistics and probability. It forms
the foundation for large branches of statistical thinking.
Baye's rule allows us to reverse the conditioning set provided
that we know some marginal probabilities.

Why is this useful? Consider our lung cancer example again. It would be
relatively easy for physicians to calculate the probability that the
diagnostic method is positive for people with lung cancer and negative for
people without. They could take several people who are already known to
have the disease and apply the test and conversely take people known not
to have the disease. However, for the collection of people with a positive
test result, the reverse probability is more of interest, "given a positive
test what is the probability of having the disease?", and "given a given
a negative test what is the probability of not having the disease?".

Baye's rule allows us to switch the conditioning event, provided a little
bit of extra information. Formally Baye's rule is:

{$$}
P(B ~|~ A) = \frac{P(A ~|~ B) P(B)}{P(A ~|~ B) P(B) + P(A ~|~ B^c)P(B^c)}.
{/$$}

### Diagnostic tests
Since diagnostic tests are a really good example of Baye's rule in practice,
let's go over them in greater detail. (In addition, understanding Baye's rule
will be helpful for your own ability to understand medical tests that you
see in your daily life). We require a few definitions first.

Let {$$}+{/$$} and {$$}-{/$$} be the events that the result of a
diagnostic test is positive or negative respectively
Let {$$}D{/$$} and {$$}D^c{/$$} be the event that the subject of the
test has or does not have the disease respectively

The **sensitivity** is the probability that the test is positive given
that the subject actually has the disease, {$$}P(+ ~|~ D){/$$}

The **specificity** is the probability that the test is negative given that
the subject does not have the disease, {$$}P(- ~|~ D^c){/$$}

So, conceptually at least, the sensitivity and specificity are straightforward
to estimate. Take people known to have and not have the disease and apply the
diagnostic test to them. However, the reality of estimating these quantities
is quite challenging. For example, are the people known to have the disease
in its later stages, while the diagnostic will be used on people in the early
stages where it's harder to detect? Let's put these subtleties to the side
and assume that they are known well.

The quantities that we'd like to know are the predictive values.

The **positive predictive value** is the probability that the subject has the  disease given that the test is positive, {$$}P(D ~|~ +){/$$}

The **negative predictive value** is the probability that the subject does not have the disease given that the test is negative, {$$}P(D^c ~|~ -){/$$}

Finally, we need one last thing, the **prevalence of the disease** -
which is the marginal probability of disease, {$$}P(D){/$$}. Let's now
try to figure out a PPV in a specific setting.

### Example

A study comparing the efficacy of HIV tests, reports on an experiment which
concluded that HIV antibody tests have a sensitivity of 99.7% and a specificity of 98.5%
Suppose that a subject, from a population with a .1% prevalence of HIV, receives a positive test result. What is the positive predictive value?

Mathematically, we want $P(D ~|~ +)$ given the sensitivity, $P(+ ~|~ D) = .997$,
the specificity, {$$}P(- ~|~ D^c) =.985{/$$} and the prevalence
{$$}P(D) = .001{/$$}.

{$$}
\begin{eqnarray*}
P(D ~|~ +) & = &\frac{P(+~|~D)P(D)}{P(+~|~D)P(D) + P(+~|~D^c)P(D^c)}\\
 & = & \frac{P(+~|~D)P(D)}{P(+~|~D)P(D) + \{1-P(-~|~D^c)\}\{1 - P(D)\}} \\
 & = & \frac{.997\times .001}{.997 \times .001 + .015 \times .999}\\
 & = & .062
\end{eqnarray*}
{/$$}

In this population a positive test result only suggests a 6% probability that
the subject has the disease, (the positive predictive value is 6% for this test).
If you were wondering how it could be so low for this test, the low positive
predictive value is due to low prevalence of disease and the somewhat modest specificity

Suppose it was known that the subject was an intravenous drug user and routinely had intercourse with an HIV infected partner? Our prevalence would change dramatically, thus
increasing the PPV. You might wonder if there's a way to summarize the
evidence without appealing to an often unknowable prevalence? Diagnostic
likelihood ratios provide this for us.

## Diagnostic Likelihood Ratios
The diagnostic likelihood ratios summarize the evidence of disease given a
positive or negative test. They are defined as:


The **diagnostic likelihood ratio of a positive test**, labeled {$$}DLR_+{/$$},
is {$$}P(+ ~|~ D) / P(+ ~|~ D^c){/$$}, which is the
{$$}sensitivity / (1 - specificity){/$$}.

The **diagnostic likelihood ratio of a negative test**, labeled {$$}DLR_-{/$$},
is {$$}P(- ~|~ D) / P(- ~|~ D^c){/$$}, which is the
{$$}(1 - sensitivity) / specificity{/$$}.

How do we interpret the DLRs? This is easiest when looking at so called
**odds ratios**. Remember that if {$$}p{/$$} is a probability, then
{$$}p / (1 - p){/$$} is the odds. Consider now the odds in our setting:

Using Bayes rule, we have

{$$}  
P(D ~|~ +) = \frac{P(+~|~D)P(D)}{P(+~|~D)P(D) + P(+~|~D^c)P(D^c)}
{/$$}

and

{$$}
P(D^c ~|~ +) = \frac{P(+~|~D^c)P(D^c)}{P(+~|~D)P(D) + P(+~|~D^c)P(D^c)}.
{/$$}

Therefore, dividing these two equations we have:

{$$}
\frac{P(D ~|~ +)}{P(D^c ~|~ +)} = \frac{P(+~|~D)}{P(+~|~D^c)}\times \frac{P(D)}{P(D^c)}
{/$$}

In other words, the post test odds of disease is the pretest odds of disease
times the {$$}DLR_+{/$$}. Similarly, {$$}DLR_-{/$$} relates the decrease in the odds
of the disease after a negative test result to the odds of disease prior to
the test.

So, the DLRs are the factors by which you multiply your pre test odds to get
your post test odds. Thus, if a test has a {$$}DLR_+{/$$} of 6, regardless
of the prevalence of disease, the post test odds is six times that of the
pretest odds.


### HIV example revisited

Let's reconsider our HIV antibody test again.  
Suppose a subject has a positive HIV test

{$$}DLR_+ = .997 / (1 - .985) = 66{/$$}

The result of the positive test is that the odds of disease is now 66 times
the pretest odds. Or, equivalently, the hypothesis of disease is 66 times
more supported by the data than the hypothesis of no disease

Suppose instead that a subject has a negative test result

{$$}DLR_- = (1 - .997) / .985  =.003{/$$}

Therefore, the post-test odds of disease is now 0.3% of the pretest odds given
the negative test. Or, the hypothesis of disease is supported {$$}.003{/$$}
times that of the hypothesis of absence of disease given the negative test result


## Independence
[Watch this video before beginning.](http://youtu.be/MY1EfrR1ZUs?list=PLpl-gQkQivXiBmGyzLrUjzsblmQsLtkzJ)

Statistical independence of events is the idea that the events are unrelated.
Consider successive coin flips. Knowledge of the result of the first coin flip
tells us nothing about the second. We can formalize this into a definition.

Two events {$$}A{/$$} and {$$}B{/$$} are **independent** if

{$$}P(A \cap B) = P(A)P(B){/$$}

Equivalently if {$$}P(A ~|~ B) = P(A){/$$}. Note that since {$$}A{/$$} is
independent of {$$}B{/$$} we know that {$$}A^c{/$$} is independent of {$$}B{/$$}
{$$}A{/$$} is independent of {$$}B^c{/$$}
{$$}A^c{/$$} is independent of {$$}B^c{/$$}.

While this definition works for sets, remember that random variables are really the things
that we are interested in. Two random variables, {$$}X{/$$} and {$$}Y{/$$} are independent
if for any two sets
{$$}A{/$$} and {$$}B{/$$} {$$}P([X \in A] \cap [Y \in B]) = P(X\in A)P(Y\in B){/$$}

We will almost never work with these definitions. Instead, the important
principle is that probabilities of independent things multiply! This has
numerous consequences, including the idea that we shouldn't multiply non-independent
probabilities.

### Example

Let's cover a very simple example:
"What is the probability of getting two consecutive heads?". Then we have
that {$$}A{/$$} is the event of getting a head on flip 1 {$$}P(A) = 0.5{/$$}
{$$}B{/$$} is the event of getting a head on flip 2 {$$}P(B) = 0.5{/$$}
{$$}A \cap B{/$$} is the event of getting heads on flips 1 and 2. Then
independence would tell us that:

{$$}P(A \cap B) = P(A)P(B) = 0.5 \times 0.5 = 0.25{/$$}

This is exactly what we would have intuited of course. But, it's nice that
the mathematics mirrors our intuition. In more complex settings, it's easy
to get tripped up. Consider the following famous (among statisticians at least)
case study.

### Case Study

Volume 309 of Science reports on a physician who was on trial for expert
testimony in a criminal trial. Based on an estimated prevalence of sudden
infant death syndrome (SIDS) of 1 out of 8,543, a physician testified that that
the probability of a mother having two children with SIDS was
{$$}(1 / 8,543)^2{/$$}. The mother on trial was convicted
of murder.

Relevant to this discussion, the principal mistake was to *assume* that the
events of having SIDs within a family are independent. That is,
{$$}P(A_1 \cap A_2){/$$} is not necessarily equal to {$$}P(A_1)P(A_2){/$$}.
This is because biological processes that have a believed genetic or familiar
environmental component, of course, tend to be dependent within families.
Thus, we can't just multiply the probabilities to obtain the result.

There are many other interesting aspects to the case. For example, the idea of
a low probability of an event representing evidence against a plaintiff. (Could
we convict all lottery winners of fixing the lotter since the chance that they
would win is so small.)


## IID random variables
Now that we've introduced random variables and independence, we can introduce
a central modeling assumption made in statistics. Specifically the idea of a
random sample. Random variables are said to be independent and
identically distributed (*iid*) if they are independent and all are drawn from
the same  population. The reason iid samples are so important is that they are
are model for random samples. This is a default starting point for most
statistical inferences.

The idea of having a random sample is powerful for a variety of reasons. Consider
that in some study designs, such as in election polling, great pains are made to make
sure that the sample is randomly drawn from a population of interest. The idea
is to expend a lot of effort on design to get robust inferences. In these settings
assuming that the data is iid is both natural and warranted.

In other settings, the study design is far more opaque, and statistical
inferences are conducted
under the assumption that the data arose from a random sample, since it serves
as a useful benchmark. Most studies in the fields of epidemiology and
economics fall under this category. Take, for example, studying how policies
impact countries gross domestic product by looking at countries before and
after enacting the policies. The countries are not a random sample from the
set of countries. Instead, conclusions must be made under the assumption that
the countries are a random sample and the interpretation of the
strength of the inferences adapted in kind.

## Exercises

1. I pull a card from a deck and do not show you the result. I say that the resulting card is a heart. What is the probability that it is the queen of hearts?
  - 1/52
  - 1/4
  - 1/13
  - 13/54
2. The odds associated with a probability, {$$}p{/$$}, are defined as:
  - Exactly the same thing as the probability, {$$}p{/$$}.
  - {$$}1 / p{/$$}
  - {$$}p / (1 - p){/$$}
  - {$$}-2 \log(p){/$$}
3. The probability of getting two sixes when rolling a pair of dice is:
  - 1/2
  - 1/4
  - 1/6
  - 1/36
