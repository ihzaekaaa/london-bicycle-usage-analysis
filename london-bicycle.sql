SELECT *
FROM bigquery-public-data.london_bicycles.cycle_hire;

-- QUERY --
SELECT
  CASE 
    WHEN EXTRACT(DAYOFWEEK FROM start_date) IN (2, 3, 4, 5, 6) THEN 'Weekday'
    WHEN EXTRACT(DAYOFWEEK FROM start_date) IN (1, 7) THEN 'Weekend'
  END AS week_type, 
  duration,
  CASE
    WHEN bike_model IS NULL OR bike_model = '' THEN 'unknown'
    ELSE bike_model
  END AS bike_model_cleaned,
  end_date, end_station_name, start_date, start_station_name,
  COUNT(*) AS total_usage
FROM `bigquery-public-data.london_bicycles.cycle_hire`
GROUP BY week_type, duration, bike_model_cleaned, end_date, end_station_name, start_date, start_station_name
ORDER BY total_usage DESC;
