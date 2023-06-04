
CREATE TABLE music (
       id INT PRIMARY KEY NOT NULL,
       name TEXT NOT NULL,
       artistId INT NOT NULL
);

CREATE TABLE artist (
       id INT PRIMARY KEY NOT NULL,
       name TEXT NOT NULL
);
