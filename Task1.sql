CREATE TABLE country_pollutions (
    country VARCHAR(100),
    temperature FLOAT,
    CO2_Emission FLOAT,
    year DATE
);

SELECT * FROM country_pollutions

SELECT 
    country, 
    temperature,
    RANK() OVER (PARTITION BY year ORDER BY temperature DESC) AS rk
FROM 
    country_pollutions
ORDER BY rk;

SELECT YEAR(year), country, temperature
FROM country_pollutions cp
WHERE temperature = (SELECT MAX(temperature) FROM country_pollutions 
WHERE year = cp.year)
ORDER BY year;


SELECT country, temperature
FROM country_pollutions
WHERE temperature = (SELECT MAX(temperature) FROM country_pollutions);

SELECT 
    cp.year,
    cp.country,
    cp.temperature
FROM 
    country_pollutions cp
INNER JOIN 
    (
        SELECT 
            year, 
            MAX(temperature) AS max_temp
        FROM 
            country_pollutions
        GROUP BY 
            year
    ) AS yearly_max 
ON 
    cp.year = yearly_max.year 
    AND cp.temperature = yearly_max.max_temp
ORDER BY 
    cp.year;


SELECT country, CO2_Emission 
FROM country_pollutions
ORDER BY CO2_Emission;

WITH RankedCountries AS (
    SELECT 
        country, 
        CO2_Emission,
        ROW_NUMBER() OVER (PARTITION BY country ORDER BY CO2_Emission ASC) AS rn
    FROM 
        country_pollutions
)
SELECT 
    country, 
    CO2_Emission
FROM 
    RankedCountries
WHERE 
    rn = 1
ORDER BY 
    CO2_Emission ASC;
