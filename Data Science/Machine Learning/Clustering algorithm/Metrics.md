---
aliases:
---
Mainly, there're two type of **big metrics**, those are **internal and external evaluation metrics**. Each of which provide different useful information for clustering algorithm. 

**Remember:**
- **Internal Metrics**: useful for comparing algorithms or settings, may not always reflect the true underlying cluster structure. 
- **External Metrics**: offer objective evaluation but rely on the availability of ground truth labels, which might not always be practical. 
# Key Considerations in Choosing Metrics
- **No One-Size-Fits-All:** Different metrics suit different goals and data characteristics. It’s crucial to choose metrics that align with your specific clustering objectives.
- **Comprehensive Evaluation:** Employing multiple metrics can provide a more rounded assessment of clustering performance.
- **Visualization Aid:** Visual tools like scatter plots or density plots can complement metric-based evaluations.
- **Domain Knowledge:** Integrating domain expertise is vital when interpreting scores and assessing the quality of clustering.
# Internal Evaluation Metrics (without ground truth knowledge). 
To be clear, ground truth knowledge basically is the label of the dataset. With that being said, internal metrics are crucial when ground truth labels are not available. They provide a way to **assess the quality of clustering based on the attributes of the data itself**. 
## Inertia (Within-Cluster Sum of Squares)
1. What it measures: **Sum of squared distances between each datapoint and its cluster's centroid.** 
2. Interpretation: **The lower the inertia, the more compact that cluster is.** However, a very **low inertia** also mean **overfitting**, where the number of clusters is too high. 
3. Formular:
$$
\mathbf{TSS = \Sigma_{i=1}^{n}(y_i - \bar{y})^2}
$$
## Silhouette Coefficient
1. Assessment: Evaluates cohesion within clusters and separation between them. \
2. Range: It varies from -1 (poor clustering) to 1 (excellent clustering). 
3. Usage: Higher scores suggest better-defined clusters with good separation and tightness.
4. Explained:
	1. Cohesion: how close a datapoint is to other points in its own cluster (which is average distance to all other data points within the same cluster). 
	2. Separation: how far a datapoint is from points in other clusters (which is average distance to all data points in the nearest neighboring cluster).
5. Formular:
	$$
	\textbf{silhouette coefficient} = \frac{(seperation - cohesion)}{max(separation, cohesion)}
	$$
6. Interpretation: ranges from -1 to 1. A value close to 1 indicates a well-clustered data point, near 0 suggests overlapping clusters, and a value close to -1 indicates a misclassified datapoint. 
## Davies-Bouldin Index
1. Purpose: Measures the average similarity between each cluster and its most similar cluster. 
2. Optimal Scoring: Lower scores are desirable, indicating better separation and compactness. 
3. Main idea: Good clusters are those that have low within-cluster variation and high between-cluster separation. 
4. Formula: 

## Calinski-Harabasz Index (Variance Ration Criterion)
1. Purpose: compares the variance between cluster with the variance within clusters. 
2. Higher Scores: Indicate more distinct, well-separated cluster. 
3. Formula:

# External Evaluation Metrics (with ground truth knowledge)
When ground truth labels are available, external metrics can provide a more objective measure of clustering performance.
## Rand Index (RI)
1. Measurement: Asses the agreement between the predicted clusters and ground truth labels. 
2. Interpretation: The index ranges from 0 (random clustering) to 1 (perfect agreement).
3. Formula: 
$$
R = \frac{a+b}{\textbf{n choose 2}}
$$
	where: 
	- a represents the count of element pairs that belong to the same cluster in both clustering methods
	- b denotes the number of element pairs that are assigned to different clusters in both clustering approaches.
	- n stands for the overall number of elements being clustered. 
## Adjusted Rand Index (ARI)
- **Improvement Over RI:** This is a corrected version that accounts for chance agreement, offering a more robust evaluation.
- **Preferred Use:** ARI is often favored for its reliability in various clustering scenarios.
## Normalized Mutual Information (NMI)
- **Insight:** NMI measures the mutual information between predicted clusters and ground truth, normalized by entropy.
- **Higher Scores:** They indicate a greater similarity between the clustering outcome and the actual distribution.
- **Formula:**
$$
NMI(Y,C) = \frac{2 \times I(Y;C)}{H(Y) + H(C)}
$$
	Where: 
	- Y = class labels
	- C = cluster labels
	- H(.) = Entropy
	- I(Y;C) = Mutual Information between Y and C = H(Y) - H(Y|C)