-- Objective: To evaluate the impact of business travel frequency on employee satisfaction and retention
SELECT business_travel,
        COUNT(*) AS total_employees,
        ROUND(AVG(job_satisfaction), 2) AS avg_job_satisfaction,
        ROUND(AVG(environment_satisfaction), 2) AS avg_environment_satisfaction,
        ROUND(AVG(work_life_balance), 2) AS avg_work_life_balance
FROM ibm_hr_attrition
GROUP BY business_travel