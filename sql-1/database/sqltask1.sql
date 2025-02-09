-- CREATING DATABASE BY USING THE KEYWORD "SCHEMA"
create schema ecommerce;

-- USING THE CREATED DATABASE BY USING THE KEYWORD "USE"
use ecommerce;

-- CREATING CUSTOMERS TABLE 
create table customers(id int primary key unique auto_increment ,name varchar(255),email varchar(255),address varchar(255));

-- INSERTING VALUES INTO CUSTOMER TABLE 
insert into customers (name,email,address)values('ligesh','ligesh@gmail.com','south street,chidambaram'),
('logesh','logesh@gmail.com','north street,chidambaram'),
('siddhu','sid@gmail.com','west street,erode'),
('karthi','karthi@gmail.com','east tambaram,tambaram'),
('bharath','bharath@gmail,com','nlc,neyveli');

-- VIEWING CUSTOMERS TABLE
select*from customers;

-- CREATING ORDERS TABLE
create table orders(id int primary key unique auto_increment , customer_id int,order_date date,total_amount int,
foreign key(customer_id)references customers(id));

-- INSERTING VALUES INTO ORDERS TABLE
insert into orders (customer_id,order_date,total_amount)
values(1,'2024-02-15',1000),
(2,'2024-12-12',1500),
(3,'2024-12-17',2000),
(4,'2025-01-01',2500),
(5,'2025-01-07',3000);

-- VIEWING ORDERS TABLE 
select*from orders;

-- CREATING PRODUCTS TABLE
create table products(id int primary key unique auto_increment, name varchar(255),price float,description varchar(255)); 

-- INSERTING VALUES INTO PRODUCTS TABLE
insert into products(name,price,description)values
('product a',115000,'4 gb ram, 256 gb internal storage'),
('product b',60000,'6 gb ram, 128 gb internal storage'),
('product c',20000,'8gb ram, 128 gb internal storage'),
('product d',30000,'6 gb ram, 256 internal storage'),
('product e',120000,'12 gb ram, 1tb internal storage');

-- VIEWING PRODUCTS TABLE 
select*from products; 

-- 1.
select*from customers inner join orders on customers.id=orders.customer_id where orders.order_date >=current_date() - interval 30 day; 

-- 2.
select customers.name ,sum(orders.total_amount) from orders inner join customers on orders.customer_id = customers.id group by customers.id;

-- 3. 
update products set price=45.00 where name='product c'; 

-- 4
alter table products 
add column discount varchar(255);

-- 5.
select price from products order by price desc limit 3;

-- 6.
select customers.name from customers 
inner join orders on customers.id=orders.customer_id 
inner join products on orders.customer_id = products.id
 where products.name='product a' ;

-- 7.
select customers.name,orders.order_date from orders inner join customers on  customers.id = orders.customer_id;

-- 8. 
select*from orders where total_amount >= 150;

-- 9.
CREATE TABLE order_items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    price FLOAT,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

INSERT INTO order_items (order_id, product_id, quantity, price)
VALUES
    (1, 1, 1, 115000),  
    (2, 2, 1, 60000),  
    (3, 3, 1, 20000),   
    (4, 1, 1, 115000),  
    (5, 5, 1, 120000);

ALTER TABLE orders ADD COLUMN items_count INT DEFAULT 0;

UPDATE orders
SET items_count = (
    SELECT COUNT(*)
    FROM order_items
    WHERE order_items.order_id = orders.id
);

-- 10.
select avg(total_amount)from orders;
