-- генерим пользователей

INSERT INTO users (name, surname, patronymic) VALUES                                                                     
        ('Глеб', 'Пивушев', 'Сергеевич'),                                                                                    
        ('Марина', 'Озеринникова', 'Евгеньевна'),                                                                          
        ('Кирилл', 'Нивин', 'Владимирович'),                                                                                  
        ('Артем', 'Костерин', 'Игоревич'),                                                                                         
        ('Юлия', 'Кругликова', 'Павловна'),                                                                                
        ('Евгений', 'Озеринников', 'Николаевич'),                                                                                 
        ('Карина', 'Цой', 'Эдуардовна');

-- регионы
INSERT INTO areas(area_name) VALUES
	('Вологодская область'),
	('Краснодарский край'),
	('Ивановская область'),
	('Ярославская область'),
	('Республика Карелия'),
	('Мурманская область');

-- специализации/профессии
INSERT INTO specializations(name) VALUES
	('Разработчик'),
	('Тестировщик'),
	('Аналитик'),
	('Строитель'),
	('Режиссер'),
	('Врач');	

-- работодатели
INSERT INTO employers(employer_name, area_id) VALUES
	('Яндекс', 1),
	('Магнит', 2),
	('Google', 3),
	('Netflix', 4),
	('Сбер', 5),
	('Тинкофф', 6);

-- вакансии 10к
with test_data(id, title, salary, random_time) as (select generate_series(1, 10000) as id, 
                                             md5(random()::text) as title,
                                             round((random()*100000)::int, -3) as salary,
                                             timestamp '2020-01-01 20:00:00' +
       													random() * (timestamp '2025-12-31 20:00:00' -
                   													timestamp '2020-01-01 10:00:00') 
                                      )
insert into vacancies (employer_id, position_name, specialization_id, compensation_from, compensation_to, compensation_gross, created_at)
	select floor(random() * 6 + 1), title, floor(random() * 6 + 1), salary, salary + 10000, true, random_time
	from test_data;

-- резюме 100к
with test_data(id, title, salary, random_time) as (select generate_series(1, 100000) as id, 
                                      md5(random()::text) as title,
                                      round((random()*100000)::int, -3) as salary,
                                      timestamp '2020-01-01 20:00:00' +
			      								  random() * (timestamp '2025-12-31 20:00:00' -
            			      								 timestamp '2020-01-01 10:00:00')                                                                                      	
                                      )
insert into resumes (user_id, specialization_id, compensation_from, compensation_to, skills, description, created_at)
	select floor(random() * 7 + 1), floor(random() * 6 + 1), salary, salary + 10000, title, title, random_time
	from test_data;


-- отклики 1млн
with test_data(id, res_id, vac_id) as (select generate_series(1, 1000000) as id, 
                                      floor(random() * 100000 + 1),
                                      floor(random() * 10000 + 1)
)
insert into responses (resume_id, vacancy_id, created_at) 
        select res_id, vac_id, v.created_at + (((floor(random() * 365 + 1))::text || ' day')::interval) -- прибавляем к дате создание вакансии случайное колво дней, 
                --  иначе если взять просто случаное время, то отлик может быть раньше чем была опубликована вакансия - противоречит логике
        from test_data 
                join vacancies v on test_data.vac_id = v.vacancy_id 
on conflict(resume_id, vacancy_id) do nothing 	-- для игнорирования конфликтующих строк
												--(когда с одним и тем же резюме пытаемся откликнутся на одну вакансию кучу раз)
;

