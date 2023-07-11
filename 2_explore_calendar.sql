-- WHEN USING CSV FILES MAKE SURE HEADER ROW IS PRESENT OR FIRST ROW
SELECT
     *
FROM
    OPENROWSET(
        BULK  'calendar.csv',
        DATA_SOURCE= 'nyc_taxi_raw',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE
        )
    WITH(
        date_key INT,
        date     DATE,
        year     SMALLINT,
        month    TINYINT,
        day_name VARCHAR(10),
        day_of_year SMALLINT,
        week_of_month TINYINT,
        week_of_year TINYINT,
        month_name VARCHAR(10),
        year_month INT,
        year_week  INT
    )
    AS cal;

EXEC sp_describe_first_result_set N'SELECT
     *
FROM
    OPENROWSET(
        BULK  ''calendar.csv'',
        DATA_SOURCE= ''nyc_taxi_raw'',
        FORMAT = ''CSV'',
        PARSER_VERSION = ''2.0'',
        HEADER_ROW = TRUE
    ) AS cal'