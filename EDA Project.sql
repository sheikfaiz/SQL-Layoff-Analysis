-- Exploratory  Data Analysis --

SELECT  *
FROM layoffs_staging2;


SELECT  MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

SELECT  *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions desc;

SELECT  company, sum(total_laid_off)
FROM layoffs_staging2
group by company
order by 2 desc; 

SELECT MIN(`DATE`),MAX(`DATE`)
FROM layoffs_staging2;

SELECT  country, sum(total_laid_off)
FROM layoffs_staging2
group by country
order by 2 desc; 

SELECT  *
FROM layoffs_staging2;

SELECT year( `date`), sum(total_laid_off)
FROM layoffs_staging2
group by year(`date`)
order by 1 desc; 


SELECT stage, sum(total_laid_off)
FROM layoffs_staging2
group by stage
order by 2 desc; 

SELECT  company, avg(percentage_laid_off)
FROM layoffs_staging2
group by company
order by 2 desc; 

SELECT  substring(`DATE`,1,7) AS `MONTH` , SUM(total_laid_off)
FROM layoffs_staging2
WHERE substring(`DATE`,1,7) IS NOT NULL
group by `MONTH`
order by 1 asc
;

WITH Rolling_Total AS 
(
SELECT  substring(`DATE`,1,7) AS `MONTH` , SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE substring(`DATE`,1,7) IS NOT NULL
group by `MONTH`
order by 1 asc
)
SELECT `MONTH`, total_off,
  SUM(total_off) OVER(ORDER BY `MONTH`) AS rolling_total
FROM Rolling_Total;


SELECT  company, sum(total_laid_off)
FROM layoffs_staging2
group by company
order by 2 desc; 

SELECT  company,year(`date`), sum(total_laid_off)
FROM layoffs_staging2
group by company ,year(`date`)#
order by 3 desc;

WITH Company_Year (company, years, total_laid_off)AS 
(
SELECT company, year(`date`), sum(total_laid_off)
FROM layoffs_staging2
group by company , year(`date`)
), Company_Year_Rank AS 
(SELECT *,
 dense_rank() over (partition by years order by total_laid_off desc) AS Ranking 
FROM company_year
where years is not null
)
SELECT *
FROM  Company_Year_Rank
WHERE Ranking <= 5
;