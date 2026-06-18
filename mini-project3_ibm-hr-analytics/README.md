# IBM HR Employee Attrition & Performance Analytics

## Overview

This project focuses on analyzing employee attrition and workplace satisfaction using the **IBM HR Analytics Dataset**. By leveraging Advanced SQL queries (including Window Functions and Common Table Expressions - CTEs), the analysis uncovers critical workforce dynamics, tracks turnover rates across departments, evaluates the impact of business travel, and evaluates salary equity against employee retention.

The final data-driven insights aim to provide HR leaders with actionable recommendations to improve employee retention, optimize compensation strategies, and enhance overall workplace satisfaction.

---

* **Task 1: Departmental Attrition Rate Analysis** 
            Measures and ranks the employee turnover rate (Attrition Rate) across different departments to identify areas with high structural attrition. Sorted at the top of this list, certain business units require urgent workplace climate assessments to understand why staff are leaving faster than the company average.
	    *View full report: [01_attrition_overview.sql](./Query/01_attrition_overview.sql)*

* **Task 2: Workforce Profiling & Demographics** 
            Profiles the total workforce size and monitors the average age across each business unit. Establishing this demographic baseline helps HR identify the generational makeup of teams, ensuring target engagement strategies match the age breakdown of specific business lines. 
	    *View full report: [02_department_attrition_age.sql](./Query/02_department_attrition_age.sql)*

* **Task 3: Business Travel Impact on Employee Well-being** 
            Evaluates how the frequency of business travel affects core satisfaction metrics, including Job Satisfaction, Environment Satisfaction, and Work-Life Balance. Spotting distinct score drops among frequent travelers flags potential burnout risks and indicates a need for travel policy reforms. 
            *View full report: [03_business_travel_impact.sql](./Query/03_business_travel_impact.sql)*

* **Task 4: Advanced Salary Equity & Retention Analysis** 
            Utilizes Window Functions and multi-dimensional CTEs to benchmark individual monthly income against peer job-level averages, labeling status as 'Below Average' or 'Above Average'. Correlating this with turnover rates builds an airtight business case for execution of targeted salary adjustments. 
            *View full report: [04_salary_equity_analysis.sql](./Query/04_salary_equity_analysis.sql)*

