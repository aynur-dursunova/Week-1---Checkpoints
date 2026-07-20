--Hər sifarişin sifariş nömrəsini, sifarişi verən müştərinin adını, sifariş tarixini göstərin.
select 
       o.OrderID,
       c.ContactName,
	     o.OrderDate
from Orders o
join Customers c on o.CustomerID = c.CustomerID
order by o.OrderDate;

--Hər müştərinin aldığı məhsulları, yəni müştərinin adı, məhsulun adı, sifariş olunan miqdarı göstər
select c.ContactName, 
       p.ProductName, 
       od.Quantity
from Customers c
join Orders o on c.CustomerID = o.CustomerID
join [Order Details] od on o.OrderID = od.OrderID
join Products p on p.ProductID = od.ProductID;

--Londonda yerləşən bütün müştəriləri göstərin. Əgər sifariş veriblərsə: sifariş nömrəsi, məhsulun adı, qiymeti, məhsulun kateqoriyası, sifariş olunan miqdar 
--göstərilsin. Nəticəni müştərinin adına görə A-Z sıralayın.
select c.ContactName,
       o.OrderID, 
       p.ProductName, 
	     p.UnitPrice, 
	     cg.CategoryName, 
	     od.Quantity
from Customers c
left join Orders o on c.CustomerID = o.CustomerID
left join [Order Details] od on o.OrderID = od.OrderID
left join Products p on od.ProductID = p.ProductID
left join Categories cg on p.CategoryID = cg.CategoryID
where c.City = 'London'
order by c.ContactName asc;

--SELF JOIN
--Bütün işçiləri və onların rəhbərlərini göstərin. Nəticədə işçinin adı, işçinin soyadı, rəhbərinin adı və rəhbərinin soyadı göstərilsin.
--Işçinin soyadına görə A-Z sıralayın
SELECT e.FirstName as EmployeeFirstName,
       e.LastName as EmployeeLastName,
	   m.FirstName as ManagerFirstName,
	   m.LastName as ManagerLastName
from Employees e left join Employees  m
on e.ReportsTo = m.EmployeeID
order by e.FirstName asc;

--Bütün təchizatçıları göstərin. Əgər məhsulları varsa, təchizatçı şirkətin adı,məhsulun adı,
--məhsulun kateqoriyası, məhsulun sifariş olunduğu sifariş nömrəsi göstər. Yalnız USA ölkəsində yerləşən təchizatçılar göstərilsin.
select s.CompanyName, 
       p.ProductName, 
	     c.CategoryName, 
	     o.OrderID 
from Suppliers s
left join Products p on s.SupplierID = p.SupplierID
left join Categories c on p.CategoryID = c.CategoryID
left join [Order Details] od on od.ProductID = p.ProductID
left join Orders o on od.OrderID = o.OrderID
where s.Country = 'USA';
