CREATE PROCEDURE sp_AddNewBorrower
    @FirstName NVARCHAR(255),
    @LastName NVARCHAR(255),
    @Email NVARCHAR(255),
    @DateOfBirth DATETIME,
    @MembershipDate DATETIME
AS
BEGIN
    IF EXISTS (SELECT 1 FROM [borrower] WHERE email = @Email)
    BEGIN
        SELECT 'Error: A borrower with this email already exists.' AS ErrorMessage;
    END
    ELSE
    BEGIN
        INSERT INTO [borrower] (first_name, last_name, email, date_of_birth, membership_date)
        VALUES (@FirstName, @LastName, @Email, @DateOfBirth, @MembershipDate);

        SELECT SCOPE_IDENTITY() AS NewBorrowerID;
    END
END
GO


EXEC sp_AddNewBorrower 
    @FirstName = 'John',
    @LastName = 'Doe',
    @Email = 'johndoe@example.com',
    @DateOfBirth = '1990-05-15',
    @MembershipDate = '2024-01-01';