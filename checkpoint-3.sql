--Sual. Müştərilərin yerləşdiyi ölkələr üzrə neçə müştəri olduğunu göstərin. 
--Nəticədə ölkə adı və həmin ölkədəki müştəri sayı göstərilsin. Müştəri sayına görə azalan sırada göstərin.

select Country, count(CustomerID) as CustomerCount
from Customers
group by Country
order by CustomerCount desc;

--Burada Customers cədvəlində ölkələr üzrə müştəri sayını COUNT() ilə hesablandım.
--GROUP BY ilə ölkələr qruplaşdırdım və nəticəni müştəri sayına görə azalan qaydada sıraladım.

--Sual. Hər sifariş üzrə sifariş olunan məhsulların ümumi sayını hesablayın. Nəticədə sifariş nömrəsi və ümumi sifariş miqdarı göstərilsin. 
--Ən çox məhsul sifariş edilən sifarişlər yuxarıda olsun.

select OrderID, sum(Quantity) as Total
from [Order Details]
group by OrderID
order by Total desc;

--Burada Order Details cədvəlində hər sifariş üzrə məhsul miqdarı SUM() ilə hesabladım.GROUP BY ilə sifarişləri qruplaşdırdım 
--və nəticəni ümumi miqdara görə azalan sırayla sıraladım.

--Sual. 5-dən çox məhsulu olan kateqoriyaları göstərin. Nəticədə kateqoriya adı və məhsul sayı göstərilsin. 
--Məhsul sayına görə azalan sırada sıralayın.

select c.CategoryName, count(p.ProductID) as ProductCount
from Categories c
join Products p on p.CategoryID = c.CategoryID
group by c.CategoryName
having count(p.ProductID) > 5
order by ProductCount desc;

--Burada Categories və Products cədvəllərini JOIN etdim. GROUP BY ilə kateqoriyalar üzrə qruplaşdırdım.COUNT() ilə hər kateqoriyadakı məhsul sayını hesabladım.
--HAVING ilə 5-dən çox məhsulu olan kateqoriyaları seçdim.

--Sual. Hər müştərinin sifariş etdiyi ümumi məhsul miqdarını hesablayın. Nəticədə müştərinin adı və sifariş etdiyi ümumi məhsul sayı göstərilsin. 
--Yalnız ümumi məhsul sayı 100-dən çox olan müştərilər göstərilsin. Nəticəni ümumi məhsul sayına görə azalan sırada göstərin.

select c.ContactName, 
	   sum(od.Quantity) as TotalProductCount
from Customers c
join Orders o on o.CustomerID = c.CustomerID
join [Order Details] od on od.OrderID = o.OrderID
group by c.ContactName
having sum(od.Quantity) > 100
order by TotalProductCount desc;

--Burada Customers, Orders və Order Details cədvəllərini JOIN etdim. SUM() ilə hər müştərinin sifariş etdiyi ümumi məhsul miqdarını hesabladım.
--HAVING ilə ümumi məhsul miqdarı 100-dən çox olan müştəriləri seçdim.

--Sual. Hər ay üzrə ümumi satış məbləğini hesablayın. Nəticədə ay və ümumi satış məbləği göstərilsin. Nəticəni ay üzrə artan qaydada sıralayın.
--Oracle SQL sintaksisi ilə.
select extract(month from o.OrderDate) as OrderMonth,
       sum(od.UnitPrice * od.Quantity) as TotalSales
from Orders o
join OrderDetails od on o.OrderID = od.OrderID
group by extract(month from o.OrderDate)
order by OrderMonth;

--Queryni Oracle SQL sintaksisi ile yazmışam. Burada Orders və OrderDetails cədvəllərini JOIN etdim. 
--EXTRACT() funksiyası ilə sifariş tarixindən ayı götürdüm. SUM() ilə hər ay üzrə ümumi satış məbləğini hesabladım.
--GROUP BY ilə aylar üzrə qruplaşdırdım və nəticəni artan sırayla sıraladım.
