CREATE TRIGGER trg_BookStatusChange
ON [book]
AFTER UPDATE
AS
BEGIN
    INSERT INTO AuditLog (BookID, StatusChange, ChangeDate)
    SELECT 
        i.bookId, 
        CASE 
            WHEN i.current_status = 'Borrowed' AND d.current_status = 'Available' THEN 'Available to Borrowed'
            WHEN i.current_status = 'Available' AND d.current_status = 'Borrowed' THEN 'Borrowed to Available'
        END AS StatusChange,
        GETDATE() AS ChangeDate
    FROM 
        inserted i
    INNER JOIN 
        deleted d ON i.bookId = d.bookId
    WHERE 
        (i.current_status = 'Borrowed' AND d.current_status = 'Available') 
        OR (i.current_status = 'Available' AND d.current_status = 'Borrowed');
END
GO

-- testing
UPDATE [book]
SET current_status = 'Borrowed'
WHERE bookId = 1;

UPDATE [book]
SET current_status = 'Available'
WHERE bookId = 1;

SELECT * FROM AuditLog;
