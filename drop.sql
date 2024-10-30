-- Удаление таблиц, начиная с тех, которые содержат внешние ключи
DROP TABLE IF EXISTS Repayment_Payment CASCADE;
DROP TABLE IF EXISTS Borrower_Loan CASCADE;
DROP TABLE IF EXISTS Guarantor_Loan CASCADE;
DROP TABLE IF EXISTS Payment CASCADE;
DROP TABLE IF EXISTS RepaymentSchedule CASCADE;
DROP TABLE IF EXISTS Loan CASCADE;
DROP TABLE IF EXISTS Vehicle CASCADE;
DROP TABLE IF EXISTS Dealer CASCADE;
DROP TABLE IF EXISTS InsuranceCompany CASCADE;
DROP TABLE IF EXISTS LoanProgram CASCADE;
DROP TABLE IF EXISTS Borrower CASCADE;
DROP TABLE IF EXISTS Guarantor CASCADE;
DROP TABLE IF EXISTS Blacklist CASCADE;
DROP TABLE IF EXISTS Document CASCADE;
DROP TABLE IF EXISTS SecurityCheck CASCADE;
DROP TABLE IF EXISTS Client CASCADE;
DROP TABLE IF EXISTS Employee CASCADE;

-- Удаление типов ENUM
DROP TYPE IF EXISTS marital_status_enum CASCADE;
DROP TYPE IF EXISTS loan_status_enum CASCADE;
DROP TYPE IF EXISTS check_status_enum CASCADE;
DROP TYPE IF EXISTS repayment_status_enum CASCADE;

