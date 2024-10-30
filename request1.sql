-- Показать все активные кредиты, с именем, суммой, машиной, дилером
SELECT 
    c.full_name AS client_name,
    c.contact_info,
    l.loan_amount,
    l.loan_status,
    v.model AS vehicle_model,
    v.year_of_manufacture,
    lp.program_name AS loan_program,
    d.name AS dealer_name
FROM 
    Client c
JOIN Borrower b ON c.id = b.client_id
JOIN Borrower_Loan bl ON b.id = bl.borrower_id
JOIN Loan l ON bl.loan_id = l.id AND l.loan_status = 'Активен'
JOIN Vehicle v ON l.vehicle_id = v.id
JOIN Dealer d ON v.dealer_id = d.id
JOIN LoanProgram lp ON l.loan_program_id = lp.id;

