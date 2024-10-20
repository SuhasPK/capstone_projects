SELECT * FROM gda.bikeshare2020;

SELECT member_casual, AVG(trip_duration) AS avg_trip_duration
FROM gda.bikeshare2020
GROUP BY member_casual;

SELECT member_casual, day_of_week, COUNT(*) AS rides_count
FROM gda.bikeshare2020
GROUP BY member_casual, day_of_week
ORDER BY member_casual, rides_count DESC;

SELECT member_casual, HOUR(started_at) AS hour_of_day, COUNT(*) AS ride_count
FROM gda.bikeshare2020
GROUP BY member_casual, hour_of_day
ORDER BY member_casual, hour_of_day;

SELECT member_casual, rideable_type, COUNT(*) AS ride_count
FROM gda.bikeshare2020
GROUP BY member_casual, rideable_type
ORDER BY member_casual, ride_count DESC;

SELECT member_casual, 
       CASE 
           WHEN trip_duration <= 10 THEN '<= 10 min'
           WHEN trip_duration BETWEEN 11 AND 20 THEN '11-20 min'
           WHEN trip_duration BETWEEN 21 AND 30 THEN '21-30 min'
           WHEN trip_duration BETWEEN 31 AND 60 THEN '31-60 min'
           ELSE '> 60 min'
       END AS duration_range, 
       COUNT(*) AS ride_count
FROM gda.bikeshare2020
GROUP BY member_casual, duration_range
ORDER BY member_casual, duration_range;

SELECT member_casual, start_station_name, COUNT(*) AS ride_count
FROM gda.bikeshare2020
GROUP BY member_casual, start_station_name
ORDER BY ride_count DESC
LIMIT 10;
SELECT member_casual, end_station_name, COUNT(*) AS ride_count
FROM gda.bikeshare2020
GROUP BY member_casual, end_station_name
ORDER BY ride_count DESC
LIMIT 10;

SELECT ride_id, 
    member_casual,
    111.111 * DEGREES(ACOS(COS(RADIANS(start_lat))
                 * COS(RADIANS(end_lat))
                 * COS(RADIANS(start_lng) - RADIANS(end_lng))
                 + SIN(RADIANS(start_lat))
                 * SIN(RADIANS(end_lat)))) AS distance_km
FROM gda.bikeshare2020;

SELECT member_casual, AVG(distance_km) AS avg_distance_km
FROM (SELECT ride_id, 
             member_casual,
             111.111 * DEGREES(ACOS(COS(RADIANS(start_lat))
                          * COS(RADIANS(end_lat))
                          * COS(RADIANS(start_lng) - RADIANS(end_lng))
                          + SIN(RADIANS(start_lat))
                          * SIN(RADIANS(end_lat)))) AS distance_km
      FROM gda.bikeshare2020) AS distances
GROUP BY member_casual;

ALTER TABLE gda.bikeshare2020 ADD COLUMN week_part VARCHAR(10);

UPDATE gda.bikeshare2020 
SET week_part = CASE 
                   WHEN DAYOFWEEK(started_at) IN (1, 7) THEN 'Weekend'
                   ELSE 'Weekday'
               END;

SELECT member_casual, MONTHNAME(started_at) AS month, COUNT(*) AS ride_count
FROM gda.bikeshare2020
GROUP BY member_casual, month
ORDER BY FIELD(month, 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December');


