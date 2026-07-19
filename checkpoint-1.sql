--1)Bütün müştəriləri göstər
select * from Customers;

--Customers cədvəlindən bütün müştərilərin CompanyName, ContactName və City sütunlarını göstər
select CompanyName, ContactName, City
from Customers;

--2)Yalnız Kanadadakı müştəriləri göstər
select * from Customers
where Country = 'Canada';

--Products cədvəlindən qiyməti 35-dən böyük olan məhsulların ProductName və UnitPrice sütunlarını göstər
select ProductName, UnitPrice
from Products
where UnitPrice > 35;

--3)Products cədvəlindəki bütün məhsulları UnitPrice sütununa görə azalan qaydada sırala
select * from Products
order by UnitPrice DESC;

--4)Products cədvəlindən qiyməti 10-dan böyük olan məhsulları qiymətə görə azalan sırala və yalnız ilk 7 məhsulu göstər
select *
from Products
where UnitPrice > 10
order by UnitPrice DESC
limit 7;

--5)Customers cədvəlindən yalnız Berlin şəhərində yerləşən müştərilərin CompanyName, City və Country sütunlarını göstər
select CompanyName, City, Country
from Customers
where City = 'Berlin';
