DROP PROCEDURE GetOverdueBorrowersAndBooks;
GO

CREATE PROCEDURE GetOverdueBorrowersAndBooks
AS
BEGIN
    CREATE TABLE #OverdueBorrowers (
        borrower_id INT,
        first_name NVARCHAR(255),
        last_name NVARCHAR(255),
        email NVARCHAR(255)
    );

    INSERT INTO #OverdueBorrowers (borrower_id, first_name, last_name, email)
    SELECT DISTINCT 
        br.borrower_id,
        br.first_name,
        br.last_name,
        br.email
    FROM 
        borrower br
    JOIN 
        loan l ON br.borrower_id = l.borrower_id
    WHERE 
        l.due_date < GETDATE() AND l.date_returned IS NULL;

    SELECT 
        ob.borrower_id,
        ob.first_name,
        ob.last_name,
        ob.email,
        b.bookId,
        b.title,
        b.author,
        l.date_borrowed,
        l.due_date,
        DATEDIFF(DAY, l.due_date, GETDATE()) AS days_overdue
    FROM 
        #OverdueBorrowers ob
    JOIN 
        loan l ON ob.borrower_id = l.borrower_id
    JOIN 
        book b ON l.book_id = b.bookId
    ORDER BY 
        ob.borrower_id, l.due_date;

    DROP TABLE #OverdueBorrowers;
END
GO

EXEC GetOverdueBorrowersAndBooks;
