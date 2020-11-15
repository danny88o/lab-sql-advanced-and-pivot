use sakila;

-- Select the first name, last name, and email address of all the customers who have rented a movie
select distinct concat(c.first_name, " ", c.last_name) as Name, c.Email from customer c
right join rental r on r.customer_id = c.customer_id;

-- What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).

select distinct c.Customer_id, concat(c.first_name, " ", c.last_name) as Name , avg(p.amount) as "Average amount payed"
from customer c
right join rental r on r.customer_id = c.customer_id
join payment p on p.rental_id = r.rental_id
group by c.customer_id
;

-- Select the name and email address of all the customers who have rented the "Action" movies.
-- 		Write the query using multiple join statements
-- 		Write the query using sub queries with multiple WHERE clause and IN condition
select concat(c.first_name, " ", c.last_name) as Name, c.Email from customer c
join rental r on r.customer_id = c.customer_id
join  inventory i on i.inventory_id = r.inventory_id
join film_category fcat on fcat.film_id = i.film_id
join category cat on cat.category_id = fcat.category_id
where cat.name = "Action"
group by Name, email;

select distinct concat(first_name, " ", last_name) as Name, Email 
from customer 
where customer_id in
	(select customer_id from rental where inventory_id in
		(select inventory_id from inventory where film_id in
			(select film_id from film_category 
            join category using (category_id) 
            where category.name="Action")))
;

-- Use the case statement to create a new column classifying existing columns as either low, medium or high value transactions based on the amount of payment
select distinct c.Customer_id, concat(c.first_name, " ", c.last_name) as Name , avg(p.amount)  as "Average amount payed",
case 
	when avg(p.amount) between 0 and 2 then "low"
    when avg(p.amount) between 2 and 4 then "medium"
    else "high"
end as Trans
from customer c
right join rental r on r.customer_id = c.customer_id
join payment p on p.rental_id = r.rental_id
group by c.customer_id
; 
