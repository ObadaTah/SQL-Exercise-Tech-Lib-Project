CREATE FUNCTION CalculateOverdueFees
(
  @LoanID INT
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @due_date DATETIME,
            @date_returned DATETIME,
            @overdue_days INT,
            @overdue_fee DECIMAL(10, 2);

    SELECT 
        @due_date = due_date,
        @date_returned = date_returned
    FROM 
        [loan]
    WHERE 
        loan_id = @LoanID;

    IF @date_returned IS NULL
    BEGIN
        SET @date_returned = GETDATE();
    END

    SET @overdue_days = DATEDIFF(DAY, @due_date, @date_returned);

    IF @overdue_days <= 0
    BEGIN
        SET @overdue_fee = 0;
    END
    ELSE
    BEGIN
        SET @overdue_fee = CASE 
            WHEN @overdue_days <= 30 THEN @overdue_days * 1
            ELSE 30 * 1 + (@overdue_days - 30) * 2
        END;
    END

    RETURN @overdue_fee;
END
GO
SELECT dbo.CalculateOverdueFees(779) AS OverdueFee;