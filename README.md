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

SQL Query: [Data Combining](###########);

I created a Google Cloud Storage bucket to store uploaded 12 CSV files, then established a project in BigQuery and uploaded these files as datasets. Subsequently,I merged the CSV files into a single table named `2023_biketrips`.

### Data Exploration
SQL Query: [Data Exploration](#######)

1. Let's check the **Schema** and **Detail**  of 2023_biketrips table. 

<img width="365" alt="Screenshot" src="https://github.com/user-attachments/assets/caa7e8ac-9820-4abc-a417-3c5d111345ce">

**Observations:**  
a) The **ride_id** field is the primary key.  
b) There are 5,719,877 rows and 13 columns.  

2. Checking the number of **null value** in each field.

![null_value](https://github.com/user-attachments/assets/bba855e7-d5c2-433b-84a1-2a53f7949117)

3. Checking for duplicate data (since the primary key has no null value)

**Verification:** Dataset contains uqique row only

4. Length Constraints: ride_id

**Verification:** The length of all ride_id values is consistently 16 characters,indicating that no cleanup is required.

5. rideable_type -- 3 unique bike types:

<img width="386" alt="rideable_type" src="https://github.com/user-attachments/assets/894df1b0-9430-4dbc-b7dd-0d275488b5fe">




   



