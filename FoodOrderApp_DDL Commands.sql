/*The schema includes tables for users, user sessions, categories, cuisines, fooditems, 
restaurants, menus, menuitems, shopping carts, cart items, shipping details, orders and orderitems.

The user table stores information about registered users like username, fullname, emailId, phoneNo and password.
The usersession table is used to manage user sessions and stores information like userId and sessionToken.
The category table stores information about categories like category name, description and image url.
The cuisine table stores information about cuisines like cuisine name, description and image url.
The restaurant table stores information about restaurants like restaurant name, address, contact and image url.
The fooditem table stores information about fooditems like fooditem name, description, categoryId, cuisineId, isVeg and image url.
The menu table stores information about food menu like restaurantId of the restaurant offering the particular menu.
The menuitem table stores information about fooditems for a menu like menuId, fooditemId and fooditemPrice for the particular fooditem.
The cart table stores information about shopping carts created by users like userId, restaurantId, orderTotalPrice.
The cart_items table stores information about the fooditems added to each cart like cartId, fooditemId, fooditemPrice and UnitsInCart. 
The shippingDetails table stores information about the shipping address, email, and phone number. 
The order table stores information about each order, including the user who placed the order, the shipping details, the order total price, the restaurant from where the order fooditems are ordered and the order status.
Finally, the order_items table stores information about the fooditems ordered in each order like orderId, fooditemId, fooditemPrice and UnitsPurchased. 

Each table also includes some additional columns, such as createdTs and updatedTs, which are used to store timestamps of when each record was created and last updated. 
Additionally, each table has an isActive column, which is used to mark records as inactive rather than deleting them outright. 
This allows for data to be retained for future reference without cluttering the database with unnecessary data.*/
DROP DATABASE IF exists `food_order_app`;

/*Create database command*/
CREATE DATABASE `food_order_app`;

/*Select the newly created database*/
USE `food_order_app`;

