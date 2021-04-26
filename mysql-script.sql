select * from student 
	where id in(
		select id from student where firstname = 'Greg'
    );