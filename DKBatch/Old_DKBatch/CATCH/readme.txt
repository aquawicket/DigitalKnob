When NoRelativePaths is turned on, the directory will be monitored.
Is used to test that absolute file paths are used. dkbatch will cd into this directory between every error call, and check it for files. 
If a file is found in this directory (besides this readme.txt file), dkbatch will throw an error alerting that something in the batch script is using reletive paths.
