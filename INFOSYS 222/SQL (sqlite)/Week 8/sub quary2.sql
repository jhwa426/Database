SELECT staffLastName 
FROM Staff
WHERE staffCode IN
 (SELECT staffCode FROM StaffAssignment
    WHERE salary >
     (SELECT MIN(salary) FROM StaffAssignment
      WHERE roleID = 1));