CREATE TABLE event
(
    id          int auto_increment          primary key,
    text        varchar(2048)               not null,
    start_date  varchar(2048)               not null,
    end_date    varchar(2048)               not null,
    color       varchar(7) default ''       not null,
    calendar    int                         not null,
    details     text                        not null,
    all_day     int default 0               not null,
    recurring   varchar(2048) default ''    not null,
    units       varchar(2048)               not null
);

CREATE TABLE calendar
(
    id      int auto_increment  primary key,
    text    varchar(2048)       not null,
    color   varchar(7)        not null,
    active  int     default 0   not null
);

CREATE TABLE unit
(
    id      int auto_increment  primary key,
    value   varchar(2048)       not null
);

INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (1, "Zentralstadion - Leipzig", "2020-10-23 00:00:00", "2020-10-24 00:00:00", "#91E4A6", 2, "Leipzig, GER", 0, "", "1");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (2, "Inter Stadion Slovakia", "2020-10-23 00:00:00", "2020-10-24 00:00:00", "#74B1A7", 2, "Bratislava, Slovakia", 0, "", "1");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (3, "Aegon Championship", "2020-10-23 00:00:00", "2020-10-24 00:00:00", "", 2, "The Queens Club \nLondon, ENG", 1, "", "1");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (4, "LTU Arena", "2020-10-05 12:00:00", "2020-10-05 15:00:00", "#ADD579", 2, "Dusseldorf, GER", 0, "", "1");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (5, "Zentralstadion - Leipzig", "2020-10-07 20:00:00", "2020-10-07 23:00:00", "", 2, "Leipzig, GER", 0, "", "1");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (6, "Stade de France - Paris", "2020-10-27 19:00:00", "2020-10-27 22:00:00", "#91E4A6", 2, "Paris, FRA", 0, "", "1");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (7, "French Open", "2020-10-24 00:00:00", "2020-10-08 00:00:00", "", 1, "Philippe-Chatrier Court \nParis, FRA", 1, "", "1");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (8, "HSH Nordbank Arena (formerly AOL Arena)", "2020-10-02 10:00:00", "2020-10-02 13:00:00", "#6BA8CB", 2, "Hamburg, GER", 0, "", "1");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (9, "Stadio Olimpico", "2020-10-16 19:00:00", "2020-10-16 22:00:00", "", 2, "Rome, Italy", 0, "", "1");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (10, "Commerz Bank Arena", "2020-10-12 14:00:00", "2020-10-12 17:00:00", "#F68896", 2, "Frankfurt, GER", 0, "", "1");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (11, "LTU Arena", "2020-10-04 11:00:00", "2020-10-04 14:00:00", "", 0, "Dusseldorf, GER", 0, "", "1");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (12, "Olympiastadion - Berlin", "2020-10-10 14:00:00", "2020-10-10 17:00:00", "#01C2A5", 2, "Berlin, GER", 0, "", "1");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (13, "Olympic Stadium - Munich", "2020-10-13 11:00:00", "2020-10-13 14:00:00", "", 2, "Munich, GER", 0, "", "1");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (14, "Puskas Ferenc Stadium", "2020-10-23 14:00:00", "2020-10-23 17:00:00", "#74B1A7", 2, "Budapest, Hungary", 0, "", "1");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (15, "Slavia Stadion", "2020-10-25 10:00:00", "2020-10-25 13:00:00", "", 2, "Prague, Czech Republic", 0, "", "1");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (16, "Comunale Giuseppe Meazza - San Siro", "2020-10-21 20:00:00", "2020-10-21 23:00:00", "#CF89D5", 1, "Milan, Italy", 0, "", "1");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (17, "Wimbledon", "2020-10-21 00:00:00", "2020-11-05 00:00:00", "#CF89D5", 2, "Wimbledon\nJune 21, 2014 - July 5, 2014", 1, "", "1");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (18, "Parken Stadium", "2020-10-30 18:00:00", "2020-10-30 21:00:00", "#F68896", 2, "Copenhagen, DK", 0, "", "1");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (19, "Interstellar Cruise", "2020-10-12 00:00", "2020-10-13 00:00", "#D2FB9E", 1, "An awesome VR session with my buddies at the Jason's place", 0, "FREQ=YEARLY;BYMONTH=9;BYMONTHDAY=12", "2");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (20, "Panda Weekly Summit", "2020-10-20 09:00", "2020-10-20 11:00", "", 1, "The Panda club meeting, discussing the latest situation and solutions; planning.", 0, "FREQ=DAILY;INTERVAL=3;BYDAY=MO;UNTIL=20211023T000000Z", "2");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (21, "Biweekly Horror Book Club", "2020-10-02 00:00", "2020-10-04 00:00", "#CF89D5", 1, "Discussing the latest book of the fortnight; genres: mostly horror, both pure and within other genres like fantasy and sci-fi", 0, "FREQ=DAILY;INTERVAL=14;UNTIL=20210403T000000Z", "2");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (22, "Speculative Fiction Discussion Club", "2020-10-13 03:00", "2020-10-15 05:00", "", 1, "Contemporary speculative fiction by young authors", 0, "FREQ=DAILY;INTERVAL=14;UNTIL=20210905T000000Z", "2");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (23, "My 30th Birthday", "2020-09-20 20:01", "2020-09-21 20:01", "#CF89D5", 1, "Me and my few cronies at my place. DO NOT forget about the pre-order of foods.", 0, "", "2");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (24, "A day with a hero", "2020-10-21 20:01", "2020-10-22 20:01", "#74B1A7", 0, "An all-nighter watching Marvel films", 0, "FREQ=WEEKLY;BYDAY=MO,WE,TH;INTERVAL=2;UNTIL=20211022T000000Z", "2");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (25, "Women and aliens", "2020-10-21 10:00", "2020-10-21 18:00", "#EF9C80", 1, "A discussion of our club dedicated to the sci-fi works written by female authors, both contemporary literature and classics", 0, "FREQ=MONTHLY;UNTIL=20210922T000000Z", "2");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (26, "Grandmother's shopping", "2020-10-18 15:01", "2020-10-18 18:01", "#997CEB", 1, "<b>List:</b><ul><li>bananas</li><li>apples</li><li>pancake flour</li><li>books (at least three) by Shirley Jackson</li></ul>", 0, "FREQ=WEEKLY;INTERVAL=3;UNTIL=20210322T000000Z", "2");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (27, "A day with a hero", "2020-10-19 20:01", "2020-10-20 04:01", "", 2, "An all-nighter with DC films", 0, "FREQ=WEEKLY;INTERVAL=2;UNTIL=20210323T000000Z", "2");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (28, "Animals are also people", "2020-10-12 21:01", "2020-10-22 21:01", "#6BA8CB", 2, "A festival organized by our volunteering community. Activities:<ul><li>public donations</li><li>animal adoption</li><li>exhibition and fair of children's artwork</li><li>volunteer recruitment</li><li>community education</li></ul>", 0, "FREQ=MONTHLY;INTERVAL=2;UNTIL=20210501T000000Z", "2");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (29, "Galaxy Match", "2020-10-22 21:01", "2020-10-25 21:01", "#6BA8CB", 2, "A match between best galaxy sky-fighters", 0, "FREQ=WEEKLY;INTERVAL=3;UNTIL=20210422T000000Z", "1");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (30, "Dance club", "2020-10-19 10:30", "2020-10-19 12:30", "#DD89AF", 1, "Teaching dancing at the community center", 0, "FREQ=WEEKLY;BYDAY=TU,SA;UNTIL=20210910T000000Z", "2");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (31, "Brother's Birthday", "1986-09-15 00:00:00", "1986-04-16 00:00:00", "", 3, "", 0, "FREQ=YEARLY;BYMONTH=9;BYMONTHDAY=15;", "3");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (32, "Sister's Birthday", "1995-10-25 00:00:00", "1995-10-26 00:00:00", "", 3, "", 0, "FREQ=YEARLY;BYMONTH=10;BYMONTHDAY=25;", "3");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (33, "Cat's Birthday", "2012-10-05 00:00:00", "2012-10-06 00:00:00", "", 3, "", 0, "FREQ=YEARLY;BYMONTH=10;BYMONTHDAY=5;", "3");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (34, "Kate Middleton's Birthday", "1986-10-04 00:00:00", "1986-10-04 00:00:00", "", 3, "", 1, "FREQ=YEARLY;BYMONTH=10;BYMONTHDAY=4;", "3");    
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (35, "Prince George's Birthday", "2013-10-22 00:00:00", "2013-10-22 00:00:00", "", 3, "", 1, "FREQ=YEARLY;BYMONTH=10;BYMONTHDAY=22;", "3");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (36, "Victory Day", "1945-05-08 00:00:00", "1945-05-08 00:00:00", "#DD89AF", 4, "", 1, "FREQ=YEARLY;BYMONTH=5;BYMONTHDAY=9;UNTIL=20450509T000000Z", "3");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (37, "Independence Day in Belarus", "1996-10-0 00:00:00", "1996-10-03 00:00:00", "", 4, "", 1, "FREQ=YEARLY;BYMONTH=7;BYMONTHDAY=3", "3");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (38, "New Year", "1900-01-01 00:00:00", "1900-01-01 00:00:00", "", 4, "", 1, "FREQ=YEARLY;BYMONTH=1;BYMONTHDAY=1", "3");  
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring, units) VALUES (39, "Christmas", "1900-12-25 00:00:00", "1900-12-25 00:00:00", "", 4, "", 1, "FREQ=YEARLY;BYMONTH=12;BYMONTHDAY=25", "3");

INSERT INTO calendar (id, text, color, active) VALUES (1, "Personal", "#997CEB", 1);
INSERT INTO calendar (id, text, color, active) VALUES (2, "Public", "#01C2A5", 1);
INSERT INTO calendar (id, text, color, active) VALUES (3, "Birthdays", "#D2FB9E", 0);
INSERT INTO calendar (id, text, color, active) VALUES (4, "Holidays", "#F68896", 0);

INSERT INTO unit (id, value) VALUES (1, "Sports");
INSERT INTO unit (id, value) VALUES (2, "Social activities");
INSERT INTO unit (id, value) VALUES (3, "Celebrations");