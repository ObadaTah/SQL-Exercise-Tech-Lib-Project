WITH BorrowingFrequency AS (
    SELECT 
        l.borrower_id,
        COUNT(l.loan_id) AS borrow_count
    FROM 
        [loan] l
    GROUP BY 
        l.borrower_id
)

SELECT 
    br.borrower_id,
    br.first_name,
    br.last_name,
    bf.borrow_count,
    RANK() OVER (ORDER BY bf.borrow_count DESC) AS borrow_rank
FROM 
    BorrowingFrequency bf
JOIN 
    [borrower] br ON bf.borrower_id = br.borrower_id
ORDER BY 
    borrow_rank;