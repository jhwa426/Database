--Q3
SELECT staffCode, startDate
FROM StaffAssignment
WHERE startDate
IN
(SELECT DISTINCT startDate FROM  StaffAssignment
ORDER BY startDate
LIMIT 3);