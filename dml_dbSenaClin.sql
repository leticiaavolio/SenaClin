/*EXERCÍCIOS/QUERIES - DML*/

USE db_senaclin;

/*exercício 1*/

ALTER TABLE paciente ADD COLUMN cidade VARCHAR(100) NOT NULL AFTER cpf;
SELECT * FROM paciente;

