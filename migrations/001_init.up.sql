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
    recurring   varchar(2048) default ''    not null
);

CREATE TABLE calendar
(
    id      int auto_increment  primary key,
    text    varchar(2048)       not null,
    color   varchar(7)        not null,
    active  int     default 0   not null
);

INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (1, "Zentralstadion - Leipzig", "2018-04-23 00:00:00", "2018-04-24 00:00:00", "#91E4A6", 2, "Leipzig, GER", 0, "");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (2, "Inter Stadion Slovakia", "2018-04-23 00:00:00", "2018-04-24 00:00:00", "#74B1A7", 2, "Bratislava, Slovakia", 0, "");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (3, "Aegon Championship", "2018-04-23 00:00:00", "2018-04-24 00:00:00", "", 2, "The Queens Club \nLondon, ENG", 1, "");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (4, "LTU Arena", "2018-06-05 12:00:00", "2018-06-05 15:00:00", "#ADD579", 2, "Dusseldorf, GER", 0, "");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (5, "Zentralstadion - Leipzig", "2018-06-07 20:00:00", "2018-06-07 23:00:00", "", 2, "Leipzig, GER", 0, "");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (6, "Stade de France - Paris", "2018-06-27 19:00:00", "2018-06-27 22:00:00", "#91E4A6", 2, "Paris, FRA", 0, "");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (7, "French Open", "2018-05-24 00:00:00", "2018-06-08 00:00:00", "", 1, "Philippe-Chatrier Court \nParis, FRA", 1, "");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (8, "HSH Nordbank Arena (formerly AOL Arena)", "2018-06-02 10:00:00", "2018-06-02 13:00:00", "#6BA8CB", 2, "Hamburg, GER", 0, "");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (9, "Stadio Olimpico", "2018-06-16 19:00:00", "2018-06-16 22:00:00", "", 2, "Rome, Italy", 0, "");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (10, "Commerz Bank Arena", "2018-06-12 14:00:00", "2018-06-12 17:00:00", "#F68896", 2, "Frankfurt, GER", 0, "");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (11, "LTU Arena", "2018-06-04 11:00:00", "2018-06-04 14:00:00", "", 0, "Dusseldorf, GER", 0, "");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (12, "Olympiastadion - Berlin", "2018-06-10 14:00:00", "2018-06-10 17:00:00", "#01C2A5", 2, "Berlin, GER", 0, "");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (13, "Olympic Stadium - Munich", "2018-06-13 11:00:00", "2018-06-13 14:00:00", "", 2, "Munich, GER", 0, "");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (14, "Puskas Ferenc Stadium", "2018-06-23 14:00:00", "2018-06-23 17:00:00", "#74B1A7", 2, "Budapest, Hungary", 0, "");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (15, "Slavia Stadion", "2018-06-25 10:00:00", "2018-06-25 13:00:00", "", 2, "Prague, Czech Republic", 0, "");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (16, "Comunale Giuseppe Meazza - San Siro", "2018-05-21 20:00:00", "2018-05-21 23:00:00", "#CF89D5", 1, "Milan, Italy", 0, "");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (17, "Wimbledon", "2018-06-21 00:00:00", "2018-07-05 00:00:00", "#CF89D5", 2, "Wimbledon\nJune 21, 2014 - July 5, 2014", 1, "");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (18, "Parken Stadium", "2018-06-30 18:00:00", "2018-06-30 21:00:00", "#F68896", 2, "Copenhagen, DK", 0, "");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (19, "Interstellar Cruise", "2018-04-12 00:00", "2018-04-13 00:00", "#D2FB9E", 1, "An awesome VR session with my buddies at the Jason's place", 0, "FREQ=YEARLY;BYMONTH=4;BYMONTHDAY=12");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (20, "Panda Weekly Summit", "2018-04-20 09:00", "2018-04-20 11:00", "", 1, "The Panda club meeting, discussing the latest situation and solutions; planning.", 0, "FREQ=DAILY;INTERVAL=3;BYDAY=MO;UNTIL=20180423T000000Z");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (21, "Biweekly Horror Book Club", "2018-04-02 00:00", "2018-04-04 00:00", "#CF89D5", 1, "Discussing the latest book of the fortnight; genres: mostly horror, both pure and within other genres like fantasy and sci-fi", 0, "FREQ=DAILY;INTERVAL=14;UNTIL=20200403T000000Z");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (22, "Speculative Fiction Discussion Club", "2018-04-13 03:00", "2018-04-15 05:00", "", 1, "Contemporary speculative fiction by young authors", 0, "FREQ=DAILY;INTERVAL=14;UNTIL=20180905T000000Z");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (23, "My 30th Birthday", "2018-04-20 20:01", "2018-04-23 20:01", "#CF89D5", 1, "Me and my few cronies at my place. DO NOT forget about the pre-order of foods.", 0, "FREQ=WEEKLY;BYDAY=WE,FR,SU;UNTIL=20180423T000000Z");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (24, "A day with a hero", "2018-04-21 20:01", "2018-04-22 20:01", "#74B1A7", 0, "An all-nighter watching Marvel films", 0, "FREQ=WEEKLY;BYDAY=MO,WE,TH;INTERVAL=2;UNTIL=20180422T000000Z");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (25, "Women and aliens", "2018-04-21 10:00", "2018-04-21 18:00", "#EF9C80", 1, "A discussion of our club dedicated to the sci-fi works written by female authors, both contemporary literature and classics", 0, "FREQ=MONTHLY;UNTIL=20180922T000000Z");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (26, "Grandmother's shopping", "2018-04-18 15:01", "2018-04-18 18:01", "#997CEB", 1, "<b>List:</b><ul><li>bananas</li><li>apples</li><li>pancake flour</li><li>books (at least three) by Shirley Jackson</li></ul>", 0, "FREQ=WEEKLY;INTERVAL=3;UNTIL=20200322T000000Z");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (27, "A day with a hero", "2018-04-19 20:01", "2018-04-20 04:01", "", 2, "An all-nighter with DC films", 0, "FREQ=WEEKLY;INTERVAL=2;UNTIL=20200323T000000Z");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (28, "Animals are also people", "2018-04-12 21:01", "2018-04-22 21:01", "#6BA8CB", 2, "A festival organized by our volunteering community. Activities:<ul><li>public donations</li><li>animal adoption</li><li>exhibition and fair of children's artwork</li><li>volunteer recruitment</li><li>community education</li></ul>", 0, "FREQ=MONTHLY;INTERVAL=2;UNTIL=20200501T000000Z");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (29, "Galaxy Match", "2018-04-22 21:01", "2018-04-25 21:01", "#6BA8CB", 2, "A match between best galaxy sky-fighters", 0, "FREQ=WEEKLY;INTERVAL=3;UNTIL=20200422T000000Z");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (30, "Dance club", "2018-04-19 10:30", "2018-04-19 12:30", "#DD89AF", 1, "Teaching dancing at the community center", 0, "FREQ=WEEKLY;BYDAY=TU,TH;UNTIL=20180910T000000Z");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (31, "Brother's Birthday", "1986-04-15 00:00:00", "1986-04-16 00:00:00", "", 3, "", 0, "FREQ=YEARLY;BYMONTH=4;BYMONTHDAY=15;");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (32, "Sister's Birthday", "1995-07-25 00:00:00", "1995-07-26 00:00:00", "", 3, "", 0, "FREQ=YEARLY;BYMONTH=7;BYMONTHDAY=25;");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (33, "Cat's Birthday", "2012-10-05 00:00:00", "2012-10-06 00:00:00", "", 3, "", 0, "FREQ=YEARLY;BYMONTH=10;BYMONTHDAY=5;");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (34, "Kate Middleton's Birthday", "1986-08-04 00:00:00", "1986-08-04 00:00:00", "", 3, "", 1, "FREQ=YEARLY;BYMONTH=8;BYMONTHDAY=4;");    
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (35, "Prince George's Birthday", "2013-07-22 00:00:00", "2013-07-22 00:00:00", "", 3, "", 1, "FREQ=YEARLY;BYMONTH=7;BYMONTHDAY=22;");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (36, "Victory Day", "1945-05-08 00:00:00", "1945-05-08 00:00:00", "#DD89AF", 4, "", 1, "FREQ=YEARLY;BYMONTH=5;BYMONTHDAY=9;UNTIL=20450509T000000Z");
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (37, "Independence Day in Belarus", "1996-07-0 00:00:00", "1996-07-03 00:00:00", "", 4, "", 1, "FREQ=YEARLY;BYMONTH=7;BYMONTHDAY=3");    
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (38, "New Year", "1900-01-01 00:00:00", "1900-01-01 00:00:00", "", 4, "", 1, "FREQ=YEARLY;BYMONTH=1;BYMONTHDAY=1");  
INSERT INTO event (id, text, start_date, end_date, color, calendar, details, all_day, recurring) VALUES (39, "Christmas", "1900-12-25 00:00:00", "1900-12-25 00:00:00", "", 4, "", 1, "FREQ=YEARLY;BYMONTH=12;BYMONTHDAY=25");

INSERT INTO calendar (id, text, color, active) VALUES (1, "Personal", "#997CEB", 1);
INSERT INTO calendar (id, text, color, active) VALUES (2, "Public", "#01C2A5", 1);
INSERT INTO calendar (id, text, color, active) VALUES (3, "Birthdays", "#D2FB9E", 0);
INSERT INTO calendar (id, text, color, active) VALUES (4, "Holidays", "#F68896", 0);
