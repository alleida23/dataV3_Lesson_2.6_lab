#Lab | SQL Queries - Lesson 2.6

#Instructions
USE sakila;

# 1. In the table actor, which are the actors whose last names are not repeated?
# For example if you would sort the data in the table actor by last_name,
# you would see that there is Christian Arkoyd, Kirsten Arkoyd, and Debbie Arkoyd.
# These three actors have the same last name. So we do not want to include this last name
# in our output. Last name "Astaire" is present only one time with actor "Angelina Astaire",
# hence we would want this in our output list.

-- incloure només els actors que no tenen els cognoms repetits (únics)

SELECT DISTINCT last_name, first_name
FROM sakila.actor
GROUP BY last_name, first_name
HAVING COUNT(*) = 1;


# 2. Which last names appear more than once?
# We would use the same logic as in the previous question but this time we want to include
# the last names of the actors where the last name was present more than once

SELECT DISTINCT last_name
FROM sakila.actor
GROUP BY last_name
HAVING COUNT(*) > 1;


# 3. Using the rental table, find out how many rentals were processed by each employee.
SELECT staff_id, COUNT(rental_id) AS 'Rentals processed'
FROM rental
GROUP BY staff_id;

# 4. Using the film table, find out how many films were released each year.

SELECT release_year, count(*) AS 'Films released'
FROM film
GROUP BY release_year;


# 5. Using the film table, find out for each rating how many films were there.
SELECT DISTINCT rating from film; #PG, G, NC-17, PG-13, R

SELECT DISTINCT rating, count(film_id) AS 'Films rated'
FROM film
GROUP BY rating;

# 6. What is the mean length of the film for each rating type.
# Round off the average lengths to two decimal places

SELECT film.rating, SEC_TO_TIME(AVG(film.length*60)) AS 'Mean length'
FROM film
GROUP BY film.rating; #HH:mm:ss

#OR 

SELECT rating, ROUND(AVG(length), 2) AS avg_length
FROM film
GROUP BY rating; #mm

# 7. Which kind of movies (rating) have a mean duration of more than two hours?
SELECT DISTINCT film.rating, SEC_TO_TIME(AVG(film.length*60)) AS 'Mean length over 2 hours'
FROM film
GROUP BY film.rating
HAVING film.rating > 2; #not working 

SELECT rating, ROUND(AVG(length), 2) AS 'Average'
FROM film
GROUP BY rating
HAVING average >120;

# 8. Rank films by length (filter out the rows that have nulls or 0s in length column).
# In your output, only select the columns title, length, and the rank.

SELECT title, length, RANK() OVER(ORDER BY length DESC) 
FROM sakila.film;
