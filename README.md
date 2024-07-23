# Cyclistic_Case_Study
## ASK
### Business Task: How do annual members and casual riders use Cyclistic bikes differently?

## PREPARE
### Data Sources
I will be using Cyclistic historical trip data from Jan,2023 to Dec,2023, which can be downloaded [HERE](https://divvy-tripdata.s3.amazonaws.com/index.html), The data has been made available by Motivate International Inc. under this [lisence](https://divvybikes.com/data-license-agreement). This is public data that you can use to explore how different customer types are using Cyclistic bikes.But note that data-privacy issues prohibit you from using riders'personally identiable information. This means that you won't be able to connect pass purchases to credit card numbers to determine if casual riders live in the Cyclistic service area or if they have purchased multiple single passes.

The data is stored in spreadsheets in a total of 12 .csv files, each file includes information for one month.

```
1. 202301-divvy-tripdata.csv
2. 202302-divvy-tripdata.csv
3. 202303-divvy-tripdata.csv
4. 202304-divvy-tripdata.csv
5. 202305-divvy-tripdata.csv
6. 202306-divvy-tripdata.csv
7. 202307-divvy-tripdata.csv
8. 202308-divvy-tripdata.csv
9. 202309-divvy-tripdata.csv
10.202310-divvy-tripdata.csv
11.202311-divvy-tripdata.csv
12.202312-divvy-tripdata.csv
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

**Tool Chosen:** BigQuery
Reason:
- Excel has limited rows and columns in a single worksheet,it can also become slow when processing large amounts of data, especially when performing complex calculations or data analysis.
- In Contrast to Excel, SQL is fast and can handle large loads of data.

### Combining the Data

SQL Query: [Data Combining](https://github.com/Jasmine-yz/Cyclistic_Case_Study/blob/main/Data%20Combining.sql);

I created a Google Cloud Storage bucket to store uploaded 12 CSV files, then established a project in BigQuery and uploaded these files as datasets. Subsequently,I merged the CSV files into a single table named `2023_biketrips`.

### Data Exploration
SQL Query: [Data Exploration](https://github.com/Jasmine-yz/Cyclistic_Case_Study/blob/main/Data%20Exploration.sql)

1. Let's check the **Schema** and **Detail**  of 2023_biketrips table. 

<img width="365" alt="Screenshot" src="https://github.com/user-attachments/assets/caa7e8ac-9820-4abc-a417-3c5d111345ce">

**Observations:**  
a) The **ride_id** field is the primary key.  
b) There are 5,719,877 rows and 13 columns.  

2. Checking the number of **null value** in each field.

![null_value](https://github.com/user-attachments/assets/bba855e7-d5c2-433b-84a1-2a53f7949117)

**Verification:** 
- missing values were identified in several columns. Null values in start_station_name, end_station_name, end_lat and end_lng fields will be removed during cleaning process. 
- additionally, The start_station_id and end_station_id fields will be deleted from our analysis as they do not contribute relevant information. 
- Note: ##############

3. Checking for duplicate data (since the primary key has no null value)

**Verification:** Dataset contains unique row only

4. Length Constraints: 'ride_id'

**Verification:** The length of all ride_id values is consistently 16 characters,indicating that no cleanup is required.

5. 'rideable_type'(Bike type): Classic, Docked, Electric
<img width="386" alt="rideable_type" src="https://github.com/user-attachments/assets/b27521c6-5863-404d-9185-9a07a4c79a00">

6. 'started_at' and 'ended_at' fields indicates the start time and end times of the trip in YYYY-MM-DD HH:MI:SS UTC format.
   - To calculate the total trip duration for each trip, we will create a field called **ride_length** field.
   - Check the MAXUM and MINIMUM ride_length for each rideable_type.
   <img width="511" alt="max_min_length" src="https://github.com/user-attachments/assets/ee8ebbe0-9265-46a8-869e-977d8cb02ffc">
   
   Note that the maximum duration is 98489.07 mins (approximately equal to 68.36 days), and the minimum duration is less than 0.

   - According to the [divvy website](https://help.divvybikes.com/hc/en-us/articles/360033484791-What-if-I-keep-a-bike-out-too-long#:~:text=Day%20Pass%20holders%3A%20unlimited%20number,included%20in%20the%20membership%20price.), failing to return a bike within 24-hours may result in a $250 fee for loss or theft.
   - We will exclude trips with a ride_length greater 24 hours and less than 1 minute.

   

   
  
day_of_week, and month fields will be created during the **Cleaning process**





### Data Cleaning
SQL Query: [Data Cleaning](https://github.com/Jasmine-yz/Cyclistic_Case_Study/blob/main/Data%20Cleaning.sql)

- We added ride_length, day_of_week, and month fields to the dataset.
- All the missing values have removed
- Trips with duration longer than a day or less than a minute were deteted.
- A total 1,476,445 rows were removed during this process.



   



