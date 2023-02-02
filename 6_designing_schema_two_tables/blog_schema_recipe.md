Two Tables Design Recipe Template

1. Extract nouns from the user stories or specification
#  USER STORY:
# (analyse only the relevant part - here the final line).

As a blogger
So I can write interesting stuff
I want to write posts having a title.

As a blogger
So I can write interesting stuff
I want to write posts having a content.

As a blogger
So I can let people comment on interesting stuff
I want to allow comments on my posts.

As a blogger
So I can let people comment on interesting stuff
I want the comments to have a content.

As a blogger
So I can let people comment on interesting stuff
I want the author to include their name in comments.

Nouns:

posts, title, post content, comments, comments content, comment author name


2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

Record  |	 Properties
---------------------
post    |	 post title, post contents
comment |  comment content, comment author name


Name of the first table (always plural): posts

Column names: post_title, post_content

Name of the second table (always plural): comments

Column names: comment_content, comment_author_name

3. Decide the column types.

Here's a full documentation of PostgreSQL data types.

Most of the time, you'll need either text, int, bigint, numeric, or boolean. If you're in doubt, do some research or ask your peers.

Remember to always have the primary key id as a first column. Its type will always be SERIAL.

# tables:

Table: posts
id: SERIAL
post_title: text
post_content: text

Table: comments
id: SERIAL
comment_content: text
comment_author_name: text


4. Decide on The Tables Relationship
Most of the time, you'll be using a one-to-many relationship, and will need a foreign key on one of the two tables.

To decide on which one, answer these two questions:

Can one [posts] have many [comments]? (Yes)
Can one [comments] have many [posts]? (No)
You'll then be able to say that:

[Posts] has many [comments]
And on the other side, [comments] belongs to [posts]
In that case, the foreign key is in the table [comments]

Replace the relevant bits in this example with your own:


-> Therefore,
-> A post HAS MANY comments
-> A comment BELONGS TO a post

-> Therefore, the foreign key is on the comments table.

If you can answer YES to the two questions, you'll probably have to implement a Many-to-Many relationship, which is more complex and needs a third table (called a join table).

4. Write the SQL.
-- file: posts.sql

-- Replace the table name, columm names and types.

-- Create the table without the foreign key first.
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  post_title text,
  post_contents text
);

-- Then the table with the foreign key first.
CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  comment_contents text,
  comment_author_name text,
  post_id int,
  constraint fk_post foreign key(post_id)
    references posts(id)
    on delete cascade
);
5. Create the tables.
psql -h 127.0.0.1 database_name < albums_table.sql

-- The foreign key name is always {other_table_singular}_id
