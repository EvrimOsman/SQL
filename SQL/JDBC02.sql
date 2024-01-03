CREATE TABLE accounts(
    account_nu int UNIQUE,
    name VARCHAR(50),
    amount real
);
INSERT INTO accounts VALUES(1234, 'Fred',9500.5);
INSERT INTO accounts VALUES(5678, 'Barnie',6500.3);

SELECT * FROM accounts;

DROP  TABLE accounts;