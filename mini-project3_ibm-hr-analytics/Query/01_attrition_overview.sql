-- Objective: Measures and ranks the employee turnover rate (Attrition Rate) across different departments
SELECT Department,
        COUNT(*) AS total_employees,
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS total_attrition,
        ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS percentage_attrition
FROM ibm_hr_attrition
GROUP BY Department
ORDER BY percentage_attrition DESC