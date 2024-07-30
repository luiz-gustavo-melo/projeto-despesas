USE Despesas
GO

CREATE PROCEDURE sp_ListarContas @ID_CONTAS INT, @FK_USUARIOS INT
AS 

BEGIN TRY
	IF (@ID_CONTAS = 0)
		BEGIN
			SELECT 
				 ID_CONTAS
				,FK_USUARIOS
				,NOME
				,ICONE 	
			FROM [dbo].[Contas]
			WHERE (FK_USUARIOS = @FK_USUARIOS)
		END

	ELSE 
		BEGIN 
			SELECT 
				 ID_CONTAS
				,FK_USUARIOS
				,NOME
				,ICONE FROM [dbo].[Contas]
			WHERE (ID_CONTAS = @ID_CONTAS)
		END

END TRY

BEGIN CATCH
	DECLARE @ERRO_COMPLETO VARCHAR(2000)

	SET @ERRO_COMPLETO = CONCAT (
	'Número do erro: ', ERROR_NUMBER(), CHAR(13),
	'Descrição do erro: ', ERROR_MESSAGE(), CHAR(13),
	'Severidade do erro: ', ERROR_SEVERITY(), CHAR(13),
	'Nome do Procedimento: ', ERROR_PROCEDURE(), CHAR(13),
	'Linha do erro: ', ERROR_LINE(), CHAR(13))

	DECLARE @ESTADO INT = ERROR_STATE();

	THROW 50000, @ERRO_COMPLETO, @ESTADO
END CATCH


/*
Testando procedure: 

sp_help '[dbo].[Contas]'

EXEC sp_ListarContas @ID_CONTAS = 11, @FK_USUARIOS = 0

SELECT * FROM [dbo].[Usuarios]
SELECT * FROM [dbo].[Contas]

- inserção dados na tabela Contas
INSERT INTO [dbo].[Contas] (FK_USUARIOS, NOME, ICONE)
VALUES
	(1,'Nubank', 2),
	(1,'Itau',4),
	(2,'Itau', 6)
	(2,'C6', 8)
*/