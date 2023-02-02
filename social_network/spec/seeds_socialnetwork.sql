TRUNCATE TABLE users, posts RESTART IDENTITY; 

-- replace with your own table name.
-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO users (email_address, username) VALUES ('angela@gmail.com', 'angela2');
INSERT INTO users (email_address, username) VALUES ('john@gmail.com', 'john3');
INSERT INTO users (email_address, username) VALUES ('ollie@gmail.com', 'ollie4');

INSERT INTO posts (title, content, views, user_id) VALUES ('Hello', 'Coding is fun!', 200, 1);
INSERT INTO posts (title, content, views, user_id) VALUES ('Horses', 'Horses are majestic.', 1000, 2);
INSERT INTO posts (title, content, views, user_id) VALUES ('Fruits', 'Apples, oranges, bananas', 50, 3);

--- Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

-- psql -h 127.0.0.1 social_network_test < seeds_socialnetwork.sql
