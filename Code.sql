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

/* Adding a foreign key constraint to the orderdetails table, 
this will help automate my orderdetails if any update, delete is applied on the orders table
for a seamless transaction*/

ALTER TABLE orderdetails
ADD CONSTRAINT FK_orderdetails_orders
FOREIGN KEY (OrderID) REFERENCES orders(OrderID)
ON DELETE CASCADE
ON UPDATE CASCADE;


--  On September 25th, 2023: jay west updates the quantity of ProductID 12 in his cart to 7 units.

insert into  cart (UserID, ProductID, Quantity, AddedToCartDates)
values
(1, 12, 3, '2023-09-01 12:12:20');

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

/*
On January 15th, 2024:
A user named Joshua victor adds a review for ProductID 9 with a rating of 4 stars and comments 'Great quality!' in the Reviews table, 
after placing an order for 10 units for the product.
*/

insert into orders   (UserID, OrderDate, Status)
values
(10, '2024-01-15 15:15:15', 'payment before delivery');

insert into orderdetails (OrderID, ProductID, Quantity, UnitPrice, TotalPrice)
values
(6, 9, 10, 65.00, 650.00);


insert into reviews (ProductID, UserID, Rating, Review_text)
values
(9, 10, '****', 'Great quality!');

/*
 On February 20th, 2024:
Emily John increases the quantity of ProductID 3 ('African Djembe Drum') in her cart from 3 to 5 units in the Cart table, 
and placed the order the next day. It was decovered the 'TotalPrice' is incorrect and was updated by admin 
*/

insert into  cart (UserID, ProductID, Quantity, AddedToCartDates)
values
(4, 3, 3, '2024-02-01 16:05:20');

UPDATE cart
	SET Quantity = 5
WHERE CartID = 2;

insert into orders   (UserID, OrderDate, Status)
values
(4, '2024-02-02 16:05:20', 'pay on delivery');

insert into orderdetails (OrderID, ProductID, Quantity, UnitPrice, TotalPrice)
values
(7, 3, 5, 120.00, 650.00);

UPDATE orderdetails
	SET TotalPrice = (Quantity * UnitPrice)
WHERE OrderDetailID = 4;

/*7. On December 5th, 2023:
Charity Hope, a user, decides to deactivate her account temporarily. Her account status is changed in the Users table to 'Inactive'.
*/

UPDATE Users
	SET Userstatus = 'Inactive'
WHERE UserID = 5;

/*10. On March 20th, 2024:
Charity Udoh removes 'Kente Cloth' (ProductID 1) from her cart due to a change in preference,
leaving only Maasai Beaded Necklace with (ProductID 2) The entry is deleted from the Cart table.
*/

insert into  cart (UserID, ProductID, Quantity, AddedToCartDates)
values
(6, 1, 2, '2024-03-10 15:15:20'),
(6, 2, 2, '2024-03-10 15:15:20');

DELETE FROM cart
WHERE CartID = 3;

/* On February 14th, 2024:
a satisfied User, WITH UserID 7 leaves a detailed review for (ProductID 27) in the Reviews table, after clearing the stocks,
 highlighting the product's sound quality and comfort with 5 stars rating.
*/

insert into orders   (UserID, OrderDate, Status)
values
(7, '2024-02-14 15:40:10', 'pay on delivery');

insert into orderdetails (OrderID, ProductID, Quantity, UnitPrice, TotalPrice)
values
(8, 27, 80, 18.00, 1440.00);

insert into reviews (ProductID, UserID, Rating, Review_text)
values
(27, 7, '*****', 'sound quality and comfortable piece!');

/*
 On May 1st, 2024:
A price adjustment of 10% is applied to all 'Electronics' category products in response to market changes. Prices are updated in the Products table.
*/

UPDATE products
	SET Price = (Price * 1.10)
WHERE ProductID IN (
	SELECT Sub.ProductID 
    FROM 
	(SELECT ProductID FROM products WHERE CategoryID = 1) 
	AS Sub
);


/*
On June 5th, 2024:
The platform conducts a flash sale, offering a 20% discount on Kenyan Coffee Beans  (ProductID 6) for a limited period. 
The updated pricing is reflected in the Products table.
*/

UPDATE products
	SET Price = (Price * 0.80)
WHERE ProductID = 6;

     
