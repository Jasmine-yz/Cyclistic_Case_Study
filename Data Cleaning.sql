DROP TABLE IF EXISTS `biketrips_cleaned_second`;


CREATE TABLE biketrips_cleaned_minute` AS(

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
    DATE(started_at) AS ride_date,
    start_station_name,
    end_station_name,
    start_lat,
    start_lng,
    end_lat,
    end_lng,
    member_casual
FROM `2023biketrips`
WHERE
    start_station_name IS NOT NULL
    AND end_station_name IS NOT NULL
    AND end_lat IS NOT NULL
    AND end_lng IS NOT NULL
    AND TIMESTAMP_DIFF(ended_at,started_at,MINUTE) > 1
    AND TIMESTAMP_DIFF(ended_at,started_at,MINUTE) < 1440
    
);
