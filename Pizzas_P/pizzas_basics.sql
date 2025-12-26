-- Retrieve the total number of orders placed. 
select count(order_id) as total_orders from orders;

-- Calculate the total revenue generated from pizza sales. 
SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_sales
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
    
    
-- Identify the highest-priced pizza.    
SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;

-- Identify the most comman pizza size ordered. 
select quantity, count(order_details_id) 
from order_details group by quantity;
 select pizzas.size, count(order_details.order_details_id) as order_count
 from pizzas join order_details
 on pizzas.pizza_id = order_details.pizza_id
 group by pizzas.size order by order_count desc;

-- List the top 5 most ordered pizza types along with their quantites. 
select pizza_types.name, sum(order_details.quantity) as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name order by quantity	desc limit 5;

    
    