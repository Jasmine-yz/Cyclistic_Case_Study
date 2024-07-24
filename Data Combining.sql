CREATE TABLE `project-1-429715.divvy_tripdata.biketrips` AS (
  
  SELECT * FROM `project-1-429715.divvy_tripdata.2023_06_tripdata`
  UNION ALL
  SELECT * FROM `project-1-429715.divvy_tripdata.2023_07_tripdata`
  UNION ALL
  SELECT * FROM `project-1-429715.divvy_tripdata.2023_08_tripdata`
  UNION ALL
  SELECT * FROM `project-1-429715.divvy_tripdata.2023_09_tripdata`
  UNION ALL
  SELECT * FROM `project-1-429715.divvy_tripdata.2023_10_tripdata`
  UNION ALL
  SELECT * FROM `project-1-429715.divvy_tripdata.2023_11_tripdata`
  UNION ALL
  SELECT * FROM `project-1-429715.divvy_tripdata.2023_12_tripdata`
  UNION ALL
  SELECT * FROM `project-1-429715.divvy_tripdata.2024_01_tripdata`
  UNION ALL
  SELECT * FROM `project-1-429715.divvy_tripdata.2024_02_tripdata`
  UNION ALL
  SELECT * FROM `project-1-429715.divvy_tripdata.2024_03_tripdata`
  UNION ALL
  SELECT * FROM `project-1-429715.divvy_tripdata.2024_04_tripdata`
  UNION ALL
  SELECT * FROM `project-1-429715.divvy_tripdata.2024_05_tripdata`

);
