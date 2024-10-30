-- Создание типов ENUM
CREATE TYPE marital_status_enum AS ENUM ('Не состоит в браке', 'Состоит в браке');
CREATE TYPE loan_status_enum AS ENUM ('Активен', 'Закрыт', 'Просрочен');
CREATE TYPE check_status_enum AS ENUM ('Ожидание', 'Одобрено', 'Отклонено');
CREATE TYPE repayment_status_enum AS ENUM ('Запланирован', 'Выполнен', 'Просрочен');

-- Таблица Клиент
CREATE TABLE Client (
    id bigint primary key generated always as identity,
    full_name text NOT NULL,
    birth_date DATE,
    contact_info text,
    marital_status marital_status_enum,
    income DECIMAL(15, 2)
);

-- Таблица Сотрудник СБ
CREATE TABLE Employee (
    id bigint primary key generated always as identity,
    name text NOT NULL,
    position text NOT NULL
);

-- Таблица Проверка Службы Безопасности
CREATE TABLE SecurityCheck (
    id bigint primary key generated always as identity,
    client_id bigint REFERENCES Client(id),
    check_date DATE NOT NULL,
    employee_id bigint REFERENCES Employee(id),
    check_status check_status_enum,
    comments text,
    check_name text
);

-- Таблица Поручитель
CREATE TABLE Guarantor (
    id bigint primary key generated always as identity,
    client_id bigint REFERENCES Client(id)
);

-- Таблица Черный Список
CREATE TABLE Blacklist (
    id bigint primary key generated always as identity,
    client_id bigint REFERENCES Client(id),
    add_date DATE NOT NULL,
    reason text
);

-- Таблица Документ
CREATE TABLE Document (
    id bigint primary key generated always as identity,
    document_type text NOT NULL,
    issue_date DATE,
    document_link text,
    client_id bigint REFERENCES Client(id)
);

-- Таблица Заемщик
CREATE TABLE Borrower (
    id bigint primary key generated always as identity,
    client_id bigint REFERENCES Client(id),
    spouse_id bigint REFERENCES Client(id)
);

-- Таблица Кредитная Программа
CREATE TABLE LoanProgram (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    interest_rate DECIMAL(5, 2) NOT NULL,
    program_type text,
    program_name text,
    issuance_fee DECIMAL(15, 2),
    min_age INT,  -- Минимальный возраст заемщика
    max_age INT,  -- Максимальный возраст заемщика
    min_income DECIMAL(15, 2)  -- Максимальный доход заемщика
);


-- Таблица Страховая Компания
CREATE TABLE InsuranceCompany (
    id bigint primary key generated always as identity,
    name text NOT NULL,
    bank_account text,
    contact_info text,
    legal_address text
);

-- Таблица Дилер
CREATE TABLE Dealer (
    id bigint primary key generated always as identity,
    name text NOT NULL,
    bank_account text,
    contact_info text,
    legal_address text
);

-- Таблица Транспортное Средство
CREATE TABLE Vehicle (
    id bigint primary key generated always as identity,
    dealer_id bigint REFERENCES Dealer(id),
    model text NOT NULL,
    year_of_manufacture INT,
    cost DECIMAL(15, 2),
    insurance_company_id bigint REFERENCES InsuranceCompany(id)
);

-- Таблица Кредит
CREATE TABLE Loan (
    id bigint primary key generated always as identity,
    loan_amount DECIMAL(15, 2),
    loan_status loan_status_enum,
    vehicle_id bigint REFERENCES Vehicle(id),
    loan_program_id bigint REFERENCES LoanProgram(id),
    start_date DATE,
    initial_payment DECIMAL(15, 2),
    loan_term INT
);

-- Таблица График погашения
CREATE TABLE RepaymentSchedule (
    id bigint primary key generated always as identity,
    loan_id bigint REFERENCES Loan(id),
    principal_amount DECIMAL(15, 2),
    status text,
    interest_amount DECIMAL(15, 2),
    payment_date DATE
);

-- Таблица Платеж
CREATE TABLE Payment (
    id bigint primary key generated always as identity,
    loan_id bigint REFERENCES Loan(id),
    payment_amount DECIMAL(15, 2),
    payment_date DATE
);

-- Таблица для связи График погашения и Фактический платеж (многие ко многим)
CREATE TABLE Repayment_Payment (
    repayment_id BIGINT REFERENCES RepaymentSchedule(id) ON DELETE CASCADE,
    payment_id BIGINT REFERENCES Payment(id) ON DELETE CASCADE,
    PRIMARY KEY (repayment_id, payment_id),
    amount DECIMAL(15, 2) NOT NULL  -- сумма платежа, связанного с графиком
);

-- Таблица для связи Заемщик и Кредит (многие ко многим)
CREATE TABLE Borrower_Loan (
    borrower_id bigint REFERENCES Borrower(id),
    loan_id bigint REFERENCES Loan(id),
    PRIMARY KEY (borrower_id, loan_id)
);

-- Таблица для связи Поручитель и Кредит (многие ко многим)
CREATE TABLE Guarantor_Loan (
    guarantor_id bigint REFERENCES Guarantor(id),
    loan_id bigint REFERENCES Loan(id),
    PRIMARY KEY (guarantor_id, loan_id)
);
