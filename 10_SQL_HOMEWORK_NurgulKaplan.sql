USE sakila;
-- 1a. Display the first and last names of all actors from the table actor.
SELECT first_name, last_name FROM actor;

-- 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name.

SELECT UPPER(CONCAT(first_name, ' ', last_name)) AS 'Actor Name' FROM actor;

-- 2a. You need to find the ID number, first name, and last name of an actor, 
-- of whom you know only the first name, "Joe." What is one query would you use to obtain this information?

SELECT actor_id,first_name,last_name 
from actor
where first_name = "JOE";


-- 2b. Find all actors whose last name contain the letters GEN:

SELECT first_name,last_name 
from actor
where last_name LIKE  "%GEN%";


-- 2c. Find all actors whose last names contain the letters LI. This time, order the rows by last name and first name, in that order:


SELECT first_name,last_name 
from actor
where last_name LIKE  "%LI%" ORDER BY last_name, first_name;


-- 2d. Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China:
SHOW TABLES;

DESCRIBE actor;

SELECT country_id, country
FROM country
WHERE country 
IN 
(
	"Afghanistan", "Bangladesh", "China"
)
;


-- 3a. Add a middle_name column to the table actor. Position it between first_name and last_name. Hint: you will need to specify the data type.

SELECT * FROM actor;

ALTER TABLE actor
ADD COLUMN middle_name TEXT ;

SELECT actor_id, first_name, middle_name,last_name FROM actor;

-- 3b. You realize that some of these actors have tremendously long last names. Change the data type of the middle_name column to blobs.

ALTER TABLE actor
MODIFY COLUMN  middle_name blob ;

-- 3c. Now delete the middle_name column.
ALTER TABLE actor
DROP COLUMN  middle_name  ;

-- 4a. List the last names of actors, as well as how many actors have that last name.

SELECT last_name, COUNT(*) 
FROM actor
GROUP BY last_name;

-- 4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
-- ask this to someone!!!

ALTER TABLE actor
DROP COLUMN  count_first_name ;
SELECT * FROM actor;

    
-- 4c. Oh, no! The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS, the name of Harpo's second cousin's husband's yoga teacher. Write a query to fix the record.

UPDATE actor 
SET first_name = "HARPO"
WHERE last_name = "WILLIAMS";

-- 4d. Write a single SQL Query to change all entries in the column that match "HARPO" to "GROUCHO" 
-- and those matching "GROUCHO" (before running  the query) to "MUCHO GROUCHO"



UPDATE actor
SET first_name =
CASE
    WHEN first_name= 'HARPO'
        THEN 'GROUCHO' 
    ELSE 'MUCHO GROUCHO'
END
WHERE actor_id=172;


-- 5a. You cannot locate the schema of the address table. Which query would you use to re-create it? 

SHOW CREATE TABLE address;

DESCRIBE address;

-- 6a. Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address:

SELECT * FROM address;
SELECT * FROM staff;
SELECT * FROM payment;


SELECT staff.first_name, staff.last_name, address.address 
FROM staff 
JOIN address 
ON staff.address_id=address.address_id;

-- 6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment.


SELECT s.first_name, s.last_name, SUM(p.amount)
FROM staff s
INNER JOIN payment p
ON s.staff_id=p.staff_id
WHERE p.payment_date LIKE '2005-08%'
GROUP BY s.staff_id;

-- 6c List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.
SELECT film.title, COUNT(actor_id) AS 'Number of ACTORS'
FROM film_actor
INNER JOIN film USING (film_id)
GROUP BY film.title;
-- 6D How many copies of the film Hunchback Impossible exist in the inventory system?

SELECT film.title, COUNT(inventory.inventory_id) AS 'Number of Copies'
FROM film
INNER JOIN inventory USING (film_id)
WHERE film.title="Hunchback Impossible"
GROUP BY film.title; 

-- 6E Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name:
SELECT customer_id, sum(amount), first_name, last_name
FROM customer
INNER JOIN payment USING (customer_id)
GROUP BY customer_id
ORDER BY last_name;


-- 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.

SELECT * FROM film;
SELECT * FROM language;

SELECT language_id FROM language 
WHERE name = 'English';

SELECT title FROM film
WHERE title like 'K%' 
OR  title like 'Q%'
AND language_id IN 
(	
	SELECT language_id FROM language 
	WHERE name = 'English'
);


-- 7b. Use subqueries to display all actors who appear in the film Alone Trip.


SELECT actor_id FROM film_actor
WHERE film_id = 
(
	SELECT film_id FROM film
	WHERE title = 'ALONE TRIP'


);



SELECT first_name, last_name FROM actor
WHERE actor_id IN 
(
	SELECT actor_id FROM film_actor
	WHERE film_id = 
	(
		SELECT film_id FROM film
		WHERE title = 'ALONE TRIP'


	)
);









