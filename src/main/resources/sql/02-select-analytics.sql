-- TODO: Базовые SELECT запросы
-- 1. Получить всех пользователей, зарегистрированных за последний месяц
SELECT name, email, created_at
FROM users
WHERE created_at >= NOW() - INTERVAL '1 month'
ORDER BY created_at DESC;

-- TODO: 2. Найти самые дорогие товары в каждой категории

SELECT *
FROM products p
WHERE price = (SELECT MAX(price)
               FROM products
               WHERE category = p.category);

-- TODO: 3. Получить топ-5 клиентов по сумме покупок

SELECT user_id, sum(total)
FROM orders
GROUP BY user_id
ORDER BY sum(total) DESC LIMIT 5;

-- TODO: Продвинутые SELECT с JOIN
-- 4. Получить информацию о заказах с именами клиентов
SELECT o.id   as order_id,
       u.name as customer_name,
       o.total,
       o.status,
       o.created_at
FROM orders o
         JOIN users u ON o.user_id = u.id
ORDER BY o.created_at DESC;

-- TODO: 5. Получить детальную информацию о заказах с товарами
select o.order_id,
       o.product_id,
       p.name,
       o.quantity,
       o.price
from order_items o
         join products p on o.product_id = p.id;

-- TODO: Аналитические запросы с агрегацией
-- 6. Статистика продаж по категориям товаров

select p.category, SUM(o.quantity) AS total_purchases
from order_items o
         join products p on o.product_id = p.id
group by p.category;

-- TODO: 7. Средний чек клиентов

SELECT user_id,
       AVG(total) AS avg_check
FROM orders
GROUP BY user_id;

-- TODO: 8. Товары которые ни разу не заказывались

select p.name
from products p
         left join order_items o on o.product_id = p.id
where o.order_id is null;

-- TODO: Сложные запросы с подзапросами
-- 9. Клиенты, потратившие больше среднего

WITH total_by_user AS (SELECT user_id,
                              SUM(total) AS user_total
                       FROM orders
                       GROUP BY user_id),
     avg_total AS (SELECT AVG(user_total) AS avg_user_total
                   FROM total_by_user)
SELECT t.user_id,
       t.user_total
FROM total_by_user t,
     avg_total a
WHERE t.user_total > a.avg_user_total;

-- TODO: 10. Самый популярный товар в каждой категории

WITH count_by_product AS (SELECT p.id,
                                 p.category,
                                 COUNT(o.id) AS count_orders
                          FROM products p
                                   JOIN order_items o ON p.id = o.product_id
                          GROUP BY p.id, p.category)
SELECT *
FROM count_by_product c
WHERE c.count_orders = (SELECT MAX(cbp.count_orders)
                        FROM count_by_product cbp
                        WHERE cbp.category = c.category);