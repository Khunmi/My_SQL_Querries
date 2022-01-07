/*Table t1 contains a query of months rental payments were made, fullname of customers, 
total number of times payments were made in the month and total amount paid monthly*/
WITH t1 AS(SELECT DISTINCT CONCAT (DATE_PART('year',payment_date),'-',DATE_PART('month',payment_date)) AS pay_mon,CONCAT(customer.first_name,' ',customer.last_name) AS fullname,COUNT(payment_id) OVER (PARTITION BY customer.customer_id,DATE_TRUNC('month',payment_date)) AS pay_countpermon, SUM(amount) OVER (PARTITION BY customer.customer_id,DATE_TRUNC('month',payment_date)) AS pay_amount 
	          FROM rental
	          JOIN payment
	            ON payment.rental_id = rental.rental_id
	          JOIN customer
	            ON customer.customer_id = payment.customer_id),
/*Table t2 is a query of top 5 paying customers*/
     t2 AS (SELECT SUM(pay_amount), fullname
	           FROM t1
	          GROUP BY 2 
	          ORDER BY 1 DESC
	          LIMIT 5)
/*Final  query selects as data in t1 peculiar to the customers in t2*/
SELECT DISTINCT t1.pay_mon, t2.fullname, pay_countpermon, pay_amount
  FROM t1
  JOIN t2
    ON t2.fullname = t1.fullname
 ORDER BY 2,4