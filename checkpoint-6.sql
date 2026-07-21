--Correlated Subquery --> JOIN
--Sual. Hər sifarişin nömrəsini və həmin sifarişi verən müştərinin adını göstərin.
-- Əvvəlcə Correlated Subquery ilə, sonra isə JOIN istifadə edərək eyni nəticəni əldə edin.

--Correlated Subquery
select 
    o.OrderID,
    (
        select c.ContactName
        from Customers c
        where c.CustomerID = o.CustomerID
    ) as ContactName
from Orders o;

--Join ilə
select
    o.OrderID,
    c.ContactName
from Orders o
join Customers c on o.CustomerID = c.CustomerID;

--Birinci sorğuda hər sifariş üçün ayrıca subquery işləyir.
--JOIN istifadə etdikdə cədvəllər bir dəfə əlaqələndirilir və query daha səmərəli işləyir.


--Sual. Hər müştərinin verdiyi sifariş sayını göstərin.
--Sorğunu əvvəlcə Correlated Subquery, sonra isə JOIN ilə yazın.

--Correlated Subquery
select
    c.ContactName,
    (
        select COUNT(*)
        from Orders o
        where o.CustomerID = c.CustomerID
    ) as OrderCount
from Customers c;

--JOIN ilə
select
    c.ContactName,
    COUNT(o.OrderID) as OrderCount
from Customers c
left join Orders o
on c.CustomerID = o.CustomerID
group by c.ContactName;

--Birinci sorğuda hər müştəri üçün ayrıca subquery işləyir.
--İkinci sorğuda isə JOIN və GROUP BY istifadə edərək sifariş sayı daha səmərəli hesablanır.


--Index anlayışı
--Sual. Customers cədvəlində Country sütunu üzrə tez-tez axtarış aparılır.
-- Bu sütun üçün indeks yaradın.

CREATE INDEX idx_customers_country
ON Customers(Country);

select *
from Customers
where Country = 'Italy';

--Country sütunu üçün INDEX yaratdım.
--İndeks axtarış zamanı bütün cədvəli oxumaq əvəzinə uyğun sətrləri daha sürətli tapmağa kömək edir.



--Sorğu optimallaşdırma verilənlər bazasında sorğuların daha sürətli və daha az resurs istifadə etməsi üçün tətbiq olunan üsullardır.

--Sorğu optimallaşdırma verilənlər bazasında sorğuların daha sürətli və daha az resurs istifadə etməsi üçün tətbiq olunan üsullardır.

--INDEX axtarış əməliyyatlarını sürətləndirir.
--JOIN bəzi hallarda Correlated Subquery-dən daha performanslı işləyir.
--CTE mürəkkəb sorğuları daha oxunaqlı və idarəolunan edir.

