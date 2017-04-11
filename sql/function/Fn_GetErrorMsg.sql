
IF OBJECT_ID('dbo.Fn_GetErrorMsg') IS NOT NULL
  DROP FUNCTION Fn_GetErrorMsg
GO

create function dbo.Fn_GetErrorMsg(@NoError int)
returns varchar(255)
as
begin
	declare @strError varchar(255)
	if @NoError>50000
		select @strError = FR_DESC from dbo.CONF_ERROR where NO_ERROR = @NoError

	return @strError
end

GO