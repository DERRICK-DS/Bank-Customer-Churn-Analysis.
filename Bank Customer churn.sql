SELECT *
FROM [Bank customer churn]

--1.Churn Rate Analysis
--Churn Percentage: Calculate the percentage of customers who have exited the bank (churned). 
   
SELECT 
     Exited,
     COUNT(Exited) as Customercount
FROM [Bank customer churn]
GROUP BY Exited

SELECT 
    SUM(
	CASE 
	 WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0 / 
	 COUNT(*) AS ChurnPercentage
FROM 
    [Bank customer churn]


--Churn by Geography: Analyze churn rates across different geographic regions (in this case countries)
SELECT 
    Geography,
    SUM(
	CASE 
	 WHEN Exited = 1 THEN 1 ELSE 0 END) as churned
FROM [Bank customer churn]
GROUP BY Geography

SELECT 
     Geography,
     COUNT(Exited) as Customercount
FROM [Bank customer churn]
GROUP BY Geography


SELECT 
    Geography,
    CAST(
        SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)
        AS DECIMAL(5,1)
    ) AS ChurnPercentage
FROM [Bank customer churn]
GROUP BY Geography


--Churn by Age Group: Determine the age groups that are most likely to churn

--ALTER TABLE [Bank customer churn]
--ADD Age_group VARCHAR(10)

--UPDATE [Bank customer churn]
--SET Age_group = 
    --CASE
        --WHEN Age BETWEEN 18 AND 30 THEN 'Youth'
        --WHEN Age BETWEEN 31 AND 50 THEN 'Adult'
        --WHEN Age BETWEEN 51 AND 65 THEN 'Middle Age'
        --WHEN Age > 65 THEN 'Senior'
        --ELSE 'Unknown'
    --END


SELECT 
     Age_group,
     COUNT(Exited) as Customercount
FROM [Bank customer churn]
GROUP BY Age_group

SELECT 
    Age_group,
    SUM(
	CASE 
	 WHEN Exited = 1 THEN 1 ELSE 0 END) as churned
FROM [Bank customer churn]
GROUP BY Age_group


--Churn by Tenure: Evaluate if customers with shorter tenure (fewer years with the bank)tend to churn more often. Long-term customers may be more stable.

--ALTER TABLE [Bank customer churn]
--ADD Tenure_group VARCHAR(20)

--UPDATE [Bank customer churn]
--SET Tenure_group = 
--    CASE
--        WHEN Tenure BETWEEN 0 AND 3 THEN 'New'        -- Customers with 1-3 years of tenure
--        WHEN Tenure BETWEEN 4 AND 7 THEN 'Medium'     -- Customers with 4-7 years of tenure
--        WHEN Tenure BETWEEN 8 AND 10 THEN 'Long-Term' -- Customers with 8-10 years of tenure
--        ELSE 'Unknown'                                -- For any other cases (optional)
--    END


SELECT 
     Tenure_group,
     COUNT(Exited) as Customercount
FROM [Bank customer churn]
GROUP BY Tenure_group


SELECT 
    Tenure_group,
    SUM(
	CASE 
	 WHEN Exited = 1 THEN 1 ELSE 0 END) as churned
FROM [Bank customer churn]
GROUP BY Tenure_group

--2.Credit Score vs. Churn
--Churn by Credit Score: Analyze if there is a correlation between customer credit score and churn. Customers with lower credit scores may have higher churn rates due to financial difficulties or dissatisfaction with services.
   
--ALTER TABLE [Bank customer churn]
--ADD Creditscore_category VARCHAR(20)

--UPDATE [Bank customer churn]
--SET Creditscore_category = 
--    CASE
--        WHEN CreditScore BETWEEN 350 AND 579 THEN 'Poor'       
--        WHEN CreditScore BETWEEN 580 AND 669 THEN 'Fair'     
--        WHEN CreditScore BETWEEN 670 AND 739 THEN 'Good' 
--		WHEN CreditScore BETWEEN 740 AND 799 THEN 'Very Good'
--        ELSE 'Exceptional'                                
--    END


SELECT 
     Tenure_group,
     COUNT(Exited) as Customercount
FROM [Bank customer churn]
GROUP BY Tenure_group


SELECT 
    Creditscore_category,
    SUM(
	CASE 
	 WHEN Exited = 1 THEN 1 ELSE 0 END) as churned
FROM [Bank customer churn]
GROUP BY Creditscore_category
   
--Risk Segmentation: Segment customers into risk categories (high, medium, low) based on their credit scores to identify those at risk of leaving the bank.

ALTER TABLE [Bank customer churn]
ADD Risk_category VARCHAR(20);

UPDATE [Bank customer churn]
SET Risk_category = 
    CASE
        WHEN CreditScore BETWEEN 700 AND 850 THEN 'Low Risk'    -- Low-risk customers
        WHEN CreditScore BETWEEN 500 AND 699 THEN 'Medium Risk' -- Medium-risk customers
        WHEN CreditScore BETWEEN 350 AND 499 THEN 'High Risk'   -- High-risk customers
        ELSE 'Unknown'                                          -- For any outliers or missing data
    END;

SELECT 
     Risk_category,
     COUNT(CustomerId) as Customercount
FROM [Bank customer churn]
GROUP BY Risk_category
ORDER BY 1 DESC

SELECT 
    Risk_category,
    SUM(
	CASE 
	 WHEN Exited = 1 THEN 1 ELSE 0 END) as churned
FROM [Bank customer churn]
GROUP BY Risk_category

