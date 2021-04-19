ALTER TABLE event ADD room INT NOT NULL;

CREATE TABLE room
(
    id      INT auto_increment  PRIMARY KEY,
    text    VARCHAR(2048)       NOT NULL
);

INSERT INTO room (id, text) VALUES (1, "Room 1");
INSERT INTO room (id, text) VALUES (2, "Room 2");
INSERT INTO room (id, text) VALUES (3, "Room 3");
INSERT INTO room (id, text) VALUES (4, "Room 4");
INSERT INTO room (id, text) VALUES (5, "Room 5");

UPDATE event SET room=FLOOR(RAND()*5)+1;
