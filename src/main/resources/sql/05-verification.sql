-- Проверка количества записей
SELECT
    'users' as table_name,
    COUNT(*) as record_count
FROM users
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items;

-- TODO: Добавить проверки целостности данных
-- TODO: Проверить что все foreign key корректны
-- TODO: Проверить что нет записей с некорректными данными

-- 1. Проверка "orders.user_id" -> "users.id"
--    Заказы без существующего пользователя
SELECT o.id AS order_id, o.user_id
FROM orders o
         LEFT JOIN users u ON o.user_id = u.id
WHERE u.id IS NULL;

-- 2. Проверка "order_items.order_id" -> "orders.id"
--    Позиции заказа без существующего заказа
SELECT oi.id AS order_item_id, oi.order_id
FROM order_items oi
         LEFT JOIN orders o ON oi.order_id = o.id
WHERE o.id IS NULL;

-- 3. Проверка "order_items.product_id" -> "products.id"
--    Позиции заказа без существующего товара
SELECT oi.id AS order_item_id, oi.product_id
FROM order_items oi
         LEFT JOIN products p ON oi.product_id = p.id
WHERE p.id IS NULL;

-- 4. Проверка на отрицательные или нулевые количества в order_items
SELECT *
FROM order_items
WHERE quantity IS NULL OR quantity <= 0;

-- 5. Проверка на отрицательные или нулевые цены товаров
SELECT *
FROM products
WHERE price IS NULL OR price <= 0;

-- 6. Проверка, что сумма заказа совпадает с суммой его позиций (если есть поле orders.total)
SELECT
    o.id AS order_id,
    o.total AS order_total,
    SUM(oi.quantity * oi.price) AS items_total
FROM orders o
         JOIN order_items oi ON oi.order_id = o.id
GROUP BY o.id, o.total
HAVING o.total <> SUM(oi.quantity * oi.price);

-- 7. Проверка, что нет заказов без позиций
SELECT o.id AS order_id
FROM orders o
         LEFT JOIN order_items oi ON oi.order_id = o.id
WHERE oi.id IS NULL;
