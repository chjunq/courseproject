The first step is to set working directory, read data into R using read.table, and load two packages (plyr and sqldf). Package sqldf is used in the last step to create average. I am a data base analyst so using SQL is more straightforward to me. Truly this is not the most efficient way to do it.

The second step is to merge data using cbind and rbind. 

The third step is to extract mean and standard deviation measurements.

And then I name activities names by using conditional logic checking on acitivities lables. And then I use rename funciton to create descritive variable names.

The last step is to use SQL's AVG function to calculate average, and then group by subjectid and activityNames.

Thank you!
