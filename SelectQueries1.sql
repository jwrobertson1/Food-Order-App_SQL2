USE `food_order_app`;

/* 1. Display all cuisine names. */

SELECT name
FROM cuisine;

/* 2. Display description of 'Cake' category. */

SELECT description FROM category WHERE id='4';

/* 3. Select all restaurants where restaurant names end with 'Junction'. */

SELECT name FROM `restaurant` WHERE name LIKE '%junction%';

/* 4. Display details of all vegetarian food items. */

SELECT * FROM `fooditem` WHERE `isVeg` = '%TRUE%';

/* 5. Retrieve all menu items with food items that have a price equal to or less than $10. */

SELECT * FROM `menu_items` WHERE`fooditemPrice` <= 10; 

/* 6.Retrieve cartId having the maximum number of food items. */

SELECT cartId FROM cart_items WHERE unitsInCart = (
SELECT MAX(unitsInCart) FROM cart_items
);


/* 7. Retrieve all the shipping details where emailId contains 'doe'. */
 
SELECT * FROM `shippingDetails` WHERE `emailId` LIKE '%doe%';

/* 8. Retrieve the order with the highest price. */
SELECT * FROM cart;

SELECT id, userId, restaurantId, orderTotalPrice, orderStatus, isActive FROM `order` WHERE orderTotalPrice = (
SELECT MAX(orderTotalPrice) FROM `order`
);

/* 9. Retrieve the most recently updated order. */
 SELECT * FROM `order`;
 
SELECT id, restaurantId, orderTotalPrice, shippingDetailsId, isActive, createdTs, updatedTs FROM `order` WHERE createdTS = (
SELECT MAX(createdTS) FROM `order`
);

/* 10. How many total units of food items were purchased in orderId 1? */

SELECT SUM(unitsPurchased) FROM `order_items` WHERE orderId='1';
