--Sual. Məhsullar arasında orta qiymətdən baha olan məhsulları göstərin. Nəticədə məhsulun adı və qiyməti göstərilsin.

select ProductName, 
       UnitPrice
from Products
where UnitPrice > 
(
select avg(UnitPrice) 
from Products
)
order by UnitPrice desc;

--Subquery ilə Products cədvəlində orta qiyməti AVG() funksiyası ilə hesabladım. Əsas sorğuda orta qiymətdən baha olan məhsulları göstərdim.

--Sual. Ən bahalı məhsulu göstərin. Nəticədə məhsulun adı və qiyməti göstərilsin.

select ProductName,
       UnitPrice
from Products
where UnitPrice =
(
select max(UnitPrice) 
from Products
);
--Subquery ilə ən yüksək məhsul qiymətini MAX() funksiyası ilə tapdım.
--Əsas sorğuda həmin qiymətə malik məhsulu göstərdim.

--Sual. Hər müştərinin ümumi sifariş miqdarını hesablayın. Daha sonra yalnız 100-dən çox məhsul sifariş edən müştəriləri göstərin.

WITH CustomerOrders AS
(
select 
      c.ContactName,
      sum(od.Quantity) as TotalQuantity
from Customers c
join Orders o on c.CustomerID = o.CustomerID
join [Order Details] od on o.OrderID = od.OrderID
group by c.ContactName
)
select *
from CustomerOrders
where TotalQuantity > 100
order by TotalQuantity desc;

--WITH ilə CustomerOrders adlı müvəqqəti cədvəl yaratdım. Sonra həmin nəticədən istifadə edərək 100-dən çox məhsul sifariş edən müştəriləri göstərdim.

--Sual. Kateqoriyalar üzrə məhsul sayını hesablayın. Daha sonra yalnız 5-dən çox məhsulu olan kateqoriyaları göstərin.

WITH CategoryProducts AS
(
select
      c.CategoryName,
      count(p.ProductID) as ProductCount
from Categories c
join Products p on c.CategoryID = p.CategoryID
group by c.CategoryName
)

select *
from CategoryProducts
where ProductCount > 5
order by ProductCount desc;

--WITH ifadəsi ilə CategoryProducts adlı müvəqqəti nəticə cədvəli yaratdım.
--Bu cədvəldə hər kateqoriya üzrə məhsul sayını COUNT() funksiyası ilə hesabladım.
--Daha sonra əsas sorğuda məhsul sayı 5-dən çox olan kateqoriyaları seçib nəticəni azalan qaydada sıraladım.

