USE nyc_taxi_discovery;

SELECT
     *
FROM
    OPENROWSET(
        BULK  'vendor_unquoted.csv',
        DATA_SOURCE= 'nyc_taxi_raw',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE,
        ESCAPECHAR= '\\'
    ) AS vendor;