CREATE TABLE [book] (
  [bookId] integer PRIMARY KEY,
  [title] nvarchar(255),
  [author] nvarchar(255),
  [ISBN] nvarchar(255),
  [published_date] datetime,
  [genre] nvarchar(255),
  [shelf_location] nvarchar(255),
  [current_status] nvarchar(40) NULL CHECK([current_status] IN ('Available', 'Borrowed')),
)
GO

CREATE TABLE [borrower] (
  [borrower_id] integer PRIMARY KEY,
  [first_name] nvarchar(255),
  [last_name] nvarchar(255),
  [email] nvarchar(255),
  [date_of_birth] datetime,
  [membership_date] datetime
)
GO

CREATE TABLE [loan] (
  [loan_id] integer PRIMARY KEY,
  [book_id] integer,
  [borrower_id] integer,
  [date_borrowed] datetime,
  [due_date] datetime,
  [date_returned] datetime
)
GO

ALTER TABLE [loan] ADD FOREIGN KEY ([book_id]) REFERENCES [book] ([bookId])
GO

ALTER TABLE [loan] ADD FOREIGN KEY ([borrower_id]) REFERENCES [borrower] ([borrower_id])
GO
