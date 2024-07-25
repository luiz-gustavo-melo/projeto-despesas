USE Despesas
GO 

-- verificando se a tb já existe;
IF NOT EXISTS ( SELECT name
				FROM sys.tables
				WHERE name = 'Atividades')

-- criando tb 'ReceitasFixas'
BEGIN
	CREATE TABLE Atividades (
		ID_ATIVIDADES INT IDENTITY(1,1) NOT NULL CONSTRAINT [PK_ATIVIDADES] PRIMARY KEY CLUSTERED,
		FK_USUARIOS INT					NOT NULL,
		DATA DATETIME					NOT NULL,
		ACAO VARCHAR(10)				NOT NULL,
		ANTES VARCHAR(MAX)				NOT NULL,
		DEPOIS VARCHAR(MAX)				NOT NULL)

		-- criando chave primaria(FK_USUARIOS);
		ALTER TABLE Atividades WITH NOCHECK
		ADD CONSTRAINT FK_USUARIOS_ATIVIDADES
		FOREIGN KEY (FK_USUARIOS) REFERENCES Usuarios(ID_USUARIOS)
		
		ON DELETE CASCADE
END;

/*
-- testando criação da tabela
SELECT * FROM Atividades


-- verficando informações gerais
SP_HELP 'Atividades'

DROP TABLE IF EXISTS Atividades
*/