use newschema;
show tables;
# QUESTION-8 

USE newschema;

SELECT * FROM `policy data`;
SELECT  distinct`Renewal Status`
FROM `policy data`;



use newschema;
SELECT DISTINCT `Renewal Status`
FROM `policy data`;
select * from `policy data`;

USE newschema;

SELECT `Renewal Status`, COUNT(*) AS Policy_Count
FROM `policy data`
GROUP BY `Renewal Status`;


# QUESTION-9

USE newschema;

SELECT `Policy Status`, COUNT(*) AS Policy_Count
FROM `policy data`
GROUP BY `Renewal Status`
ORDER BY Policy_Count DESC
LIMIT 1;

use newschema;
select 'policy status' , count(*) AS
policy_count
from `policy data`
group by 'policy status'
order by policy_count DESC;

use newschema;
select 'policy status', count(*) AS
policy_count
from `policy data`
group by 'policy status'
order by policy_count DESC
LIMIT 1;

# QUESTION 10
use newschema;


SELECT 
    `Policy Status`,
    COUNT(*) AS Policy_Count
FROM `policy data`
WHERE `Policy Status` IN ('Active', 'Inactive')
GROUP BY `Policy Status`;

# QUESTION 11
USE newschema;

SELECT 
    `Age Group`,
    COUNT(*) AS Policy_Count
FROM `policy data`
GROUP BY `Age Group`
ORDER BY Policy_Count DESC
LIMIT 1; 
describe `policy data`;

# QUESTION 12
USE newschema;

SELECT 
    `Age Group`,
    COUNT(*) AS total_customers
FROM customer
GROUP BY Age
ORDER BY Total_customers DESC
LIMIT 3;
use newschema;
describe`policy data`;

# QUESTION 13
USE newschema;

SELECT 
    Gender,
    COUNT(*) AS Policy_Count
FROM `policy data`
GROUP BY Gender
ORDER BY Policy_Count DESC
LIMIT 1;

# QUESTION 14
USE newschema;

SELECT
    ABS(
        SUM(Gender = 'Male') - SUM(Gender = 'Female')
    ) AS Difference
FROM `policy data`;
SELECT
    Gender,
    COUNT(*) AS Policy_Count
FROM `policy data`
WHERE Gender IN ('Male', 'Female')
GROUP BY Gender;

