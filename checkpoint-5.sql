--Sual. Hər kateqoriyada məhsulları qiymətinə görə nömrələyin. Nəticədə kateqoriya, məhsulun adı, qiyməti və sıra nömrəsi göstərilsin.

select 
    c.CategoryName,
    p.ProductName,
    p.UnitPrice,
    ROW_NUMBER() OVER
    ( PARTITION BY c.CategoryID
        ORDER BY p.UnitPrice DESC
    ) AS RowNum
FROM Categories c
JOIN Products p
ON c.CategoryID = p.CategoryID;

--PARTITION BY ilə məhsulları kateqoriyalar üzrə qruplaşdırdım.
--ROW_NUMBER() funksiyası ilə hər kateqoriyada məhsullara qiymətinə görə sıra nömrəsi verdim.

--Sual. Məhsulları ümumi satış məbləğinə görə reytinqləndirin. Nəticədə məhsulun adı, ümumi satış məbləği və reytinqi göstərilsin.

select p.ProductName,
       SUM(od.UnitPrice * od.Quantity) as TotalSales,
	   RANK() OVER (ORDER BY SUM(od.UnitPrice * od.Quantity) DESC) AS SalesRank
from Products p
join [Order Details] od on od.ProductID = p.ProductID
group by p.ProductName;

--Products və Order Details cədvəllərini JOIN etdim. SUM() funksiyası ilə hər məhsulun ümumi satış məbləğini hesabladım.
--RANK() funksiyası ilə məhsulları ümumi satış məbləğinə görə reytinqləndirdim.

--Sual. İşçiləri qəbul etdikləri sifariş sayına görə reytinqləndirin. Nəticədə işçinin adı, sifariş sayı və reytinqi göstərilsin.

select
    e.FirstName,
    e.LastName,
    count(o.OrderID) as OrderCount,
    RANK() OVER(ORDER BY COUNT(o.OrderID) DESC) AS EmployeeRank
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
GROUP BY e.FirstName, e.LastName;

--Employees və Orders cədvəllərini JOIN etdim.
--COUNT() ilə hər işçinin qəbul etdiyi sifariş sayını hesabladım.
--RANK() ilə işçiləri sifariş sayına görə reytinqləndirdim.

--Sual. Kateqoriyaları məhsul sayına görə reytinqləndirin. Nəticədə kateqoriya adı, məhsul sayı və reytinq göstərilsin.

SELECT
    c.CategoryName,
    COUNT(p.ProductID) AS ProductCount,
    DENSE_RANK() OVER
    (
        ORDER BY COUNT(p.ProductID) DESC
    ) AS CategoryRank
FROM Categories c
JOIN Products p
ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryName;

--Categories və Products cədvəllərini JOIN etdim.
--COUNT() funksiyası ilə hər kateqoriyadakı məhsul sayını hesabladım.
--DENSE_RANK() ilə kateqoriyaları məhsul sayına görə reytinqləndirdim.

--Sual. Hər sifarişin satış məbləğini hesablayın. Daha sonra sifariş tarixinə görə yığılan (running total) ümumi satış məbləğini göstərin. 
--Nəticədə sifariş tarixi, satış məbləği və yığılan ümumi satış məbləği göstərilsin.

SELECT
    o.OrderDate,
    od.UnitPrice * od.Quantity AS SaleAmount,
    SUM(od.UnitPrice * od.Quantity)
        OVER (ORDER BY o.OrderDate) AS RunningTotal
FROM Orders o
JOIN [Order Details] od
ON o.OrderID = od.OrderID
ORDER BY o.OrderDate;

--Orders və Order Details cədvəllərini JOIN etdim.
--Hər sifariş üzrə satış məbləğini hesabladım.
--SUM() OVER() funksiyası ilə tarixə görə yığılan ümumi satış məbləğini (Running Total) hesabladım.
