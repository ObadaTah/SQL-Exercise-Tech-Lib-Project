database.sql: has the database schema and relations set.
ListOfBorrowedBooks.sql: Simple joining and retrieving with WHERE
ActiveBorrowersWithCTEssql.sql: using WITH made a CTE to have all unreturned loans with count and grouping by the borrower then select with WHERE to have more than 2 books
BorrowingFrequencyUsingWindowFunctions.sql: using WITH made a CTE to have the frequency of each borrower then SELECT with RANK() over the borrow count
PopularGenreAnalysisUsingJoinsAndWindowFunctions.sql: using WITH made a CTE to have the count of each genre borrowed then select top 1 with ranking over borrow count
StoredProcedureAddNewBorrowers.sql: made a procedure to add new customers while checking if email exists
DatabaseFunctionCalculateOverdueFees.sql: made a function to calculate the over due fees using if statements
DatabaseFunctionBookBorrowingFrequency.sql: made a function that takes book id to calculate the frequency of the book
OverdueAnalysis.sql: simple selecting with WHERE
AuthorPopularityUsingAggregation.sql: using a CTE i calculated the count of books borrowed for each author, then SELECTING with RANK over the count
GenrePreferenceByAgeUsingGroupByAndHaving.sql: first divide borrowers into groups and set into BorrowerAgeGroups, then count each group borrow count while using HAVING to get the maximum StoredProcedureBorrowedBooksReport.sql: made a procedure takes start date and end date to get a borrowed books report in that range
TriggerImplementation.sql: Create a trigger on books after update then insert into auditlog the changes.
SQLStoredProcedureWithTempTable.sql: create procedure then a temp table #OverdueBorrowers then populate it with the unreturned loans and due then gets the loan, book info from that table by joining then drop the table.
