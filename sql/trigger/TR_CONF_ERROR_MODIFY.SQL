IF OBJECT_ID('dbo.TR_CONF_ERROR_MODIFY') IS NOT NULL
  DROP TRIGGER TR_CONF_ERROR_MODIFY
GO

create trigger TR_CONF_ERROR_MODIFY on CONF_ERROR
for insert,update
as

if not update(DATE_CREATED) and not update(USER_CREATED) and not update(DATE_MODIFY) and not update(USER_MODIFY)
begin
	update a
	set DATE_MODIFY = getdate(),
		USER_MODIFY = dbo.Fn_GetConnectedUsername()
	from CONF_ERROR a
	join inserted b on a.ID_CONF_ERROR = b.ID_CONF_ERROR
end
return
GO
