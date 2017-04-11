alter function dbo.Fn_GetConnectedUsername()
returns varchar(320)
as
begin
	declare @username varchar(320)
			

	set @username = SUBSTRING(APP_NAME(), charindex(']',APP_NAME(),0)+1,len(APP_NAME()))	
	if ~len(isnull(@username,''))>0
		set @username = SYSTEM_USER

	return @username
end