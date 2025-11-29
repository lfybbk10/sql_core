-- TODO: Безопасные DELETE операции
-- 1. Удалить заказы старше 2 лет
DELETE FROM orders
WHERE created_at < NOW() - INTERVAL '2 years'
    RETURNING id, created_at;

-- TODO: 2. Удалить неактивных пользователей
DELETE FROM users
WHERE id IN (
    SELECT id
    FROM users
    WHERE status = 'inactive'
);

-- TODO: 3. Удалить товары с нулевой ценой

delete from products
where id in(
    select id
    from products
    where price = 0
);

-- TODO: Каскадные удаления
-- 4. Удалить заказ вместе со всеми позициями
-- (должно работать автоматически если настроен CASCADE)

DELETE FROM users WHERE id = 5;

-- TODO: Мягкие удаления (рекомендуемый подход)
-- 5. Мягкое удаление пользователя
UPDATE users
SET
    status = 'deleted',
    updated_at = NOW()
WHERE id = 999;

-- TODO: 6. Создать представление для активных пользователей
CREATE VIEW active_users AS
SELECT * FROM users
WHERE status != 'deleted';