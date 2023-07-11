USE nyc_taxi_discovery;

SELECT
     *
FROM
    OPENROWSET(
        BULK  'payment_type.json',
        DATA_SOURCE= 'nyc_taxi_raw',
        FORMAT = 'CSV',
        PARSER_VERSION = '1.0',
        FIELDTERMINATOR = '0x0b',
        FIELDQUOTE ='0x0b',
        ROWTERMINATOR ='0x0a'
    ) 
    WITH(
        jsonDoc NVARCHAR(MAX)
    )AS payment_type;
-- CODE FOR JSON FILES TO READ ALL THE ROWS AS IT IS IN THE JSON FILE  

SELECT CAST (JSON_VALUE(jsonDoc, '$.payment_type') AS SMALLINT )payment_type,
       CAST( JSON_VALUE(jsonDoc, '$.payment_type_desc') AS VARCHAR (15))payment_type_desc
     
FROM
    OPENROWSET(
        BULK  'payment_type.json',
        DATA_SOURCE= 'nyc_taxi_raw',
        FORMAT = 'CSV',
        PARSER_VERSION = '1.0',
        FIELDTERMINATOR = '0x0b',
        FIELDQUOTE ='0x0b',
        ROWTERMINATOR ='0x0a'
    ) 
    WITH(
        jsonDoc NVARCHAR(MAX)
    )AS payment_type;

  -- PULL OUT THE PROPRETIES INTO SEPEARATE COLUMNS  
  -- $ stands for this 
  -- CAST IS USED TO DEFINE THE DATA TYPE 



-- CODE TO EFFICENTLY TURN THE JSON FILE INTO ROWS AND COLUMNS
SELECT payment_type, payment_type_desc     
FROM
    OPENROWSET(
        BULK  'payment_type.json',
        DATA_SOURCE= 'nyc_taxi_raw',
        FORMAT = 'CSV',
        FIELDTERMINATOR = '0x0b',
        FIELDQUOTE ='0x0b'
    ) 
    WITH(
        jsonDoc NVARCHAR(MAX)
    )AS payment_type
    CROSS APPLY OPENJSON(jsonDoc)
    WITH(
        payment_type SMALLINT,
        payment_type_desc VARCHAR (20)
    );  


--READING DATA FROM JSON FILES WITH ARRAYS
SELECT CAST (JSON_VALUE(jsonDoc, '$.payment_type') AS SMALLINT )payment_type,
       CAST( JSON_VALUE(jsonDoc, '$.payment_type_desc[0].value') AS VARCHAR (15))payment_type_desc_0,
       CAST( JSON_VALUE(jsonDoc, '$.payment_type_desc[1].value') AS VARCHAR (15))payment_type_desc_1
     
FROM
    OPENROWSET(
        BULK  'payment_type_array.json',
        DATA_SOURCE= 'nyc_taxi_raw',
        FORMAT = 'CSV',
        PARSER_VERSION = '1.0',
        FIELDTERMINATOR = '0x0b',
        FIELDQUOTE ='0x0b',
        ROWTERMINATOR ='0x0a'
    ) 
    WITH(
        jsonDoc NVARCHAR(MAX)
    )AS payment_type;

--USING JSON TO EXPLODE THE ARRAY
SELECT payment_type, payment_type_desc_value
     
FROM
    OPENROWSET(
        BULK  'payment_type_array.json',
        DATA_SOURCE= 'nyc_taxi_raw',
        FORMAT = 'CSV',
        PARSER_VERSION = '1.0',
        FIELDTERMINATOR = '0x0b',
        FIELDQUOTE ='0x0b',
        ROWTERMINATOR ='0x0a'
    ) 
    WITH(
        jsonDoc NVARCHAR(MAX)
    )AS payment_type
    CROSS APPLY OPENJSON (jsonDoc)
    WITH(
        payment_type SMALLINT,
        payment_type_desc NVARCHAR(MAX) AS JSON
    )
    CROSS APPLY OPENJSON(payment_type_desc)
    WITH(
        sub_type SMALLINT,
        payment_type_desc_value VARCHAR(20) '$.value'
    );
