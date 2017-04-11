IF OBJECT_ID('dbo.TR_MSG_HISTORY_LOG_MSG_MODIFY') IS NOT NULL
  DROP TRIGGER TR_MSG_HISTORY_LOG_MSG_MODIFY
GO

create trigger TR_MSG_HISTORY_LOG_MSG_MODIFY on MSG_HISTORY_LOG_MSG
for insert,update
as

if not update(DATE_CREATED) and not update(USER_CREATED) and not update(DATE_MODIFY) and not update(USER_MODIFY)
begin
	update a
	set DATE_MODIFY = getdate(),
		USER_MODIFY = dbo.Fn_GetConnectedUsername()
	from MSG_HISTORY_LOG_MSG a
	join inserted b on a.ID_MSG_HISTORY_LOG_MSG = b.ID_MSG_HISTORY_LOG_MSG
end
return
GO