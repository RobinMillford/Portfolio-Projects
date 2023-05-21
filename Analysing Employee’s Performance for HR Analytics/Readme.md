# Analysing Employee’s Performance for HR Analytics

## Data Pre-processing:
I started by cleaning the dataset named 'Uncleaned_employees_final_dataset' with the following steps:

Removed duplicate rows from the dataset using the drop_duplicates() function in Python.

Filtered and removed rows with irrelevant data type values in numeric columns using the isnumeric() function to check if a value is numeric.
## Exported Cleaned Dataset:

Once the dataset was cleaned, I exported it as a CSV file with UTF-8 encoding using the to_excel() function in Python. The cleaned dataset was saved as a separate file, ready for further analysis.
## SQL Queries:
I tried several SQL queries to solve various problem statements based on the dataset:

Average Age by Department and Gender: Calculated the average age of employees in each department and gender group using the AVG() function in SQL.

Top Departments by Average Training Scores: Listed the top 3 departments with the highest average training scores using the AVG() function and TOP clause in SQL.

Percentage of Employees with Awards by Region: Calculated the percentage of employees who have won awards in each region using the COUNT() function and percentage calculation in SQL.

Number of Employees with KPIs > 80% by Recruitment Channel and Education Level: Showed the number of employees who have met more than 80% of KPIs for each recruitment channel and education level using the COUNT() function and grouping in SQL.

Average Length of Service by Department with Previous Year Rating >= 4: Found the average length of service for employees in each department, considering only employees with previous year ratings greater than or equal to 4 using the AVG() function and condition in SQL.

Top Regions by Average Previous Year Ratings: Listed the top 5 regions with the highest average previous year ratings using the AVG() function and TOP clause in SQL.

Departments with More than 100 Employees and Length of Service > 5 years: Identified the departments with more than 100 employees having a length of service greater than 5 years using the COUNT() function and conditions in SQL.

Average Length of Service for Employees with More than 3 Trainings: Calculated the average length of service for employees who have attended more than 3 trainings, grouped by department and gender using the AVG() function and grouping in SQL.

Percentage of Female Employees with Awards by Department: Calculated the percentage of female employees who have won awards per department, along with the number of female employees who won awards and the total number of female employees using the COUNT() function and percentage calculation in SQL.

Percentage of Employees with Length of Service between 5 and 10 years: Calculated the percentage of employees per department who have a length of service between 5 and 10 years using the COUNT() function and percentage calculation in SQL.

Top Regions by Employees with KPIs > 80% and Awards: Listed the top 3 regions with the highest number of employees who have met more than 80% of their KPIs and received at least one award, grouped by department and region using the TOP clause, COUNT() function, and grouping in SQL.

Average Length of Service by Education Level and Gender with Training and Score Criteria: Calculated the average length of service for employees per education level and gender, considering only those employees who have completed more than 2 trainings and have an average training score greater than 75 using the AVG() function, conditions, and grouping in SQL.

These SQL queries were designed to solve specific problem statements and extract useful insights from the dataset. Each query focused on aggregating data, filtering based on conditions, grouping by specific criteria, and calculating summary statistics.
