--Challenge 1
CREATE SCHEMA Reports;
GO

create procedure Reports.GetProductColors 
as
select distinct Color
from SalesLT.Product
where Color is not null

exec Reports.GetProductColors 

--Challenge 1
drop procedure Reports.GetProductsAndModels
create procedure Reports.GetProductsAndModels
as
select SalesLT.Product.ProductID,SalesLT.Product.Name,SalesLT.Product.ProductNumber,SalesLT.Product.SellStartDate,SalesLT.Product.SellEndDate,SalesLT.Product.Color,  SalesLT.ProductModel.ProductModelID,  SalesLT.ProductDescription.Description 
from  SalesLT.Product,  SalesLT.ProductModel,  SalesLT.ProductDescription
where SalesLT.Product.ProductModelID=SalesLT.ProductModel.ProductModelID  and  SalesLT.ProductModel.ModifiedDate =  SalesLT.ProductDescription.ModifiedDate
order by SalesLT.Product.ProductID, SalesLT.ProductModel.ProductModelID

exec Reports.GetProductsAndModels

--Challenge2
drop proc  Reports.GetProductsByColor
create proc Reports.GetProductsByColor @Color nvarchar(20)
as 
select ProductID, Name, ListPrice as Price, Color, Size
from SalesLT.Product
where  Color=@Color
if exists(select ProductID, Name, ListPrice as Price, Color, Size from SalesLT.Product where @Color is null)
begin 
   select ProductID, Name, ListPrice as Price, Color, Size from SalesLT.Product where Color is Null
end
order by SalesLT.Product.Name;

exec Reports.GetProductsByColor