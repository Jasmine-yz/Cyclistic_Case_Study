# Cyclistic_Case_Study
## ASK
### Business Task: How do annual members and casual riders use Cyclistic bikes differently?

## PREPARE
### Data Sources
I will be using Cyclistic historical trip data from Jan,2023 to Dec,2023, which can be downloaded [HERE](https://divvy-tripdata.s3.amazonaws.com/index.html), The data has been made available by Motivate International Inc. under this [lisence](https://divvybikes.com/data-license-agreement). This is public data that you can use to explore how different customer types are using Cyclistic bikes.But note that data-privacy issues prohibit you from using riders'personally identiable information. This means that you won't be able to connect pass purchases to credit card numbers to determine if casual riders live in the Cyclistic service area or if they have purchased multiple single passes.

The data is stored in spreadsheets in a total of 12 .csv files, each file includes information for one month.

```
1. 202306-divvy-tripdata.csv
2. 202307-divvy-tripdata.csv
3. 202308-divvy-tripdata.csv
4. 202309-divvy-tripdata.csv
5. 202310-divvy-tripdata.csv
6. 202311-divvy-tripdata.csv
7. 202312-divvy-tripdata.csv
8. 202401-divvy-tripdata.csv
9. 202402-divvy-tripdata.csv
10.202403-divvy-tripdata.csv
11.202404-divvy-tripdata.csv
12.202405-divvy-tripdata.csv
```
The data is well-structured with rows and columns, and each table maintains consistent column count and field names.
```
Index:
'ride_id',                  # Ride id - unique 
'rideable_type'             # Bike type - Classic, Docked,Electric
'started_at',               # Trip start day and time
'ended_at',                 # Trip end day and and time
'start_station_name',       # Trip start station name
'start_station_id',         # Trip start station ID
'end_station_name',         # Trip end station name
'end_station_id',           # Trip end station ID
'start_lat',                # Trip start latitude
'start_lng',                # Trip start longitude
'end_lat',                  # Trip end latitude
'end_lng',                  # Trip end longitude
'member_casual'             # Rider Types: Member or Casual
```

## PROCESS
## Data cleaning and Manipulation

We will use **BigQuery** for data cleaning and manipulation due to ites efficiency in handling large datasets. SQL provides rapid processing capabilities, which is important for managing and analyzing substantial volumes of data. In contrast, Excel has limitations on the number of rows and columns in a single worksheet and can become slow when dealing with large amounts of data or  performing complex calculations.

### Combining the Data

SQL Query: [Data Combining](https://github.com/Jasmine-yz/Cyclistic_Case_Study/blob/main/Data%20Combining.sql);

I created a Google Cloud Storage bucket to store 12 uploaded CSV files, then established a project in BigQuery and uploaded these files as datasets. Afterwards, I merged the CSV files into a single table named `biketrips`, resulting in a combined table with a total of 5,743,278 rows.

### Data Exploration
SQL Query: [Data Exploration](https://github.com/Jasmine-yz/Cyclistic_Case_Study/blob/main/Data%20Exploration.sql)

1. Checking the number of **null value** in each field.

![null_value](https://github.com/user-attachments/assets/18bc8d5a-1dfe-4b44-836a-6baa56b888a5)

**Verification:** 
- missing values were identified in several columns. Null values in 'start_station_name', 'end_station_name', 'end_lat' and 'end_lng' fields will be removed during cleaning process. 
- additionally, The 'start_station_id' and 'end_station_id' fields will be deleted from our analysis as they do not contribute relevant information. 
- Note: In real-world scenarios, it's important to be cautious when removing missing values. Missing values can come from various sources, such as data entry errors, data conversion issues, or incomplete data collection. It's crucial to assess how missing values impact the overall integrity of the dataset. If a large portion of the data is missing, it may distort the results of your analyses or modeling.


2. Checking for duplicate data (since the unique key ride_id has no null value)

**Verification:** There is no duplicates.


3. Length Constraints: 'ride_id'

<img width="312" alt="ride_id_length" src="https://github.com/user-attachments/assets/f01afe35-3045-447c-8b77-c563f5d39b4d">

**Verification:**  ride_id values are consistently 16 characters long.


4. 'rideable_type'(Bike type): Classic, Docked, Electric

<img width="385" alt="rideable_type" src="https://github.com/user-attachments/assets/741650f9-6fe8-4313-8d41-99b9cbf440d3">


5. 'started_at' and 'ended_at' fields indicates the start time and end times of the trip in YYYY-MM-DD HH:MI:SS UTC format.

   - Check the MAXUM and MINIMUM ride_length for each rideable_type.
<img width="511" alt="max_min_ride_length" src="https://github.com/user-attachments/assets/7e34b73b-fc84-44c5-b9aa-8eacacc19cac">

   Note that the maximum duration is 98489.07 mins (approximately equal to 68.36 days), and the minimum duration is less than 0.

   - According to the [divvy website](https://help.divvybikes.com/hc/en-us/articles/360033484791-What-if-I-keep-a-bike-out-too-long#:~:text=Day%20Pass%20holders%3A%20unlimited%20number,included%20in%20the%20membership%20price.), failing to return a bike within 24-hours may result in a $250 fee for loss or theft.
   - We will exclude trips with a ride_length greater 24 hours and less than 1 minute.



### Data Cleaning
SQL Query: [Data Cleaning](https://github.com/Jasmine-yz/Cyclistic_Case_Study/blob/main/Data%20Cleaning.sql)

- We added ride_length, 
- All the missing values have removed
- Trips with duration longer than a day or less than a minute were deteted.
- A total 1,476,445 rows were removed during this process.



   



