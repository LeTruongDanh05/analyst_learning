-- Objective: Profiles the workforce size and average age for each department
SELECT Department,
        COUNT(*) AS total_employees,
        ROUND(AVG(Age), 1) AS average_age
FROM ibm_hr_attrition
GROUP BY Department
