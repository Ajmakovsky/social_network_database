{{Posts}} Model and Repository Classes Design Recipe
Copy this recipe template to design and implement Model and Repository classes for a database table.

1. Design and create the Table

--- √√√√

Table: posts

Columns:
id | title | content | views | user_id 

2. Create Test SQL seeds
Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

-- (file: spec/seeds_socialnetwork.sql)

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

# EXAMPLE
# Table name: posts

# Model class
# (in lib/post.rb)

```ruby 

class Post
end

# Repository class
# (in lib/post_repository.rb)
class PostRepository
end
```


4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

# EXAMPLE
# Table name: posts

# Model class
# (in lib/post.rb)

```ruby 

class Post

  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :content, :views, :user_id
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# post = Post.new
# post.title = 'Hello'
# post.content = 'Coding is fun!'
# post.views = '200'
# post.user_id = '1'
```
You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.

5. Define the Repository Class interface
Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: post

# Repository class
# (in lib/post_repository.rb)
class PostRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, content, views, user_id FROM posts;

    # Returns an array of Post objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, title, content, views, user_id FROM posts WHERE id = $1;

    # Returns a single Post object.
  end

  # creates a new user record 
  # one argument: the post object
  def create(post)
    # executes the SQL query: 
    # INSERT INTO posts (title, content, views, user_id) VALUES($1, $2, $3, $4);

    #returns nothing 
  end

  # deletes a user record 
  # takes one argument, the record ID 
  def delete(id)
    # executes the SQL query: 
    # DELETE FROM posts WHERE id = $1;

    #returns nothing (only deletes the user record)
  end
end
```


6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.
```ruby

# 1
# Get all posts

repo = PostRepository.new

posts = repo.all

posts.length # =>  3

posts[0].id # =>  1
posts[0].title # =>  'Hello'
posts[0].content # =>  'Coding is fun!'
posts[0].views # => '200'
posts[0].user_id # => '1'

posts[0].title # =>  'Horses'
posts[0].content # =>  'Horses are majestic.'
posts[0].views # => '1000'
posts[0].user_id # => '2'

# 2
# Get a single post

repo = PostRepository.new

post = repo.find(1)

post.id # =>  1
post.title # =>  'Hello'
post.content # =>  'Coding is fun!'
post.views # => '200'
post.user_id # => '1'

# 3
# creates a new post 

repo = PostRepository.new

user = User.new
post.title = 'Dogs'
post.content = 'Bichon, poodle, retreiver'
post.views = '500'
post.user_id = '1'

repo.create(post) => nil 

post = posts.all 

last_post = posts.last
last_post.title # = 'Dogs'
last_post.content # = 'Bichon, poodle, retreiver'
last_post.views # = '500'
last_post.user_id # = '1'


# 4
# deletes a post record 

repo = PostRepository.new

repo.delete(1)

all_posts = repo.all 
all_posts.length # => 2
all_posts.first.id # => '2'

```
# Add more examples for each method
Encode this example as a test.

7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/student_repository_spec.rb

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

