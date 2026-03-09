-- собираем средние зарплаты по регионам

select ROUND(AVG(v.compensation_from), 2) as avg_comp_from, ROUND(AVG(v.compensation_to), 2) as avg_comp_to, ROUND((AVG(v.compensation_from) + AVG(v.compensation_to)) / 2, 2) as avg_comp_from_to
from vacancies v 
join employers e on v.employer_id = e.area_id 
group by e.area_id ;

