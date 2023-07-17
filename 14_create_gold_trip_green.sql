USE nyc_taxi_ldw
GO


--CAMPAIGN REQUIREMENTS START WITH THE SELECT STATEMENT

SELECT TOP (100)
       year,
       month,
       tz.borough,
       CONVERT(DATE, td.lpep_pickup_datetime) AS trip_date --CONVERTS THE DATETIME INTO DATE MAKE SURE YOU APPLY THE COLUMN DATA

    FROM silver.vw_trip_data_green td
    JOIN silver.taxi_zone tz ON (td.PULocationID = tz.location_id)
WHERE year =  '2020'
    AND month = '01'
   SELECT * FROM silver.taxi_zone 