SELECT 
	br.borrower_id,
    b.title, 
    b.author, 
    l.date_borrowed, 
    l.due_date, 
	b.current_status,
    l.date_returned
FROM 
    [loan] l
JOIN 
    [book] b ON l.book_id = b.bookId
JOIN 
    [borrower] br ON l.borrower_id = br.borrower_id
WHERE
br.borrower_id = 113;