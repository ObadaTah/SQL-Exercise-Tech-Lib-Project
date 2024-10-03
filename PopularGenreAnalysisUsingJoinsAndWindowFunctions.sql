WITH GenreBorrowCount AS (
    SELECT 
        b.genre,
        COUNT(l.loan_id) AS borrow_count
    FROM 
        [loan] l
    JOIN 
        [book] b ON l.book_id = b.bookId
    WHERE 
        DATEPART(MONTH, l.date_borrowed) = 9  -- month
        AND DATEPART(YEAR, l.date_borrowed) = 2023 -- year
    GROUP BY 
        b.genre
)

SELECT 
	TOP (1)
    gb.genre,
    gb.borrow_count,
    RANK() OVER (ORDER BY gb.borrow_count DESC) AS genre_rank
FROM 
    GenreBorrowCount gb
;
