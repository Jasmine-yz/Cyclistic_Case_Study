CREATE TABLE `project-1-429715.cyclistic_tripdata.2023biketrips` AS (
  
  SELECT * FROM `project-1-429715.cyclistic_tripdata.2023_01_biketrips`
  UNION ALL
  SELECT * FROM `project-1-429715.cyclistic_tripdata.2023_02_biketrips`
  UNION ALL
  SELECT * FROM `project-1-429715.cyclistic_tripdata.2023_03_biketrips`
  UNION ALL
  SELECT * FROM `project-1-429715.cyclistic_tripdata.2023_04_biketrips`
  UNION ALL
  SELECT * FROM `project-1-429715.cyclistic_tripdata.2023_05_biketrips`
  UNION ALL
  SELECT * FROM `project-1-429715.cyclistic_tripdata.2023_06_biketrips`
  UNION ALL
  SELECT * FROM `project-1-429715.cyclistic_tripdata.2023_07_biketrips`
  UNION ALL
  SELECT * FROM `project-1-429715.cyclistic_tripdata.2023_08_biketrips`
  UNION ALL
  SELECT * FROM `project-1-429715.cyclistic_tripdata.2023_09_biketrips`
  UNION ALL
  SELECT * FROM `project-1-429715.cyclistic_tripdata.2023_10_biketrips`
  UNION ALL
  SELECT * FROM `project-1-429715.cyclistic_tripdata.2023_11_biketrips`
  UNION ALL
  SELECT * FROM `project-1-429715.cyclistic_tripdata.2023_12_biketrips`
  
);
