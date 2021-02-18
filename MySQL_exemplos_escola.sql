 #Tabela Alunos
 #identificador de aluno ( Chave primaria - tipo número)
 
CREATE TABLE escola_curso.alunos (
  id_alunos INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (id_alunos)
  ) ;
  
  #Tabela Cursos
CREATE TABLE escola_curso.cursos (
  id_curso INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (id_curso)
  ) ;
  
   #Tabela Notas
  CREATE TABLE escola_curso.notas (
  id_nota INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (id_nota)
  ) ;

   #Tabela Alunos - Criando os campos 
   ALTER TABLE `escola_curso`.`alunos` 
ADD COLUMN `nome` VARCHAR(100) NOT NULL AFTER `id_alunos`,
ADD COLUMN `data_nascimento` DATE NOT NULL AFTER `nome`,
ADD COLUMN `endereco` VARCHAR(255) NOT NULL AFTER `data_nascimento`,
ADD COLUMN `cidade` VARCHAR(100) NOT NULL AFTER `endereco`,
ADD COLUMN `estado` VARCHAR(2) NOT NULL AFTER `cidade`,
ADD COLUMN `cpf` VARCHAR(11) NOT NULL AFTER `estado`;

#Tabela cursos - Criando os campos 
   ALTER TABLE `escola_curso`.`cursos` 
ADD COLUMN `nome` VARCHAR(100) NOT NULL AFTER `id_curso`;


#Tabela notas - Criando os campos 
   ALTER TABLE `escola_curso`.`notas` 
ADD COLUMN `descricao_atividade` VARCHAR(100) NOT NULL AFTER `id_nota`,
ADD COLUMN `vlr_nota` DECIMAL(5,2) NOT NULL AFTER `descricao_atividade`;


#comando para deletar a tabela 
DROP TABLE escola_curso.alunos;


