SELECT c.Subject, c.Section, 
		CONCAT(i.lastname, ', ', i.Firstname) as 'Name',
		i.YearsExperience, i.IsTenured
	from Class c
	join Instructor i on i.Id = c.InstructorId
	where i.YearsExperience = 9
	order by i.Lastname, c.Subject
