CREATE FUNCTION fn_BookBorrowingFrequency
(
    @BookID INT
)
RETURNS INT
AS
BEGIN
    DECLARE @BorrowingCount INT;

    SELECT 
        @BorrowingCount = COUNT(*)
    FROM 
        [loan]
    WHERE 
        book_id = @BookID;

    RETURN @BorrowingCount;
END
GO


SELECT dbo.fn_BookBorrowingFrequency(10) AS BorrowingCount;
