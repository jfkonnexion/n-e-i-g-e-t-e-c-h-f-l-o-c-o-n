create procedure SCHE_InsertUpdateAbsence
(
	@idAbsence int,
	@idComCompanyUser int,
	@description varchar(255),
	@timeStart time,
	@timeStop time,
	@date date
)
as


declare @tranCount int,
		@tranName varchar(100),
		@strError varchar(255)



set @tranCount = @@TRANCOUNT 
set @tranName = 'SCHE_InsertUpdateAbsence'

if @tranCount > 0
	save tran @tranName
else
	begin tran
begin try
	
	if @tranCount = 0
		commit tran
end try
begin catch
	if @tranCount = 0
		rollback tran
	else  if XACT_STATE() != -1
		ROLLBACK tran @tranName;
				
	throw 
end catch
go
