#Overview

The 'R' script perform the following tasks:

1.) All the data files are loaded into R.
2.) All the similar data are merged using the rbind() function. Then the three datasets are combined using cbind() function and the columns of the resulting dataset has been given appropriate names.
3.) Then, only the columns with the mean and standard deviation measures are taken from the whole dataset. After extracting these columns, they are given the correct names, taken from features.txt.
4.) Descriptive names are used in the activity column ehich initially represented numbers ranging from 1 to 6.
5.) Appropriately label the column names with descriptive variable names.
6.) New independent data are generated with all the average measures for each subject and activity type (6 activities*30 subjects = 180 records). The output file is called tidydata.txt, and uploaded to this repository.
