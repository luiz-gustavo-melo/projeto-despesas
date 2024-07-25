USE Despesas
GO

-- verificando se a tb j� existe;
IF NOT EXISTS ( SELECT name
				FROM sys.tables
				WHERE name= 'Usuarios')

-- criando tb 'Usuarios'
BEGIN
	CREATE TABLE Usuarios (
		ID_USUARIOS INT IDENTITY(1,1)	NOT NULL CONSTRAINT [PK_USUARIOS] PRIMARY KEY CLUSTERED,
		NOME_USUARIO VARCHAR(50)		NOT NULL,
		EMAIL VARCHAR(50)				NOT NULL,
		SENHA VARCHAR(30)				NOT NULL)
END;


/*
-- testando cria��o da tabela
SELECT * FROM Usuarios

-- verficando informa��es gerais
SP_HELP 'Usuarios'

DROP TABLE IF EXISTS Usuarios

*/