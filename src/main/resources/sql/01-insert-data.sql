INSERT INTO users (name, email)
VALUES ('Алексей Петров', 'alex.petrov@example.com'),
       ('Мария Сидорова', 'maria.sidorova@example.com'),
       ('Иван Гончаров', 'ivan.goncharov@example.com'),
       ('Пётр Иванов', 'petr.ivanov@example.com'),
       ('Кирилл Фролов', 'kirill.frolov@example.com'),
       ('Андрей Викторов', 'andrew.viktorov@example.com'),
       ('Артём Дзюба', 'artem.dzyuba@example.com'),
       ('Анастасия Загитова', 'nastya.zagitova@example.com'),
       ('Михаил Осипенко', 'mikhail.osipenko@example.com'),
       ('Сергей Увалов', 'sergey.uvalov@example.com');

INSERT INTO products (name, price, category, stock_quantity)
VALUES
    ('Ноутбук ASUS ROG', 89999.00, 'electronics', 5), ('Мышка Logitech MX Master', 7500.00, 'electronics', 20), ('Книга "Чистый код"', 2500.00, 'books', 100),
    -- еще 12 товаров
    ('Смартфон Samsung Galaxy S24', 79999.00, 'electronics', 10), ('Телевизор LG OLED 55"', 119999.00, 'electronics', 3), ('Наушники Sony WH-1000XM5', 29999.00, 'electronics', 15), ('Книга "Совершенный код"', 2200.00, 'books', 50), ('Книга "Грокаем алгоритмы"', 2800.00, 'books', 40), ('Электронная книга Kindle Paperwhite', 15999.00, 'electronics', 25), ('Стул офисный', 6999.00, 'furniture', 12), ('Стол компьютерный', 12999.00, 'furniture', 7), ('Кружка керамическая', 499.00, 'home', 60), ('Подушка ортопедическая', 3499.00, 'home', 30), ('Кроссовки Nike Air Zoom', 8999.00, 'clothes', 25), ('Футболка хлопковая', 1299.00, 'clothes', 80);

INSERT INTO orders (user_id, total, status)
VALUES (1, 97499.00, 'completed'),
       (2, 15000.00, 'processing'),
       -- еще 3 заказа
       (3, 29999.00, 'pending'),
       (1, 4598.00, 'cancelled'),
       (4, 152297.00, 'shipped');


INSERT INTO order_items (order_id, product_id, quantity, price)
VALUES
    -- Заказ 1
    (1, 1, 1, 89999.00),  -- Ноутбук в первом заказе
    (1, 2, 1, 7500.00),   -- Мышка в первом заказе
    (1, 3, 1, 2500.00),   -- Книга "Чистый код"

    -- Заказ 2
    (2, 9, 1, 15999.00),  -- Kindle
    (2, 12, 2, 499.00),   -- 2 кружки
    (2, 15, 1, 1299.00),  -- футболка

    -- Заказ 3
    (3, 6, 1, 29999.00),  -- Наушники Sony

    -- Заказ 4
    (4, 3, 1, 2500.00),   -- "Чистый код"
    (4, 7, 1, 2200.00),   -- "Совершенный код"
    (4, 12, 1, 499.00),   -- кружка

    -- Заказ 5
    (5, 5, 1, 119999.00), -- Телевизор
    (5, 2, 1, 7500.00),   -- мышка
    (5, 14, 2, 8999.00),  -- 2 пары кроссовок
    (5, 10, 1, 6999.00); -- стул
