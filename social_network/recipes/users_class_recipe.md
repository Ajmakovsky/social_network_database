{{Users}} Model and Repository Classes Design Recipe
Copy this recipe template to design and implement Model and Repository classes for a database table.

1. Design and create the Table
If the table is already created in the database, you can skip this step.

Otherwise, follow this recipe to design and create the SQL schema for your table.

In this template, we'll use an example table students

# EXAMPLE

Table: users

Columns:
id | email_address | username 


2. Create Test SQL seeds
Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

-- (file: spec/seeds_socialnetwork.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,

-- so we can start with a fresh state.

-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE users,posts RESTART IDENTITY; 

-- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO users (email_address, username) VALUES ('angela@gmail.com', 'angela2');
INSERT INTO users (email_address, username) VALUES ('john@gmail.com', 'john3');
INSERT INTO users (email_address, username) VALUES ('ollie@gmail.com', 'ollie4');

INSERT INTO posts (title, content, views, user_id) VALUES ('Hello', 'Coding is fun!', 200, 1);
INSERT INTO posts (title, content, views, user_id) VALUES ('Horses', 'Horses are majestic.', 1000, 2);
INSERT INTO posts (title, content, views, user_id) VALUES ('Fruits', 'Apples, oranges, bananas', 50, 3);

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

psql -h 127.0.0.1 your_database_name < seeds_socialnetwork.sql

3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

# Table name: users

# Model class
# (in lib/user.rb)

```ruby 
class User
end

# Repository class
# (in lib/user_repository.rb)
class UserRepository
end
```


4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

# EXAMPLE
# Table name: users

# Model class
# (in lib/user.rb)

```ruby 
class User

  # Replace the attributes by your own columns.
  attr_accessor :id, :email_address, :username
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# user = User.new
# user.email_address = 'angela@gmail.com'
# user.username = 'angela2'
```

You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.

5. Define the Repository Class interface
Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.
```ruby


# EXAMPLE
# Table name: user

# Repository class
# (in lib/user_repository.rb)
class UserRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, email_address, username FROM users;

    # Returns an array of User objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, email_address, username FROM users WHERE id = $1;

    # Returns a single User object.
  end

  # creates a new user record 
  # one argument: the user object
  def create(user)
    # executes the SQL query: 
    # INSERT INTO users (email_address, username) VALUES($1, $2);

    #returns nothing 
  end

  # deletes a user record 
  # takes one argument, the record ID 
  def delete(id)
    # executes the SQL query: 
    # DELETE FROM users WHERE id = $1;

    #returns nothing (only deletes the user record)
  end
end
```


6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.
```ruby
# EXAMPLES

# 1
# Get all students

repo = UserRepository.new

users = repo.all

users.length # =>  3

users[0].id # =>  1
users[0].email_address # =>  'angela@gmail.com'
users[0].username # =>  'angela2'

users[1].id # =>  2
users[1].email_address # =>  'john@gmail.com'
users[1].username # =>  'john3'

# 2
# Get a single user

repo = UserRepository.new

user = repo.find(1)

user.id # =>  1
user.email_address # =>  'angela@gmail.com'
user.username # =>  'angela2'

# 3
# creates a new user 

repo = UserRepository.new

user = User.new
user.email_address = 'frances@gmail.com'
user.username = 'frances5'

repo.create(user) => nil 

users = users.all 

last_user = users.last
last_user.email_address #=>  'frances@gmail.com'
last_user.username #=> 'frances5'


# 4
# deletes a user record 

repo = UserRepository.new

repo.delete(1)

all_users = repo.all 
all_users.length # => 2
all_users.first.id # => '2'



```
# Add more examples for each method
Encode this example as a test.


7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.


# file: spec/user_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end
8. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.

