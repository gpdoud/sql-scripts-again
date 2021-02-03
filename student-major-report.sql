SELECT s.id, CONCAT(s.Firstname, ' ', s.Lastname) as 'Name', 
		s.GPA, s.SAT,
		m.Description as 'Major'
	From Student s
	Join Major m
		on s.MajorId = m.Id
	Where s.GPA > 3.5 AND (s.MajorId = 3 OR s.MajorId = 5)
	Order by s.GPA desc, s.SAT desc