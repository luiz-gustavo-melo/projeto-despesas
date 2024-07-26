USE Despesas
GO

CREATE PROCEDURE sp_GerarLogin @NOME_USUARIO VARCHAR(50), @EMAIL VARCHAR(50), @SENHA VARCHAR(50), @SENHA2 VARCHAR(50)
AS

BEGIN TRY
	DECLARE @RETORNO VARCHAR(20)

	-- senhas não conferem;
	IF (@SENHA COLLATE Latin1_General_CS_AS <> @SENHA2 COLLATE Latin1_General_CS_AS)
		BEGIN
			SET @RETORNO = 'SenhasDiferentes'
		END

	-- usuário existente
	ELSE IF (EXISTS (SELECT 1 FROM Usuarios WHERE (NOME_USUARIO = @NOME_USUARIO) OR (EMAIL = @EMAIL)))
		BEGIN 
			SET @RETORNO = 'UsuarioExistente'
		END

	-- cadastro novo usuário
	ELSE
		BEGIN
			INSERT Usuarios (NOME_USUARIO, EMAIL, SENHA)
			SELECT @NOME_USUARIO, @EMAIL, @SENHA
			SET @RETORNO = 'CadastroRealizado'
		END

	SELECT @RETORNO Retorno
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
EXEC sp_GerarLogin @NOME_USUARIO = 'LuizMelo', @EMAIL = 'luiz@email.com', @SENHA = 'Luiz@123', @SENHA2 ='Luiz@123'

SELECT * FROM Usuarios
*/