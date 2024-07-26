USE Despesas
GO 

-- verificando se a tb já existe;
IF NOT EXISTS ( SELECT name
				FROM sys.tables
				WHERE name = 'ReceitasFixas')

-- criando tb 'ReceitasFixas'
BEGIN
	CREATE TABLE ReceitasFixas (
		ID_RECEITAS_FIXAS INT IDENTITY(1,1) NOT NULL CONSTRAINT [PK_RECEITAS_FIXAS] PRIMARY KEY CLUSTERED,
		FK_USUARIOS INT						NOT NULL,
		FK_CONTAS INT						NOT NULL,
		DESCRICAO VARCHAR(150)				NOT NULL,
		VALOR NUMERIC(18,2)					NOT NULL,
		DATA_VENCIMENTO DATETIME			NOT NULL,
		DETALHES VARCHAR(MAX)				NULL)

	-- criando chave primaria(FK_USUARIOS);
	ALTER TABLE ReceitasFixas WITH NOCHECK
	ADD CONSTRAINT FK_USUARIOS_RECEITAS_FIXAS
	FOREIGN KEY (FK_USUARIOS) REFERENCES Usuarios(ID_USUARIOS)
	
	-- NO ACTION: ação padrão do banco quando houver delete/update, não irá permitir quando existir o vínculo(PK <-> FK);
	-- CASCADE: quando houver delete/update na dimensão irá atualizar todas as tabelas automaticamente;
	ON DELETE CASCADE
	ON UPDATE NO ACTION

	-- criando chave primaria(FK_CONTAS);
	ALTER TABLE ReceitasFixas WITH NOCHECK
	ADD CONSTRAINT FK_CONTAS_RECEITAS_FIXAS
	FOREIGN KEY (FK_CONTAS) REFERENCES Contas(ID_CONTAS)
END;



/*
-- testando criação da tabela
SELECT * FROM ReceitasFixas


-- verficando informações gerais
SP_HELP 'ReceitasFixas'

DROP TABLE IF EXISTS ReceitasFixas
*/

-------------------------------------------------------------------------------------------------------------------------
-- verificando se a tb criado já existe;
IF NOT EXISTS ( SELECT name
				FROM sys.tables
				WHERE name= 'RECEITAS')

-- criando tb 'RECEITAS'
BEGIN
	CREATE TABLE Receitas (
		ID_RECEITAS INT IDENTITY(1,1)	NOT NULL CONSTRAINT [PK_RECEITAS] PRIMARY KEY CLUSTERED,
		FK_USUARIOS INT					NOT NULL,
		FK_RECEITAS INT					NULL,
		FK_RECEITAS_FIXAS INT			NULL,
		FK_CONTAS INT					NOT NULL,
		DESCRICAO VARCHAR(150)			NOT NULL,
		VALOR NUMERIC(18,2)				NOT NULL,
		DATA_VENCIMENTO DATETIME		NULL,
		DATA_RECEBIMENTO DATETIME		NULL,
		DETALHES VARCHAR(MAX)			NULL,
		STATUS_RECEITA INT				NOT NULL) -- 0=NãoRecebida, 1=Reecebida e 2=FixaExcluída

		-- criando chave primaria(FK_USUARIOS);
		ALTER TABLE Receitas WITH NOCHECK
		ADD CONSTRAINT FK_USUARIOS_RECEITAS
		FOREIGN KEY (FK_USUARIOS) REFERENCES Usuarios(ID_USUARIOS)

		ON DELETE CASCADE

		-- criando chave primaria(FK_RECEITAS);
		ALTER TABLE Receitas WITH NOCHECK
		ADD CONSTRAINT FK_RECEITAS_RECEITAS
		FOREIGN KEY (FK_RECEITAS) REFERENCES RECEITAS(ID_RECEITAS)

		-- criando chave primaria(FK_RECEITAS_FIXAS);
		ALTER TABLE Receitas WITH NOCHECK
		ADD CONSTRAINT FK_RECEITAS_FIXAS
		FOREIGN KEY (FK_RECEITAS_FIXAS) REFERENCES ReceitasFixas(ID_RECEITAS_FIXAS)

		-- criando chave primaria(FK_CONTAS);
		ALTER TABLE Receitas WITH NOCHECK
		ADD CONSTRAINT FK_CONTAS_RECEITAS
		FOREIGN KEY (FK_CONTAS) REFERENCES Contas(ID_CONTAS)

END;


/*
-- testando criação da tabela
SELECT * FROM Receitas

-- verficando informações gerais
SP_HELP 'Receitas'

DROP TABLE IF EXISTS Receitas
*/