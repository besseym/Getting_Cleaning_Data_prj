---
title: "Read Me"
output: html_document
---


* **Script:** run_analysis.R
* **Input:** Dataset from the "Human Activity Recognition Using Smartphones" experiment
* **Output:** Summation dataset
* **Parameters:** No parameters are required for the script.


The R script, run_analysis.R, needs to be run in the same directory as the "Human Activity Recognition Using Smartphones" dataset. The tidy summary dataset produced, "tidy_dataset_ave.txt", is the average of the mean and standard deviation variables accross the test and train measurements of the "Human Activity Recognition Using Smartphones" experiment.

```{r}
cd ${path_to_dataset}
RScript run_analysis.R
```


