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

UPDATE paciente SET complemento=NULL WHERE complemento='';

/*exercicio 3*/

SELECT * FROM dentista

INSERT INTO dentista(nome, cro, especialidade, telefone, celular) VALUES 
('Davi Dalagnoli','SP-20125','Implantodontia','32354965','13995263847'),
('Eduarda Escobar','MG-54968','Ortodontia','32358694','13994025645'),
('Francisco Franco','RJ-45826','Geral','32359684','13997258634'),
('Sueli Silva','BA-45623','Periodontia','32568941','1399820563');

/*exercicio 4 - 4.	Inserir 3 consultas, sendo 1 para o dentista que cuida de Ortodontia e 2 para o dentista cuja especialidade é Geral. O tipo de todas elas será Avaliação.*/

SELECT * FROM consulta;
SELECT * FROM dentista;
SELECT * FROM paciente;

INSERT INTO consulta (dataConsulta,horaConsulta,tipoConsulta,codPaciente,codDentista,observacao) VALUES
('2024-02-23','15:00','Avaliação','3','2',''),('2024-03-25','17:00','Avaliação','2','3',''),
('2024-04-09','14:00','Avaliação','5','3','');

/*exercicio 5 - 5.	Atualizar todos os dados, exceto nome e cro, do dentista que cuida de implantodontia, mudando sua especialidade para Geral;*/

SELECT * FROM dentista;

UPDATE dentista SET telefone='32359864',celular='13996024853',especialidade='Geral' 
WHERE especialidade='Implantodontia';

/*exercico 6 - 6.	Atualizar a data e hora de uma consulta marcada com um dentista cuja especialidade é Geral;*/

SELECT * FROM consulta;

UPDATE consulta SET dataConsulta='2024-03-29',horaConsulta='14:30' WHERE codConsulta='2';

/*exercicio 7 - 7.	Atualizar a consulta do dentista de especialidade ortodontia, mudando o tipo de consulta para Tratamento e inserindo uma observação do dentista com o seguinte texto: “Tratamento será realizado em 10 consultas. Prioridade: Moderada. Remédio aplicado: Ponstan, caso sinta dores”*/

SELECT * FROM consulta;

UPDATE consulta SET tipoConsulta='Tratamento',
observacao='Tratamento será realizado em 10 consultas. Prioridade: Moderada. 
Remédio aplicado: Ponstan, caso sinta dores' WHERE codConsulta='1';

/*exercicio 8 - 8.	Selecionar nome e telefone de todo os pacientes que residem em Santos, em ordem alfabética*/

SELECT * FROM paciente;

SELECT nome, telefone FROM paciente WHERE cidade='Santos' ORDER BY nome ASC;

/*exercicio 9 - 9.	Selecionar o nome dos dentistas, a datas da consulta, o nome do paciente e seu telefone, APENAS dos dentistas que possuem consultas;*/

SELECT * FROM paciente;
SELECT * FROM consulta;
SELECT * FROM dentista;

SELECT dentista.nome, dataConsulta, paciente.nome, paciente.telefone FROM dentista 
INNER JOIN consulta ON dentista.codDentista=consulta.codDentista 
INNER JOIN paciente ON consulta.codPaciente=paciente.codPaciente

/*exercicio 10 -	Selecionar o nome do dentista, a data da consulta e o tipo da consulta, MESMO quando os dentistas não possuam consultas; */

SELECT * FROM consulta;
SELECT * FROM dentista;

SELECT dentista.nome, dataConsulta, tipoConsulta FROM dentista 
LEFT JOIN consulta ON dentista.codDentista=consulta.codDentista;

/*exercicio 11 -11.	Criar uma query que exiba a quantidade de dentistas que a clínica possui, agrupando-os por especialidade, ordenando pelo nome da especialidade de A-Z. Para isto, você utilizará o comando group by do sql. */

SELECT * FROM dentista;

SELECT COUNT(codDentista) AS 'Quant. Dentista', especialidade 
FROM dentista GROUP BY especialidade ORDER BY especialidade ASC;

/*exercicio 12 - 12.	Criar uma query que mostre a quantidade de consultas que a clínica possui em determinado período do ano. Escolher um mês que retorne ao menos uma consulta, e incluir o mês como filtro.*/

SELECT * FROM consulta;

SELECT COUNT(codConsulta) AS 'Quant. Consultas' FROM consulta WHERE MONTH(dataConsulta)='04';

/*exercicio 13 -13.	Criar uma query que traga todos os tipos de consulta, agrupadas pela quantidade.*/

SELECT * FROM consulta;

SELECT COUNT(tipoConsulta) AS 'Quant. Tipos',tipoConsulta FROM consulta GROUP BY tipoConsulta;

/*exercicio 14 -14.	Criar uma query que traga o número de pacientes que a clínica possui.*/

SELECT COUNT(codPaciente) AS 'Quant. Paciente' FROM paciente;

/*exercicio 15 - 15.	Criar uma query que traga todas as consultas da especialidade implantodontia. Deve vir na query o nome do dentista, o cro, a data da consulta e o nome do paciente, ordenados da data mais atual para a mais antiga.*/

SELECT * FROM dentista;
SELECT * FROM consulta;
SELECT * FROM paciente;

SELECT dentista.nome, cro, dataConsulta, paciente.nome FROM consulta 
INNER JOIN dentista ON consulta.codDentista=dentista.codDentista
INNER JOIN paciente ON consulta.codPaciente=paciente.codPaciente
WHERE especialidade='Implantodontia' ORDER BY dataConsulta ASC;

/*exercicio 16 - 16.	Crie uma procedure similar ao exercício 15, porém a especialidade deve ser passada como parâmetro. Execute a procedure para testar.*/

CREATE PROCEDURE ConsultasPorEspecialidade(IN especialidadeDesejada VARCHAR(100))
SELECT dentista.nome, cro, dataConsulta, paciente.nome FROM consulta 
INNER JOIN dentista ON consulta.codDentista=dentista.codDentista
INNER JOIN paciente ON consulta.codPaciente=paciente.codPaciente
WHERE especialidade=especialidadeDesejada ORDER BY dataConsulta ASC;

CALL ConsultasPorEspecialidade('Geral')
CALL ConsultasPorEspecialidade('Ortodontia')

/*exercicio 17 - 17.	Crie uma view similar ao exercício 13. Execute a view para testar.*/

CREATE VIEW quantTipos AS
SELECT COUNT(tipoConsulta) AS 'Quant. Tipos',tipoConsulta FROM consulta GROUP BY tipoConsulta;

SELECT * FROM quantTipos;

/*Desafio - Criar uma query que traga quantas consultas cada um dos dentistas realizou ao longo de todo o período,  ordenando as do que atendeu mais pacientes para o que atendeu menos. */

SELECT * FROM consulta;
SELECT * FROM dentista;

SELECT COUNT(codConsulta), dentista.nome FROM consulta 
RIGHT JOIN dentista ON consulta.codDentista=dentista.codDentista 
GROUP BY dentista.codDentista ORDER BY COUNT(codConsulta) DESC;
















