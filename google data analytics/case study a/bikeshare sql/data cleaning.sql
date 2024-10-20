DESCRIBE gda.bikeshare2020;

SELECT * FROM gda.bikeshare2020 LIMIT 10;

SELECT COUNT(*) FROM gda.bikeshare2020;

SELECT 
	COUNT(*) AS total_rows,
	SUM( CASE WHEN started_at IS NULL THEN 1 ELSE 0 END) AS started_at_nulls,
    SUM( CASE WHEN ended_at IS NULL THEN 1 ELSE 0 END) AS ended_at_nulls,
    SUM( CASE WHEN member_casual IS NULL THEN 1 ELSE 0 END) AS member_casual_nulls
FROM gda.bikeshare2020;

ALTER TABLE gda.bikeshare2020 
MODIFY COLUMN started_at DATETIME,
MODIFY COLUMN ended_at DATETIME;

SELECT 
    started_at, 
    STR_TO_DATE(started_at, '%d-%m-%Y %H:%i') AS converted_start 
FROM gda.bikeshare2020 
LIMIT 10;

SET SQL_SAFE_UPDATES = 0;
UPDATE gda.bikeshare2020
SET started_at = STR_TO_DATE(started_at, '%d-%m-%Y %H:%i'),
    ended_at = STR_TO_DATE(ended_at, '%d-%m-%Y %H:%i')
WHERE ride_id IS NOT NULL;
SET SQL_SAFE_UPDATES = 1;

ALTER TABLE gda.bikeshare2020 
MODIFY COLUMN started_at DATETIME,
MODIFY COLUMN ended_at DATETIME;

DESCRIBE gda.bikeshare2020;

SET SQL_SAFE_UPDATES = 0;
DELETE FROM gda.bikeshare2020 
WHERE started_at IS NULL OR ended_at IS NULL OR member_casual IS NULL;
SET SQL_SAFE_UPDATES = 1;

ALTER TABLE gda.bikeshare2020 ADD COLUMN trip_duration INT;
SET SQL_SAFE_UPDATES = 0;
UPDATE gda.bikeshare2020 
SET trip_duration = TIMESTAMPDIFF(MINUTE, started_at, ended_at);
SET SQL_SAFE_UPDATES = 0;
SELECT * FROM gda.bikeshare2020 LIMIT 10;

ALTER TABLE gda.bikeshare2020 ADD COLUMN day_of_week VARCHAR(10);
SET SQL_SAFE_UPDATES = 0;
UPDATE gda.bikeshare2020 
SET day_of_week = DAYNAME(started_at);
SET SQL_SAFE_UPDATES = 1;
SELECT * FROM gda.bikeshare2020 LIMIT 10;