/*Create table command for user table*/
CREATE TABLE `user` (
  `id` int NOT NULL,
  `userName` varchar(50) NOT NULL,
  `fullName` varchar(100) NOT NULL,
  `emailId` varchar(100) NOT NULL,
  `phoneNo` int NOT NULL,
  `password` varchar(50) NOT NULL,
  `isActive` int NOT NULL DEFAULT '1',
  `createdTs` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedTs` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Create table command for usersession table*/
CREATE TABLE `usersession` (
  `id` int NOT NULL,
  `userId` int DEFAULT NULL,
  `sessionToken` varchar(200) NOT NULL,
  `isActive` int NOT NULL DEFAULT '1',
  `createdTs` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedTs` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `userForeignKey_idx` (`userId`),
  CONSTRAINT `userForeignKey` FOREIGN KEY (`userId`) REFERENCES `user`
   (`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Create table command for category table*/
CREATE TABLE `category` (
  `id` int NOT NULL,
  `name` varchar(45) NOT NULL,
  `description` varchar(200) NOT NULL,
  `image` varchar(200) NOT NULL,
  `isActive` int NOT NULL DEFAULT '1',
  `createdTs` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedTs` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Q. 1. Create table command for cuisine table*/
CREATE TABLE `cuisine` (
  `id` int NOT NULL,
  `name` varchar(45) NOT NULL,
  `description` varchar(200) NOT NULL,
  `image` varchar(200) NOT NULL,
  `isActive` int NOT NULL DEFAULT '1',
  `createdTs` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedTs` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Q. 2. Create table command for restaurant table*/
CREATE TABLE `restaurant` (
  `id` int NOT NULL,
  `name` varchar(45) NOT NULL,
  `address` varchar(200) NOT NULL,
  `contact` int NOT NULL,
  `image` varchar(200) NOT NULL,
  `isActive` int NOT NULL DEFAULT '1',
  `createdTs` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedTs` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Q. 3. Create table command for fooditem table*/
CREATE TABLE `fooditem` (
  `id` int NOT NULL,
  `name` varchar(45) NOT NULL,
  `description` varchar(200) NOT NULL,
  `image` varchar(200) NOT NULL,
  `categoryId` int DEFAULT NULL,
  `cuisineId` int DEFAULT NULL,
  `isVeg` boolean NOT NULL,
  `isActive` int NOT NULL DEFAULT '1',
  `createdTs` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedTs` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `categoryForeignKey_idx` (`categoryId`),
CONSTRAINT `categoryForeignKey` FOREIGN KEY (`categoryId`) REFERENCES `category`
(`id`) ON DELETE SET NULL ON UPDATE SET NULL,
KEY `cuisineForeignKey_idx` (`categoryId`),
CONSTRAINT `cuisineForeignKey` FOREIGN KEY (`cuisineId`) REFERENCES `cuisine`
(`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Q. 4. Create table command for menu table*/
CREATE TABLE `menu` (
  `id` int NOT NULL,
  `restaurantId` int DEFAULT NULL,
  `isActive` int NOT NULL DEFAULT '1',
  `createdTs` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedTs` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `restaurantForeignKey_idx` (`restaurantId`),
CONSTRAINT `restaurantForeignKey` FOREIGN KEY (`restaurantId`) REFERENCES `restaurant`
(`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Q. 5. Create table command for menu_items table*/
CREATE TABLE `menu_items` (
  `id` int NOT NULL,
  `menuId` int DEFAULT NULL,
  `fooditemId` int DEFAULT NULL,
  `fooditemPrice` decimal(10,2) NOT NULL,
  `isActive` int NOT NULL DEFAULT '1',
  `createdTs` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedTs` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `menuForeignKey_idx` (`menuId`),
CONSTRAINT `menuForeignKey` FOREIGN KEY (`menuId`) REFERENCES `menu`
(`id`) ON DELETE SET NULL ON UPDATE SET NULL,
KEY `fooditemForeignKey_idx` (`fooditemId`),
CONSTRAINT `fooditemForeignKey` FOREIGN KEY (`fooditemId`) REFERENCES `fooditem`
(`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Q. 6. Create table command for cart table*/
CREATE TABLE `cart` (
  `id` int NOT NULL,
  `userId` int DEFAULT NULL,
  `restaurantId` int DEFAULT NULL,
  `orderTotalPrice` decimal(10,2) NOT NULL,
  `isActive` int NOT NULL DEFAULT '1',
  `createdTs` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedTs` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `userForeignKey_idx` (`userId`),
  CONSTRAINT `userForeignKey2` FOREIGN KEY (`userId`) REFERENCES `user`
   (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
   KEY `restaurantForeignKey_idx` (`restaurantId`),
CONSTRAINT `restaurantForeignKey2` FOREIGN KEY (`restaurantId`) REFERENCES `restaurant`
(`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Q. 7. Create table command for cart_items table*/
CREATE TABLE `cart_items` (
  `id` int NOT NULL,
  `cartId` int DEFAULT NULL,
  `fooditemId` int DEFAULT NULL,
  `fooditemPrice` decimal(10,2) NOT NULL,
  `unitsInCart` int NOT NULL,
  `isActive` int NOT NULL DEFAULT '1',
  `createdTs` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedTs` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `cartForeignKey_idx` (`cartId`),
CONSTRAINT `cartForeignKey` FOREIGN KEY (`cartId`) REFERENCES `cart`
(`id`) ON DELETE SET NULL ON UPDATE SET NULL,
KEY `fooditemForeignKey_idx` (`fooditemId`),
CONSTRAINT `fooditemForeignKey2` FOREIGN KEY (`fooditemId`) REFERENCES `fooditem`
(`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Q. 8. Create table command for shippingDetails table*/
CREATE TABLE `shippingDetails` (
  `id` int NOT NULL,
  `shippingAddress` varchar(200) NOT NULL,
  `emailId` varchar(50) NOT NULL,
  `phoneNo` int NOT NULL,
  `isActive` int NOT NULL DEFAULT '1',
  `createdTs` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedTs` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Q. 9. Create table command for order table*/
CREATE TABLE `order` (
  `id` int NOT NULL,
  `userId` int DEFAULT NULL,
  `restaurantId` int DEFAULT NULL,
  `orderTotalPrice` decimal(10,2) NOT NULL,
  `shippingDetailsId` int DEFAULT NULL,
  `orderStatus` varchar(50) NOT NULL DEFAULT 'PROCESSING',
  `isActive` int NOT NULL DEFAULT '1',
  `createdTs` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedTs` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `userForeignKey_idx` (`userId`),
  CONSTRAINT `userForeignKey3` FOREIGN KEY (`userId`) REFERENCES `user`
   (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
   KEY `restaurantForeignKey_idx` (`restaurantId`),
CONSTRAINT `restaurantForeignKey3` FOREIGN KEY (`restaurantId`) REFERENCES `restaurant`
(`id`) ON DELETE SET NULL ON UPDATE SET NULL,
KEY `shippingDetailsForeignKey_idx` (`shippingDetailsId`),
CONSTRAINT `shippingDetailsForeignKey` FOREIGN KEY (`shippingDetailsId`) REFERENCES `shippingDetails`
(`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Q. 10. Create table command for order_items table*/
CREATE TABLE `order_items` (
  `id` int NOT NULL,
  `orderId` int DEFAULT NULL,
  `fooditemId` int DEFAULT NULL,
  `fooditemPrice` decimal(10,2) NOT NULL,
  `unitsPurchased` int NOT NULL,
  `isActive` int NOT NULL DEFAULT '1',
  `createdTs` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedTs` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `orderForeignKey_idx` (`orderId`),
CONSTRAINT `orderForeignKey` FOREIGN KEY (`orderId`) REFERENCES `order`
(`id`) ON DELETE SET NULL ON UPDATE SET NULL,
KEY `fooditemForeignKey_idx` (`fooditemId`),
CONSTRAINT `fooditemForeignKey3` FOREIGN KEY (`fooditemId`) REFERENCES `fooditem`
(`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;