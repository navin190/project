--changing crash point data type to array
ALTER TABLE crash_data
    ALTER COLUMN "geo_shape.geometry.coordinates" TYPE FLOAT[]
    USING "geo_shape.geometry.coordinates"::FLOAT[];

--changing crash_time data time to time
ALTER TABLE crash_data
    ALTER COLUMN crash_time TYPE TIME
    USING crash_time::time without time zone;

--Question 3 solution	
SELECT city FROM crash_data
WHERE crash_time > '20:00:00' and crash_time < '20:30:00' and
	(acos(sin(RADIANS(-78.95570271414434)) * 
	sin(RADIANS("geo_shape.geometry.coordinates"[1])) + 
	cos(RADIANS(-78.95570271414434)) * cos(RADIANS("geo_shape.geometry.coordinates"[1])) 
	* cos(RADIANS(35.95956710652295)- RADIANS("geo_shape.geometry.coordinates"[2])))*6371)<=10
	
--Q4 indexes

--SIMPLE INDEX
	-- On crash_time
	CREATE INDEX crash_time_index ON crash_data(crash_time);
	
	-- On geometry coordinates
	CREATE INDEX 
	coordinates_index ON crash_data("geo_shape.geometry.coordinates");
	
--COMPOSITE INDEX
	-- On crash_time & geometry coordinates
	CREATE INDEX crash_time_coordinates_index ON crash_data(crash_time,"geo_shape.geometry.coordinates");
	