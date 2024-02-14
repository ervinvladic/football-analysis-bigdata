# football-analysis-bigdata

## Description
- The project presents an analysis of the English Premier League in the 2021/2022 season, using Hadoop and MapReduce. The dataset contains information about 380 matches, including match statistics, results, and various match-related features. The most important data were extracted, such as the average number of shots, the number of shots on goal, yellow and red cards, the ratio of results at halftime and at the end, the average number of goals scored and conceded per game.
  
- The project was done as a part of the **CEN 569 Big Data Technologies** and **CEN 555 - Advanced Topics in Database Systems** courses at the Master Study of Data Science at International Burch University.

## Repository structure
- In the [**database**](https://github.com/ervinvladic/football-analysis-bigdata/tree/main/database) directory, you can find the database that is used for this project.
- In the [**dataset**](https://github.com/ervinvladic/football-analysis-bigdata/tree/main/dataset) directory, you can find the dataset that is used for this project.
- In the [**sql queries**](https://github.com/ervinvladic/football-analysis-bigdata/tree/main/sql%20queries) directory, you can find the SQL queries for database operations.
- In the [**Combinations.java**](https://github.com/ervinvladic/football-analysis-bigdata/blob/main/Combinations.java) file, you can find counter for combinations of half-time and full-time score ratios
- In the [**Corners.java**](https://github.com/ervinvladic/football-analysis-bigdata/blob/main/Corners.java) file, you can find the calculation of the average number of corners per team in this season per game
- In the [**GoalsReceived.java**](https://github.com/ervinvladic/football-analysis-bigdata/blob/main/GoalsReceived.java) file, you can find the calculation of the average number of goals team receives in this season per game
- In the [**GoalsScored.java**](https://github.com/ervinvladic/football-analysis-bigdata/blob/main/GoalsScored.java) file, you can find the calculation of the average number of goals team scores in this season per game
- In the [**RedCards.java**](https://github.com/ervinvladic/football-analysis-bigdata/blob/main/RedCards.java) file, you can find the calculation of the average number of red cards team receives in this season per game
- In the [**Shots.java**](https://github.com/ervinvladic/football-analysis-bigdata/blob/main/Shots.java) file, you can find the calculation of the average number of shots team has in this season per game
- In the [**ShotsOnTarget.java**](https://github.com/ervinvladic/football-analysis-bigdata/blob/main/ShotsOnTarget.java) file, you can find the calculation of the average number of shots on target team has in this season per game
- In the [**YellowCards.java**](https://github.com/ervinvladic/football-analysis-bigdata/blob/main/YellowCards.java) file, you can find the calculation of the average number of yellow cards team receives in this season per game

## Prerequisites:
- Hadoop installed
- Microsoft SQL Server & SQL Server Management Studio (SSMS) installed

## Commands 
- Run Command Prompt as Administrator:
- Navigate to Hadoop sbin Directory: **cd C:\hadoop\sbin**
- Start Hadoop Services: **start-all.cmd**
- Create HDFS Directory: **hadoop fs -mkdir /input_average**
- Copy Data to HDFS (Upload the 'soccer21-22.csv' file from your local file system to the 'input_average' directory): **hadoop -put /path/to/soccer21-22.csv /input_average**
- List Files in HDFS Directory: **hadoop fs -ls /input_average (Optional)**
- Display Contents of a File in HDFS: **hadoop fs -cat /input_average/soccer21-22.csv (Optional)**
- Build Hadoop JAR File: **Compile your MapReduce code and package it into a JAR file**
- Run MapReduce Job: **hadoop jar YourJarFile.jar YourMapperClass YourReducerClass YourInputPath YourOutputPath
(Example: hadoop jar C:\Users\Ervin\Desktop\goalsreceived.jar GoalsReceived /input_average/soccer21-22.csv /output_dir_goalsreceived)**
- Display Results: **hadoop fs -cat YourOutputPath/part-r-00000 (Example: hadoop fs -cat /output_dir_goalsreceived/part-r-00000)**

## Database setup instructions
- Install SQL Server & SQL Server Management Studio (SSMS)
- Create Database:  **CREATE DATABASE EnglishPremierLeague;**
- Create Table: **CREATE TABLE EnglishPremierLeague (features);**
- Format Date Column: **Ensure that the Date column is in the YYYY-MM-DD format for successful insertion
  (We have already ensured that the Date column is in the correct YYYY-MM-DD format, and the processed dataset is located here: [**YellowCards.java**](https://github.com/ervinvladic/football-analysis-bigdata/blob/main/YellowCards.java)**
- Bulk Insert Data:

**BULK INSERT EnglishPremierLeague
FROM '/path/to/soccer21-22.csv'
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',
    FIRSTROW = 1,  
    FORMAT = 'CSV'
);**
  
## Done by
- [**Ervin Vladić**](https://github.com/ervinvladic)
- [**Benjamin Mehanović**](https://github.com/benjom22)

