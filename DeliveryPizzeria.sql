-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Pizza
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Pizza
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Pizza` DEFAULT CHARACTER SET utf8 ;
USE `Pizza` ;

-- -----------------------------------------------------
-- Table `Pizza`.`Province`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizza`.`Province` (
  `idProvince` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idProvince`, `Name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizza`.`Locality`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizza`.`Locality` (
  `idLocality` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `idProvince` INT NULL,
  PRIMARY KEY (`idLocality`),
  INDEX `idProvince_idx` (`idProvince` ASC) VISIBLE,
  CONSTRAINT `idProvince`
    FOREIGN KEY (`idProvince`)
    REFERENCES `Pizza`.`Province` (`idProvince`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizza`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizza`.`Customer` (
  `idCustomer` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Surname` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  `Postcode` VARCHAR(45) NOT NULL,
  `Phone` INT NOT NULL,
  `idLocality` INT NULL,
  `idProvince` INT NULL,
  PRIMARY KEY (`idCustomer`),
  INDEX `idLocality_idx` (`idLocality` ASC) VISIBLE,
  INDEX `idProvince_idx` (`idProvince` ASC) VISIBLE,
  CONSTRAINT `idLocality`
    FOREIGN KEY (`idLocality`)
    REFERENCES `Pizza`.`Locality` (`idLocality`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idProvince`
    FOREIGN KEY (`idProvince`)
    REFERENCES `Pizza`.`Province` (`idProvince`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizza`.`Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizza`.`Category` (
  `idCategory` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCategory`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizza`.`Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizza`.`Products` (
  `idProduct` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` TEXT NULL,
  `image` VARCHAR(45) NULL,
  `price` DECIMAL NOT NULL,
  `idCategory` INT NULL,
  PRIMARY KEY (`idProduct`),
  INDEX `idCategory_idx` (`idCategory` ASC) VISIBLE,
  CONSTRAINT `idCategory`
    FOREIGN KEY (`idCategory`)
    REFERENCES `Pizza`.`Category` (`idCategory`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizza`.`Stores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizza`.`Stores` (
  `idStore` INT NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(45) NOT NULL,
  `postal code` VARCHAR(45) NOT NULL,
  `idEmployee` INT NOT NULL,
  `idLocality` INT NOT NULL,
  `idProvince` INT NOT NULL,
  PRIMARY KEY (`idStore`),
  INDEX `idLocality_idx` (`idLocality` ASC) VISIBLE,
  INDEX `idProvince_idx` (`idProvince` ASC) VISIBLE,
  CONSTRAINT `idLocality`
    FOREIGN KEY (`idLocality`)
    REFERENCES `Pizza`.`Locality` (`idLocality`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idProvince`
    FOREIGN KEY (`idProvince`)
    REFERENCES `Pizza`.`Province` (`idProvince`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizza`.`Employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizza`.`Employees` (
  `idEmployee` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `NIF` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `role` ENUM('Chef', 'Delivery_Person') NOT NULL,
  `idStore` INT NULL,
  PRIMARY KEY (`idEmployee`),
  INDEX `idStore_idx` (`idStore` ASC) VISIBLE,
  CONSTRAINT `idStore`
    FOREIGN KEY (`idStore`)
    REFERENCES `Pizza`.`Stores` (`idStore`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizza`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizza`.`Orders` (
  `idOrder` INT NOT NULL AUTO_INCREMENT,
  `order_DateTime` DATETIME NOT NULL,
  `delivary_type` ENUM('home_delivery', 'pickup') NOT NULL,
  `total_price` DECIMAL NOT NULL,
  `idStore` INT NULL,
  `idCustomer` INT NULL,
  `idDelivery_Person` INT NULL,
  PRIMARY KEY (`idOrder`),
  INDEX `idCustomer_idx` (`idCustomer` ASC) VISIBLE,
  INDEX `idStore_idx` (`idStore` ASC) VISIBLE,
  INDEX `idDelivery_Person_idx` (`idDelivery_Person` ASC) VISIBLE,
  CONSTRAINT `idCustomer`
    FOREIGN KEY (`idCustomer`)
    REFERENCES `Pizza`.`Customer` (`idCustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idStore`
    FOREIGN KEY (`idStore`)
    REFERENCES `Pizza`.`Stores` (`idStore`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idDelivery_Person`
    FOREIGN KEY (`idDelivery_Person`)
    REFERENCES `Pizza`.`Employees` (`idEmployee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizza`.`Order_Details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizza`.`Order_Details` (
  `idOrder_Details` INT NOT NULL AUTO_INCREMENT,
  `idOrder` INT NULL,
  `idProduct` INT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`idOrder_Details`),
  INDEX `idOrder_idx` (`idOrder` ASC) VISIBLE,
  INDEX `idProduct_idx` (`idProduct` ASC) VISIBLE,
  CONSTRAINT `idOrder`
    FOREIGN KEY (`idOrder`)
    REFERENCES `Pizza`.`Orders` (`idOrder`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idProduct`
    FOREIGN KEY (`idProduct`)
    REFERENCES `Pizza`.`Products` (`idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
