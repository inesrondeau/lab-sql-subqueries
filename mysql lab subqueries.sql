-- 1
SELECT COUNT(inventory_id)
FROM inventory
WHERE film_id = (SELECT film_id
					FROM film
                    WHERE  title = 'Hunchback Impossible' );
-- 2
SELECT title, length
FROM film
WHERE length > (SELECT AVG(length)
				FROM film);
-- 3
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (SELECT actor_id
				FROM film_actor
                WHERE film_id = (SELECT film_id
								FROM film
                                WHERE title = 'Alone Trip'));
-- 4
SELECT title
FROM film
WHERE film_id IN (SELECT film_id
				FROM film_category
                WHERE category_id IN (SELECT category_id
									FROM category
                                    WHERE name ='family'));
-- 5 (subqueries)
SELECT first_name, email
FROM customer
WHERE address_id IN (SELECT address_id
					FROM address
                    WHERE city_id IN (SELECT city_id
									FROM city
                                    WHERE country_id IN (SELECT country_id
														FROM country
                                                        WHERE country = 'CANADA')));
-- 5 (joins)
SELECT sakila.c.first_name, sakila.c.email
FROM sakila.customer c
JOIN sakila.address a
USING (address_id)
JOIN sakila.city ci
USING (city_id)
JOIN sakila.country co 
USING (country_id)
WHERE sakila.co.country = 'CANADA';
-- 6
SELECT title
FROM film
WHERE film_id in (
SELECT film_id 
FROM film_actor
WHERE actor_id = (
SELECT actor_id FROM(
SELECT actor_id, count(film_id) FROM film_actor
GROUP BY actor_id
ORDER BY count(film_id) DESC
LIMIT 1) sub1));
-- 7 
SELECT title
FROM film
WHERE film_id in(
SELECT film_id
FROM inventory
WHERE inventory_id in(
SELECT inventory_id
FROM rental
WHERE customer_id =(
SELECT customer_id
FROM customer c
JOIN payment p
USING (customer_id)
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 1)));
-- 8
SELECT first_name, last_name
FROM customer
WHERE customer_id in (
SELECT customer_id
FROM payment
WHERE amount > (
SELECT AVG(amount)
FROM payment));

														