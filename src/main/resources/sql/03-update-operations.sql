-- TODO: Простые UPDATE операции
-- 1. Обновить статус заказа
UPDATE orders
SET status = 'shipped'
WHERE id = 1;

-- TODO: 2. Обновить информацию о пользователе с логированием
UPDATE users
SET
    name = 'Алексей Петрович Петров',
    updated_at = NOW()
WHERE email = 'alex.petrov@example.com'
    RETURNING id, name, updated_at;

-- TODO: 3. Массовое обновление цен (повышение на 10%)
update products
set
    price = price * 1.1
returning *;

-- TODO: Сложные UPDATE с подзапросами
-- 4. Обновить статус пользователей на 'premium' для тех, кто потратил > 50000
UPDATE users
SET status = 'premium'
WHERE id IN (
    SELECT user_id
    FROM orders
    GROUP BY user_id
    HAVING SUM(total) > 50000
);

-- TODO: 5. Обновить количество товара на складе после заказа
UPDATE products p
SET stock_quantity = p.stock_quantity - COALESCE(oi.total_qty, 0)
    FROM (
    SELECT product_id, SUM(quantity) AS total_qty
    FROM order_items
    GROUP BY product_id
) AS oi
WHERE oi.product_id = p.id;

-- TODO: Условные обновления
-- 6. Установить статус товаров в зависимости от количества на складе
UPDATE products
SET status = CASE
                 WHEN stock_quantity = 0 THEN 'out_of_stock'
                 WHEN stock_quantity < 5 THEN 'low_stock'
                 ELSE 'in_stock'
    END;