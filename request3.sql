-- Показать кто находится в чс, с причиной добавления
SELECT 
    c.full_name AS client_name,
    b.add_date,
    b.reason,
    e.name AS employee_name,
    sc.check_date,
    sc.check_status,
    sc.comments
FROM 
    Client c
JOIN Blacklist b ON c.id = b.client_id
JOIN SecurityCheck sc ON c.id = sc.client_id
JOIN Employee e ON sc.employee_id = e.id
WHERE 
    sc.check_status = 'Отклонено';

