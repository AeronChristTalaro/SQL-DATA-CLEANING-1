#DATA CLEANING


#REMOVE DUPLICATES
#STANDARDIZED DATA(FINDING ISSUES ON YOUR DATA)
#NULL VALUES
#REMOVE UNECESSARY COLUMNS

CREATE TABLE layoffs_staging
like layoffs;


INSERT layoffs_staging
SELECT *
from layoffs;



SELECT *
FROM layoffs;

SELECT *
FROM layoffs_staging;



WITH duplicate_cte as (
SELECT *,ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`,stage, country, funds_raised_millions
) as row_num
FROM layoffs_staging
)

SELECT *
FROM duplicate_cte
WHERE row_num >1
;


SELECT *
FROM layoffs_staging
WHERE COMPANY = 'CAZOO'
;


INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`,stage, country, funds_raised_millions
) as row_num
FROM layoffs_staging
;

SELECT *
FROM layoffs_staging2;

 
DELETE 
FROM layoffs_staging2
WHERE row_num > 1;


SELECT distinct(trim(company))
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);



Select *
From layoffs_staging2;


UPDATE layoffs_staging2
SET country = 'United States'
WHERE country like 'United States%';

SELECT *
From layoffs_staging2
WHERE country like 'United States%';

SELECT DISTINCT country
From layoffs_staging2
order by country asc;

SELECT `date`,
str_to_date(`date`,'%m/%d/%Y')
From layoffs_staging2;

UPDATE layoffs_staging2
SET `date`= str_to_date(`date`,'%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date`DATE;

	
SELECT DISTINCT stage
From layoffs_staging2
ORDER BY 1;









Select *
From layoffs_staging2;
#NULL VALUES


Select *
From layoffs_staging2
WHERE total_laid_off is NULL AND percentage_laid_off is NULL;

Select *
From layoffs_staging2
WHERE industry is NULL OR industry = '';


Select *
From layoffs_staging2
WHERE company = 'Airbnb';


#TIP/NOTE
#THIS MEANS SOMETHING LIKE HEY 

SELECT t1.company,t1.industry, t2.industry, t2.company
From layoffs_staging2 t1
	JOIN layoffs_staging2 t2
	ON t1.company=t2.company
    and t1.location=t2.location
    WHERE (t1.industry is null or t1.industry = '')and t2.industry is not NULL;
	
UPDATE layoffs_staging2    
SET industry = NULL
WHERE industry = '';

    
    
    
#TIP/NOTES THIS MEANS:
#THIS CODE MEANS SOMETHINNG LIKE THIS
#Hey t1, you don't have an industry listed. 
#Let me check t2 to see if that same company has an industry value. 
#If t2 has one, I’ll fill in the missing information for you.
    
UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	on t1.company =t2.company
SET t1.industry =t2.industry
 WHERE (t1.industry is null or t1.industry = '')
 and t2.industry is not NULL;


SELECT company, total_laid_off
From layoffs_staging2
WHERE total_laid_off IS NULL;

SELECT distinct(count(company))
From layoffs_staging2;


SELECT company, COUNT(company) AS total_layoffs
FROM layoffs_staging2
WHERE total_laid_off is NULL
GROUP BY company
order by total_layoffs desc
;


SELECT *
From layoffs_staging2 t1
	JOIN layoffs_staging2 t2
	ON t1.company=t2.company
    and t1.location=t2.location;
#    WHERE (t1.total_laid_off is null or t1.total_laid_off = '')and t2.total_laid_off is not NULL;
#t1.company,t1.total_laid_off, t2.industry, t2.total_laid_off	
    
Select *
From layoffs_staging2
WHERE company = 'Ada';

