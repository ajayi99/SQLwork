-- This is auto-generated code
SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'trip_data_green_parquet/year=2020/month=01/',
        FORMAT = 'PARQUET',
        DATA_SOURCE = 'nyc_taxi_raw'
    ) AS [result]

--IDENTIFY INHERITED DATA TYPES
EXEC sp_describe_first_result_set N'SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK ''trip_data_green_parquet/year=2020/month=01/'',
        FORMAT = ''PARQUET'',
        DATA_SOURCE = ''nyc_taxi_raw''
    ) AS [result]'

-- ADD THE PREFERRED DATA TYPES
SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'trip_data_green_parquet/year=2020/month=01/',
        FORMAT = 'PARQUET',
        DATA_SOURCE = 'nyc_taxi_raw'
    )
    WITH (
        VendorID INT,
        lpep_pickup_datetime DATETIME2(7),
        lpep_dropoff_datetime DATETIME2(7),
        store_and_fwd_flag CHAR(1),
        RatecodeID INT,
        PULocationID INT,
        DOLocationID INT,
        passenger_count INT,
        trip_distance FLOAT,
        fare_amount FLOAT,
        extra FLOAT,
        mta_tax FLOAT,
        tip_amount FLOAT,
        tolls_amount FLOAT,
        ehail_fee INT,
        improvement_surchage FLOAT,
        total_amount FLOAT,
        payment_type INT,
        trip_type INT,
        congestion_surcharge FLOAT
    ) AS[result]    