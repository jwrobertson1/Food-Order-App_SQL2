USE `food_order_app`;
/* 1. Retrieve number of food items for each cuisine */

SELECT cuisine.name, SUM(fooditem.cuisineId) as number_of_fooditems
FROM cuisine
LEFT JOIN fooditem ON cuisine.id = fooditem.id
GROUP BY cuisine.name;


/* 2. Retrieve category names in the order of highest to lowest no. of food items */
SELECT cuisine.name, SUM(fooditem.cuisineId) as number_of_fooditems
FROM cuisine
LEFT JOIN fooditem ON cuisine.id = fooditem.id
GROUP BY cuisine.name
ORDER BY number_of_fooditems DESC;

/* 3. Retrieve details of all food items belonging to 'Italian' cuisine, 
including CuisineName, FoodItemName, Description */

SELECT cuisine.name, fooditem.Name, fooditem.description
FROM fooditem
LEFT JOIN cuisine ON fooditem.id = cuisine.name;

/* 4. Display details of menu items offered by the 'Gourmet Junction' restaurant, 
including the MenuId, RestaurantName, MenuItemId, FoodItemName, and FoodItemPrice */

SELECT restaurant.name, restaurant.name, menu_items.menuId, menu_items.fooditemId, menu_items.foodItemPrice
FROM restaurant
INNER JOIN menu_items ON restaurant.name = menu_items.menuId
WHERE restaurant.name = 'Gourmet Junction';


/* 5. Display details of order items placed by the user 'John Doe', 
including the orderId, orderItemId, foodItemName, foodItemPrice, and unitsPurchased? */

SELECT user.username, order_Items.orderId, order_Items.foodItemId, order_Items.foodItemPrice, order_Items.unitsPurchased
FROM USER
INNER JOIN order_items ON user.id = order_Items.orderID
WHERE user.username = 'John Doe';
