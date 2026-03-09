-- месяц с наибольшим колвом вакансий
select extract(year from created_at) as year, extract(month from created_at) as month, count(*) as max_vacancies
		from vacancies
			group by year, month
			order by max_vacancies desc
		limit 1;

-- наибольшее колво резюме
select extract(year from created_at) as year, extract(month from created_at) as month, count(*) as max_resumes
		from resumes
			group by year, month
			order by max_resumes desc
		limit 1;
