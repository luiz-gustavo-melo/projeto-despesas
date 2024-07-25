USE Despesas
GO 

-- verificando se a tb criado já existe;
IF NOT EXISTS ( SELECT name
				FROM sys.tables
				WHERE name= 'DespesasFixas')

-- criando tb 'Despesas_Fixas'
BEGIN
	CREATE TABLE DespesasFixas (
		ID_DESPESAS_FIXAS INT IDENTITY(1,1) NOT NULL CONSTRAINT [PK_DESPESAS_FIXAS] PRIMARY KEY CLUSTERED,
		FK_USUARIOS INT						NOT NULL,
		FK_CONTAS INT						NOT NULL,
		DESCRICAO VARCHAR(150)				NOT NULL,
		VALOR NUMERIC(18,2)					NOT NULL,
		DATA_VENCIMENTO DATETIME			NOT NULL,
		DETALHES VARCHAR(MAX)				NULL)

	-- criando chave primaria(FK_USUARIOS);
	ALTER TABLE DespesasFixas WITH NOCHECK
	ADD CONSTRAINT FK_USUARIOS_DESPESAS_FIXAS
	FOREIGN KEY (FK_USUARIOS) REFERENCES Usuarios(ID_USUARIOS)
	
	-- NO ACTION: ação padrão do banco quando houver delete/update, não irá permitir quando existir o vínculo(PK <-> FK);
	-- CASCADE: quando houver delete/update na dimensão irá atualizar todas as tabelas automaticamente;
	ON DELETE CASCADE
	ON UPDATE NO ACTION

	-- criando chave primaria(FK_CONTAS);
	ALTER TABLE DespesasFixas WITH NOCHECK
	ADD CONSTRAINT FK_CONTAS_DESPESAS_FIXAS
	FOREIGN KEY (FK_CONTAS) REFERENCES Contas (ID_CONTAS)
END;



/*
-- testando criação da tabela
SELECT * FROM DespesasFixas


-- verficando informações gerais
SP_HELP 'DespesasFixas'

DROP TABLE IF EXISTS DespesasFixas
*/

-------------------------------------------------------------------------------------------------------------------------
-- verificando se a tb criado já existe;
IF NOT EXISTS ( SELECT name
				FROM sys.tables
				WHERE name= 'Despesas')

-- criando tb 'Despesas'
BEGIN
	CREATE TABLE Despesas (
		ID_DESPESAS INT IDENTITY(1,1)	NOT NULL CONSTRAINT [PK_DESPESAS] PRIMARY KEY CLUSTERED,
		FK_USUARIOS INT					NOT NULL,
		FK_DESPESAS INT					NULL,
		FK_DESPESAS_FIXAS INT			NULL,
		FK_CONTAS INT					NOT NULL,
		DESCRICAO VARCHAR(150)			NOT NULL,
		VALOR NUMERIC(18,2)				NOT NULL,
		DATA_VENCIMENTO DATETIME		NULL,
		DATA_PAGAMENTO DATETIME			NULL,
		DETALHES VARCHAR(MAX)			NULL,
		STATUS_DESPESA INT				NOT NULL)

		-- criando chave primaria(FK_USUARIOS);
		ALTER TABLE Despesas WITH NOCHECK
		ADD CONSTRAINT FK_USUARIOS_DESPESAS
		FOREIGN KEY (FK_USUARIOS) REFERENCES Usuarios (ID_USUARIOS)

		ON DELETE CASCADE

		-- criando chave primaria(FK_DESPESAS);
		ALTER TABLE Despesas WITH NOCHECK
		ADD CONSTRAINT FK_DESPESAS_DESPESAS
		FOREIGN KEY (FK_DESPESAS) REFERENCES Despesas(ID_DESPESAS)

		-- criando chave primaria(FK_DESPESAS_FIXAS);
		ALTER TABLE Despesas WITH NOCHECK
		ADD CONSTRAINT FK_DESPESAS_FIXAS
		FOREIGN KEY (FK_DESPESAS_FIXAS) REFERENCES DespesasFixas(ID_DESPESAS_FIXAS)

		-- criando chave primaria(FK_CONTAS);
		ALTER TABLE Despesas WITH NOCHECK
		ADD CONSTRAINT FK_CONTAS_DESPESAS
		FOREIGN KEY (FK_CONTAS) REFERENCES Contas(ID_CONTAS)

END;


/*
-- testando criação da tabela
SELECT * FROM Despesas

-- verficando informações gerais
SP_HELP 'Despesas'

DROP TABLE IF EXISTS Despesas
*/