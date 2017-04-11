IF OBJECT_ID('dbo.TR_COMP_ZONE_MODIFY') IS NOT NULL
  DROP TRIGGER TR_COMP_ZONE_MODIFY
GO

create trigger TR_COMP_ZONE_MODIFY on COMP_ZONE
for insert,update
as

if not update(DATE_CREATED) and not update(USER_CREATED) and not update(DATE_MODIFY) and not update(USER_MODIFY)
begin
	update a
	set DATE_MODIFY = getdate(),
		USER_MODIFY = dbo.Fn_GetConnectedUsername()
	from COMP_ZONE a
	join inserted b on a.ID_COMP_ZONE = b.ID_COMP_ZONE
end
return
GO