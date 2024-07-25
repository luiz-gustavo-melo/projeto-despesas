USE Despesas
GO 

-- verificando se a tb já existe;
IF NOT EXISTS ( SELECT name
				FROM sys.tables
				WHERE name= 'Contas')

-- criando tb 'Contas';
BEGIN
	CREATE TABLE Contas (
		ID_CONTAS INT IDENTITY(1,1) NOT NULL CONSTRAINT[PK_CONTAS] PRIMARY KEY CLUSTERED,
		FK_USUARIOS INT				NOT NULL,
		NOME VARCHAR(30)			NOT NULL,
		ICONE INT					NOT NULL)

	-- criando chave primaria(FK_USUARIOS);
	ALTER TABLE Contas WITH CHECK
	ADD CONSTRAINT FK_CONTAS_USUARIOS
	FOREIGN KEY (FK_USUARIOS) REFERENCES Usuarios(ID_USUARIOS)

	-- se houver um delete/update na tb 'Usuario' o mesmo irá acontecer na tb 'Contas';
	ON DELETE CASCADE
	ON UPDATE CASCADE
END;


/*
-- testando criação da tabela
SELECT * FROM Contas

-- verficando informações gerais
SP_HELP 'Contas'

DROP TABLE IF EXISTS Contas
*/