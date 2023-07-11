-- This is auto-generated code
SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK '/trip_data_green_csv/year=2020/month=01/green_tripdata_2020-01.csv',
        DATA_SOURCE = 'nyc_taxi_raw',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE
    ) AS [result]

--SELECT DATA FROM A FOLDER
SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK '/trip_data_green_csv/year=2020/month=01/*.csv', --*.csv will take data from all the csv files
        DATA_SOURCE = 'nyc_taxi_raw',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE
    ) AS [result]

--SELECT DATA FROM SUBFOLDERS

SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK '/trip_data_green_csv/year=2020/**', --Double star will get the data from the subfolder
        DATA_SOURCE = 'nyc_taxi_raw',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE
    ) AS [result]

--SPECIFIC FILES
 SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK ('/trip_data_green_csv/year=2020/month=01/*csv',
        '/trip_data_green_csv/year=2020/month=02/*.csv'), --This is how you specify getting data from specific months
        DATA_SOURCE = 'nyc_taxi_raw',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE
    ) AS [result]   


 --USE MORE THAN ONE WILDCARD
SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK '/trip_data_green_csv/year=*/month=*/*.csv',
        DATA_SOURCE = 'nyc_taxi_raw',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE
    ) AS [result]     

 --FILE METADATA FUNCTION FILENAME()   
 SELECT
    TOP 100
    result.filename() AS file_name,
     result.*
FROM
    OPENROWSET(
        BULK '/trip_data_green_csv/year=*/month=*/*.csv',
        DATA_SOURCE = 'nyc_taxi_raw',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE
    ) AS [result] 



SELECT
    result.filename() AS file_name,
    COUNT(1) AS record_count 
FROM
    OPENROWSET(
        BULK '/trip_data_green_csv/year=*/month=*/*.csv',
        DATA_SOURCE = 'nyc_taxi_raw',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE
    ) AS [result] 
GROUP BY result.filename()  
ORDER BY result.filename();


--LIMIT DATA USING FILENAME BY SPECIFYING FILENAME IN THE WHERE CLAUSE
SELECT
    result.filename() AS file_name,
    COUNT(1) AS record_count 
FROM
    OPENROWSET(
        BULK '/trip_data_green_csv/year=*/month=*/*.csv',
        DATA_SOURCE = 'nyc_taxi_raw',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE
    ) AS [result] 
WHERE result.filename() IN ('green_tripdata_2020-01.csv','green_tripdata_2021-01.csv') 
GROUP BY result.filename()  
ORDER BY result.filename();


--USE FILEPATH FUNCTION
SELECT
    result.filename() AS file_name,
    result.filepath() AS file_path,
    COUNT(1) AS record_count 
FROM
    OPENROWSET(
        BULK '/trip_data_green_csv/year=*/month=*/*.csv',
        DATA_SOURCE = 'nyc_taxi_raw',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE
    ) AS [result] 
WHERE result.filename() IN ('green_tripdata_2020-01.csv','green_tripdata_2021-01.csv') 
GROUP BY result.filename(), result.filepath() 
ORDER BY result.filename(), result.filepath();


--USE FILEPATH FUNCTION TO RETURN THE YEAR AND MONTH
SELECT
    result.filename() AS file_name,
    result.filepath(1) AS year,
    result.filepath(2) AS month,
    COUNT(1) AS record_count 
FROM
    OPENROWSET(
        BULK '/trip_data_green_csv/year=*/month=*/*.csv',
        DATA_SOURCE = 'nyc_taxi_raw',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE
    ) AS [result] 
WHERE result.filename() IN ('green_tripdata_2020-01.csv','green_tripdata_2021-01.csv') 
GROUP BY result.filename(), result.filepath(1),result.filepath(2)
ORDER BY result.filename(), result.filepath(1),result.filepath(2);


--USE FILEPATH FUNCTION TO RETURN THE COUNT OF TRIPS FOR EACH YEAR AND MONTH
SELECT
    result.filepath(1) AS year,
    result.filepath(2) AS month,
    COUNT(1) AS record_count 
FROM
    OPENROWSET(
        BULK '/trip_data_green_csv/year=*/month=*/*.csv',
        DATA_SOURCE = 'nyc_taxi_raw',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE
    ) AS [result] 
GROUP BY result.filename(), result.filepath(1),result.filepath(2)
ORDER BY result.filename(), result.filepath(1),result.filepath(2);

--USE FILEPATH IN WHERE CLAUSE FOR SPECIFIC MONTHS IN A YEAR
SELECT
    result.filepath(1) AS year,
    result.filepath(2) AS month,
    COUNT(1) AS record_count 
FROM
    OPENROWSET(
        BULK '/trip_data_green_csv/year=*/month=*/*.csv',
        DATA_SOURCE = 'nyc_taxi_raw',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE
    ) AS [result] 
WHERE result.filepath(1)= '2020'
    AND result.filepath(2) IN ('06','07','08')
GROUP BY result.filename(), result.filepath(1),result.filepath(2)
ORDER BY result.filename(), result.filepath(1),result.filepath(2);
