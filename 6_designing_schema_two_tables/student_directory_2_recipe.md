Two Tables Design Recipe Template
Copy this recipe template to design and create two related database tables from a specification.

1. Extract nouns from the user stories or specification


#  USER STORY:
# (analyse only the relevant part).

As a coach
So I can get to know all students
I want to see a list of students' names.

As a coach
So I can get to know all students
I want to see a list of cohorts' names.

As a coach
So I can get to know all students
I want to see a list of cohorts' starting dates.

As a coach
So I can get to know all students
I want to see a list of students' cohorts.

Nouns:

students, student names, cohort names, cohort starting dates, student cohort


2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.


Record  |	 Properties
---------------------
student |	 student name, student cohort,
cohort  |  cohort name, cohort starting date


Name of the first table (always plural): students

Column names: student_name, student_cohort

Name of the second table (always plural): cohorts

Column names: cohort_name, starting_date

3. Decide the column types.

Here's a full documentation of PostgreSQL data types.

Most of the time, you'll need either text, int, bigint, numeric, or boolean. If you're in doubt, do some research or ask your peers.

Remember to always have the primary key id as a first column. Its type will always be SERIAL.

# EXAMPLE:

Table: student
id: SERIAL
student_name: text
student_cohort: integer

Table: cohorts
id: SERIAL
cohort_name: text
starting_date: date

4. Decide on The Tables Relationship
Most of the time, you'll be using a one-to-many relationship, and will need a foreign key on one of the two tables.

To decide on which one, answer these two questions:

Can one cohort have many students? (Yes)
Can one student have many cohorts? (No)
You'll then be able to say that:

[Cohorts] has many [students]
And on the other side, [students] belongs to [cohorts]
In that case, the foreign key is in the table [B]


-> Therefore,
-> A cohort HAS MANY students
-> A student BELONGS TO a cohort

-> Therefore, the foreign key is on the students table.

Foreign key (students) - 'cohort_id'

Cohorts
  1) November 2022
  2) December 2022 
  3) January 2023

Students
                cohort_id
  1) Angela     1
  2) Dave       1
  3) Sarah      2


If you can answer YES to the two questions, you'll probably have to implement a Many-to-Many relationship, which is more complex and needs a third table (called a join table).


5. Write the SQL.

-- file: student_directory_2.sql

-- Replace the table name, columm names and types.

-- Create the table without the foreign key first.
CREATE TABLE cohorts (
  id SERIAL PRIMARY KEY,
  cohort_name text,
  starting_date timestamp
);

-- Then the table with the foreign key first.
CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  student_name text,
  cohort_id int,
  constraint fk_cohort foreign key(cohort_id)
    references cohorts(id)
    on delete cascade
);

-- The foreign key name is always {other_table_singular}_id


6. Create the tables.
psql -h 127.0.0.1 database_name < albums_table.sql