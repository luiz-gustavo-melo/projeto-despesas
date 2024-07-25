USE Despesas
GO

-- verificando se a tb já existe;
IF NOT EXISTS ( SELECT name
				FROM sys.tables
				WHERE name = 'Anotacoes')

-- criando tb 'Usuarios'
BEGIN
	CREATE TABLE Anotacoes (
		ID_ANOTACOES INT IDENTITY(1,1)	NOT NULL CONSTRAINT [PK_ANOTACOES] PRIMARY KEY CLUSTERED,
		FK_USUARIOS INT					NOT NULL,
		TITULO VARCHAR(100)				NOT NULL,
		DATA DATETIME					NULL,
		HORA INT						NULL,
		ENVIA_EMAIL CHAR(3)				NOT NULL,
		DETALHES VARCHAR(MAX)			NULL)

	-- criando chave primaria(FK_USUARIOS);
	ALTER TABLE Anotacoes WITH NOCHECK
	ADD CONSTRAINT FK_USUARIOS_ANOTACOES
	FOREIGN KEY (FK_USUARIOS) REFERENCES Usuarios(ID_USUARIOS)
END;


/*
-- testando criação da tabela
SELECT * FROM Anotacoes

-- verficando informações gerais
SP_HELP 'Anotacoes'

DROP TABLE IF EXISTS Anotacoes
*/