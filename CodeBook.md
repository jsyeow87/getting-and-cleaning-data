#Data Source

Original dataset "Human Activity Recognition Using Smartphones Data Set" 

Original URL: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


#Important thing to note

This R script require the following packages to be installed: reshape2 and data.table

#Outline of steps in the R scrit

1) Loading of datasets by 
  i) read.table ()

2) Loading of features and activity labels by
  i) names ()

3) Extraction of mean and SD data columns by
  i) Subsetting of datasets []

4) Processing of the 2 separate datasets: Test_data and Train_data by
  i) cbind ()
  ii) rbind ()

5) Merge data set by
  i) Melt function
  ii) Dcast function
