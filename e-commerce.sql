CREATE TABLE `users`(
    `id` BIGINT UNSIGNED uuid NOT NULL PRIMARY KEY,
    `firstname` CHAR(255) NOT NULL,
    `lastname` CHAR(255) NOT NULL,
    `username` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `phone_number` VARCHAR(255) NOT NULL,
    `gender` ENUM('male', 'female', 'others') NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    `created_at` DATETIME NOT NULL,
    `updated_at` DATETIME NOT NULL
);

CREATE TABLE `categories`(
    `id` BIGINT UNSIGNED uuid NOT NULL PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `slug` VARCHAR(255) NOT NULL,
    `parent_id` BIGINT NULL,
    `created_at` DATETIME NOT NULL,
    `updated_at` DATETIME NOT NULL,
    FOREIGN KEY (parent_id) REFERENCES categories(id)
);

CREATE TABLE `admin`(
    `id` BIGINT UNSIGNED uuid NOT NULL PRIMARY KEY,
    `roles` VARCHAR(255) NOT NULL,
    `user_id` BIGINT NOT NULL
    FOREIGN KEY (user_id) REFERENCES user(id),
);

CREATE TABLE `orders`(
    `id` BIGINT UNSIGNED uuid NOT NULL PRIMARY KEY,
    `order_no` VARCHAR(255) NOT NULL,
    `status` ENUM(
        'processing',
        'shipped',
        'delivered',
        'canceled'
    ) NOT NULL DEFAULT 'processing',
    `billing_address_id` BIGINT NOT NULL,
    `shipping_address_id` BIGINT NOT NULL,
    FOREIGN KEY (billing_address_id) REFERENCES address(id),
);

CREATE TABLE `products`(
    `id` BIGINT UNSIGNED uuid NOT NULL PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `slug` VARCHAR(255) NOT NULL,
    `size` ENUM('S', 'M', 'L') NOT NULL,
    `category_id` BIGINT NOT NULL,
    `price` DECIMAL(8, 2) NOT NULL,
    `weight` FLOAT(53) NOT NULL,
    `is_wholesale` BOOLEAN NOT NULL,
    `amount_in_stock` BIGINT NOT NULL,
    `created_at` DATETIME NOT NULL,
    `updated_at` DATETIME NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

CREATE TABLE `product_order`(
    `id` BIGINT UNSIGNED uuid NOT NULL PRIMARY KEY,
    `order_id` BIGINT NOT NULL,
    `product_id` BIGINT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(id),
  	FOREIGN kEY (order_id) REFERENCES orders(id)
    
);
CREATE TABLE `address`(
    `id` BIGINT UNSIGNED uuid NOT NULL PRIMARY KEY,
    `address1` VARCHAR(255) NOT NULL,
    `address2` VARCHAR(255) NULL,
    `landmark` VARCHAR(255) NOT NULL,
    `city` VARCHAR(255) NOT NULL,
    `lga` VARCHAR(255) NOT NULL,
    `state` VARCHAR(255) NOT NULL,
    `country` VARCHAR(255) NOT NULL,
    `user_id` BIGINT NOT NULL,
    `created_at` DATETIME NOT NULL,
    `updated_at` DATETIME NOT NULL,
    `type` ENUM('shipping', 'billing') NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);



-- Inserting record into database

INSERT INTO `users` (
    `id`, `firstname`, `lastname`, `username`, `email`, `phone_number`, 
    `gender`, `password`, `created_at`, `updated_at`
) VALUES
(1, 'Akande', 'Lateef', 'curious', 'akandelateef0@gmail.com', '1234567890', 'male', 'password123', DATETIME(), DATETIME()),
(2, 'Omotayo', 'Fatima', 'chinaza', 'omofachi@example.com', '0987654321', 'female', 'password456', DATETIME(), DATETIME());

INSERT INTO `categories` (
    `id`, `name`, `slug`, `parent_id`, `created_at`, `updated_at`
) VALUES
(1, 'Electronics', 'electronics', 0, DATETIME(), DATETIME()),
(2, 'Phones', 'phones', 1, DATETIME(), DATETIME()),
(3, 'Laptops', 'laptops', 1, DATETIME(), DATETIME());

INSERT INTO `products` (
    `id`, `name`, `slug`, `size`, `category_id`, `price`, `weight`, `is_wholesale`, `amount_in_stock`, `created_at`, `updated_at`
) VALUES
(1, 'Samsung Galaxy S21', 'samsung-galaxy-s21', 'M', 2, 200000.00, 0.5, 0, 100, DATETIME(), DATETIME()),
(2, 'HP Pavilion 15', 'hp-pavilion-15', 'L', 3, 300000.00, 1.5, 1, 50, DATETIME(), DATETIME());

INSERT INTO `address` (
    `id`, `address1`, `address2`, `landmark`, `city`, `lga`, `state`, `country`, `user_id`, `created_at`, `updated_at`, `type`
) VALUES
(1, 'No 1, Lagos Road', 'Opposite Shoprite', 'Ojodu', 'Lagos', 'Ikeja', 'Lagos', 'Nigeria', 1, DATETIME(), DATETIME(), 'shipping'),
(2, 'No 2, Lagos Road', 'Opposite Shoprite', 'Ojodu', 'Lagos', 'Ikeja', 'Lagos', 'Nigeria', 1, DATETIME(), DATETIME(), 'billing');

INSERT INTO `orders` (
    `id`, `order_no`, `status`, `billing_address_id`, `shipping_address_id`
) VALUES
(1, 'ORD-123456', 'processing', 2, 1);

INSERT INTO `product_order` (
    `id`, `order_id`, `product_id`
) VALUES
(1, 1, 1),
(2, 1, 2);

INSERT INTO `admin` (
    `id`, `roles`, `user_id`
) VALUES
(1, 'admin', 1);

-- getting user with id 1
SELECT * FROM `users` WHERE `id` = 1;

-- getting all products
SELECT * FROM `products`;

-- getting orders that belong to user with id 1
SELECT * FROM `orders` WHERE `billing_address_id` = 2;

--updating record in the database
UPDATE `users` SET `firstname` = 'Olayinka' WHERE `id` = 1;

UPDATE `products` SET `price` = 250000.00 WHERE `id` = 1;

UPDATE `orders` SET `status` = 'shipped' WHERE `id` = 1;

-- deleting record from the database

DELETE FROM `users` WHERE `id` = 2;

DELETE FROM `products` WHERE `id` = 2;

DELETE FROM `orders` WHERE `id` = 1;

-- querying record from two or more tables using join

SELECT * FROM products JOIN categories ON categories.id = products.category_id;