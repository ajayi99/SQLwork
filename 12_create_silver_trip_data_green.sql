-- TRANSFORMING TO PARQUET FILE
/*IF OBJECT_ID ('silver.trip_data_green') IS NOT NULL
    DROP EXTERNAL TABLE  silver.trip_data_green
GO    
CREATE EXTERNAL TABLE silver.trip_data_green
    WITH(
        DATA_SOURCE = nyc_taxi_src,
        LOCATION = 'silver/trip_data_green',
        FILE_FORMAT = parquet_file_format
    )
AS
SELECT *
    FROM bronze.trip_data_green_csv;    

SELECT * FROM silver.trip_data_green;

*/
--DO IT FOR ALL YEARS AND MONTHS
EXEC silver.usp_silver_trip_data_green '2020' ,'01'