SELECT *
FROM `bigquery-public-data.london_bicycles.cycle_hire`;

-- TOTAL USAGE --
SELECT COUNT(*) AS total_usage
FROM `bigquery-public-data.london_bicycles.cycle_hire`;

-- TOTAL USAGE PER YEAR AND MONTH --
SELECT EXTRACT(YEAR FROM start_date) AS year,
 EXTRACT(MONTH FROM start_date) AS month,
 COUNT(*) AS total_usage
FROM `bigquery-public-data.london_bicycles.cycle_hire`
GROUP BY year, month;

-- TOTAL START & END STATION --
SELECT COUNT(DISTINCT start_station_id) AS total_start_station,
COUNT(DISTINCT end_station_id) AS total_end_station
FROM `bigquery-public-data.london_bicycles.cycle_hire`;

-- DATE RANGE --
SELECT MIN(DATE(start_date)) AS first_date, 
  MAX(DATE(start_date)) AS last_date
FROM `bigquery-public-data.london_bicycles.cycle_hire`;

-- YEAR RANGE --
SELECT DISTINCT (EXTRACT(YEAR FROM start_date)) AS year
FROM `bigquery-public-data.london_bicycles.cycle_hire`
ORDER BY year ASC;

-- COUNTING BIKE MODEL --
SELECT DISTINCT 
  CASE
    WHEN bike_model IS NULL OR bike_model = '' THEN 'unknown'
    ELSE bike_model
  END AS bike_model_cleaned,
  COUNT(*) AS total_bike_model
  FROM bigquery-public-data.london_bicycles.cycle_hire
  GROUP BY bike_model_cleaned
  ORDER BY total_bike_model;

-- COUNTING START BICYCLE STATION --
SELECT DISTINCT 
  CASE
    WHEN bike_model IS NULL OR bike_model = '' THEN 'unknown'
    ELSE bike_model
  END AS bike_model_cleaned, 
  start_station_name, 
  COUNT(start_station_name) AS total_start_station
FROM bigquery-public-data.london_bicycles.cycle_hire
GROUP BY 
  bike_model_cleaned, 
  start_station_name
  ORDER BY total_start_station DESC;

-- COUNTING END BICYCLE STATION --
SELECT DISTINCT 
  CASE
    WHEN bike_model IS NULL OR bike_model = '' THEN 'unknown'
    ELSE bike_model
  END AS bike_model_cleaned, 
  end_station_name, 
  COUNT(end_station_name) AS total_end_station
FROM bigquery-public-data.london_bicycles.cycle_hire
GROUP BY 
  bike_model_cleaned, 
  end_station_name
  ORDER BY total_end_station DESC;

-- VOLUME BIKE USAGE PER DAY --
SELECT
EXTRACT(YEAR FROM start_date) AS year,
EXTRACT(MONTH FROM start_date) AS month,
EXTRACT(DAYOFWEEK FROM start_date) AS day_week,
  CASE EXTRACT(DAYOFWEEK FROM start_date)
    WHEN 1 THEN 'Sunday'
    WHEN 2 THEN 'Monday'
    WHEN 3 THEN 'Tuesday'
    WHEN 4 THEN 'Wednesday'
    WHEN 5 THEN 'Thursday'
    WHEN 6 THEN 'Friday'
    WHEN 7 THEN 'Saturday'
  END AS day_name,
COUNT(*) AS total_usage
FROM bigquery-public-data.london_bicycles.cycle_hire
GROUP BY day_week, day_name, year, month
ORDER BY day_week;

-- VOLUME BIKE USAGE PER HOUR --
SELECT
EXTRACT(HOUR FROM start_date) AS hour,
EXTRACT(YEAR FROM start_date) AS year,
EXTRACT(MONTH FROM start_date) AS month,
COUNT(*) AS total_usage
FROM bigquery-public-data.london_bicycles.cycle_hire
GROUP BY hour, year, month
ORDER BY hour;

-- VOLUME BIKE START STATION USAGE PER HOUR AT HYDE PARK CORNER --
SELECT
EXTRACT(HOUR FROM start_date) AS hour,
start_station_name,
COUNT(*) AS total_usage
FROM bigquery-public-data.london_bicycles.cycle_hire
WHERE start_station_name LIKE 'Hyde Park Corner%'
GROUP BY hour, start_station_name
ORDER BY hour;

-- VOLUME BIKE END STATION USAGE PER HOUR AT HYDE PARK CORNER --
SELECT
EXTRACT(HOUR FROM start_date) AS hour,
end_station_name,
COUNT(*) AS total_usage
FROM bigquery-public-data.london_bicycles.cycle_hire
WHERE end_station_name LIKE 'Hyde Park Corner%'
GROUP BY hour, end_station_name
ORDER BY hour;

-- WEEKDAY & WEEKEND COMPARISON --
SELECT
  CASE 
    WHEN EXTRACT(DAYOFWEEK FROM start_date) IN (2, 3, 4, 5, 6) THEN 'Weekday'
    WHEN EXTRACT(DAYOFWEEK FROM start_date) IN (1, 7) THEN 'Weekend'
  END AS week_type,
  COUNT(*) AS total_usage
FROM `bigquery-public-data.london_bicycles.cycle_hire`
GROUP BY week_type
ORDER BY total_usage DESC;