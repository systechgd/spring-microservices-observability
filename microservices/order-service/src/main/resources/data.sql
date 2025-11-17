-- Sample data for order-service
INSERT INTO orders (user_id, product_name, quantity, total_amount, status, created_at, updated_at) VALUES
(1, 'Laptop', 1, 1299.99, 'DELIVERED', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Mouse', 2, 49.98, 'CONFIRMED', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'Keyboard', 1, 89.99, 'PROCESSING', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 'Monitor', 2, 599.98, 'SHIPPED', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, 'Headphones', 1, 199.99, 'PENDING', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
