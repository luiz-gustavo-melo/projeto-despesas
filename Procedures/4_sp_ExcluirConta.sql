USE Despesas
GO

CREATE PROCEDURE sp_ExcluirConta @ID_CONTAS INT
AS

BEGIN TRY
	DECLARE @RETORNO VARCHAR(20)

	-- validando se h� despesa vinculada na conta que ser� exclu�da;
	IF EXISTS(SELECT 1 FROM [dbo].[Despesas] WHERE (FK_CONTAS = @ID_CONTAS))
		BEGIN
			SET @RETORNO = 'DespesaVinculada'
		END

	ELSE IF EXISTS(SELECT 1 FROM [dbo].[DespesasFixas] WHERE (FK_CONTAS = @ID_CONTAS))
		BEGIN
			SET @RETORNO = 'DespesaVinculada'
		END

	--validando se h� receita vinculada na conta que ser� exclu�da;
	ELSE IF EXISTS(SELECT 1 FROM [dbo].[Receitas] WHERE (FK_CONTAS = @ID_CONTAS))
		BEGIN
			SET @RETORNO = 'ReceitaVinculada'
		END
	
	ELSE IF EXISTS (SELECT 1 FROM [dbo].[ReceitasFixas] WHERE (FK_CONTAS = @ID_CONTAS))
		BEGIN
			SET @RETORNO = 'ReceitaVinculada'
		END

	-- validando quando n�o existe o registro passado no par�metro @id_contas;
	ELSE IF NOT EXISTS(SELECT 1 FROM [Despesas].[dbo].[Contas] WHERE ID_CONTAS = @ID_CONTAS) 
		BEGIN
			SET @RETORNO = 'RegistroVazio'
		END

	-- deletando a conta ap�s valida��es de vinculo em despesas, receitas e se o registro existe;
	ELSE
		BEGIN
			DELETE [dbo].[Contas]
			WHERE (ID_CONTAS = @ID_CONTAS)

		SET @RETORNO = 'RegistroExclu�do'
		END

	SELECT @RETORNO AS Retorno
END TRY

-- tratando erros;
BEGIN CATCH
	DECLARE @ERRO_COMPLETO VARCHAR(2000)

	SET @ERRO_COMPLETO = CONCAT(
		'N�mero do Erro: ',			ERROR_NUMBER(),			CHAR(13),
		'Descri��o do Erro: ',		ERROR_MESSAGE(),		CHAR(13),
		'Severidade do Erro: ',		ERROR_SEVERITY(),		CHAR(13),
		'Nome do procedimento: ',	ERROR_PROCEDURE(),		CHAR(13),
		'Linha do Error: ',			ERROR_LINE(),			CHAR(13))

	DECLARE @ESTADO INT = ERROR_STATE();

	THROW 50000, @ERRO_COMPLETO, @ESTADO
END CATCH


/*
Testando procedure:

EXEC sp_ExcluirConta @ID_CONTAS = 6

SELECT * FROM [dbo].[Contas]
*/