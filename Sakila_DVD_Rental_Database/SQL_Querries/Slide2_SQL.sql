/*This query extracts the store ID, number of rental orders
fulfilled by each store as well as the year and months of occurrence*/

SELECT DISTINCT CONCAT(DATE_PART('year',payment_date),'-',DATE_PART('month',payment_date)) AS Rental_month,inventory.store_id AS Store_ID, COUNT(payment_id) OVER (PARTITION BY store_id, DATE_TRUNC('month',rental_date)) AS rental_count 
  FROM film
  JOIN film_category
    ON film.film_id = film_category.film_id
  JOIN category 
    ON category.category_id = film_category.category_id
  JOIN inventory 
    ON film.film_id = inventory.film_id
  JOIN rental
    ON rental.inventory_id = inventory.inventory_id
  JOIN payment
    ON rental.rental_id = payment.rental_id
 ORDER BY 3 DESC