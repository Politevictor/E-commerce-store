-- In order to make 'products' table dynamic, I created a 'Trigger' so the 'QuantityInStock' will reduce as orders are placed
DELIMITER //

CREATE TRIGGER update_QuantityInStock
AFTER INSERT ON orderdetails
FOR EACH ROW
BEGIN
    UPDATE products 
    SET QuantityInStock = QuantityInStock - NEW.Quantity 
    WHERE ProductID = NEW.ProductID;
END //

DELIMITER ;

SELECT * FROM users;
SELECT * FROM categories;
SELECT * FROM cart;
SELECT * FROM orderdetails;
SELECT * FROM orders;
SELECT * FROM products;



insert into  cart (UserID, ProductID, Quantity, AddedToCartDates)
values
(1, 12, 3, '2023-09-01 12:12:20');

--  On September 25th, 2023: jay west updates the quantity of ProductID 12 in his cart to 7 units.

UPDATE cart
	SET Quantity = 7
WHERE CartID = 1;

-- On December 10th, 2023: A product with ProductID 20 is deleted from the Products table due to being discontinued.

DELETE FROM products
WHERE ProductID = 20;

-- On December 20th, 2023: An order with OrderID 1 is placed by Sarah wet, buying three units of ProductID 8 (an existing product)

insert into orders   (UserID, OrderDate, Status)
values
(2, '2023-12-20 12:00:00', 'on tranit');

insert into orderdetails (OrderID, ProductID, Quantity, UnitPrice, TotalPrice)
values
(4, 8, 3, 12.00, 36.00);


/*  On May 5th, 2023:
Sarah Johnson registers on the e-commerce platform ('every_day_Shipping') with email 'sarahj@email.com' and adds a new address ('123 Green Avenue'). 
This action involves inserting records into the Users table.
*/

insert into users (Username, Email, Password, Address, Phone, RegistrationDate )
values
('Sarah Johnson', 'sarahj@email.com', 'Johnson247', '123 Green Avenue Delta', 08044332219, '2023-05-05 15:10:10');


/*On August 20th, 2023:
Joshua victor places an order (OrderID 5) for three units of ProductID 1. 
This involves entries in the Orders and OrderDetails.*/

insert into orders   (UserID, OrderDate, Status)
values
(10, '2023-08-20 14:40:00', 'pay on delivery');

insert into orderdetails (OrderID, ProductID, Quantity, UnitPrice, TotalPrice)
values
(5, 1, 3, 50.00, 150.00);
