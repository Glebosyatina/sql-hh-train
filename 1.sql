--создаем основные сущности

CREATE TABLE users (
	user_id 	INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 	-- ID ПОЛЬЗОВАТЕЛЯ
	name		TEXT NOT NULL,										-- ИМЯ 
	surname 	TEXT NOT NULL,										-- ФАМИЛИЯ
	patronymic  TEXT NOT NULL										-- ОТЧЕСТВО
);

CREATE TABLE areas (
	area_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,	-- ID РЕГИОНА
	area_name TEXT NOT NULL										-- НАЗВАНИЕ РЕГИОНА
);

CREATE TABLE specializations (
	specialization_id	INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,  	-- ID СПЕЦИАЛИЗАЦИИ/ПРОФЕССИИ
	name 				TEXT NOT NULL										-- название профессии
);

CREATE TABLE resumes (
	resume_id 			INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,				-- ID РЕЗЮМЕ
	user_id   			INTEGER NOT NULL REFERENCES users(user_id),						-- ID ПОЛЬЗОВАТЕЛЯ
	specialization_id 	INTEGER NOT NULL REFERENCES specializations(specialization_id),	-- ID ПРОФЕССИИ
	skills				TEXT NOT NULL,													-- НАВЫКИ
	description			TEXT NOT NULL,													-- ОПИСАНИЕ
	compensation_from   INTEGER,
	compensation_to     INTEGER,
	created_at 			TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE employers (
	employer_id		INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,	-- ID РАБОТОДАТЕЛЯ
	employer_name	TEXT NOT NULL,										-- НАЗВАНИЕ КОМПАНИИ
	area_id			INTEGER NOT NULL REFERENCES areas(area_id)			-- РЕГИОН
);

CREATE TABLE vacancies (
	vacancy_id 			INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,				-- ID ВАКАНСИИ
	employer_id 		INTEGER NOT NULL REFERENCES employers(employer_id),				-- ID РАБОТОДАТЕЛЯ, КОМПАНИИ
	position_name 		TEXT NOT NULL,													-- НАЗВАНИЕ ВАКАНСИИ
	specialization_id 	INTEGER NOT NULL REFERENCES specializations(specialization_id),	-- СПЕЦИАЛИЗАЦИЯ, КОНКРЕТНОЕ НАЗВАНИЕ ПРОФЕССИИ
	compensation_from	INTEGER,														-- ЗАРПЛАТА ОТ
	compensation_to		INTEGER,														-- И ДО
	compensation_gross  BOOLEAN DEFAULT false,															-- С ВЫЧИТОМ НАЛОГОВ ИЛИ НЕТ
	created_at 			TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE responses (
	response_id		INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,			-- ID ОТКЛИКА
	resume_id 		INTEGER NOT NULL REFERENCES resumes(resume_id),				-- ID ОТКЛИКНУВШЕГОСЯ РЕЗЮМЕ
	vacancy_id		INTEGER NOT NULL REFERENCES vacancies(vacancy_id),			-- ID ВАКАНСИИ
	created_at		TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP										-- ВРЕМЯ ОТКЛИКА
);

