
--Check the number of null value in each field.

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
