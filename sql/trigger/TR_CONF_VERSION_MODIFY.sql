create trigger TR_CONF_VERSION_MODIFY on CONF_VERSION
for insert,update
as

if not update(DATE_CREATED) and not update(USER_CREATED) and not update(DATE_MODIFY) and not update(USER_MODIFY)
begin
	update a
	set DATE_MODIFY = getdate(),
		USER_MODIFY = dbo.Fn_GetConnectedUsername()
	from CONF_VERSION a
	join inserted b on a.ID_CONF_VERSION = b.ID_CONF_VERSION
end
return
GO
