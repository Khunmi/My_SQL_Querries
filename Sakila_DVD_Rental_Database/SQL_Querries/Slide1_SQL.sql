/* This query generates the top ten family-friendly-specific movies according to rental count from subquery t1 which contains all movie categories*/
SELECT DISTINCT *	
  FROM	(SELECT DISTINCT f.title title, ca.name category_name, COUNT(rental_date) OVER (PARTITION BY f.title ) AS rental_count
            FROM film f
	         JOIN film_category fc
	           ON f.film_id = fc.film_id
	         JOIN category ca
	           ON ca.category_id = fc.category_id
	         JOIN inventory i
	           ON f.film_id = i.film_id
	         JOIN rental r
	           ON r.inventory_id = i.inventory_id
           ORDER BY 2,1) t1
 WHERE category_name IN ('Animation','Children','Classics','Family','Music','Comedy')
 ORDER BY rental_count DESC
 LIMIT 10