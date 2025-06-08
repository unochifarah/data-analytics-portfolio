-- 📊 Exploratory Data Analysis on Layoffs Dataset
-- Table: layoffs_staging2
-- Skills: Aggregation, Window Functions, CTEs, Date Handling

-- ============================================
-- 1. Preview the cleaned dataset
-- ============================================
SELECT * FROM layoffs_staging2;


-- ============================================
-- 2. Get the maximum total and percentage of layoffs
-- ============================================
SELECT 
    MAX(total_laid_off) AS max_laid_off, 
    MAX(percentage_laid_off) AS max_percentage
FROM layoffs_staging2;


-- ============================================
-- 3. Companies that laid off 100% of employees
-- ============================================
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;


-- ============================================
-- 4. Companies with the highest total layoffs
-- ============================================
SELECT 
    company, 
    SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY company
ORDER BY total_laid_off DESC;


-- ============================================
-- 5. Time range of the dataset
-- ============================================
SELECT 
    MIN(`date`) AS earliest_date, 
    MAX(`date`) AS latest_date
FROM layoffs_staging2;


-- ============================================
-- 6. Total layoffs by country
-- ============================================
SELECT 
    country, 
    SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY country
ORDER BY total_laid_off DESC;


-- ============================================
-- 7. Total layoffs per year
-- ============================================
SELECT 
    YEAR(`date`) AS year, 
    SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY year DESC;


-- ============================================
-- 8. Layoffs by company stage
-- ============================================
SELECT 
    stage, 
    SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY stage
ORDER BY total_laid_off DESC;


-- ============================================
-- 9. Average percentage laid off per company
-- ============================================
SELECT 
    company, 
    AVG(percentage_laid_off) AS avg_percentage
FROM layoffs_staging2
GROUP BY company
ORDER BY avg_percentage DESC;


-- ============================================
-- 10. Monthly total layoffs (YYYY-MM)
-- ============================================
SELECT 
    DATE_FORMAT(`date`, '%Y-%m') AS month,
    SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
WHERE `date` IS NOT NULL
GROUP BY month
ORDER BY month ASC;


-- ============================================
-- 11. Rolling total of monthly layoffs
-- ============================================
WITH MonthlyTotals AS (
    SELECT 
        DATE_FORMAT(`date`, '%Y-%m') AS month,
        SUM(total_laid_off) AS total_off
    FROM layoffs_staging2
    WHERE `date` IS NOT NULL
    GROUP BY month
)
SELECT 
    month,
    total_off,
    SUM(total_off) OVER (ORDER BY month) AS rolling_total
FROM MonthlyTotals;


-- ============================================
-- 12. Layoffs by company and year
-- ============================================
SELECT 
    company, 
    YEAR(`date`) AS year, 
    SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY total_laid_off DESC;


-- ============================================
-- 13. Company ranking by layoffs per year
-- ============================================
WITH CompanyYear AS (
    SELECT 
        company, 
        YEAR(`date`) AS year, 
        SUM(total_laid_off) AS total_laid_off
    FROM layoffs_staging2
    WHERE `date` IS NOT NULL
    GROUP BY company, YEAR(`date`)
),
CompanyYearRanked AS (
    SELECT 
        *,
        DENSE_RANK() OVER (PARTITION BY year ORDER BY total_laid_off DESC) AS Ranking
    FROM CompanyYear
)
SELECT *
FROM CompanyYearRanked
Where Ranking <= 5;
