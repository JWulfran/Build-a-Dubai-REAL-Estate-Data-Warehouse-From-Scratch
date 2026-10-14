SELECT * FROM dim_area;

SELECT * FROM dim_procedure;

SELECT * FROM fact_transaction;

-- Yearly Growth rate
SELECT
    year,
    COUNT(*) AS total_transactions,
    ROUND(AVG(f.actual_worth)::numeric,0) AS avg_price,
    ROUND((SUM(f.actual_worth) / 1000000000)::numeric, 2) AS total_value_billion_aed
FROM fact_transaction f
JOIN dim_date d ON f.date_id = d.date_id
GROUP BY year
ORDER BY year;

-- Area Ranking
SELECT 
    a.area_name_en,
    COUNT(*) as total_transactions,
    ROUND((SUM(f.actual_worth)/1000000000)::numeric, 2) AS total_value_billion_aed,
    ROUND(AVG(f.actual_worth)::numeric,0) AS avg_price
FROM fact_transaction f
JOIN dim_area a ON f.area_id = a.area_id
GROUP BY area_name_en
ORDER BY total_value_billion_aed DESC
LIMIT 10

-- Property type market share
SELECT
    p.property_type_en,
    COUNT(*) AS total_transactions,
    ROUND((SUM(f.actual_worth)/1000000000)::numeric, 2) AS total_value_billion_aed,
    ROUND(AVG(f.actual_worth)::numeric,0) AS avg_price
FROM fact_transaction f 
JOIN dim_property p ON f.property_id = p.property_id
GROUP BY p.property_type_en
ORDER BY total_transactions DESC;

-- Monthly transactions and average prices
SELECT
    d.month,
    COUNT(*) AS total_transaction,
    ROUND(AVG(f.actual_worth)::numeric, 2) AS avg_price
FROM fact_transaction f 
JOIn dim_date d on f.date_id = d.date_id
WHERE d.year = 2022
GROUP BY d.month
ORDER BY d.month;

-- Top 5 Most expensive Areas Per Sqm
SELECT
    a.area_name_en,
    ROUND(AVG(f.meter_sale_price)::numeric, 0) AS avg_price_per_sqm,
    COUNT(*) AS total_transactions
FROM fact_transaction f
JOIN dim_area a ON f.area_id = a.area_id
GROUP BY a.area_name_en
HAVING COUNT(*) > 1000
ORDER BY avg_price_per_sqm DESC
LIMIT 5;