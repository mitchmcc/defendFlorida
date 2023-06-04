BEGIN;

    PRAGMA temp_store = 2; /* 2 means use in-memory */
    CREATE TEMP TABLE _Variables(Name TEXT PRIMARY KEY, TextValue TEXT);

    /* Declaring a variable */
    INSERT INTO _Variables (Name) VALUES ('VoterId');

    /* Assigning a variable (pick the right storage class) */
    UPDATE _Variables SET TextValue = '115911939' WHERE Name = 'VoterId';

    /* Getting variable value (use within expression) */
    select firstName, lastName from voters where voterId = (SELECT TextValue from _Variables where Name = 'VoterId');

    DROP TABLE _Variables;
    END;
