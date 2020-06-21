# Pewlett-Hackard-Analysis

## A.Background
PH company is planning for growth and orderly transistion. The median age of the workforce is high 
anda large percentage are nearing retiring age.The company wants to identify the retirement eligible 
workers and maangers so that succession planning can be done for an orderly transition.The current 
data of employees are in multiple excel spreadsheets, csv format tables. The goal is to migrate these
tables using postgres so that SQL can be applied analyze the data and identify retirees meeting the 
eligibility criteria. In addition identify mentoring group to enable smoother tranisition of the workforce. 
The software must be able to group employees by department number and by title.

## B.Approach
1. Create a ERD based on the current data (6 tables) using QuickDBD.
   - Conceptual
   - Logical
   - Physical
2. Identified primary (pk) and foreign (fk) keys for each table
   - emp_no : pk and fk and many tables (4)
   - dept_no : pk and fk ina few tables (2) 

3. Used pgAdmin4 (postgres) to create Tables (6) and wrote SQL querries to understand and create additonal 
tables for analysis
  - Sorted using employees table. Criteria for retirees : birth date 1952 to 19955 and hire date 85 to 88.
  - Criteria for mentors : birth date 1965 and hire date 85 to 88.
  - Used emp_no to left join the employee table with dept_emp table to identify exiting employees (to_date= '9999-01-01')
  - Obtained titles by inner joinning with titles table.
  - ** DUPLICATES ** found as titles changed for some employees
  - Removed duplicates using PARTITION by emp_no ORDER BY from_date. This implementation seems not very clean.
  - To get numbers by department, joinned with dept_emp/departments using dept_no
  - Filtered using partiton to remove ** DUPLICATES ** as some have worked for more than one department
  - Used GROUP BY on dept_name to get numbers by department for both retirees and mentors.
## C. Results and Summary
![]EmployeeDB.png
1. 33118 employees meet retirment criteria.

2. Retirement Count by department
count	dept_name
1605	Finance
5860	Sales
2234	Quality Management
1617	Customer Service
8175	Development
1863	Human Resources
2413	Research
1775	Marketing
7576	Production

3. Retirement count by title
count	title
10424	Engineer
4879	Senior Engineer
4	Manager
1310	Assistant Engineer
3726	Staff
11167	Senior Staff
1608	Technique Leader


4. 691 employees meet mentoring criteria

5. Mentoring Count by department
count	dept_name
21	Finance
127	Sales
38	Quality Management
43	Customer Service
177	Development
42	Human Resources
52	Research
46	Marketing
145	Production

## Next Steps and Recommedation
1. Should look at % for each department and plan accordingly for both retirees and mentors.
   - ~50% of retirees are engineers. Important to breakdown and focus on various engineering group

2. For high percentage transition, may need additional programs to meet orderly, minimal impact transition.








