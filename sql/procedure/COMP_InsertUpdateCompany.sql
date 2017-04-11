IF OBJECT_ID('dbo.COMP_InsertUpdateCompany') IS NOT NULL
  DROP PROCEDURE COMP_InsertUpdateCompany
GO

create procedure COMP_InsertUpdateCompany
(
	@idCompCompany int,
	@name varchar(500),
	@address varchar(500),
	@city varchar(255),
	@zipCode varchar(10),
	@phone varchar(50),
	@phone2 varchar(50),
	@country char(2) = 'CA',
	@province char(2) = 'QC'
)
as


declare @tranCount int,
		@tranName varchar(100),
		@strError varchar(255)



set @tranCount = @@TRANCOUNT 
set @tranName = 'COMP_InsertUpdateCompany'

if @tranCount > 0
	save tran @tranName
else
	begin tran
begin try
	
	if exists(select ID_COMP_COMPANY from COMP_COMPANY where ID_COMP_COMPANY != isnull(@idCompCompany, -1) and @name = NAME)
	begin
		set @strError = dbo.Fn_GetErrorMsg(50000);
		throw 50000, @strError,1 --Un fournisseur de service exite déjà sous ce nom.
	end

	if(@idCompCompany is null)
	begin
		INSERT INTO COMP_COMPANY(NAME, ADDRESS, CITY, ZIP_CODE, PROVINCE, COUNTRY, PHONE, PHONE_2)
		values (@name, @address, @city, @zipCode, @province, @country, @phone, @phone2)
	end
	else
	begin
		update COMP_COMPANY
		set NAME = @name, 
			ADDRESS = @address,
			CITY = @city,
			ZIP_CODE = @zipCode, 
			PROVINCE = @province, 
			COUNTRY = @country, 
			PHONE = @phone, 
			PHONE_2 = @phone2
			where ID_COMP_COMPANY = @idCompCompany;
	end

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
