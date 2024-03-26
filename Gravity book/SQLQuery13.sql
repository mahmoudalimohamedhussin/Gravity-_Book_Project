insert INTO dbo.Dim_Book
(
 BookID_BK,
 Title,
 ISBN13,
 language,
 NumPage,
 Publisher,
 Start_Date,
 End_Date,
 IS_Current
)
SELECT 
    b.book_id AS BookID_BK,
    b.title AS Title,
    b.isbn13 AS Isbn13,
	bl.language_name AS LanguageName,
	b.num_pages AS NUMofPages,
    p.publisher_name AS PublisherName,
    GETDATE() AS StartDate,
    NULL AS EndDate,
    1 AS IsCurrent
FROM 
    gravity_books1.dbo.book b
JOIN 
    gravity_books1.dbo.book_language bl ON b.language_id = bl.language_id
JOIN 
    gravity_books1.dbo.publisher p ON b.publisher_id = p.publisher_id


GO
INSERT INTO Dim_Customer(
	CustomerID_Bk,
	First_name,
	last_name,
	Email,
	StreetName,
	City,
	Country,
	Start_Date,
	End_Date,
	IScurrent
)
SELECT
c.customer_id,
first_name,
last_name,
email,
street_name,
city,
country_name,
GETDATE() AS StartDate,
NULL AS EndDate,
1 AS IsCurrent
from
	gravity_books1.dbo.customer C 
	inner join gravity_books1.dbo.Customer_address ca
	ON ca.[customer_id]=c.[customer_id]
	inner join gravity_books1.dbo.address A
	On a.[address_id]=ca.[address_id]
	inner join gravity_books1.dbo.Country Co
	on co.[country_id]=a.[country_id]
GO

INSERT INTO Dim_Shipping_Method(
ShippingMethodID_BK,
MethodName,
Start_Date,
End_Date,
Iscurrent
)
SELECT
[method_id],
[method_name],
GETDATE() AS StartDate,
NULL AS EndDate,
1 AS IsCurrent
from gravity_books1.dbo.shipping_method

GO
INSERT INTO Fact_Order(
OrderID_bk,
FK_BookID,
FK_CustomerID,
FK_ShippingMetohdID,
created_at,
OrderPrice,
MethodCost,
TotalPrice,

)
select
		book.book_id,
		[customer_id],
		[method_id],
		GETDATE() AS [created_at],
		[price],
		[cost],
		[price]+[cost] as Totalprice,
		[order_date]
from gravity_books1.dbo.[order_line],
	gravity_books1.dbo.[book],
	gravity_books1.dbo.[cust_order],
	gravity_books1.dbo.shipping_method,
	Dim_book b
WHERE 
	cust_order.order_id=order_line.order_id 
	and book.book_id=order_line.book_id
	and shipping_method_id=method_id
	and b.BookID_BK=order_line.order_id


-----
SELECT
    book.book_id,
    cust_order.customer_id,
    order_line.order_id,
    GETDATE() AS created_at,
    order_line.price,
   [price]+[cost] as Totalprice,
    cust_order.order_date
FROM
    gravity_books1.dbo.order_line 
JOIN
    gravity_books1.dbo.book ON book.book_id = order_line.book_id
JOIN
    gravity_books1.dbo.cust_order ON cust_order.order_id = order_line.order_id
JOIN
    gravity_books1.dbo.shipping_method ON shipping_method_id=method_id
JOIN
    Dim_book b ON b.BookID_BK = order_line.book_id;
where order_id > 
and order_date >=
and order_date <

		
GO
insert INTO Author(
authorID_BK,
author,
Start_Date,
End_Date,
Iscurrent
)
SELECT
	author_id,
	author_name,
	GETDATE() AS StartDate,
	NULL AS EndDate,
	1 AS IsCurrent
from gravity_books1.dbo.author 

GO
SET IDENTITY_INSERT book_author ON
insert INTO book_author(

authorFK,
BookFK
)
SELECT
authorID_SK,
BookID_SK
FROM Dim_book,
dbo.Author,gravity_books1.dbo.book_author
	where
		BookID_BK=book_id and authorID_SK=author_id

SELECT * FROM Fact_Order


