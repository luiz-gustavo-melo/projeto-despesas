-- criação do database
USE Despesas
GO

-- criação da tabela usuários
IF NOT EXISTS ( SELECT name 
				FROM sys.tables
				WHERE name= 'Usuarios')

BEGIN 

	CREATE TABLE Usuarios (
		PK INT IDENTITY(1,1)		NOT NULL CONSTRAINT [PK_USUARIOS] PRIMARY KEY CLUSTERED,
		NOME_USUARIO VARCHAR(50)	NOT NULL,
		EMAIL VARCHAR(50)			NOT NULL,
		SENHA VARCHAR(30)			NOT NULL)

END;


/*
-- testando criação da tabela
SELECT * FROM Usuarios


-- verficando informações gerais
SP_HELP 'Usuarios'

*/