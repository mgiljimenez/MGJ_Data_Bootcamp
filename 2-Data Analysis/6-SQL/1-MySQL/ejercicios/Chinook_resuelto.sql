-- 1.	Muestra los clientes de brasil
SELECT *
FROM customer
WHERE country="Brazil";

-- 2.	Muestrame los empleados que son agentes de ventas*
SELECT *
FROM employee
WHERE Title="Sales Support Agent";

-- 3.	Muestrame las canciones de ‘AC/DC’
SELECT *
FROM track
WHERE Composer="AC/DC";

-- 4.	Muestra los clientes que no sean de USA: Nombre completo, ID, Pais
SELECT CustomerID, FirstName, LastName, Country
FROM customer
WHERE Country != "USA";

-- 5.	Muestrame los empleados que son agentes de ventas: Nombre completo, Dirección (Ciudad, Estado, Pais) y email
SELECT FirstName, LastName, Address, City, State, Country, Email
FROM employee
WHERE Title="Sales Support Agent";

-- 6.	Muestra una lista con los paises que aparecen a los que se ha facturado, la lista no debe contener paises repetidos
SELECT distinct BillingCountry
FROM invoice;

-- 7.	Muesta una lista con los estados de USA de donde son los clientes, la lista no debe contener estados repetidos
SELECT DISTINCT State
FROM customer
WHERE Country="USA";

-- 8.	Cuantos articulos tiene la factura 37*
SELECT  SUM(Quantity)
FROM invoiceline
WHERE InvoiceId=37;

-- 9.	Cuantas canciones tiene ‘AC/DC’
SELECT COUNT(*)
FROM track
WHERE Composer="AC/DC";

-- 10.	Cuantos articulos tiene cada factura
SELECT InvoiceId, COUNT(*)
FROM invoiceline
GROUP BY InvoiceId;


-- 11.	Muestrame cuantos facturas hay de cada pais
SELECT BillingCountry, COUNT(*)
FROM invoice
GROUP BY BillingCountry
;

-- 12.	Muestrame cuantos items tiene cada factura
SELECT InvoiceId, COUNT(*)
FROM invoiceline
GROUP BY InvoiceId;

-- 13.	Cuantas facturas ha habido en 2009 y 2011*
SELECT COUNT(*) 
FROM INVOICE
WHERE InvoiceDate LIKE "2009%"
OR InvoiceDate LIKE "2011%"
;

-- 14.	Cuantas facturas ha habido entre 2009 y 2011*
SELECT COUNT(*) 
FROM INVOICE
WHERE InvoiceDate between "2009-01-01" AND "2011-12-31"
;

-- 15.	Cuantos clientes hay de españa y de Brazil
 SELECT COUNT(*)
 FROM CUSTOMER
 WHERE COUNTRY IN ("SPAIN", "BRAZIL")
 ;

-- 16.	Muestrame las canciones que su titulo empieza por ‘You’*/
SELECT * 
FROM TRACK
WHERE NAME LIKE "YOU%";



-- 1.	Facturas de Clientes de Brasil, Nombre del cliente, Id de factura, fecha de la factura y el pais de la factura
SELECT c.FirstName, c.Lastname, i.InvoiceId, i.InvoiceDate, i.BillingCountry
FROM invoice i
LEFT JOIN customer c
ON i.CustomerId=c.CustomerId
WHERE c.Country="Brazil";

-- 2.	Facturas de Clientes de Brasil*
SELECT *
FROM invoice
WHERE BillingCountry = "Brazil";

-- 3.	Muestra cada factura asociada a cada agente de ventas con su nombre completo
SELECT e.FirstName, e.LastName, i.InvoiceId
FROM employee e
LEFT JOIN customer c
ON e.EmployeeId=c.SupportRepId
LEFT JOIN invoice i
ON i.CustomerId=c.CustomerId
WHERE e.Title="Sales Support Agent";

-- 4.	Muestra el nombre del cliente, el pais, el nombre del agente y el total
SELECT c.FirstName, c.LastName, c.Country, e.FirstName, e.LastName ,i.Total
FROM employee e
LEFT JOIN customer c
ON e.EmployeeId=c.SupportRepId
LEFT JOIN invoice i
ON i.CustomerId=c.CustomerId
WHERE e.Title="Sales Support Agent";

-- 5.	Muestra cada articulo de la factura con el nombre de la cancion
SELECT InvoiceLineId, t.name
FROM invoiceline i
LEFT JOIN TRACK	t
ON i.TrackId = t.TrackId
;

-- 6.	Muestra todas las conciones con su nombre, formato, album y genero

SELECT t.name, m.name, a.title, g.name
FROM track t
LEFT JOIN album a
ON t.AlbumId = a.AlbumId
LEFT JOIN genre g
ON t.GenreId = g.GenreId
LEFT JOIN mediatype m
ON t.mediaTypeId = m.mediaTypeId
;

-- 7.	Muestra cuantas canciones hay en cada playlist y el nombre de cada playlist

SELECT COUNT(*) , p.name
FROM playlist p
LEFT JOIN playlisttrack pt
ON p.PlaylistId = pt.PlaylistId
GROUP BY p.name
;

-- 8.	Muestra cuánto ha vendido cada empleado
SELECT EmployeeId, SUM(i.Total)
FROM employee e
LEFT JOIN customer c
ON e.EmployeeId=c.SupportRepId
LEFT JOIN invoice i
ON i.CustomerId=c.CustomerId
group by EmployeeId
;

-- 9.	Quien ha sido el agente de ventas que más ha vendido en 2009?
SELECT EmployeeId, SUM(i.Total)
FROM employee e
LEFT JOIN customer c
ON e.EmployeeId=c.SupportRepId
LEFT JOIN invoice i
ON i.CustomerId=c.CustomerId
WHERE e.title="Sales Support Agent"
AND i.InvoiceDate like "2009%"
group by EmployeeId;

-- 10.	Quien es son los 3 grupos que más han vendido?

SELECT AR.Name
FROM artist AR
LEFT JOIN album AL
USING(artistID)
LEFT JOIN Track
using(albumID)
LEFT JOIN invoiceline
USING(trackId)

;


SELECT ar.name, SUM(i.unitPrice) AS suma
FROM TRACK t
LEFT JOIN invoiceline i
ON t.trackId = i.TrackId
LEFT JOIN album a
ON a.AlbumId = T.AlbumId
LEFT JOIN Artist ar
ON ar.ArtistId  = a.ArtistId
GROUP BY ar.name
;

SELECT TOP 3 * FROM 
(SELECT ar.name, SUM(i.unitPrice) AS suma
FROM TRACK t
LEFT JOIN invoiceline i
ON t.trackId = i.TrackId
LEFT JOIN album a
ON a.AlbumId = T.AlbumId
LEFT JOIN Artist ar
ON ar.ArtistId  = a.ArtistId
GROUP BY ar.name) X
order by suma desc
;

