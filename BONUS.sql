WITH LoanDayStats AS (
    SELECT 
        DATENAME(WEEKDAY, date_borrowed) AS BorrowedDay,
        COUNT(*) AS LoanCount
    FROM 
        loan
    GROUP BY 
        DATENAME(WEEKDAY, date_borrowed)
),
TotalLoans AS (
    SELECT 
        SUM(LoanCount) AS TotalLoanCount
    FROM 
        LoanDayStats
)

SELECT 
    BorrowedDay,
    LoanCount,
    ROUND(CAST(LoanCount AS FLOAT) / (SELECT TotalLoanCount FROM TotalLoans) * 100, 2) AS LoanPercentage
FROM 
    LoanDayStats
ORDER BY 
    LoanPercentage DESC;
