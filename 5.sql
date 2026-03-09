-- выборка вакансий где откликов больше 5 за неделю

select v.vacancy_id, v.position_name, count(*) as responses		-- для проверки дат age(r.created_at, v.created_at) as time_diff, r.created_at as resume_time, v.created_at as vac_time
from responses r
join vacancies v on r.vacancy_id = v.vacancy_id 
where r.created_at <= v.created_at + interval '7 day' --смотрим отклики в первую неделю
group by v.vacancy_id
having count(*) > 5;
