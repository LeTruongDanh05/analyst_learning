WITH salary_benchmarks AS (
    -- Salary benchmarking & equity labeling
    SELECT 
        department,
        job_level,
        attrition,
        monthly_income,
        AVG(monthly_income) OVER(PARTITION BY job_level) AS avg_income_for_level,
        CASE 
            WHEN monthly_income < AVG(monthly_income) OVER(PARTITION BY job_level) THEN 'Below Average'
            ELSE 'Above Average'
        END AS salary_status
    FROM ibm_hr_attrition
),
department_summary AS (
    -- Multi-dimensional aggregation (Department & Salary status)
    SELECT 
        department,
        salary_status,
        COUNT(*) AS total_employees,
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count
    FROM salary_benchmarks
    GROUP BY department, salary_status
)
-- Attrition rate calculation & final insights breakdown
SELECT 
    department,
    salary_status,
    total_employees,
    attrition_count,
    ROUND(attrition_count * 100.0 / total_employees, 2) AS attrition_rate_percent
FROM department_summary
ORDER BY department, salary_status DESC;