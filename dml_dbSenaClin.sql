/*EXERCÍCIOS/QUERIES - DML*/

USE db_senaclin;

/*exercício 1*/

ALTER TABLE paciente ADD COLUMN cidade VARCHAR(100) NOT NULL AFTER cpf;
SELECT * FROM paciente;

/*exercício 2*/

SELECT * FROM paciente

INSERT INTO paciente VALUES 
('1','Rebeca Reis','46859133567','Santos','Rua','Comendador Alfaia Rodrigues','260','Apartamento 21', '13995684236'),
('2','Luis Lima','94568255794','São Vicente','Avenida','Frei Gaspar','150','Apartamento 15','13994360520'),
('3','Barbara Bueno','64582397015','Santos','Avenida','Francisco Glicério','329','','13997204365'),
('4','Vinicius Vasquez','52486395826','Guarujá','Rua', 'Araguaçu','400','','13998254603'),
('5','Carla Coimbra','32589645521','São Vicente','Rua','Manoel Covas Raia','724','Casa 2','13996452358'),
('6','Arthur Albuquerque','35268261149','Santos','Rua','Alfredo Ximenes','4','','13997204536');

