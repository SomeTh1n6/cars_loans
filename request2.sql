-- Показать наиболее привлекательные программы для заемщика, если его нет в чс
SELECT 
    c.full_name AS client_name,
    c.income AS client_income,
    EXTRACT(YEAR FROM AGE(c.birth_date)) AS client_age,
    lp.program_name,
    lp.interest_rate,
    lp.issuance_fee,
    lp.min_age,
    lp.max_age,
    lp.min_income
FROM 
    Client c
LEFT JOIN Blacklist b ON c.id = b.client_id
JOIN LoanProgram lp ON 
    (EXTRACT(YEAR FROM AGE(c.birth_date)) BETWEEN lp.min_age AND lp.max_age)
    AND (c.income >= lp.min_income)
WHERE 
    c.id = 11             
    AND b.client_id IS NULL         -- Проверка, что клиента нет в чс
ORDER BY 
    lp.interest_rate ASC,           -- Сортировка по ставке
    lp.issuance_fee ASC;            -- Сортировка по комиссии

