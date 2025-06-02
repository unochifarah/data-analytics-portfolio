-- Layoffs Dataset Cleaning Script
-- Description: Clean and prepare layoffs data for analysis
-- Skills: SQL (CTEs, Window Functions, Joins, Data Standardization, Null Handling, Date Parsing)

-- ============================================
-- STEP 1: LOAD RAW DATA
-- ============================================

SELECT * FROM layoffs;


-- ============================================
-- STEP 2: REMOVE DUPLICATES
-- ============================================

-- Create staging table to perform cleaning
CREATE TABLE layoffs_staging LIKE layoffs;

-- Copy raw data into staging table
INSERT INTO layoffs_staging
SELECT * FROM layoffs;

-- Identify duplicate rows using ROW_NUMBER
WITH duplicate_cte AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY company, location, industry, total_laid_off, 
                            percentage_laid_off, `date`, stage, country, funds_raised_millions
               ) AS row_num
    FROM layoffs_staging
)
-- Delete duplicate records (keep row_num = 1)
DELETE FROM duplicate_cte
WHERE row_num > 1;


-- ============================================
-- STEP 3: CREATE SECOND STAGING TABLE WITH ROW_NUM
-- ============================================

-- Optional: For further cleaning steps
CREATE TABLE layoffs_staging2 LIKE layoffs_staging;

-- Insert cleaned data with row_num included
INSERT INTO layoffs_staging2
SELECT *,
       ROW_NUMBER() OVER (
           PARTITION BY company, location, industry, total_laid_off, 
                        percentage_laid_off, `date`, stage, country, funds_raised_millions
       ) AS row_num
FROM layoffs_staging;

-- Remove duplicates (again, if needed)
DELETE FROM layoffs_staging2 
WHERE row_num > 1;


-- ============================================
-- STEP 4: STANDARDIZE STRING FIELDS
-- ============================================

-- Trim whitespace in company names
UPDATE layoffs_staging2 
SET company = TRIM(company);

-- Standardize industry values
UPDATE layoffs_staging2 
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- Trim trailing periods in country names
UPDATE layoffs_staging2 
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';


-- ============================================
-- STEP 5: CONVERT STRING DATES TO PROPER DATE FORMAT
-- ============================================

UPDATE layoffs_staging2 
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;


-- ============================================
-- STEP 6: HANDLE NULL AND BLANK VALUES
-- ============================================

-- Replace empty strings in industry with NULL
UPDATE layoffs_staging2 
SET industry = NULL
WHERE industry = '';

-- Fill NULL industry values using other rows with same company + location
UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2 
    ON t1.company = t2.company AND t1.location = t2.location
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
  AND t2.industry IS NOT NULL;

-- Delete rows with missing total and percentage laid off (unusable)
DELETE FROM layoffs_staging2 
WHERE total_laid_off IS NULL
  AND percentage_laid_off IS NULL;


-- ============================================
-- STEP 7: CLEANUP TEMPORARY COLUMNS
-- ============================================

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

-- Data cleaning complete. The dataset is now ready for analysis.