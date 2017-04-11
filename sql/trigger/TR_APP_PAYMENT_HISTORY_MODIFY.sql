IF OBJECT_ID('dbo.TR_APP_PAYMENT_HISTORY_MODIFY') IS NOT NULL
  DROP TRIGGER TR_APP_PAYMENT_HISTORY_MODIFY
GO

create trigger TR_APP_PAYMENT_HISTORY_MODIFY on APP_PAYMENT_HISTORY
for insert,update
as

if not update(DATE_CREATED) and not update(USER_CREATED) and not update(DATE_MODIFY) and not update(USER_MODIFY)
begin
	update a
	set DATE_MODIFY = getdate(),
		USER_MODIFY = dbo.Fn_GetConnectedUsername()
	from APP_PAYMENT_HISTORY a
	join inserted b on a.ID_APP_PAYMENT_HISTORY = b.ID_APP_PAYMENT_HISTORY
end
return
GO