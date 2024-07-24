


--1. Checking the number of null value in each field.

SELECT
  SUM((CASE WHEN ride_id IS NULL THEN 1 ELSE 0 END)) AS ride_id,
  SUM(CASE WHEN rideable_type IS NULL THEN 1 ELSE 0 END) AS rideable_type,
  SUM(CASE WHEN started_at IS NULL THEN 1 ELSE 0 END) AS started_at,
  SUM(CASE WHEN ended_at IS NULL THEN 1 ELSE 0 END) AS ended_at,
  SUM(CASE WHEN start_station_name IS NULL THEN 1 ELSE 0 END) AS start_station_name,
  SUM(CASE WHEN start_station_id IS NULL THEN 1 ELSE 0 END) AS start_station_id,
  SUM(CASE WHEN end_station_name IS NULL THEN 1 ELSE 0 END) AS end_station_name,
  SUM(CASE WHEN end_station_id IS NULL THEN 1 ELSE 0 END) AS end_station_id,
  SUM(CASE WHEN start_lat IS NULL THEN 1 ELSE 0 END) AS start_lat,
  SUM(CASE WHEN start_lng IS NULL THEN 1 ELSE 0 END) AS start_lng,
  SUM(CASE WHEN end_lat IS NULL THEN 1 ELSE 0 END) AS end_lat,
  SUM(CASE WHEN end_lng IS NULL THEN 1 ELSE 0 END) AS end_lng,
  SUM(CASE WHEN member_casual IS NULL THEN 1 ELSE 0 END) AS member_casual
  
FROM `project-1-429715.divvy_tripdata.biketrips`

--2.Checking for duplicate data

SELECT 
  ride_id,
  COUNT(*) AS num_of_duplicates
FROM `project-1-429715.divvy_tripdata.biketrips`
  GROUP BY ride_id
  HAVING COUNT(ride_id) > 1;

--3.Length Constraints: 'ride_id'

SELECT 
    LENGTH(ride_id) AS ride_id_length,
    COUNT(*) AS count_of_ride_id
FROM `project-1-429715.divvy_tripdata.biketrips`
GROUP BY LENGTH(ride_id)
ORDER BY ride_id_length;

--4. Total trips for each unique 'rideable_type'

SELECT
  DISTINCT rideable_type,
  COUNT(*) AS num_of_trips,
FROM `project-1-429715.divvy_tripdata.biketrips`
GROUP BY rideable_type;

--5. Check the MAXUM and MINIMUM  ride_length for each rideable_type.

SELECT
  rideable_type,
  MAX(ROUND(TIMESTAMP_DIFF(ended_at, started_at, MINUTE), 2)) AS ride_length_MAX,
  MIN(ROUND(TIMESTAMP_DIFF(ended_at, started_at, MINUTE), 2)) AS ride_length_MIN

FROM `project-1-429715.divvy_tripdata.biketrips`
GROUP BY rideable_type;


--The trip longer than a day (Total of rows = 7542)
SELECT COUNT(*) AS longer_than_a_day
FROM `project-1-429715.divvy_tripdata.biketrips` 
WHERE TIMESTAMP_DIFF(ended_at,started_at,MINUTE) > 1440;

--The trip less than a miniute (Total of rows = 136168)
SELECT COUNT(*) AS less_than_a_mins
FROM `project-1-429715.divvy_tripdata.biketrips` 
WHERE TIMESTAMP_DIFF(ended_at,started_at,MINUTE) < 1;















