#Getting and Cleaning Data---Project 1
### by Thomax Young
### Mon Mar 16 2015

##How the code work

The code read in X_train and X_test and combine them correspondently in dataframe data, Then read in the features.txt and assign the second col to the name of the data.

Use grep() to get all mean and std col index and subset the data into data_sub. Reand in activity_labels and activity_code from y_train.txt and y_test.txt, then combine them correspondently. The same process also used on subject_id.

After inner_join activity_code and activity_labels, aggregate() the data_sub by activity_labels and subject_id to get the tidied data.

finnally out put the result by write.table()

##Code book 

The only two Var created by the code were activity_labels and subject_id. the rest of the variables' code book can be found in the data set code book.

 

