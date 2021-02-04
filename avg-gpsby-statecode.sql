-- Average GPA for all students by major
select m.description as 'Major', avg(gpa) 
	from Student s
	join Major m on m.id = s.MajorId
	where s.StateCode <> 'OH'
	group by m.Description
	having avg(gpa) >= 3.0