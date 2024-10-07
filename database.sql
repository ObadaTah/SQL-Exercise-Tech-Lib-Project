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

CREATE INDEX idx_loan_borrower_id ON [loan](borrower_id);
CREATE INDEX idx_loan_book_id ON [loan](book_id);
CREATE INDEX idx_loan_date_borrowed ON [loan](date_borrowed);
CREATE INDEX idx_loan_due_date_returned ON [loan](due_date, date_returned);
CREATE INDEX idx_loan_borrower_book ON [loan](borrower_id, book_id);

CREATE INDEX idx_borrower_email ON [borrower](email);

CREATE INDEX idx_book_author ON [book](author);
CREATE INDEX idx_book_current_status ON [book](current_status);

