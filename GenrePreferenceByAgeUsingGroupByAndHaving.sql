WITH BorrowerAgeGroups AS (
    SELECT 
        br.borrower_id,
        br.first_name,
        br.last_name,
        DATEDIFF(YEAR, br.date_of_birth, GETDATE()) AS age,
		CASE 
        -- WHEN DATEDIFF(YEAR, br.date_of_birth, GETDATE()) BETWEEN 0 AND 10 THEN '0-10'
        -- WHEN DATEDIFF(YEAR, br.date_of_birth, GETDATE()) BETWEEN 11 AND 20 THEN '11-20'
        WHEN DATEDIFF(YEAR, br.date_of_birth, GETDATE()) BETWEEN 21 AND 30 THEN '21-30'
        WHEN DATEDIFF(YEAR, br.date_of_birth, GETDATE()) BETWEEN 31 AND 40 THEN '31-40'
        WHEN DATEDIFF(YEAR, br.date_of_birth, GETDATE()) BETWEEN 41 AND 50 THEN '41-50'
        WHEN DATEDIFF(YEAR, br.date_of_birth, GETDATE()) BETWEEN 51 AND 60 THEN '51-60'
        ELSE '61+' 
    END AS age_group,
        b.genre
    FROM 
        [borrower] br
    JOIN 
        [loan] l ON br.borrower_id = l.borrower_id
    JOIN 
        [book] b ON b.book_id = b.bookId
)

SELECT 
    bg.age_group,
    bg.genre,
    COUNT(*) AS borrow_count
FROM 
    BorrowerAgeGroups bg
GROUP BY 
    bg.age_group, bg.genre
HAVING 
    COUNT(*) = (
        SELECT MAX(borrow_count) 
        FROM (
            SELECT 
                COUNT(*) AS borrow_count
            FROM 
                BorrowerAgeGroups
            WHERE 
                CASE 
                    -- WHEN age BETWEEN 0 AND 10 THEN '0-10'
                    -- WHEN age BETWEEN 11 AND 20 THEN '11-20'
                    WHEN age BETWEEN 21 AND 30 THEN '21-30'
                    WHEN age BETWEEN 31 AND 40 THEN '31-40'
                    WHEN age BETWEEN 41 AND 50 THEN '41-50'
                    WHEN age BETWEEN 51 AND 60 THEN '51-60'
                    ELSE '61+' 
                END = bg.age_group
            GROUP BY 
                genre
        ) AS max_count
    )
ORDER BY 
    age_group;
