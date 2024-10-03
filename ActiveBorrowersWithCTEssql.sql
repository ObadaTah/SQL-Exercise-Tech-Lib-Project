WITH BorrowedBooks AS (
    SELECT 
        l.borrower_id, 
        COUNT(l.loan_id) AS books_borrowed
    FROM 
        [loan] l
    WHERE 
        l.date_returned IS NULL
    GROUP BY 
        l.borrower_id
)

SELECT 
    br.borrower_id, 
    br.first_name, 
    br.last_name, 
    bb.books_borrowed
FROM 
    BorrowedBooks bb
JOIN 
    [borrower] br ON bb.borrower_id = br.borrower_id
WHERE 
    bb.books_borrowed >= 2;
