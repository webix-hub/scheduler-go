ALTER TABLE event ADD section INT NOT NULL;

CREATE TABLE section
(
    id      INT auto_increment  PRIMARY KEY,
    text    VARCHAR(2048)       NOT NULL
);

INSERT INTO section (id, text) VALUES (1, "Section 1");
INSERT INTO section (id, text) VALUES (2, "Section 2");
INSERT INTO section (id, text) VALUES (3, "Section 3");
INSERT INTO section (id, text) VALUES (4, "Section 4");
INSERT INTO section (id, text) VALUES (5, "Section 5");

UPDATE event SET section=FLOOR(RAND()*5)+1;
