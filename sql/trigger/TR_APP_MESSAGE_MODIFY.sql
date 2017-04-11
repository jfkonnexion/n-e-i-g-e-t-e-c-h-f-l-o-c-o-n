IF OBJECT_ID('dbo.TR_APP_MESSAGE_MODIFY') IS NOT NULL
  DROP TRIGGER TR_APP_MESSAGE_MODIFY
GO

create trigger TR_APP_MESSAGE_MODIFY on APP_MESSAGE
for insert,update
as

if not update(DATE_CREATED) and not update(USER_CREATED) and not update(DATE_MODIFY) and not update(USER_MODIFY)
begin
	update a
	set DATE_MODIFY = getdate(),
		USER_MODIFY = dbo.Fn_GetConnectedUsername()
	from APP_MESSAGE a
	join inserted b on a.ID_APP_MESSAGE = b.ID_APP_MESSAGE
end
return
GO