--3.Balance and Churn Behavior
--Churn by Account Balance: Investigate if customers with higher balances are less likely to churn compared to customers with lower balances. Higher balances could indicate more engaged customers who rely on the bank for financial services.
  
ALTER TABLE [Bank customer churn]
ADD Balance_category VARCHAR(20);

UPDATE [Bank customer churn]
SET Balance_category = 
    CASE
        WHEN Balance BETWEEN 0 AND 83632 THEN 'Low Balance'        -- Low-balance customers
        WHEN Balance BETWEEN 83633 AND 167265 THEN 'Medium Balance' -- Medium-balance customers
        WHEN Balance BETWEEN 167266 AND 250899 THEN 'High Balance'  -- High-balance customers
        ELSE 'Unknown'                                              -- For outliers or missing data
    END;
  
SELECT 
     Balance_category,
     COUNT(CustomerId) as Customercount
FROM [Bank customer churn]
GROUP BY Balance_category
ORDER BY 1 DESC
  
SELECT 
    Balance_category,
    SUM(
	CASE 
	 WHEN Exited = 1 THEN 1 ELSE 0 END) as churned
FROM [Bank customer churn]
GROUP BY Balance_category
  
  
 --4.Product Usage Insights
 --Churn by Number of Products: Customers with multiple products (e.g., savings accounts, credit cards, loans) are often more loyal. Analyzing churn by the number of products customers use can help identify cross-selling opportunities to reduce churn.
  
SELECT 
     NumOfProducts,
     COUNT(CustomerId) as Customercount
FROM [Bank customer churn]
GROUP BY NumOfProducts
ORDER BY 1 DESC
   

 --5.Credit Card and Churn
 --Credit Card Ownership and Churn: Assess if having a credit card is a factor in customer retention. Customers with credit cards may have deeper engagement with the bank, leading to lower churn rates.
SELECT 
     HasCrCard,
     COUNT(CustomerId) as Customercount
FROM [Bank customer churn]
GROUP BY HasCrCard
ORDER BY 1 DESC   
   
SELECT 
    HasCrCard,
    SUM(
	CASE 
	 WHEN Exited = 1 THEN 1 ELSE 0 END) as churned
FROM [Bank customer churn]
GROUP BY HasCrCard
ORDER BY 1 DESC

--6.Gender and Churn
 --Churn by Gender: Analyze churn rates for male and female customers to see if there are any significant differences in customer behavior or satisfaction between genders.
SELECT 
     Gender,
     COUNT(CustomerId) as Customercount
FROM [Bank customer churn]
GROUP BY Gender
ORDER BY 1 DESC  

SELECT 
    Gender,
    SUM(
	CASE 
	 WHEN Exited = 1 THEN 1 ELSE 0 END) as churned
FROM [Bank customer churn]
GROUP BY Gender
ORDER BY 1 DESC
    
 --7.Estimated Salary and Churn
 --Churn by Salary Levels: Analyze if higher-income customers churn less frequently than lower-income customers. High-income clients might be more valuable and require special attention to retain.

 SELECT 
    CustomerId, 
    EstimatedSalary,
    CASE
        WHEN EstimatedSalary <= 66667 THEN 'Low'
        WHEN EstimatedSalary <= 133333 THEN 'Medium'
        ELSE 'High'
    END AS SalaryCategory
FROM 
    [Bank customer churn];


ALTER TABLE [Bank customer churn]
ADD Salarycategory VARCHAR(20);

UPDATE [Bank customer churn]
SET Salarycategory = 
    CASE
        WHEN EstimatedSalary <= 66667 THEN 'Low'
        WHEN EstimatedSalary <= 133333 THEN 'Medium'
        ELSE 'High'
    END 

SELECT 
     Salarycategory,
     COUNT(CustomerId) as Customercount
FROM [Bank customer churn]
GROUP BY Salarycategory
ORDER BY 1 DESC

SELECT 
    Salarycategory,
    SUM(
	CASE 
	 WHEN Exited = 1 THEN 1 ELSE 0 END) as churned
FROM [Bank customer churn]
GROUP BY  Salarycategory

--8.Tenure and Loyalty
   --Churn by Tenure: Determine if customers with shorter tenure (fewer years with the bank) are more likely to churn. This can help in designing special loyalty programs for newer customers to improve retention.

SELECT 
     Tenure,
     COUNT(CustomerId) as Customercount
FROM [Bank customer churn]
GROUP BY Tenure
ORDER BY 1 DESC

SELECT 
     Tenure,
    SUM(
	CASE 
	 WHEN Exited = 1 THEN 1 ELSE 0 END) as churned
FROM [Bank customer churn]
GROUP BY Tenure
ORDER BY 1

--9.Customer Satisfaction & Experience
--Active Memberships and Engagement: Explore how active membership correlates with churn. Customers who actively use their accounts or memberships may be less likely to churn, providing an opportunity for banks to increase engagement.

SELECT 
     IsActiveMember,
     COUNT(CustomerId) as Customercount
FROM [Bank customer churn]
GROUP BY IsActiveMember
ORDER BY 1 DESC



SELECT 
    IsActiveMember,
    SUM(
	CASE 
	 WHEN Exited = 1 THEN 1 ELSE 0 END) as churned
FROM [Bank customer churn]
GROUP BY IsActiveMember
ORDER BY 1



--To Power BI....

SELECT *
FROM [Bank customer churn]


SELECT 
    Tenure,
    SUM(
	CASE 
	 WHEN Exited = 1 THEN 1 ELSE 0 END) as churned
FROM [Bank customer churn]
GROUP BY Tenure
ORDER BY 1

