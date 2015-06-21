#Code Book

#Dataset
This project has a script `run_analysis.R` that processes on Samsung's data set.
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The output file has following 69 features:
  
"activityname"             "subject"                  "activitylabel"            "tbodyaccmeanx"           
"tbodyaccmeany"            "tbodyaccmeanz"            "tgravityaccmeanx"         "tgravityaccmeany"        
"tgravityaccmeanz"         "tbodyaccjerkmeanx"        "tbodyaccjerkmeany"        "tbodyaccjerkmeanz"       
"tbodygyromeanx"           "tbodygyromeany"           "tbodygyromeanz"           "tbodygyrojerkmeanx"      
"tbodygyrojerkmeany"       "tbodygyrojerkmeanz"       "tbodyaccmagmean"          "tgravityaccmagmean"      
"tbodyaccjerkmagmean"      "tbodygyromagmean"         "tbodygyrojerkmagmean"     "fbodyaccmeanx"           
"fbodyaccmeany"            "fbodyaccmeanz"            "fbodyaccjerkmeanx"        "fbodyaccjerkmeany"       
"fbodyaccjerkmeanz"        "fbodygyromeanx"           "fbodygyromeany"           "fbodygyromeanz"          
"fbodyaccmagmean"          "fbodybodyaccjerkmagmean"  "fbodybodygyromagmean"     "fbodybodygyrojerkmagmean"
"tbodyaccstdx"             "tbodyaccstdy"             "tbodyaccstdz"             "tgravityaccstdx"         
"tgravityaccstdy"          "tgravityaccstdz"          "tbodyaccjerkstdx"         "tbodyaccjerkstdy"        
"tbodyaccjerkstdz"         "tbodygyrostdx"            "tbodygyrostdy"            "tbodygyrostdz"           
"tbodygyrojerkstdx"        "tbodygyrojerkstdy"        "tbodygyrojerkstdz"        "tbodyaccmagstd"          
"tgravityaccmagstd"        "tbodyaccjerkmagstd"       "tbodygyromagstd"          "tbodygyrojerkmagstd"     
"fbodyaccstdx"             "fbodyaccstdy"             "fbodyaccstdz"             "fbodyaccjerkstdx"        
"fbodyaccjerkstdy"         "fbodyaccjerkstdz"         "fbodygyrostdx"            "fbodygyrostdy"           
"fbodygyrostdz"            "fbodyaccmagstd"           "fbodybodyaccjerkmagstd"   "fbodybodygyromagstd"     
"fbodybodygyrojerkmagstd" 

The first three values have been added through code (see point 15 for clarity)
Rest of 66 features represent **average mean and standard deviation** values for different type of observation.
**All are numerical values**

**tbodyaccmeanx** : This feature represents `mean` (denoted by `mean` substring) value of `time domain signals` (prefix 't' to denote time) captured by `accelerometer` (denoted by `acc`) for `x-direction` (denoted by x at the end, other values are y and z)

**fbodygyrostdy** : Similarly this feature represents `standard deviation` (denoted by `std`) value for `Fast Fourier Transform` (prefix 'f' to denote fast fourier) applied on signal captured by `gyroscope` (denoted by `gyro`) for `y-direction` (denoted by `y` at the end)

Similarly other variables can also be interpreted.

####This briefs about the run_analysis.R script (Steps taken to convert Raw data into Tidy Data)

1. This script firstly creates a `data` directory (if it doesn't exist) where it saves all downloaded information, intermediate data and final tidy dataset output file.
2. If the file that has to be downloaded and processed is present, then it is deleted first just to ensure that it works on fresh data that has not been corrupted/edited.
3. It downloads data from url path to the data set which is present in zip format.
4. The downloaded file is then unzipped.
5. `Train` and `Test` data are read from respective files (present in unzipped directory) and merged into a single data set.
6. Features are read from features file which are further merged with the data read in previos step so that every column in above data frame represent one feature. (characteristic of tidy data set)
7. Mean and standard deviation features are filtered out into another data.frame (`meanStdData`)
8. Train and test `activityLabels` are read from its respective files and then merged into a single activityLabel object. This activity label is then binded with data set (present in column 3). Activity label is an id that tells about the activity for which every observation(row) in data frame has been recorded. There are 6 such activities viz.

  |ID | ACTIVITY_LABEL|
|---|---------------:|
|1 | WALKING|
|2 | WALKING_UPSTAIRS|
|3 | WALKING_DOWNSTAIRS|
|4 | SITTING|
|5 | STANDING|
|6 | LAYING|

9. Similarly `subject` is binded with data set (present in column 2). Subject is an id ranging from 1 to 30 which represent the person who took observation.
10. Thereafter in order to keep the data tidy, column names (features) are converted to its lowercase character and any extra character like hyphen/parenthesis is removed. This ensures that data can be fetched by a simple lowercase name. So, there won't be any ambiguity about camelcase feature name and all functions can be applied successfully as unwanted special characters has been removed which might lead to some error since they are mostly associated with some operations.
11. After that another data set is created from this filtered data which contains average of all features (`mean` and `standard deviation` features) for each activity and each subject. (This doesn't include data like meanFreq)
12. A tidy data set should contain sensible information. So, `activity name` is added as first column which contains a comprehensive name for which record was collected.
13. Finally, the data is written as a text file in `uci_har_dataset_output.txt`.
14. Each column has a feature name that tells about data. Except the first three all 66 columns are predefined features of data that were read from features file itself. Hence, they are self-explanatory. All features in output data set are `numeric` values.
15. The first three columns are added from other files
  1. _first column_ : **activityname** : This is a `factor` having the value as present defined in 8th point
  2. _second column_ : **subject** : This is a `numeric` as defined in 9th point
  3. _third column_ : **activitylabel** : This is a `numeric` label associated with activity name

#UNITS
The features selected for this database come from the accelerometer and gyroscope. These time domain signals are measured in **Hertz**
The first three features are added manually to find average of all feature values for each subject and activity. So, these values are just an marker to do the computations. Hence, no significant units except they are character and numeric ids.
