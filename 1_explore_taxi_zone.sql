-- This is auto-generated code
SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'https://synapseajayiwork.dfs.core.windows.net/nyc-taxi/raw/taxi_zone.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0'
    ) AS [result]


SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'abfss://nyc-taxi@synapseajayiwork.dfs.core.windows.net/raw/taxi_zone.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE, -- THIS IDENTIFIES THE HEADER IN THE CSV FILE
        FIELDTERMINATOR = ',' ,-- THIS IDENTIFIES THE FIELD TERMINATOR TO BE A COMMA
        ROWTERMINATOR = '\n'-- THIS IDENTIFIES THE ROW TERMINATOR TO BE SLASH N FOR WINDOWS
    ) AS [result]





--EXAMINE THE DATA TYPES FOR THE COLUMNS --THIS IS THE CODE TO RUN TO SEE THE DATA TYPES 
EXEC sp_describe_first_result_set N'SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK ''abfss://nyc-taxi@synapseajayiwork.dfs.core.windows.net/raw/taxi_zone.csv'',
        FORMAT = ''CSV'',
        PARSER_VERSION = ''2.0'',
        HEADER_ROW = TRUE
    ) AS [result] '

--CODE TO SHOW THE MAX LENGTH FOR THE COLUMNS
SELECT
    MAX(LEN(LocationID)) AS len_locationId,
    MAX(LEN(Borough)) AS len_Borough,
    MAX(LEN(Zone)) AS len_Zone,
    MAX(LEN(service_zone)) AS len_service_zone

FROM
    OPENROWSET(
        BULK 'abfss://nyc-taxi@synapseajayiwork.dfs.core.windows.net/raw/taxi_zone.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE, 
        FIELDTERMINATOR = ',' ,
        ROWTERMINATOR = '\n'
    ) AS [result]

--USE THE WITH CLAUSE TO PROVIDE EXPLICIT DATA TYPES 
SELECT
  *
FROM
    OPENROWSET(
        BULK 'abfss://nyc-taxi@synapseajayiwork.dfs.core.windows.net/raw/taxi_zone.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE, 
        FIELDTERMINATOR = ',' ,
        ROWTERMINATOR = '\n'
    ) 
    WITH( 
        LocationID SMALLINT,
        Borough VARCHAR(15),
        Zone VARCHAR(50),
        service_zone VARCHAR(15)
        ) AS [result]
-- YOU RUN THIS QUERY AS IT SAVES YOU MONEY RATHER THAN USING THE DEFAULT SPACE FOR SYNAPSE
EXEC sp_describe_first_result_set N'SELECT
  *
FROM
    OPENROWSET(
        BULK ''abfss://nyc-taxi@synapseajayiwork.dfs.core.windows.net/raw/taxi_zone.csv'',
        FORMAT = ''CSV'',
        PARSER_VERSION = ''2.0'',
        HEADER_ROW = TRUE, 
        FIELDTERMINATOR = '','' ,
        ROWTERMINATOR = ''\n''
    ) 
    WITH( 
        LocationID SMALLINT,
        Borough VARCHAR(15),
        Zone VARCHAR(50),
        service_zone VARCHAR(15)
        ) AS [result]'


-- CODE TO FIND THE COLLATION FROM THE DATABASES
SELECT name, collation_name FROM sys.databases;

--CODE TO SPECIFY THE UTF-8 COLLATION IN THE WITH CLAUSE
SELECT
  *
FROM
    OPENROWSET(
        BULK 'abfss://nyc-taxi@synapseajayiwork.dfs.core.windows.net/raw/taxi_zone.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE, 
        FIELDTERMINATOR = ',' ,
        ROWTERMINATOR = '\n'
    ) 
    WITH( 
        LocationID SMALLINT,
        Borough VARCHAR(15) COLLATE Latin1_General_100_CI_AI_SC_UTF8,
        Zone VARCHAR(50) COLLATE Latin1_General_100_CI_AI_SC_UTF8,
        service_zone VARCHAR(15) COLLATE Latin1_General_100_CI_AI_SC_UTF8
        ) AS [result]

-- CODE TO ALTER DATABASE TO USE UTF-8 COLLATION
CREATE DATABASE nyc_taxi_discovery;
ALTER DATABASE nyc_taxi_discovery COLLATE Latin1_General_100_CI_AI_SC_UTF8;

SELECT
  *
FROM
    OPENROWSET(
        BULK 'abfss://nyc-taxi@synapseajayiwork.dfs.core.windows.net/raw/taxi_zone.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE, 
        FIELDTERMINATOR = ',' ,
        ROWTERMINATOR = '\n'
    ) 
    WITH( 
        LocationID SMALLINT,
        Borough VARCHAR(15),
        Zone VARCHAR(50),
        service_zone VARCHAR(15)
        ) AS [result]

--SELECT ONLY A SUBSET OF COLUMNS 
SELECT
  *
FROM
    OPENROWSET(
        BULK 'abfss://nyc-taxi@synapseajayiwork.dfs.core.windows.net/raw/taxi_zone.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE, 
        FIELDTERMINATOR = ',' ,
        ROWTERMINATOR = '\n'
    ) 
    WITH( 
        
        Borough VARCHAR(15),
        Zone VARCHAR(50)
        
        ) AS [result]


-- READ DATA FROM FILE WITHOUT HEADER
SELECT
  *
FROM
    OPENROWSET(
        BULK 'abfss://nyc-taxi@synapseajayiwork.dfs.core.windows.net/raw/taxi_zone_without_header.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        FIELDTERMINATOR = ',' ,
        ROWTERMINATOR = '\n'
    ) 
    WITH( 
        Borough VARCHAR(15) 2 , -- USE ORDINAL OF POSTION TO GET THE CREATE DATA IN THE ORDER
        Zone VARCHAR(50) 3
        )
     AS [result]

-- FIX COLUMN NAMES USING ORDINAL POSTION WITHOUT HEADER ROW
SELECT
  *
FROM
    OPENROWSET(
        BULK 'abfss://nyc-taxi@synapseajayiwork.dfs.core.windows.net/raw/taxi_zone.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        FIRSTROW = 2, -- SPECIFIES THAT YOU DATA STARTS FROM THE SECOND ROW
        FIELDTERMINATOR = ',' ,
        ROWTERMINATOR = '\n'
    ) 
    WITH( 
        location_id SMALLINT 1,
        borough VARCHAR(15) 2,
        zone VARCHAR(50) 3 ,
        service_zone VARCHAR(15) 4
        ) AS [result]


-- EXTERNAL DATA SOURCES 

CREATE EXTERNAL DATA SOURCE nyc_taxi_raw
WITH (
    LOCATION = 'abfss://nyc-taxi@synapseajayiwork.dfs.core.windows.net/raw'
)

SELECT
  *
FROM
    OPENROWSET(
        BULK 'taxi_zone.csv',
        DATA_SOURCE= 'nyc_taxi_raw',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        FIRSTROW = 2, -- SPECIFIES THAT YOU DATA STARTS FROM THE SECOND ROW
        FIELDTERMINATOR = ',' ,
        ROWTERMINATOR = '\n'
    ) 
    WITH( 
        location_id SMALLINT 1,
        borough VARCHAR(15) 2,
        zone VARCHAR(50) 3 ,
        service_zone VARCHAR(15) 4
        ) AS [result]

 -- USE THIS AS IT IS AN EASIER WAY TO WRITE THE PATH FOR DIRECTORIES   
 
 -- CODE TO FIND THE LOCATION OF THE DATA SOURCE
 SELECT name, location FROM sys.external_data_sources;