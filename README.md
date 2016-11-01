# Getting-and-Cleaning-Data-Course-Project

Save ‘run_analysis.R’ source file into desired working directory.
The source takes one parameter furl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" .

Execute ‘run_analysis.R’ - run_analysis(); the parameter (see above) is optional; 
The source will 
- create ./data directory (if not exist);
- download zip file from the url;
- unzip the file into the “./data/UCI HAR Dataset” directory;
- produce tidy dataset “tidy data.txt”;
