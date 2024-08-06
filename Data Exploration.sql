


--1. Identifying Missing Values.

SELECT
  SUM(CASE WHEN ride_id IS NULL THEN 1 ELSE 0 END) AS ride_id,
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
  
FROM `2023biketrips`;

--2.Identifying Duplicate Entries (0 duplicate)

SELECT 
  ride_id,
  COUNT(*) AS num_of_duplicates
FROM `2023biketrips`
GROUP BY ride_id 
HAVING COUNT(*) > 1;

--3.Identifying Invalid Entries

a) Length Constraints: 'ride_id'

SELECT 
    LENGTH(ride_id) AS ride_id_length,
    COUNT(*) AS count_of_ride_id
FROM `2023biketrips`
GROUP BY LENGTH(ride_id)
ORDER BY ride_id_length;

b) unique 'rideable_type'

SELECT
  DISTINCT rideable_type,
  COUNT(*) AS num_of_trips,
FROM `2023biketrips`
GROUP BY rideable_type;

c) 
SELECT
  DISTINCT member_casual,
  COUNT(*) AS num_of_trips,
FROM `2023biketrips` 
GROUP BY member_casual;
  
  
d) Check the MAXUM and MINIMUM  ride_length for each rideable_type.

SELECT
  rideable_type,
  MAX(ROUND(TIMESTAMP_DIFF(ended_at, started_at, MINUTE), 2)) AS ride_length_MAX,
  MIN(ROUND(TIMESTAMP_DIFF(ended_at, started_at, MINUTE), 2)) AS ride_length_MIN

FROM `2023biketrips`
GROUP BY rideable_type;


--The trip longer than a day (Total of rows = 6417)
SELECT COUNT(*) AS longer_than_a_day
FROM `2023biketrips` 
WHERE TIMESTAMP_DIFF(ended_at,started_at,MINUTE) > 1440;

--The trip less than a miniute (Total of rows = 149615)
SELECT COUNT(*) AS less_than_a_mins
FROM `2023biketrips` 
WHERE TIMESTAMP_DIFF(ended_at,started_at,MINUTE) < 1;















