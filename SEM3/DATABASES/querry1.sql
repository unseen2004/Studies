
-- Start MariaDB and connect to the database
sudo systemctl start mariadb;
sudo mariadb -u root -p;

USE sakila;

-- 1) Show all tables
SHOW TABLES;

-- 2) Select films with length greater than 120 minutes
SELECT title
FROM film
WHERE length > 120;

-- 3) Select PG-13 films ordered by length (ascending), limit to 4
SELECT title
FROM film
WHERE rating = 'PG-13'
ORDER BY length ASC
LIMIT 4;

-- 4) Select film titles and their language for films with "Drama" in the description
SELECT f.title, l.name AS language
FROM film f
JOIN language l ON f.language_id = l.language_id
WHERE f.description LIKE '%Drama%';

-- 5) Select film titles categorized as 'Family' and having 'Documentary' in their description
SELECT f.title
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Family'
AND f.description LIKE '%Documentary%';

-- 6) Select titles of 'Children' films not rated 'PG-13'
SELECT f.title
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Children'
AND f.rating <> 'PG-13';

-- 7) Count films grouped by their rating
SELECT rating, COUNT(*) AS film_count
FROM film
WHERE rating IN ('G', 'PG-13', 'PG', 'NC-17', 'R')
GROUP BY rating;

-- 8) Select distinct titles rented between May 31, 2005, and June 30, 2005, in descending order
SELECT DISTINCT f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.rental_date BETWEEN '2005-05-31' AND '2005-06-30'
ORDER BY f.title DESC;

-- 9) Select actors featured in films with 'Deleted Scenes' special features
SELECT DISTINCT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.special_features LIKE '%Deleted Scenes%';

-- 10) Select customers whose rentals are handled by a different staff member than their payments
SELECT DISTINCT c.first_name, c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN payment p ON c.customer_id = p.customer_id
WHERE r.staff_id <> p.staff_id;

-- 11) Compare customer rental counts with Mary's rental count
SELECT COUNT(r.rental_id) INTO @maryCount
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
WHERE c.email = 'MARY.SMITH@sakilacustomer.org';

SELECT c.first_name, c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
HAVING COUNT(r.rental_id) > @maryCount;

-- 12) Find pairs of actors appearing in more than one film together
SELECT fa1.actor_id AS a1_id, fa2.actor_id AS a2_id, COUNT(*) AS shared_films
FROM film_actor fa1
JOIN film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
GROUP BY fa1.actor_id, fa2.actor_id
HAVING COUNT(*) > 1
ORDER BY shared_films DESC;

-- 13) Find actors who have not acted in films starting with 'C'
SELECT a.last_name
FROM actor a
WHERE a.actor_id NOT IN (
    SELECT fa.actor_id
    FROM film_actor fa
    JOIN film f ON fa.film_id = f.film_id
    WHERE f.title LIKE 'C%'
);

-- 14) Find actors in more Horror films than Action films
SELECT a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name IN ('Horror', 'Action')
GROUP BY a.actor_id
HAVING SUM(c.name = 'Horror') > SUM(c.name = 'Action');

-- 15) Compare average payment amounts with a given day's average
SELECT AVG(amount) INTO @avg
FROM payment
WHERE DATE(payment_date) = '2005-07-30';

SELECT c.first_name, c.last_name
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
HAVING AVG(p.amount) < @avg;

-- 16) Update the language of a specific film
UPDATE film
SET language_id = 2
WHERE title = 'YOUNG LANGUAGE';

-- 17) Insert a new language and update related films
INSERT INTO language (name, last_update)
VALUES ('Spanish', NOW());

UPDATE film
SET language_id = (
  SELECT language_id
  FROM language
  WHERE name = 'Spanish'
)
WHERE film_id IN (
  SELECT fa.film_id
  FROM film_actor fa
  WHERE fa.actor_id = (
    SELECT actor_id
    FROM actor
    WHERE first_name = 'ED' AND last_name = 'CHASE'
  )
);

-- 18) Add a column for film counts in the language table and update it
ALTER TABLE language 
ADD COLUMN films_no INT DEFAULT 0;

UPDATE language l
SET l.films_no = (
    SELECT COUNT(*)
    FROM film f
    WHERE f.language_id = l.language_id
);

-- 19) Remove the 'release_year' column from the 'film' table
ALTER TABLE film
DROP COLUMN release_year;

