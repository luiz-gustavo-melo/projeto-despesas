USE Despesas 
GO

CREATE PROCEDURE sp_SalvarContas @ID_CONTAS INT, @FK_USUARIOS INT, @NOME VARCHAR(30), @ICONE INT
AS

BEGIN TRY
	IF (@ID_CONTAS = 0)
	BEGIN 
		INSERT [dbo].[Contas](FK_USUARIOS, NOME, ICONE)
		SELECT @FK_USUARIOS, @NOME, @ICONE

		-- irá retornar a última PK inserida;
		SET @ID_CONTAS = SCOPE_IDENTITY()
	END 
ELSE 
	BEGIN
		UPDATE Contas
		SET NOME = @NOME, ICONE = @ICONE
		WHERE (ID_CONTAS = @ID_CONTAS)
	END

END TRY

-- tratando erros;
BEGIN CATCH
	DECLARE @ERRO_COMPLETO VARCHAR(2000)

	SET @ERRO_COMPLETO = CONCAT(
		'Número do Erro: ',			ERROR_NUMBER(),			CHAR(13),
		'Descrição do Erro: ',		ERROR_MESSAGE(),		CHAR(13),
		'Severidade do Erro: ',		ERROR_SEVERITY(),		CHAR(13),
		'Nome do procedimento: ',	ERROR_PROCEDURE(),		CHAR(13),
		'Linha do Error: ',			ERROR_LINE(),			CHAR(13))

		DECLARE @ESTADO INT = ERROR_STATE();

	THROW 50000, @ERRO_COMPLETO, @ESTADO
END CATCH


/*
Testando procedure: 

EXEC sp_SalvarContas @ID_CONTAS = 0, @FK_USUARIOS = 1 , @NOME = 'Inter', @ICONE = 1

SELECT * FROM Usuarios
SELECT * FROM Contas

sp_help 'Contas'
*/