IF OBJECT_ID('dbo.TR_COMP_CLIENT_MODIFY') IS NOT NULL
  DROP TRIGGER TR_COMP_CLIENT_MODIFY
GO

create trigger TR_COMP_CLIENT_MODIFY on COMP_CLIENT
for insert,update
as

if not update(DATE_CREATED) and not update(USER_CREATED) and not update(DATE_MODIFY) and not update(USER_MODIFY)
begin
	update a
	set DATE_MODIFY = getdate(),
		USER_MODIFY = dbo.Fn_GetConnectedUsername()
	from COMP_CLIENT a
	join inserted b on a.ID_COMP_CLIENT = b.ID_COMP_CLIENT
end
return
GO