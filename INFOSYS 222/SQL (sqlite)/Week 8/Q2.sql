--Q2

SELECT StaffCode, branchNo, roleID,  salary
FROM StaffAssignment
WHERE  (roleID = (SELECT roleID FROM StaffAssignment WHERE staffCode = 7)
OR
salary = (SELECT salary FROM StaffAssignment WHERE staffCode = 7))
AND staffCode != 7;