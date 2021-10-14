

Week 08 - Lab suggested solution 

--Question 1.
SELECT restID, '$' || SUM(prodPrice)
FROM Product 
GROUP BY restID;


-- Question 2.
SELECT '$' || prodPrice, GROUP_CONCAT(prodName, ', ')
FROM Product 
GROUP BY prodPrice;


-- Question 3.
SELECT prodNo, GROUP_CONCAT(optionDesc, ', ')
FROM Option 
GROUP BY prodNo;


-- Question 4.
SELECT prodNo, SUM(price), AVG(price)
FROM Option
GROUP BY prodNo;

-- Question 5.
SELECT CAST(MIN(JULIANDAY('now') - JULIANDAY(orderDateTime)) AS INT) || ' Day(s)' AS 'Number of Days Since Last Order'
FROM CustOrder;


-- Question 6.
SELECT CAST(AVG(JULIANDAY(endDateTime) - JULIANDAY(startDateTime)) AS INT) || ' Day(s)' AS 'Average Special Length'
FROM ProductSpecial;

-- Question 7.
SELECT c.customerID, firstName, lastName, orderNo 
FROM Customer c, CustOrder co;

-- Question 8. 
SELECT c.customerID, firstName, lastName, orderNo 
FROM Customer c, CustOrder co
WHERE c.customerID = co.customerID;

-- Question 9.
SELECT reviewNo, reviewTypeDesc, reviewStar, reviewDesc 
FROM Review r, ReviewType rt 
WHERE r.reviewTypeID = rt.reviewTypeID;

-- Question 10.
SELECT p.prodNo, p.prodName, p.prodParentNo 
FROM Product p , Product pp
WHERE p.prodParentNo = pp.prodNo;

-- Question 11.
SELECT e.empID, empFirstName, empLastName, IFNULL(orderNo, 'None') 
FROM Employee e 
LEFT OUTER JOIN CustOrder co ON e.empID = co.empID;

--Question 12.
SELECT SUBSTR(email, INSTR(email, '@')) AS 'Provider', COUNT(email) AS 'Count' 
FROM Customer 
GROUP BY Provider;