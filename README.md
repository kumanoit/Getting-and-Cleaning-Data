# Getting-and-Cleaning-Data
Coursera Project

This project is part of coursera's [Data Science Specialization](https://www.coursera.org/specialization/jhudatascience/1?utm_medium=courseDescripSidebar) course - [Getting and Cleaning data](https://www.coursera.org/course/getdata).

#####It contains following files:

1. **run_analysis.R :** This is a R-script that refines and cleans raw data to a tidy one. This is the only script that performs all of the processing which includes :
  1. downloading file
  2. unzipping file
  3. reading `trainData` and `testdata`
  4. extracting `mean` and `standard deviation` information from the downloaded file
  5. reading `features` from feature file
  6. reading `activitylabel` from its file
  7. reading `subject` from subject file
  8. binding these information with the dataset
  9. labeling data set with descriptive variable name
  10. creating another data set containing averages of all features for each activity label and each subject
  11. finally saving data into a file

2. **CodeBook.md :** This contains all the details about what above script do and details about data.

#Using script
1. Clone this repo into local machine.
2. Install R and RStudio
3. Run the script `run_analysis.R`. From terminal :

  ```
  Rscript run_analysis.R 
  ```
4. Check if the output data file is created under `./data` directory with name `uci_har_dataset_output.txt`


#Output
1. The output file has **69 columns** (66 predefined `mean` and `standard deviation` and 3 added for `activitylabel`, `activityname` and `subject`)
2. The output file has **180 rows** = length(`subject`) * length(`activity`) = 30 * 6
