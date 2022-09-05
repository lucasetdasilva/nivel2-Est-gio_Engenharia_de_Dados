use Loja_Bicicletas;

alter table [dbo].[Production.Product] add constraint [Fk_SpecialOfferID] foreign key (ProductID) references [dbo].[Sales.SpecialOfferProduct](SpecialOfferID,ProductID)

alter table Sales.SpecialOfferProduct add constraint [Fk_ProductID] foreign key (SpecialOfferID) references Production.Product(ProductID);

alter table Sales.SpecialOfferProduct add constraint [Fk_SalesOrderDetail] foreign key (SpecialOfferID) references Sales.SalesOrderDetail(SalesOrderDetailID);

alter table Sales.SalesOrderDetail add constraint [Fk_SalesOrderID] foreign key (SalesOrderDetailID) references Sales.SalesOrderHeader(SalesOrderID);

alter table Sales.SalesOrderHeader add constraint [Fk_SalesOrderDetailID] foreign key (SalesOrderID) references Sales.SalesOrderDetail(SalesOrderDetailID);

alter table Sales.Customer add constraint [Fk_SalesOrderID02] foreign key (CustomerID) references Sales.SalesOrderHeader(SalesOrderID); 

alter table [dbo].[Person.Person] add constraint [Fk_CustomerID] foreign key (BusinessEntityID) references [dbo].[Sales.Customer](CustomerID);


--Exercicio1 Feito

select count(SalesOrderID) from [Sales.SalesOrderDetail] where CarrierTrackingNumber = 'NULL';


--Exercício 2 Feito

select prod.Name, sum(detail.OrderQty) from [Sales.SpecialOfferProduct] as special inner join [Production.Product] as prod on prod.Fk_SpecialOfferID = special.SpecialOfferID inner join [Sales.SalesOrderDetail] as detail on special.Fk_SalesOrderDetail = detail.SalesOrderDetailID group by prod.DaysToManufacture;

--Exercício 3 Feito

select person.FirstName, count(salesheader.SalesOrderNumber) from [Sales.Customer] as customer inner join [Person.Person] as person on person.Fk_CustomerID = customer.CustomerID inner join [Sales.SalesOrderHeader] as salesheader on customer.Fk_SalesOrderID = salesheader.SalesOrderID group by person.FirstName, salesheader.SalesOrderNumber; 

--Exercício 4 Feito
 
select sum(detail.OrderQty), detail.ProductID, orderh.OrderDate from [Sales.SalesOrderHeader] as orderh inner join [Sales.SalesOrderDetail] as detail on orderh.SalesOrderID = detail.SalesOrderID group by detail.OrderQty, detail.ProductID, orderh.OrderDate;


--Exercício 5 Feito

select SalesOrderID, OrderDate, TotalDue from [Sales.SalesOrderHeader] where OrderDate between '2011-09-01' and '2011-09-30' and TotalDue > 1000 order by TotalDue desc;
