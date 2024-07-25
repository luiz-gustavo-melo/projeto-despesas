-- cria��o do database
USE Despesas
GO

-- cria��o da tabela usu�rios
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
-- testando cria��o da tabela
SELECT * FROM Usuarios


-- verficando informa��es gerais
SP_HELP 'Usuarios'

*/