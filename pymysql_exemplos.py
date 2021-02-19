# -*- coding: utf-8 -*-
"""
Created on Thu Feb 18 13:24:01 2021

@author: Mateus Paape
"""

import pymysql

host = "localhost"
user = "aplicacao"
password = "123456"
db = "escola_curso"
 

#fazendo a conexão com o Banco.


con = pymysql.connect(host=host,
                             user=user,
                             password=password,
                             database=db,
                             charset='utf8mb4')


#criando função para fazer um select no banco

c = con.cursor()


def select(fields, tables, where=None):
    global c # indica que o c é a variavel definida fora da função
    
    query = "SELECT " + fields + " FROM " + tables
    if (where): # se where for diferente de none entra no if
        query = query + " WHERE " + where
         
    c.execute(query)
    return c.fetchall() # busca todas as linhas da tabela 
    
    
result = select("nome,cpf","alunos","id_aluno = 2")

print(result)
'''
(('Mateus Magnus P. Paape', '22345678911'),)
'''
 

def insert (values, table, fields=None):
    global c, con
    # comando no sql seria :
    # INSERT INTO <TABLE> (fields) VALUES (),(),()
    query = "INSERT INTO " + table 
    if (fields):
        query = query + " (" + fields + ") "
    query = query + " VALUES " + ",".join(["(" + v + ")" for v in values]) #lista interativa
    #print(query)
    c.execute(query)
    con.commit()
 
 # exemplo (DEFAULT,'Maria Beatriz','1980-01-03','AV Carlos Antonio, 111','RIO DE JANEIRO','RJ','12345678944')   
    
values = ["DEFAULT,'João pedro','2000-01-01','AV pedras, 123','Betim','MG','1234567897'",
         "DEFAULT,'maria pedro','2000-01-01','AV pedras, 123','Betim','MG','1234567898'"]
    
insert(values,"alunos")

#conferindo

print( select("*","alunos") )


def update(sets, table, where= None):
    #exemplo de update
    #UPDATE alunos
    #SET nome = 'Mateus Magnus P. Paape'
    #WHERE id_aluno = 2;
    
    global c , con 

    query = "UPDATE "+ table + " SET " + ",".join([field + " = '" + value + "'" for field, value in sets.items()]) #funcao .items retorna um dicionario     
    if(where):
        query = query + " WHERE " + where
     
    c.execute(query)
    con.commit()    

print( select("*","alunos","id_aluno = 1") )
''' resultado antes do update
((1, 'Pedro Martins', datetime.date(1987, 7, 17), 'AV Antonio Carlos, 6377', 'BELO HORIZONTE', 'MG', '12345678911'),)
'''

update({"nome": "João Martins","cidade":"Curitiba"},"alunos", "id_aluno = 1")

print( select("*","alunos","id_aluno = 1") )

def delete(table,where):
    #exemplo delete
    #DELETE FROM TABLE WHERE 
    
    global c, con
    query = "DELETE FROM " + table + " WHERE " + where
    c.execute(query)
    con.commit()  
    
print(select("*","alunos","id_aluno= 7"))

print(delete("alunos","id_aluno= 7"))

print(select("*","alunos","id_aluno = 7"))
