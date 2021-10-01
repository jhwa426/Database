SELECT staffLastName, salary
FROM Staff s, StaffAssignment sa
WHERE s.staffCode = sa.staffCode
AND salary > (SELECT salary
    FROM Staff s, StaffAssignment sa
    WHERE s.staffCode = sa.staffCode
    AND LOWER(staffLastName) = 'jones');
	
SELECT staffLastName, salary
FROM Staff s, StaffAssignment sa
WHERE s.staffCode = sa.staffCode
AND salary = (SELECT MAX(salary)
 FROM StaffAssignment);
	
