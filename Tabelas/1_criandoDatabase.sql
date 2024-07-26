-- criação do database

IF NOT EXISTS ( SELECT NAME 
				FROM SYS.DATABASES 
				WHERE (NAME = 'Despesas'))

BEGIN
	CREATE DATABASE Despesas
END