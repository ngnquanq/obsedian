**Definition: an A/B test is an experiment with two groups to establish which of two treatments,  products, procedures, or the like is superior.**

**Key terms for A/B Testing:**
- **Treatment**: Something (drug, price, web headline) to which a subject is exposed
- **Treatment group**: A group of subjects exposed to a specific treatment
- **Control group**: A group of subjects exposed to no (or standard) treatment. 
- **Randomization**: The process of **randomly choosing** subjects for treatment.
- **Subjects:** The items (web visitors, patients, etc) that are exposed to treatments.
- **Test statistic**: The metric used to measure the effect of the treatment.

# What make a proper A/B Testing?

A proper A/B test has **subjects that can be assigned to one treatment or another**. The **subject might be a person, web visitor, etc.** The key is that the **the subject is exposed to the treament**. Ideally, the **subject should be randomized** to treatments. 

Also need to pay attention to the *test statistic* or *metric* you use to compare group A to group B. Based on different interests and the type of the variable (discrete or continous), we can display a result in a different way, for example, the most common metric to use in data science is *binary variable*, like in this table:

| Outcome       | Price A | Price B |
| ------------- | ------- | ------- |
| Conversion    | 200     | 182     |
| No conversion | 23539   | 22406   |

