WITH AuthorBorrowCount AS (
    SELECT 
        b.author,
        COUNT(l.loan_id) AS borrow_count
    FROM 
        [book] b
    JOIN 
        [loan] l ON b.bookId = l.book_id 
    GROUP BY 
        b.author
)

SELECT 
    abc.author,
    abc.borrow_count,
    RANK() OVER (ORDER BY abc.borrow_count DESC) AS author_rank
FROM 
    AuthorBorrowCount abc
ORDER BY 
    author_rank;
