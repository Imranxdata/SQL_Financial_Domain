-- ------------------------------------------FINANCIAL DOMAIN PROJECT-----------------------------------------------
							 --  A.Key Performance Indicators | (KPIs) Requirements: --
-- -------------------------------------------------------------------------------------------------------------------

-- KPI’s:- TOTAL APPLICATIONS

-- 1.Total Loan Applications
SELECT COUNT(id) AS Total_Applications
FROM bank;

-- MTD Loan Applications (EXPLAINATION - MTD Loan Applications represent the total number of loan applications received 
-- so far in the current month. For instance, if a bank receives 200 loan applications 
-- by the 10th day of the month, the MTD Loan Applications would be 200.

-- 2.MTD LOAN APPLICATION
SELECT COUNT(id) 
AS MTD_Total_Applications
FROM bank
WHERE MONTH(issue_date) 
= 12 AND year(issue_date) = 2021;


-- PMTD-(Previous Month-to-Date Loan Applications If today is the 15th of the current month,
-- the PMTD Loan Applications would include all loan applications received from the 1st 
-- of the previous month until the 15th of the current month.

-- 3.PMTD Loan Applications
SELECT COUNT(id) 
AS PMTD_Total_Applications 
FROM bank
WHERE MONTH(issue_date) 
= 11 AND YEAR(issue_date) = 2021;


-- -------------------------------------------------------------------------------------------------------------------
-- FUNDED AMOUNT
-- 4.Total Funded Amount
SELECT SUM(loan_amount)
AS Total_Funded_Amount
FROM bank;

-- 5.MTD Total Funded Amount
SELECT SUM(loan_amount)
AS MTD_Total_Funded_Amount FROM bank
WHERE MONTH(issue_date) 
= 12 AND YEAR(issue_date) = 2021;

-- 6.PMTD Total Funded Amount
SELECT SUM(loan_amount) 
AS PMTD_Total_Funded_Amount 
FROM bank WHERE MONTH(issue_date) 
= 11 and YEAR(issue_date) = 2021;

-- -----------------------------------------------------------------------------------------------------------------------

--  AMOUNT RECIEVED
-- 7.Total Amount Received
SELECT SUM(total_payment) 
AS Total_Amount_Collected 
FROM bank;

-- 8.MTD Total Amount Received
SELECT SUM(total_payment) 
AS MTD_Total_Amount_Collected 
FROM bank WHERE MONTH(issue_date) 
= 12 AND YEAR(issue_date) = 2021;

-- 9.PMTD Total Amount Received
SELECT SUM(total_payment) 
AS PMTD_Total_Amount_Collected 
FROM bank WHERE MONTH(issue_date) 
= 11 AND YEAR(issue_date) = 2021;



-- ---------------------------------------------------------------------------------------------------------------------------

-- INTEREST RATE

-- 10.Average Interest Rate
SELECT 
AVG(int_rate)*100 
AS Avg_Int_Rate 
FROM bank;

-- 11.MTD Average Interest
SELECT AVG(int_rate)*100 
AS MTD_Avg_Int_Rate FROM bank
WHERE MONTH(issue_date) = 12;

-- 12.PMTD Average Interest
SELECT AVG(int_rate)*100 
AS PMTD_Avg_Int_Rate FROM bank
WHERE MONTH(issue_date) = 11;

-- ------------------------------------------------------------------------------------------------------------------------------
-- AVERAGE DTI

-- Debt-to-Income ratio (DTI) is a measure that shows how much of your monthly income goes
-- towards paying debts like loans and credit cards. It's calculated by dividing your
-- total monthly debt payments by your gross monthly income and multiplying by 100. 
-- A lower DTI is generally better because it means you have more income available for other expenses. 


-- 13.Avg DTI
SELECT 
AVG(dti)*100 
AS Avg_DTI 
FROM bank;

-- 14.MTD Avg DTI
SELECT 
ROUND(AVG(dti)*100, 2) 
AS MTD_Avg_DTI 
FROM bank
WHERE MONTH(issue_date) 
= 12 And YEAR(issue_date) 
= 2021;

-- 15.PMTD Avg DTI
SELECT 
ROUND(AVG(dti)*100, 2) 
AS PMTD_Avg_DTI 
FROM bank
WHERE MONTH(issue_date) 
= 11 AND YEAR(issue_date) = 2021;

-- ------------------------------------------------------------------------------------------------------------------------------
                                       --  Good Loan v Bad Loan KPI’s --
-- In Loan Status column, we have three loan status FULLY PAID , CURRENT and CHARGED-OFF.
-- "GOOD LOAN" if the status is 'FULLY PAID' or 'CURRENT' and as "BAD LOAN" if the status is 'CHARGED-OFF'

-- -------------------------------------------------------------------------------------------------------------------------------

-- GOOD LOAN

-- 16.Good Loan Percentage
SELECT 
(COUNT(CASE WHEN loan_status = 'Fully Paid' 
OR loan_status = 'Current' THEN id END) * 100.0) / 
	COUNT(id) AS Good_Loan_Percentage
FROM bank;

-- 17.Good Loan Applications
SELECT COUNT(id) 
AS Good_Loan_Applications 
FROM bank WHERE loan_status 
= 'Fully Paid' 
OR loan_status = 'Current';

-- 18.Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Funded_amount FROM bank
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-- 19.Good Loan Amount Received
SELECT SUM(total_payment) AS Good_Loan_amount_received FROM bank
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-- -------------------------------------------------------------------------------------------------------------------------------
-- BAD LOAN

-- 20.Bad Loan Percentage
SELECT
(COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
	COUNT(id) AS Bad_Loan_Percentage
FROM bank;

-- 21.Bad Loan Applications
SELECT COUNT(id) AS Bad_Loan_Applications FROM bank
WHERE loan_status = 'Charged Off';

-- 22.Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_amount FROM bank
WHERE loan_status = 'Charged Off';

-- 23.Bad Loan Amount Received
SELECT SUM(total_payment) AS Bad_Loan_amount_received FROM bank
WHERE loan_status = 'Charged Off';

-- -------------------------------------------------------------------------------------------------------------------------------
                                                    --  LOAN STATUS  --
 -- 24.Loan Performance Metrics by Status
 SELECT
        loan_status,
        COUNT(id) AS LoanCount,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
    FROM
        bank
    GROUP BY
        loan_status;
        
        
-- 25.Monthly Total Amount Received and Funded Amount by Loan Status       
        SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status;



-- -----------------------------------------------------------------------------------------------------------------------------
-- -------------------------------------B.BANK LOAN REPORT | OVERVIEW------------------------------------------------------------

-- 26.MONTHLY TRENDS BY ISSUE DATE
SELECT 
    MONTH(issue_date) AS Month_Number, 
    MONTHNAME(issue_date) AS Month_Name, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank
GROUP BY MONTH(issue_date), MONTHNAME(issue_date)
ORDER BY MONTH(issue_date);


-- 27.REGIONAL ANALYSIS BY STATE
SELECT 
	address_state AS State, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank
GROUP BY address_state
ORDER BY address_state;

-- 28.LOAN TERM ANALYSIS
SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank
GROUP BY term
ORDER BY term;

-- 29.Employee Length Analysis 
SELECT 
	emp_length AS Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank
GROUP BY emp_length
ORDER BY emp_length;

-- 30.Loan Purpose Breakdown 
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank
GROUP BY purpose
ORDER BY purpose;

-- 31.Home Ownership Analysis
SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank
GROUP BY home_ownership
ORDER BY home_ownership;

SELECT * from bank




