README.md
=====================

Getting and Cleaning Data Project 1

In this repository you will find the following files:

* CodeBook.md
* README.md
* run_analysis.R
* tidy.data.txt

**CodeBook.md**  

This file describes the variables, the data, and the work that I performed to clean up the data.

**README.md**  

This file explains the contents of the files found in this repo.

**run_analysis.R**   

This file contains the script that I used to perform the analysis.
The script needs to be executed in the R console or an R IDE (e.g. RStudio)
It performs the following tasks:
First it downloads and unzip source files into the current working directory.
Then it merges training data with test data into one Data Frame.
Then it extracts measurements of mean and st.deviation.
After that it labels the data set with descriptive variable names.
Then it applies descriptive activity names to name the activities in the data set
After that it creates a second, independent tidy data set containing the averabe of each variable for each activity and subject.
Then it writes the tidy data set to a file named "tidyData.txt" in the current working directory

**tidy.data.txt**  

This is the data set that is the result of running run_analysis.R

