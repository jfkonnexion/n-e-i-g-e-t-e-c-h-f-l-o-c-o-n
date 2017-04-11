IF OBJECT_ID('dbo.TR_CONF_USER_ROLE_MODIFY') IS NOT NULL
  DROP TRIGGER TR_CONF_USER_ROLE_MODIFY
GO

create trigger TR_CONF_USER_ROLE_MODIFY on CONF_USER_ROLE
for insert,update
as

if not update(DATE_CREATED) and not update(USER_CREATED) and not update(DATE_MODIFY) and not update(USER_MODIFY)
begin
	update a
	set DATE_MODIFY = getdate(),
		USER_MODIFY = dbo.Fn_GetConnectedUsername()
	from CONF_USER_ROLE a
	join inserted b on a.ID_CONF_USER_ROLE = b.ID_CONF_USER_ROLE
end
return
GO