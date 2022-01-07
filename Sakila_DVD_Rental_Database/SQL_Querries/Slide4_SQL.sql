/* this query extracts the top 25 horror movies in terms of Rental Duration as well as their respective quartile categories*/

SELECT DISTINCT film.title title, category.name category_name, NTILE(4) OVER (ORDER BY rental_duration) AS standard_quartile, rental_duration
  FROM film
  JOIN film_category
    ON film.film_id = film_category.film_id
  JOIN category 
    ON category.category_id = film_category.category_id
 WHERE category.name IN ('Horror')
 ORDER BY rental_duration DESC
 LIMIT 25