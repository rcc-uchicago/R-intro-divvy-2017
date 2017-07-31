#!/bin/bash

# This script will automatically download and prepare the data for the
# analyses in R.

# Move to the data directory.
cd ../data

# Download and unzip the Divvy data.
wget https://s3.amazonaws.com/divvy-data/tripdata/Divvy_Trips_2016_Q1Q2.zip
wget https://s3.amazonaws.com/divvy-data/tripdata/Divvy_Trips_2016_Q3Q4.zip
unzip Divvy_Trips_2016_Q1Q2.zip
unzip Divvy_Trips_2016_Q3Q4.zip

# Arrange the files a bit better and clean up (delete) files that we
# won't need for the data analysis.
rm -f *.zip
mv -f Divvy_Trips_2016_Q1Q2/* .
rmdir Divvy_Trips_2016_Q1Q2
rm -f README_2016_Q3.txt README_2016_Q4.txt

# Combine the trip data into a single file.
head -n 1 Divvy_Trips_2016_Q1.csv > header.txt
cat Divvy_Trips_2016_Q1.csv Divvy_Trips_2016_04.csv \
    Divvy_Trips_2016_05.csv Divvy_Trips_2016_06.csv \
    Divvy_Trips_2016_Q3.csv Divvy_Trips_2016_Q4.csv | \
    grep -v trip_id > temp.txt
cat header.txt temp.txt > Divvy_Trips_2016.csv

# Clean up the rest of the files that are not needed.
rm -f Divvy_Trips_2016_*.csv
rm -f header.txt temp.txt
