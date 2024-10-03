import random
from datetime import datetime, timedelta

# Function to generate random date
def random_date(start, end):
    return start + timedelta(days=random.randint(0, (end - start).days))

# Prepare some sample data
titles = ['The Great Gatsby', '1984', 'To Kill a Mockingbird', 'Pride and Prejudice', 'The Catcher in the Rye']
authors = ['F. Scott Fitzgerald', 'George Orwell', 'Harper Lee', 'Jane Austen', 'J.D. Salinger']
genres = ['Classic', 'Dystopian', 'Fiction', 'Romance', 'Drama']

# Date range for random generation
start_date = datetime(1900, 1, 1)
end_date = datetime(2023, 1, 1)

# Generate 1000 book entries
book_entries = []
for i in range(1, 1001):
    title = random.choice(titles)
    author = random.choice(authors)
    isbn = f'978{random.randint(1000000000, 9999999999)}'
    published_date = random_date(start_date, end_date).strftime('%Y-%m-%d')
    genre = random.choice(genres)
    shelf_location = f'{random.choice("ABCDE")}{random.randint(1, 10)}'
    status = random.choice(['Available', 'Borrowed'])
    book_entries.append(f"('{title}', '{author}', '{isbn}', '{published_date}', '{genre}', '{shelf_location}', '{status}')")

# Generate 1000 borrower entries
borrower_entries = []
for i in range(1, 1001):
    first_name = f'FirstName{i}'
    last_name = f'LastName{i}'
    email = f'user{i}@example.com'
    date_of_birth = random_date(datetime(1960, 1, 1), datetime(2000, 1, 1)).strftime('%Y-%m-%d')
    membership_date = random_date(datetime(2015, 1, 1), datetime(2023, 1, 1)).strftime('%Y-%m-%d')
    borrower_entries.append(f"('{first_name}', '{last_name}', '{email}', '{date_of_birth}', '{membership_date}')")

# Generate 1000 loan entries
loan_entries = []
for i in range(1, 1001):
    book_id = random.randint(1, 1000)
    borrower_id = random.randint(1, 1000)
    date_borrowed = random_date(datetime(2020, 1, 1), datetime(2024, 1, 1)).strftime('%Y-%m-%d')
    due_date = (datetime.strptime(date_borrowed, '%Y-%m-%d') + timedelta(days=30)).strftime('%Y-%m-%d')
    date_returned = None if random.random() < 0.5 else (datetime.strptime(date_borrowed, '%Y-%m-%d') + timedelta(days=random.randint(1, 30))).strftime('%Y-%m-%d')
    loan_entries.append(f"({book_id}, {borrower_id}, '{date_borrowed}', '{due_date}', '{date_returned}')")

# Writing SQL insert statements
with open("seed_data.sql", "w") as f:
    f.write("INSERT INTO [book] (title, author, ISBN, published_date, genre, shelf_location, current_status) VALUES\n")
    f.write(",\n".join(book_entries) + ";\n\n")
    
    f.write("INSERT INTO [borrower] (first_name, last_name, email, date_of_birth, membership_date) VALUES\n")
    f.write(",\n".join(borrower_entries) + ";\n\n")
    
    f.write("INSERT INTO [loan] (book_id, borrower_id, date_borrowed, due_date, date_returned) VALUES\n")
    f.write(",\n".join(loan_entries) + ";\n")
