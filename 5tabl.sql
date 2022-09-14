
DROP TABLE IF EXISTS `Buyer` ;

CREATE TABLE IF NOT EXISTS `Buyer` (
  `idBuyer` INT NOT NULL,
  `Buyer` VARCHAR(50) NULL,
  `Address` VARCHAR(100) NULL,
  `Telephone` VARCHAR(45) NULL,
  PRIMARY KEY (`idBuyer`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Products` ;

CREATE TABLE IF NOT EXISTS `Products` (
  `idProducts` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Strna_produce` VARCHAR(45) NULL,
  `price` DECIMAL(45) NULL,
  PRIMARY KEY (`idProducts`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sales`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Sales` ;

CREATE TABLE IF NOT EXISTS `Sales` (
  `idSales` INT NOT NULL,
  `Date` DATE NULL,
  `Sale_Buyer` VARCHAR(45) NULL,
  `Product` VARCHAR(45) NULL,
  `Quantity` VARCHAR(45) NULL,
  `Buyer_idBuyer` INT NOT NULL,
  `Products_idProducts` INT NOT NULL,
  PRIMARY KEY (`idSales`, `Buyer_idBuyer`, `Products_idProducts`),
  INDEX `fk_Sales_Buyer1_idx` (`Buyer_idBuyer` ASC) VISIBLE,
  INDEX `fk_Sales_Products1_idx` (`Products_idProducts` ASC) VISIBLE,
  CONSTRAINT `fk_Sales_Buyer1`
    FOREIGN KEY (`Buyer_idBuyer`)
    REFERENCES `mydb`.`Buyer` (`idBuyer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sales_Products1`
    FOREIGN KEY (`Products_idProducts`)
    REFERENCES `mydb`.`Products` (`idProducts`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Suppliers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Suppliers` ;

CREATE TABLE IF NOT EXISTS `Suppliers` (
  `idSuppliers` INT NOT NULL,
  `Postabschick` VARCHAR(45) NULL,
  `Phone` VARCHAR(45) NULL,
  PRIMARY KEY (`idSuppliers`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Deliveries`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Deliveries` ;

CREATE TABLE IF NOT EXISTS `Deliveries` (
  `idDeliveries` INT NOT NULL,
  `Date` DATE NULL,
  `Supplier` VARCHAR(45) NULL,
  `product` VARCHAR(45) NULL,
  `Products_idProducts` INT NOT NULL,
  `Suppliers_idSuppliers` INT NOT NULL,
  PRIMARY KEY (`idDeliveries`, `Products_idProducts`, `Suppliers_idSuppliers`),
  INDEX `fk_Deliveries_Products1_idx` (`Products_idProducts` ASC) VISIBLE,
  INDEX `fk_Deliveries_Suppliers1_idx` (`Suppliers_idSuppliers` ASC) VISIBLE,
  CONSTRAINT `fk_Deliveries_Products1`
    FOREIGN KEY (`Products_idProducts`)
    REFERENCES `mydb`.`Products` (`idProducts`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Deliveries_Suppliers1`
    FOREIGN KEY (`Suppliers_idSuppliers`)
    REFERENCES `mydb`.`Suppliers` (`idSuppliers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

