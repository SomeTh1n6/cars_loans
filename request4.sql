-- Вывести всех поручителей одного клиента с их данными
SELECT 
    c_g.full_name AS guarantor_name,
    c_g.contact_info AS guarantor_contact_info,
    d.document_type,
    d.issue_date,
    d.document_link
FROM 
    Client c
JOIN Borrower b ON c.id = b.client_id
JOIN Borrower_Loan bl ON b.id = bl.borrower_id
JOIN Guarantor_Loan gl ON bl.loan_id = gl.loan_id
JOIN Guarantor g ON gl.guarantor_id = g.id
JOIN Client c_g ON g.client_id = c_g.id
LEFT JOIN Document d ON c_g.id = d.client_id  -- Используем LEFT JOIN, чтобы отобразить даже тех поручителей, у которых нет документов
WHERE 
    c.full_name = 'Милкевэй Vероника Vладимировна';

