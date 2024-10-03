SELECT 
    b.bookId,
    b.title,
    b.author,
    b.ISBN,
    l.due_date,
    br.borrower_id,
    br.first_name,
    br.last_name,
    DATEDIFF(DAY, l.due_date, GETDATE()) AS overdue_days
FROM 
    [loan] l
JOIN 
    [book] b ON l.book_id = b.bookId
JOIN 
    [borrower] br ON l.borrower_id = br.borrower_id
WHERE 
    l.date_returned IS NULL
    AND DATEDIFF(DAY, l.due_date, GETDATE()) > 30
ORDER BY 
    overdue_days DESC;
