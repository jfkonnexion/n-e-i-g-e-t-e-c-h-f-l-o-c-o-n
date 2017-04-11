IF OBJECT_ID('dbo.TR_MSG_MESSAGE_MODIFY') IS NOT NULL
  DROP TRIGGER TR_MSG_MESSAGE_MODIFY
GO

create trigger TR_MSG_MESSAGE_MODIFY on MSG_MESSAGE
for insert,update
as

if not update(DATE_CREATED) and not update(USER_CREATED) and not update(DATE_MODIFY) and not update(USER_MODIFY)
begin
	update a
	set DATE_MODIFY = getdate(),
		USER_MODIFY = dbo.Fn_GetConnectedUsername()
	from MSG_MESSAGE a
	join inserted b on a.ID_MSG_MESSAGE = b.ID_MSG_MESSAGE
end
return
GO
