# Cyclistic Case Study  

In this case study, I will undertake a real-world task as a junior data analyst within the marketing analyst team of the fictional company, Cyclistic. To address key business questions, I will follow the data analysis process: Ask, Prepare, Process, Analyze, Share, and Act.  

## Scenario  
Cyclistic is a bike-sharing company based in Chicago, with two types of customers: annual members and casual riders.  Annual members purchase yearly memberships, While casual riders use single-ride or full-day passes. Finance analysts have concluded that annual members are significantly more profitable than casual riders. To boost profitability, marketing director Moreno believes increasing annual memberships is key. The marketing analytics team want to understand how casual riders and annual members use Cyclistic bikes differently to design a new marketing strategy to convert casual riders into annual members. However, before implementing any changes, the recommendations from the marketing analytics team need to be approved by Cyclistic's executives. 


## ASK
### Define the problems:  

Three questions will guide the future marketing programs:  
1. How do annual members and casual riders use Cyclistic bikes dierently?
2. Why would casual riders buy Cyclistic annual memberships?
3. How can Cyclistic use digital media to influence casual riders to become members?

Moreno has tasked me with addressing the first questions: How do annual members and casual riders use Cyclistic bikes dierently?  

### Key stakeholders: 
1. Lily Moreno: The director of marketing and responsible for the development of campaigns and initiatives to promote the bike-share program.
2. Cyclistic executive team: The team will decide whether to approve the recommended marketing program.
3. Cyclistic marketing analytics team: A team of data analysts who are responsible for collecting, analyzing, and reporting data that helps guide Cyclistic marketing strategy.

### Business Task: 
Analyze historical bikes trip to identify usage patterns and understand the difference in how casual riders and annual members utilize Cyclistic bikes.


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

We will use **BigQuery** for data cleaning and manipulation due to its efficiency in handling large datasets. SQL provides rapid processing capabilities, which is important for managing and analyzing substantial volumes of data. In contrast, Excel has limitations on the number of rows and columns in a single worksheet and can become slow when dealing with large amounts of data or  performing complex calculations.

### Combining the Data

SQL Query: [Data Combining](https://github.com/Jasmine-yz/Cyclistic_Case_Study/blob/main/Data%20Combining.sql);

I created a Google Cloud Storage bucket to store 12 uploaded CSV files, then established a project in BigQuery and uploaded these files as datasets. Afterwards, I merged the CSV files into a single table named `2023_biketrips`, resulting in a combined table with a total of **5,719,877** rows.

### Data Inspection
SQL Query: [Data Inspection](https://github.com/Jasmine-yz/Cyclistic_Case_Study/blob/main/Data%20Exploration.sql)

1. Identifying Missing Values

![null_value](https://github.com/user-attachments/assets/18bc8d5a-1dfe-4b44-836a-6baa56b888a5)

**Verification:** 
- missing values were identified in several columns. Null values in 'start_station_name', 'end_station_name', 'end_lat' and 'end_lng' fields will be removed during cleaning process. 
- additionally, The 'start_station_id' and 'end_station_id' fields will be deleted from our analysis as they do not contribute relevant information. 
- Note: In real-world scenarios, it's important to be cautious when removing missing values. Missing values can come from various sources, such as data entry errors, data conversion issues, or incomplete data collection. It's crucial to assess how missing values impact the overall integrity of the dataset. If a large portion of the data is missing, it may distort the results of your analyses or modeling.


2. Identifying Duplicate Entries (since the unique key ride_id has no null value)

**Verification:** There is no duplicates.


3. Identifying Invalid Entries

a) Length Constraints: 'ride_id'

<img width="312" alt="ride_id_length" src="https://github.com/user-attachments/assets/f01afe35-3045-447c-8b77-c563f5d39b4d">

**Verification:**  ride_id values are consistently 16 characters long.

b) 'rideable_type'(Bike type): Classic, Docked, Electric

<img width="385" alt="rideable_type" src="https://github.com/user-attachments/assets/741650f9-6fe8-4313-8d41-99b9cbf440d3">

c) 'member_casual': 2 unique values( member , casual )  

