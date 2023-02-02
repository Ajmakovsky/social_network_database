Two Tables Design Recipe Template

Social Network 

1. Extract nouns from the user stories or specification

#  USER STORY:
# (analyse only the relevant part ).

As a social network user,
So I can have my information registered,
I'd like to have a user account with my email address.

As a social network user,
So I can have my information registered,
I'd like to have a user account with my username.

As a social network user,
So I can write on my timeline,
I'd like to create posts associated with my user account.

As a social network user,
So I can write on my timeline,
I'd like each of my posts to have a title and a content.

As a social network user,
So I can know who reads my posts,
I'd like each of my posts to have a number of views.

Nouns:

user account, email address, username, posts, title, content, views


2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

Record |	 Properties
---------------------
user   |	 email address, username
posts  |   title, content, views, user_id(foreign_key)


Name of the first table (always plural): `users`

Column names: `email_address`,`username`

Name of the second table (always plural): `posts`

Column names: `title`, `content`, `views`, `user_id`



3. Decide the column types.

Here's a full documentation of PostgreSQL data types.

Most of the time, you'll need either text, int, bigint, numeric, or boolean. If you're in doubt, do some research or ask your peers.

Remember to always have the primary key id as a first column. Its type will always be SERIAL.

# Table data types:

Table: users
id: SERIAL
email_address: text
username: text

Table: posts
id: SERIAL
title: text
content: text
views: int
user_id: int (foreign key)



4. Decide on The Tables Relationship
Most of the time, you'll be using a one-to-many relationship, and will need a foreign key on one of the two tables.

To decide on which one, answer these two questions:

Can one [user] have many [posts]? (Yes)
Can one [post] have many [users]? (No)
You'll then be able to say that:

[User] has many [posts]
And on the other side, [post] belongs to [user]
In that case, the foreign key is in the table [posts]

Replace the relevant bits in this example with your own:


-> Therefore,
-> A user HAS MANY posts
-> A post BELONGS TO a user

-> Therefore, the foreign key is on the posts table.

If you can answer YES to the two questions, you'll probably have to implement a Many-to-Many relationship, which is more complex and needs a third table (called a join table).

5. Write the SQL.
-- file: social_network.sql

-- Replace the table name, columm names and types.

-- Create the table without the foreign key first.
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email_address text,
  username text
);

-- Then the table with the foreign key first.
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text,
  content text,
  views int, 
  user_id int,
  constraint fk_user foreign key(user_id)
    references users(id)
    on delete cascade
);

Table: users
id: SERIAL
email_address: text
username: text

Table: posts
id: SERIAL
title: text
content: text
views: int
user_id: int (foreign key)

  -- The foreign key name is always {other_table_singular}_id


6. Create the tables.
psql -h 127.0.0.1 social_network < social_network.sql

