	Skip to content
	This repository
	Search
	Pull requests
	Issues
	Gist
	 @GilsonPSantos
	 Unwatch 2
	  Star 0
	  Fork 0 mglaucon/GPM-Odonto-Modeling Private
	 Code  Issues 0  Pull requests 0  Projects 0  Wiki  Pulse  Graphs
	Branch: master Find file Copy pathGPM-Odonto-Modeling/SQL.sql
	04d8728  4 days ago
	@mglaucon mglaucon Update SQL.sql
	1 contributor
	RawBlameHistory     
	421 lines (361 sloc)  12.1 KB
	-- MySQL Script generated by MySQL Workbench
	-- Qua 23 Nov 2016 01:48:44 BRST
	-- Model: New Model    Version: 1.0
	-- MySQL Workbench Forward Engineering
	
	SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
	SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
	SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';
	
	-- -----------------------------------------------------
	-- Schema mydb
	-- -----------------------------------------------------
	DROP SCHEMA IF EXISTS `mydb` ;
	
	-- -----------------------------------------------------
	-- Schema mydb
	-- -----------------------------------------------------
	CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
	SHOW WARNINGS;
	USE `mydb` ;
	
	
	-- -----------------------------------------------------
	-- Schema BDODONTOSYSTEM
	-- -----------------------------------------------------
	DROP SCHEMA IF EXISTS `BDODONTOSYSTEM` ;
	
	-- -----------------------------------------------------
	-- Schema BDODONTOSYSTEM
	-- -----------------------------------------------------
	CREATE SCHEMA IF NOT EXISTS `BDODONTOSYSTEM` DEFAULT CHARACTER SET utf8 ;
	SHOW WARNINGS;
	USE `BDODONTOSYSTEM` ;
	
	-- -----------------------------------------------------
	-- Table `PESSOA`
	-- -----------------------------------------------------
	DROP TABLE IF EXISTS `PESSOA` ;
	
	SHOW WARNINGS;
	CREATE TABLE IF NOT EXISTS `PESSOA` (
	  `PES_CODIGO` INT AUTO_INCREMENT,
	  `PES_CPF` VARCHAR(11) NULL,
	  `PES_IDENTIDADE` VARCHAR(9) NULL,
	  `PES_NOME` VARCHAR(80) NULL,
	  `PES_NASCIMENTO` VARCHAR(10) NULL,
	  `PES_SEXO` ENUM('F', 'M') NULL,
	  `PES_EMAIL` VARCHAR(45) NULL,
	  `PES_DDD` CHAR(2) NULL,
	  `PES_CEL` VARCHAR(9) NULL,
	  `PES_TEL` VARCHAR(8) NULL,
	  `PES_ATIVO` BIT NULL,
	  `PES_CADASTRO` TIMESTAMP NULL,
	  `PES_ATUALIZACAO` TIMESTAMP NULL,
	  PRIMARY KEY (`PES_CODIGO`))
	ENGINE = InnoDB;
	
	SHOW WARNINGS;
	CREATE UNIQUE INDEX `PES_EMAIL_UNIQUE` ON `PESSOA` (`PES_EMAIL` ASC);
	
	SHOW WARNINGS;
	
	-- -----------------------------------------------------
	-- Table `PACIENTE`
	-- -----------------------------------------------------
	DROP TABLE IF EXISTS `PACIENTE` ;
	
	SHOW WARNINGS;
	CREATE TABLE IF NOT EXISTS `PACIENTE` (
	  `PAC_CODIGO` INT NOT NULL,
	  PRIMARY KEY (`PAC_CODIGO`),
	  CONSTRAINT `fk_PACIENTE_PESSOA`
	    FOREIGN KEY (`PAC_CODIGO`)
	    REFERENCES `PESSOA` (`PES_CODIGO`)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION)
	ENGINE = InnoDB;
	
	SHOW WARNINGS;
	
	-- -----------------------------------------------------
	-- Table `ENDERECO`
	-- -----------------------------------------------------
	DROP TABLE IF EXISTS `ENDERECO` ;
	
	SHOW WARNINGS;
	CREATE TABLE IF NOT EXISTS `ENDERECO` (
	  `END_CODIGO` INT NOT NULL,
	  `END_CEP` VARCHAR(8) NULL,
	  `END_LOGRADOURO` VARCHAR(80) NULL,
	  `END_NUMERO` VARCHAR(6) NULL,
	  `END_COMPLEMENTO` VARCHAR(30) NULL,
	  `END_BAIRRO` VARCHAR(30) NULL,
	  `END_CIDADE` VARCHAR(30) NULL,
	  `END_UF` VARCHAR(3) NULL,
	  `END_ATIVO` CHAR(1) NOT NULL DEFAULT 'S',
	  `END_CADASTRO` TIMESTAMP NULL,
	  `END_ATUALIZACAO` TIMESTAMP NULL,
	  PRIMARY KEY (`END_CODIGO`),
	  CONSTRAINT `fk_ENDERECO_PESSOA`
	    FOREIGN KEY (`END_CODIGO`)
	    REFERENCES `PESSOA` (`PES_CODIGO`)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION)
	ENGINE = InnoDB;
	
	SHOW WARNINGS;
	
	-- -----------------------------------------------------
	-- Table `USUARIO`
	-- -----------------------------------------------------
	DROP TABLE IF EXISTS `USUARIO` ;
	
	SHOW WARNINGS;
	CREATE TABLE IF NOT EXISTS `USUARIO` (
	  `US_CODIGO` INT NOT NULL,
	  `US_NOME` VARCHAR(45) NOT NULL,
	  `US_SENHA` VARCHAR(45) NOT NULL,
	  `US_NIVEL` INT NOT NULL COMMENT 'N�o ser� implementado nesse primeiro momento\nSer� o nivel de acesso que cada usuario vai ter sobre o sistema\nA ideia inicial � criar uma outra tabela com o id do nivel e a descri��o de cada um\n',
	  `US_ATIVO` BIT NULL,
	  PRIMARY KEY (`US_CODIGO`),
	  CONSTRAINT `fk_USUARIO_USUARIO`
	    FOREIGN KEY (`US_CODIGO`)
	    REFERENCES `PESSOA` (`PES_CODIGO`)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION)
	ENGINE = InnoDB;
	
	SHOW WARNINGS;
	
	-- -----------------------------------------------------
	-- Table `FUNCIONARIO`
	-- -----------------------------------------------------
	DROP TABLE IF EXISTS `FUNCIONARIO` ;
	
	SHOW WARNINGS;
	CREATE TABLE IF NOT EXISTS `FUNCIONARIO` (
	  `FUN_CODIGO` INT NOT NULL,
	  `FUN_MATRICULA` VARCHAR(10) NULL,
	  PRIMARY KEY (`FUN_CODIGO`),
	  CONSTRAINT `fk_FUNCIONARIO_USUARIO`
	    FOREIGN KEY (`FUN_CODIGO`)
	    REFERENCES `USUARIO` (`US_CODIGO`)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION)
	ENGINE = InnoDB;
	
	SHOW WARNINGS;
	
	-- -----------------------------------------------------
	-- Table `ODONTOLOGISTA`
	-- -----------------------------------------------------
	DROP TABLE IF EXISTS `ODONTOLOGISTA` ;
	
	SHOW WARNINGS;
	CREATE TABLE IF NOT EXISTS `ODONTOLOGISTA` (
	  `MED_CODIGO` INT NOT NULL,
	  `MED_CRO` CHAR(15) NOT NULL,
	  PRIMARY KEY (`MED_CODIGO`),
	  CONSTRAINT `fk_ODONTOLOGISTA_FUNCIONARIO`
	    FOREIGN KEY (`MED_CODIGO`)
	    REFERENCES `FUNCIONARIO` (`FUN_CODIGO`)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION)
	ENGINE = InnoDB;
	
	SHOW WARNINGS;
	
	-- -----------------------------------------------------
	-- Table `RECEPCIONISTA`
	-- -----------------------------------------------------
	DROP TABLE IF EXISTS `RECEPCIONISTA` ;
	
	SHOW WARNINGS;
	CREATE TABLE IF NOT EXISTS `RECEPCIONISTA` (
	  `REC_CODIGO` INT NOT NULL,
	  PRIMARY KEY (`REC_CODIGO`),
	  CONSTRAINT `fk_RECEPCIONISTA_FUNCIONARIO`
	    FOREIGN KEY (`REC_CODIGO`)
	    REFERENCES `FUNCIONARIO` (`FUN_CODIGO`)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION)
	ENGINE = InnoDB;
	
	SHOW WARNINGS;
	
	-- -----------------------------------------------------
	-- Table `AGENDA`
	-- -----------------------------------------------------
	DROP TABLE IF EXISTS `AGENDA` ;
	
	SHOW WARNINGS;
	CREATE TABLE IF NOT EXISTS `AGENDA` (
	  `AG_CODIGO` INT NOT NULL,
	  `AG_DATA` DATE NOT NULL,
	  `AG_HORA` TIME NOT NULL,
	  `AG_AGENDADO` BIT NULL COMMENT 'Campo criado para determinar se nesse dia e hor�rio o m�dico possui algum paciente agendado.',
	  `AG_CADASTRO` DATETIME NULL,
	  `AG_ATUALIZACAO` DATETIME NULL,
	  `PACIENTE_PAC_CODIGO` INT NOT NULL,
	  `ODONTOLOGISTA_MED_CODIGO` INT NOT NULL,
	  `RECEPCIONISTA_REC_CODIGO` INT NOT NULL,
	  PRIMARY KEY (`AG_CODIGO`),
	  CONSTRAINT `fk_AGENDA_PACIENTE`
	    FOREIGN KEY (`PACIENTE_PAC_CODIGO`)
	    REFERENCES `PACIENTE` (`PAC_CODIGO`)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION,
	  CONSTRAINT `fk_AGENDA_ODONTOLOGISTA`
	    FOREIGN KEY (`ODONTOLOGISTA_MED_CODIGO`)
	    REFERENCES `ODONTOLOGISTA` (`MED_CODIGO`)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION,
	  CONSTRAINT `fk_AGENDA_RECEPCIONISTA`
	    FOREIGN KEY (`RECEPCIONISTA_REC_CODIGO`)
	    REFERENCES `RECEPCIONISTA` (`REC_CODIGO`)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION)
	ENGINE = InnoDB;
	
	SHOW WARNINGS;
	
	-- -----------------------------------------------------
	-- Table `TRATAMENTO`
	-- -----------------------------------------------------
	DROP TABLE IF EXISTS `TRATAMENTO` ;
	
	SHOW WARNINGS;
	CREATE TABLE IF NOT EXISTS `TRATAMENTO` (
	  `TRA_CODIGO` INT NOT NULL,
	  `TRA_DESCRICAO` VARCHAR(100) NOT NULL,
	  `PACIENTE_PAC_CODIGO` INT NOT NULL,
	  PRIMARY KEY (`TRA_CODIGO`),
	  CONSTRAINT `fk_TRATAMENTO_PACIENTE`
	    FOREIGN KEY (`PACIENTE_PAC_CODIGO`)
	    REFERENCES `PACIENTE` (`PAC_CODIGO`)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION)
	ENGINE = InnoDB;
	
	SHOW WARNINGS;
	
	-- -----------------------------------------------------
	-- Table `CONSULTA`
	-- -----------------------------------------------------
	DROP TABLE IF EXISTS `CONSULTA` ;
	
	SHOW WARNINGS;
	CREATE TABLE IF NOT EXISTS `CONSULTA` (
	  `CON_CODIGO` INT NOT NULL,
	  `CON_CONFIRMADO` BIT NULL,
	  `CON_CADASTRO` TIMESTAMP NULL,
	  `CON_ATUALIZACAO` TIMESTAMP NULL,
	  `PACIENTE_PAC_CODIGO` INT NOT NULL,
	  `ODONTOLOGISTA_MED_CODIGO` INT NOT NULL,
	  PRIMARY KEY (`CON_CODIGO`, `ODONTOLOGISTA_MED_CODIGO`),
	  CONSTRAINT `fk_CONSULTA_PACIENTE`
	    FOREIGN KEY (`PACIENTE_PAC_CODIGO`)
	    REFERENCES `PACIENTE` (`PAC_CODIGO`)
	    ON DELETE NO ACTION
	    ON UPDATE CASCADE,
	  CONSTRAINT `fk_CONSULTA_ODONTOLOGISTA`
	    FOREIGN KEY (`ODONTOLOGISTA_MED_CODIGO`)
	    REFERENCES `ODONTOLOGISTA` (`MED_CODIGO`)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION)
	ENGINE = InnoDB;
	
	SHOW WARNINGS;
	
	-- -----------------------------------------------------
	-- Table `HISTORICO`
	-- -----------------------------------------------------
	DROP TABLE IF EXISTS `HISTORICO` ;
	
	SHOW WARNINGS;
	CREATE TABLE IF NOT EXISTS `HISTORICO` (
	  `HIS_CODIGO` INT NOT NULL,
	  `HIS_DESCRICAO` VARCHAR(100) NULL,
	  `HIS_DATA` DATE NULL,
	  `HIS_HORA` TIME NULL,
	  PRIMARY KEY (`HIS_CODIGO`),
	  CONSTRAINT `fk_HISTORICO_CONSULTA`
	    FOREIGN KEY (`HIS_CODIGO`)
	    REFERENCES `CONSULTA` (`CON_CODIGO`)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION)
	ENGINE = InnoDB;
	
	SHOW WARNINGS;
	
	-- -----------------------------------------------------
	-- Table `EXAME`
	-- -----------------------------------------------------
	DROP TABLE IF EXISTS `EXAME` ;
	
	SHOW WARNINGS;
	CREATE TABLE IF NOT EXISTS `EXAME` (
	  `EX_CODIGO` INT NOT NULL,
	  `EX_DATA` DATE NOT NULL,
	  `EX_HORA` TIME NOT NULL,
	  `EX_TIPO` VARCHAR(50) NOT NULL,
	  `PACIENTE_PAC_CODIGO` INT NOT NULL,
	  PRIMARY KEY (`EX_CODIGO`),
	  CONSTRAINT `fk_EXAME_PACIENTE`
	    FOREIGN KEY (`PACIENTE_PAC_CODIGO`)
	    REFERENCES `PACIENTE` (`PAC_CODIGO`)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION)
	ENGINE = InnoDB;
	
	SHOW WARNINGS;
	
	-- -----------------------------------------------------
	-- Table `PLANO`
	-- -----------------------------------------------------
	DROP TABLE IF EXISTS `PLANO` ;
	
	SHOW WARNINGS;
	CREATE TABLE IF NOT EXISTS `PLANO` (
	  `PL_CODIGO` INT AUTO_INCREMENT,
	  `PL_CONVENIO` VARCHAR(45) UNIQUE NOT NULL,
	  PRIMARY KEY (`PL_CODIGO`))
	ENGINE = InnoDB;
	
	SHOW WARNINGS;
	
	-- -----------------------------------------------------
	-- Table `CONVENIADO`
	-- -----------------------------------------------------
	DROP TABLE IF EXISTS `CONVENIADO` ;
	
	SHOW WARNINGS;
	CREATE TABLE IF NOT EXISTS `CONVENIADO` (
	  `CON_CODIGO` INT NOT NULL,
	  `CON_NUMERO` VARCHAR(30) NULL,
	  `CON_VALIDADE` DATE NULL,
	  `CON_COBERTURA` VARCHAR(45) NULL,
	  `CON_OBSERVACAO` VARCHAR(100) NULL,
	  `PLANO_PL_CODIGO` INT NOT NULL,
	  PRIMARY KEY (`CON_CODIGO`, `PLANO_PL_CODIGO`),
	  CONSTRAINT `fk_CONVENIO_PLANO`
	    FOREIGN KEY (`PLANO_PL_CODIGO`)
	    REFERENCES `PLANO` (`PL_CODIGO`)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION,
	  CONSTRAINT `fk_CONVENIADO_PACIENTE`
	    FOREIGN KEY (`CON_CODIGO`)
	    REFERENCES `PACIENTE` (`PAC_CODIGO`)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION)
	ENGINE = InnoDB;
	
	SHOW WARNINGS;
	
	-- -----------------------------------------------------
	-- Table `DENTE`
	-- -----------------------------------------------------
	DROP TABLE IF EXISTS `DENTE` ;
	
	SHOW WARNINGS;
	CREATE TABLE IF NOT EXISTS `DENTE` (
	  `DEN_CODIGO` INT NOT NULL,
	  `DEN_DESCRICAO` VARCHAR(45) NULL,
	  `DEN_NUMERO` TINYINT NULL,
	  `DEN_RAIOX` VARCHAR(80) NULL,
	  `PACIENTE_PAC_CODIGO` INT NOT NULL,
	  PRIMARY KEY (`DEN_CODIGO`),
	  CONSTRAINT `fk_ARCADA_PACIENTE`
	    FOREIGN KEY (`PACIENTE_PAC_CODIGO`)
	    REFERENCES `PACIENTE` (`PAC_CODIGO`)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION)
	ENGINE = InnoDB;
	
	SHOW WARNINGS;
	
	-- -----------------------------------------------------
	-- Table `PAGAMENTO`
	-- -----------------------------------------------------
	DROP TABLE IF EXISTS `PAGAMENTO` ;
	
	SHOW WARNINGS;
	CREATE TABLE IF NOT EXISTS `PAGAMENTO` (
	  `PAG_CODIGO` INT NOT NULL,
	  `PAG_FORMA` VARCHAR(45) NULL,
	  `PAG_VALOR` VARCHAR(45) NULL,
	  `PACIENTE_PAC_CODIGO` INT NOT NULL,
	  PRIMARY KEY (`PAG_CODIGO`),
	  CONSTRAINT `fk_PAGAMENTO_PACIENTE`
	    FOREIGN KEY (`PACIENTE_PAC_CODIGO`)
	    REFERENCES `PACIENTE` (`PAC_CODIGO`)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION)
	ENGINE = InnoDB;
	
	SHOW WARNINGS;
	
	-- -----------------------------------------------------
	-- Table `GERENTE`
	-- -----------------------------------------------------
	DROP TABLE IF EXISTS `GERENTE` ;
	
	SHOW WARNINGS;
	CREATE TABLE IF NOT EXISTS `GERENTE` (
	  `GER_CODIGO` INT NOT NULL,
	  PRIMARY KEY (`GER_CODIGO`),
	  CONSTRAINT `fk_GERENTE_FUNCIONARIO`
	    FOREIGN KEY (`GER_CODIGO`)
	    REFERENCES `FUNCIONARIO` (`FUN_CODIGO`)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION)
	ENGINE = InnoDB;
	
	SHOW WARNINGS;
	
	SET SQL_MODE=@OLD_SQL_MODE;
	SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
	SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
	Contact GitHub API Training Shop Blog About
	� 2016 GitHub, Inc. Terms Privacy Security Status Help