![Screenshot 2024-08-06 at 17 22 36](https://github.com/user-attachments/assets/cf834fea-7a7c-44a8-8774-56e7a494b432)

4. **Identifying Outliers**

- Check the MAXUM and MINIMUM ride_length for each rideable_type.
<img width="511" alt="max_min_ride_length" src="https://github.com/user-attachments/assets/7e34b73b-fc84-44c5-b9aa-8eacacc19cac">

Note that the maximum duration is 98489.07 mins (approximately equal to 68.36 days), and the minimum duration is less than 0.

- Count the number of trips lasting longer than a day (Total of rows = 6417)
- Count the number of trips lasting less than a minute (Total of rows = 149615) 

According to the [divvy website](https://help.divvybikes.com/hc/en-us/articles/360033484791-What-if-I-keep-a-bike-out-too-long#:~:text=Day%20Pass%20holders%3A%20unlimited%20number,included%20in%20the%20membership%20price.), failing to return a bike within 24-hours may result in a $250 fee for loss or theft.
- We will exclude trips with a ride_length greater 24 hours and less than 1 minute.



### Data Cleaning
SQL Query: [Data Cleaning](https://github.com/Jasmine-yz/Cyclistic_Case_Study/blob/main/Data%20Cleaning.sql)

1. 3 columns were added:
   - ride_length (in minute)
   - day_of_week
   - ride_date
     
2. Trips with duration longer than a day or less than a minute were deteted.
3. All the rows having missing values are deleted.
4. 1,551,156 rows are removed in this step.

## Analyze

In this phrase, We will use SQL to analyze the data and examine the distribution of values. This will help us identify usage patterns and understand the differences in how casual riders and annual members use Cyclistic bikes.

- **Total trips: Members vs Casual users, ratio of each user type**

<img width="682" alt="Total Trips" src="https://github.com/user-attachments/assets/32ac0341-b4fb-4346-8b8c-549ee8621475">  

Of the total 4,168,721 trips in 2023, 64.30% were made by annual members and 35.70% made by casual users.

- ride length distribution(in minute): Members vs Casual

<img width="1008" alt="Screenshot 2024-08-07 at 21 30 09" src="https://github.com/user-attachments/assets/ce67d387-9878-4297-8319-ead91d6cf51e">  

Interestingly, our analysis reveals that casual riders have significantly longer trip durations compared to annual members. Specifically, 75% of casual rider trips last less than 24 minutes, 75% of member rider trips last less than 14 mins.

- **Rides counts and duration by bike types**

<img width="708" alt="bike_type_ride_count" src="https://github.com/user-attachments/assets/a2ee7190-3294-46ca-9c0c-a1a50c6dcef7">  

Classic bike is the most popular bike type choice for both annual members and casual riders. Meanwhile, docked bikes have the longest trip durations but the fewest ride counts.

- **The most frequent riding month:**

![ride by month](https://github.com/user-attachments/assets/6382d24d-d255-4282-b9d0-ac492bda25ee)

The riding frequency for both annual members and casual riders shows seasonal patterns. The peak riding period occurs in Q3, encompassing July, August, and September. In contrast, the number of rides significantly decreases in Q1. Notably, in the first and fourth quarters, the total number of rides for annual members is approximately three times and more than twice that of casual riders, respectively. In Q2 and Q3, this difference narrows to more than double.
Regarding riding duration, casual riders show longer duration during the summer month. In contrast, annual members do not show a significant variation in riding duration across different seasons.

- **The most frequent riding day and hours:**

![day_of_week](https://github.com/user-attachments/assets/128c81bc-adbe-4ecb-9e6f-6938c2149b3d)

<img width="771" alt="Screenshot 2024-08-16 at 09 26 44" src="https://github.com/user-attachments/assets/509d8543-25de-4110-9402-628d35bff738">

The riding patterns of annual members and casual riders show significant differences. **Annual members** primarily ride on weekdays, with peak riding times between 7-8 a.m. and 4-6 p.m., coinciding with rush hours for commuting to work or school. Their usage decreases on weekends, from Saturday to Sunday.

In contrast, **casual riders** are more active on weekends, particularly in the afternoon. They also ride on weekdays, with peak times between 4-6 p.m., suggesting they use bicycles for commuting from work or school. Additionally, both annual and casual riders tend to have longer ride durations on weekends.


- **The most popular start sation:**

<img width="1123" alt="Screenshot 2024-08-08 at 17 51 13" src="https://github.com/user-attachments/assets/07206418-a5fe-4c46-9529-0966d923a61b">

The data presented in the table shows that there is a clear distinction between the starting stations utilized by annual members and casual riders, with no overlap among the top 10 most popular starting station for each group.  

For annual member, the most frequented starting station are Kingsbury St & Kinzie, Clinton St & Washington Blvd, and Clark St & Elm St. Notably, these location are situated in the city center, as observed from Google Street View. Additionally, station such as University Ave & 57th St, near the University of Chicago, so we initially assume that annual members predominantly use bicycles to commute within the city.

For casual riders, they show a clear preference for bike stations located near water, such as the one at Streeter Dr & Grand Ave. This location is close to the Chicago Riverwalk and popular attractions like Navy Pier. Given that casual riders mainly use their bikes on weekends, it can be inferred that their rides are largely motivated by tourist and leisure. 




Key Takeaway:



it can be inferred that annual members primarily use bicycles for commuting during weekdays, whereas casual riders tend to use them for leisure activities on weekend afternoons.




















   



