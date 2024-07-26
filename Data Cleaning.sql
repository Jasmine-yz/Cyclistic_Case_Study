DROP TABLE IF EXISTS `project-1-429715.cyclistic_tripdata.biketrips_cleaned_second`;


CREATE TABLE `project-1-429715.cyclistic_tripdata.biketrips_cleaned_second` AS(

SELECT
    ride_id,
    rideable_type,
    started_at,
    ended_at,
    TIMESTAMP_DIFF(ended_at,started_at,MINUTE)AS ride_length,
    CASE EXTRACT(DAYOFWEEK FROM started_at)
        WHEN 1 THEN 'Sunday'
        WHEN 2 THEN 'Monday'
        WHEN 3 THEN 'Tuesday'
        WHEN 4 THEN 'Wednesday'
        WHEN 5 THEN 'Thursday'
        WHEN 6 THEN 'Friday'
        WHEN 7 THEN 'Saturday'
    END AS day_of_week,
    DATE(started_at) AS start_date,
    CASE EXTRACT(MONTH FROM started_at)
      WHEN 1 THEN 'January'
      WHEN 2 THEN 'February'
      WHEN 3 THEN 'March'
      WHEN 4 THEN 'April'
      WHEN 5 THEN 'May'
      WHEN 6 THEN 'June'
      WHEN 7 THEN 'July'
      WHEN 8 THEN 'August'
      WHEN 9 THEN 'September'
      WHEN 10 THEN 'October'
      WHEN 11 THEN 'November'
      WHEN 12 THEN 'December'
    END AS month,
    EXTRACT(YEAR FROM started_at) AS year,
    TIME(EXTRACT(HOUR FROM started_at), EXTRACT(MINUTE FROM started_at), EXTRACT(SECOND FROM started_at)) AS start_time,
    TIME(EXTRACT(HOUR FROM ended_at), EXTRACT(MINUTE FROM ended_at), EXTRACT(SECOND FROM ended_at)) AS end_time,
    start_station_name,
    end_station_name,
    start_lat,
    start_lng,
    end_lat,
    end_lng,
    member_casual
FROM `project-1-429715.cyclistic_tripdata.biketrips`
WHERE
    start_station_name IS NOT NULL
    AND end_station_name IS NOT NULL
    AND end_lat IS NOT NULL
    AND end_lng IS NOT NULL
    AND LENGTH(ride_id) = 16
    AND TIMESTAMP_DIFF(ended_at,started_at,MINUTE) > 1
    AND TIMESTAMP_DIFF(ended_at,started_at,MINUTE) < 1440
    
);


