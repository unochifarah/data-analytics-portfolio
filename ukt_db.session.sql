-- ============================================================
--   1) Minimum–Maximum UKT per University + Gap
-- ============================================================
WITH row_stats AS (
    SELECT
        universitas,
        LEAST(
            ukt_1, ukt_2, ukt_3, ukt_4, ukt_5, 
            ukt_6, ukt_7, ukt_8, ukt_9, ukt_10, ukt_11
        ) AS min_ukt,
        GREATEST(
            ukt_1, ukt_2, ukt_3, ukt_4, ukt_5,
            ukt_6, ukt_7, ukt_8, ukt_9, ukt_10, ukt_11
        ) AS max_ukt
    FROM ukt_data
)
SELECT 
    universitas,
    MIN(min_ukt) AS lowest_ukt,
    MAX(max_ukt) AS highest_ukt,
    MAX(max_ukt) - MIN(min_ukt) AS ukt_gap
FROM row_stats
GROUP BY universitas;


-- ============================================================
--   2) Minimum–Maximum UKT per Program + Gap
-- ============================================================
WITH program_ukt AS (
    SELECT
        program,
        LEAST(
            ukt_1, ukt_2, ukt_3, ukt_4, ukt_5, 
            ukt_6, ukt_7, ukt_8, ukt_9, ukt_10, ukt_11
        ) AS min_ukt,
        GREATEST(
            ukt_1, ukt_2, ukt_3, ukt_4, ukt_5,
            ukt_6, ukt_7, ukt_8, ukt_9, ukt_10, ukt_11
        ) AS max_ukt
    FROM ukt_data
)
SELECT
    program,
    MIN(min_ukt) AS lowest_ukt,
    MAX(max_ukt) AS highest_ukt,
    MAX(max_ukt) - MIN(min_ukt) AS ukt_gap
FROM program_ukt
GROUP BY program;


-- ============================================================
--   3) Top 3 Universities with Highest Maximum UKT
-- ============================================================
WITH row_stats AS (
    SELECT
        universitas,
        GREATEST(
            ukt_1, ukt_2, ukt_3, ukt_4, ukt_5,
            ukt_6, ukt_7, ukt_8, ukt_9, ukt_10, ukt_11
        ) AS max_ukt
    FROM ukt_data
)
SELECT
    universitas,
    MAX(max_ukt) AS highest_ukt
FROM row_stats
GROUP BY universitas
ORDER BY highest_ukt DESC
LIMIT 3;


-- ============================================================
--   4) Top 3 Universities with the Largest UKT Gap
-- ============================================================
WITH row_stats AS (
    SELECT
        universitas,
        LEAST(
            ukt_1, ukt_2, ukt_3, ukt_4, ukt_5, 
            ukt_6, ukt_7, ukt_8, ukt_9, ukt_10, ukt_11
        ) AS min_ukt,
        GREATEST(
            ukt_1, ukt_2, ukt_3, ukt_4, ukt_5,
            ukt_6, ukt_7, ukt_8, ukt_9, ukt_10, ukt_11
        ) AS max_ukt
    FROM ukt_data
)
SELECT
    universitas,
    MAX(max_ukt) - MIN(min_ukt) AS ukt_gap
FROM row_stats
GROUP BY universitas
ORDER BY ukt_gap DESC
LIMIT 3;


-- ============================================================
--   5) UKT Category Classification Based on Minimum UKT
-- ============================================================ 
WITH row_stats AS (
    SELECT
        universitas,
        LEAST(
            ukt_1, ukt_2, ukt_3, ukt_4, ukt_5, 
            ukt_6, ukt_7, ukt_8, ukt_9, ukt_10, ukt_11
        ) AS min_ukt
    FROM ukt_data
)
SELECT 
    universitas,
    MIN(min_ukt) AS lowest_ukt,
    CASE
        WHEN MIN(min_ukt) <= 500000 THEN 'Bersubsidi'
        WHEN MIN(min_ukt) < 2000000 THEN 'Rendah'
        WHEN MIN(min_ukt) BETWEEN 2000000 AND 5000000 THEN 'Sedang'
        ELSE 'Tinggi'
    END AS ukt_category
FROM row_stats
GROUP BY universitas;
