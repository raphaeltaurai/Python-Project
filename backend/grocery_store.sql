-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema grocery_store
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `grocery_store` ;

-- -----------------------------------------------------
-- Schema grocery_store
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `grocery_store` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `grocery_store` ;

-- -----------------------------------------------------
-- Table `grocery_store`.`orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `grocery_store`.`orders` ;

CREATE TABLE IF NOT EXISTS `grocery_store`.`orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `customer_name` VARCHAR(100) NOT NULL,
  `total` DOUBLE NOT NULL,
  `datetime` DATETIME NOT NULL,
  PRIMARY KEY (`order_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `grocery_store`.`uom`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `grocery_store`.`uom` ;

CREATE TABLE IF NOT EXISTS `grocery_store`.`uom` (
  `uom_id` INT NOT NULL AUTO_INCREMENT,
  `uom_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`uom_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `grocery_store`.`products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `grocery_store`.`products` ;

CREATE TABLE IF NOT EXISTS `grocery_store`.`products` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `uom_id` INT NOT NULL,
  `price_per_unit` DOUBLE NOT NULL,
  PRIMARY KEY (`product_id`),
  INDEX `fk_uom_id _idx` (`uom_id` ASC) VISIBLE,
  CONSTRAINT `fk_uom_id `
    FOREIGN KEY (`uom_id`)
    REFERENCES `grocery_store`.`uom` (`uom_id`)
    ON UPDATE RESTRICT)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `grocery_store`.`order_details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `grocery_store`.`order_details` ;

CREATE TABLE IF NOT EXISTS `grocery_store`.`order_details` (
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `quantity` DOUBLE NOT NULL,
  `total_price` DOUBLE NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_product_id_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_id`
    FOREIGN KEY (`order_id`)
    REFERENCES `grocery_store`.`orders` (`order_id`)
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_product_id`
    FOREIGN KEY (`product_id`)
    REFERENCES `grocery_store`.`products` (`product_id`)
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO uom VALUES
('1','kg'),
('2','each');

INSERT INTO products VALUES
('2','Mealie Meal','1','10'),
('3','Rice','1','1.50'),
('4','Cooking Oil', '2', '3'),
('5','Flour','1','1.50'),
('6', 'Roibos Tea', '1', '2'),
('7', 'Candle','2', '0.2');

INSERT INTO orders VALUES
('1', 'Raphael', '3000', '20240329'),
('2', 'Taurai', '4000', '20240330');

INSERT INTO order_details VALUES
('1','1','2','4');

SELECT 
    products.product_id,
    products.name,
    products.uom_id,
    products.price_per_unit,
    uom.uom_name
FROM
    products
        INNER JOIN
    uom ON products.uom_id = uom.uom_id;
 