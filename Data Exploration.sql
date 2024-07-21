


--2. Checking the number of null value in each field.

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
FROM `project-1-429715.gda_capstone_1.2023_biketrips`;

--3.Checking for duplicate data

SELECT ride_id, COUNT(*) AS num_duplicates
  FROM `project-1-429715.gda_capstone_1.2023_biketrips` 
  GROUP BY ride_id
  HAVING COUNT(ride_id) > 1;

--4.Length Constraints: ride_id

SELECT ride_id,
      LENGTH(ride_id) AS length_ride_id, 
      COUNT(*) AS num_rows
FROM `project-1-429715.gda_capstone_1.2023_biketrips` 
GROUP BY ride_id, length_ride_id
ORDER BY length_ride_id DESC, ride_id
lIMIT 10;

--5. The trip longer than a day (Total of rows = 6418)
SELECT COUNT(*) AS longer_than_a_day
FROM `project-1-429715.gda_capstone_1.2023_biketrips` 
WHERE TIMESTAMP_DIFF(ended_at,started_at,MINUTE) >= 1440;

--6. The trip less than a miniute (Total of rows = 149615)
SELECT COUNT(*) AS less_than_a_mins
FROM `project-1-429715.gda_capstone_1.2023_biketrips` 
WHERE TIMESTAMP_DIFF(ended_at,started_at,MINUTE) < 1;















