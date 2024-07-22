

CREATE TABLE 2023_tripdata_cleaned_combined AS(
  SELECT
    ride_id,
    rideable_type,
    started_at,
    ended_at,
    FORMAT_TIMESTAMP('%T', TIMESTAMP_SECONDS(TIMESTAMP_DIFF(ended_at,started_at,SECOND)))AS ride_length,
    CASE EXTRACT(DAYOFWEEK FROM started_at)
      WHEN 1 THEN 'Sunday'
      WHEN 2 THEN 'Monday'
      WHEN 3 THEN 'Tuesday'
      WHEN 4 THEN 'Wednesday'
      WHEN 5 THEN 'Thursday'
      WHEN 6 THEN 'Friday'
      WHEN 7 THEN 'Saturday'
    END AS day_of_week,
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
    start_station_name,
    end_station_name,
    start_lat,
    start_lng,
    end_lat,
    end_lng,
    member_casual AS user_type,
FROM `2023_biketrips`
WHERE
  start_station_name IS NOT NULL
  AND end_station_name IS NOT NULL
  AND end_lat IS NOT NULL
  AND end_lng IS NOT NULL
  AND TIMESTAMP_DIFF(ended_at,started_at,SECOND) > 60
  AND TIMESTAMP_DIFF(ended_at,started_at,SECOND) < 86400
);


