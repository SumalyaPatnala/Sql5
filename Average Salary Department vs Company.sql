# Write your MySQL query statement below
SELECT department_salary.pay_month, department_id,
    CASE
        WHEN department_avg > company_avg THEN 'higher'
        WHEN department_avg < company_avg THEN 'lower'
        ELSE 'same'
    END AS comparison 
FROM(
        SELECT department_id, AVG(amount) AS department_avg,
            DATE_FORMAT(pay_date,'%Y-%m') AS pay_month 
        FROM salary 
        JOIN employee 
        ON employee.employee_id = salary.employee_id 
        GROUP BY department_id, pay_month
        ) AS department_salary 
JOIN(
        SELECT AVG(amount) AS company_avg, 
            DATE_FORMAT(pay_date, '%Y-%m') AS pay_month 
        FROM salary 
        GROUP BY DATE_FORMAT(pay_date, '%Y-%m')) AS company_salary
ON department_salary.pay_month = company_salary.pay_month;
