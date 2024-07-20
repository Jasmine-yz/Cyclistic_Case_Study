

CREATE TABLE project-1-429715.gda_capstone_1.2023_biketrips_updated AS(
  SELECT
    ride_id,
    rideable_type,
    started_at,
    ended_at,
    FORMAT_TIMESTAMP('%T', TIMESTAMP_SECONDS(TIMESTAMP_DIFF(ended_at,started_at,SECOND)))AS ride_length,
    CASE EXTRACT(DAYOFWEEK FROM started_at)
      WHEN 1 THEN 'SUN'
      WHEN 2 THEN 'MON'
      WHEN 3 THEN 'TUES'
      WHEN 4 THEN 'WED'
      WHEN 5 THEN 'THURS'
      WHEN 6 THEN 'FRI'
      WHEN 7 THEN 'SAT'
    END AS day_of_week,
    CASE EXTRACT(MONTH FROM started_at)
      WHEN 1 THEN 'JAN'
      WHEN 2 THEN 'FEB'
      WHEN 3 THEN 'MAR'
      WHEN 4 THEN 'APR'
      WHEN 5 THEN 'MAY'
      WHEN 6 THEN 'JUN'
      WHEN 7 THEN 'JUL'
      WHEN 8 THEN 'AUG'
      WHEN 9 THEN 'SEP'
      WHEN 10 THEN 'OCT'
      WHEN 11 THEN 'NOV'
      WHEN 12 THEN 'DEC'
    END AS month,
    start_station_name,
    end_station_name,
    start_lat,
    start_lng,
    end_lat,
    end_lng,
    member_casual AS user_type,
FROM `project-1-429715.gda_capstone_1.2023_biketrips`
WHERE
  start_station_name IS NOT NULL
  AND end_station_name IS NOT NULL
  AND end_lat IS NOT NULL
  AND end_lng IS NOT NULL
  AND TIMESTAMP_DIFF(ended_at,started_at,SECOND) > 0
  AND TIMESTAMP_DIFF(ended_at,started_at,SECOND) < 86400
);


