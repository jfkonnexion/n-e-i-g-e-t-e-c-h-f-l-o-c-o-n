IF OBJECT_ID('dbo.TR_MSG_HISTORY_MODIFY') IS NOT NULL
  DROP TRIGGER TR_MSG_HISTORY_MODIFY
GO

create trigger TR_MSG_HISTORY_MODIFY on MSG_HISTORY
for insert,update
as

if not update(DATE_CREATED) and not update(USER_CREATED) and not update(DATE_MODIFY) and not update(USER_MODIFY)
begin
	update a
	set DATE_MODIFY = getdate(),
		USER_MODIFY = dbo.Fn_GetConnectedUsername()
	from MSG_HISTORY a
	join inserted b on a.ID_MSG_HISTORY = b.ID_MSG_HISTORY
end
return
GO