#comando para criar de uma vez a tabela
CREATE TABLE escola_curso.alunos (
  id_aluno int NOT NULL AUTO_INCREMENT,
  nome varchar(100) NOT NULL,
  data_nascimento date NOT NULL,
  endereco varchar(255) NOT NULL,
  cidade varchar(100) NOT NULL,
  estado varchar(2) NOT NULL,
  cpf varchar(11) NOT NULL,
  PRIMARY KEY (id_aluno)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

#inserindo informações na Tabela Alunos 

INSERT INTO alunos
VALUES (DEFAULT,'Pedro Martins','1987-07-17','AV Antonio Carlos, 6377','BELO HORIZONTE','MG','12345678911'),
(DEFAULT,'Mateus Magnus','1991-02-05','AV Carlos Antonio, 623','RIO DE JANEIRO','RJ','22345678911'),
(DEFAULT,'Andrea Costa','1911-11-03','AV Carlos Antonio, 633','RIO DE JANEIRO','RJ','12345678922'),
(DEFAULT,'Carolina Campanha','2001-10-13','AV Carlos Antonio, 613','RIO DE JANEIRO','RJ','12345678933'),
(DEFAULT,'Maria Beatriz','1980-01-03','AV Carlos Antonio, 111','RIO DE JANEIRO','RJ','12345678944')
; 
#Alterando um registro na Tabela
UPDATE alunos
SET nome = 'Mateus Magnus P. Paape'
WHERE id_aluno = 2;
#Deletando um registro de uma tabela

DELETE FROM alunos
WHERE id_aluno = 1;

#consultas exemplo
SELECT nome, data_nascimento from alunos
order by nome desc;

#operadores logicos
SELECT * FROM  alunos
WHERE cidade = 'BELO HORIZONTE' AND id_aluno = 1;

SELECT * FROM  alunos
WHERE   id_aluno = 2 or  id_alunos = 3;

#operador relacional
SELECT * FROM  alunos
WHERE data_nascimento  < '1990-01-01';
 
SELECT * FROM  alunos
WHERE estado  <> 'MG';

#Modelagem 
/*
Alunos para Cursos : N X N
Cursos para Notas: 1 x N
Alunos para Notas: 1 x N

1 ) Para resolver N X N uma forma seria criar uma tabela alunos_cursos   com as chaves estrangeiras : id_aluno, id_curso apontando paras chaves primárias nas respectivas tabelas 

2) Relacionar alunos_cursos com Notas com chave estrangeira alunos_cursos


*/

#  Criando tabela alunos_cursos com as chaves estrangeiras na alunos e cursos
CREATE TABLE `escola_curso`.`alunos_cursos` (
  `id_aluno_curso` INT(11) NOT NULL AUTO_INCREMENT,
  `id_aluno` INT(11) NOT NULL,
  `id_curso` INT(11) NOT NULL,
  PRIMARY KEY (`id_aluno_curso`),
  INDEX `fk_id_aluno_idx` (`id_aluno` ASC) VISIBLE,
  INDEX `fk_id_curso_idx` (`id_curso` ASC) VISIBLE,
  CONSTRAINT `fk_id_aluno`
    FOREIGN KEY (`id_aluno`)
    REFERENCES `escola_curso`.`alunos` (`id_aluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_id_curso`
    FOREIGN KEY (`id_curso`)
    REFERENCES `escola_curso`.`cursos` (`id_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


# Fazendo a referencia a tabela aluno curso na tabela de notas 
 
 ALTER TABLE `escola_curso`.`notas` 
ADD COLUMN `id_aluno_curso` INT NOT NULL AFTER `vlr_nota`,
ADD INDEX `id_aluno_curso_idx` (`id_aluno_curso` ASC) VISIBLE;
;
ALTER TABLE `escola_curso`.`notas` 
ADD CONSTRAINT `id_aluno_curso`
  FOREIGN KEY (`id_aluno_curso`)
  REFERENCES `escola_curso`.`alunos_cursos` (`id_aluno_curso`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  #Populando as tabelas
INSERT INTO cursos
VALUES 
  (DEFAULT, "Codeignater"),
  (DEFAULT, "Python"),
  (DEFAULT, "MySQL");
  
INSERT INTO alunos_cursos
VALUES
 (DEFAULT,1,1), -- 1
 (DEFAULT,1,2), -- 2
 (DEFAULT,2,1), -- 3
 (DEFAULT,2,1), -- 4
 (DEFAULT,3,1), -- 5
 (DEFAULT,3,2), -- 6
 (DEFAULT,4,1), -- 7  
 (DEFAULT,5,1); -- 8

#alterando a ordem das colunas da tabela notas para que o id_aluno_curso venha na segunda posição no schema.
 ALTER TABLE `escola_curso`.`notas` 
CHANGE COLUMN `id_aluno_curso` `id_aluno_curso` INT NOT NULL AFTER `id_nota`;

INSERT INTO notas
VALUES
 (DEFAULT,1,'Prova 1',28.00),   
 (DEFAULT,3,'Prova 1',25.00),  
 (DEFAULT,5,'Prova 1',28.00),  
 (DEFAULT,2,'Exercicio 1',10.00),  
 (DEFAULT,6,'Exercicio 2',12.00),  
 (DEFAULT,1,'Prova 2',22.00),  
 (DEFAULT,2,'Prova 2',20.00);
 
 
#Exercicios com tabelas

SELECT * FROM alunos;
SELECT * FROM alunos_cursos;
 
 
 #trazendo nome do aluno, curso, atividades e notas
SELECT  A.nome,C.nome, N.descricao_atividade, N.vlr_nota
FROM alunos A, 
	 cursos C,
     alunos_cursos AC,
     notas N
WHERE A.id_aluno = AC.id_aluno 
	AND C.id_curso = AC.id_curso 
	AND AC.id_aluno_curso = N.id_aluno_curso
    
    




