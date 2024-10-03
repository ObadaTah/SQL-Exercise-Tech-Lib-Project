CREATE PROCEDURE BorrowedBooksReport
(
    @StartDate DATETIME,
    @EndDate DATETIME
)
AS
BEGIN
    SELECT 
        b.bookId,
        b.title,
        br.first_name,
        br.last_name,
        l.date_borrowed,
        l.date_returned
    FROM 
        [loan] l
    JOIN 
        [book] b ON l.book_id = b.bookId
    JOIN 
        [borrower] br ON l.borrower_id = br.borrower_id
    WHERE 
        l.date_borrowed BETWEEN @StartDate AND @EndDate
    ORDER BY 
        l.date_borrowed ASC;
END
GO


EXEC BorrowedBooksReport '2023-01-01', '2024-12-31';
