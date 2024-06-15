-- Active: 1710772996562@@127.0.0.1@3306@voleyball_team
CREATE TABLE USER 
(
    username CHAR(20),
    user_password CHAR(16),
    surname CHAR(20),
    PRIMARY KEY (username)
)

CREATE TABLE PLAYER 
(
    username CHAR(20),
    height REAL,
    date_of_birth DATE,
    weight REAL,
    FOREIGN KEY (username) REFERENCES USER(username),
    PRIMARY KEY (username)
)

CREATE TABLE POSITION_TYPE
(
    position_id REAL,
    position_name CHAR(20) NOT NULL,
    PRIMARY KEY (position_id)
)

CREATE TABLE PLAYER_POSITION
(
    username CHAR(20) NOT NULL,
    position_id REAL NOT NULL,
    FOREIGN KEY (username) REFERENCES PLAYER(username) ON DELETE CASCADE  ON UPDATE CASCADE,
    FOREIGN KEY (position_id) REFERENCES POSITION_TYPE(position_id) ON DELETE CASCADE  ON UPDATE CASCADE,
    PRIMARY KEY (username, position_id)
)

CREATE TABLE PLAYER_LIST
(
    username CHAR(20) NOT NULL,
    session_id REAL NOT NULL,
    FOREIGN KEY (username) REFERENCES PLAYER(username) CASCADE ON DELETE CASCADE  ON UPDATE CASCADE, 
    FOREIGN KEY (session_id) REFERENCES VOLLEYBALL_MATCH(session_id)ON DELETE CASCADE  ON UPDATE CASCADE,
    PRIMARY KEY (username, session_id)
)   

CREATE TABLE VOLLEYBALL_MATCH 
(
    session_id REAL,
    team_id REAL NOT NULL,
    PRIMARY KEY (session_id)
)

CREATE TABLE COACH 
(
    username CHAR(20),
    nationality CHAR(20) NOT NULL,
    FOREIGN KEY (username) REFERENCES USER(username),
    PRIMARY KEY (username)
)

CREATE TABLE JURY
(
    username CHAR(20),
    nationality CHAR(20) NOT NULL,
    FOREIGN KEY (username) REFERENCES USER(username),
    PRIMARY KEY (username)
)

CREATE TABLE CHANNEL
(
    channel_id CHAR(20),
    channel_name CHAR(20) UNIQUE,
    PRIMARY KEY (channel_id)
)

CREATE TABLE TEAM 
(
    team_id REAL,
    team_name CHAR(20),
    channel_id CHAR(20) NOT NULL,
    FOREIGN KEY (channel_id) REFERENCES CHANNEL(channel_id),
    PRIMARY KEY (team_id)
)

CREATE TABLE DIRECTS 
(
    team_id REAL,
    coach_username CHAR(20),
    contract_start_date DATE,
    contract_end_date DATE,
    FOREIGN KEY (team_id) REFERENCES TEAM(team_id),
    FOREIGN KEY (coach_username) REFERENCES COACH(username),
    PRIMARY KEY (team_id, coach_username)
)

CREATE TABLE STADIUM
(
    stadium_id REAL,
    stadium_name CHAR(20),
    stadium_country CHAR(20),
    PRIMARY KEY (stadium_id)
)

CREATE TABLE VOLLEYBALL_MATCH_STADIUM
(
    session_id REAL,
    time_slot INTEGER NOT NULL,
    stadium_id REAL NOT NULL,
    match_date DATE NOT NULL,
    FOREIGN KEY (session_id) REFERENCES VOLLEYBALL_MATCH(session_id),
    FOREIGN KEY (stadium_id) REFERENCES STADIUM(stadium_id),
    PRIMARY KEY (session_id),
    CHECK (time_slot >= 0 AND time_slot <= 4),
    UNIQUE (stadium_id, match_date, time_slot)
)

CREATE TABLE RATES
(
    username CHAR(20),
    session_id REAL,
    rating REAL,
    FOREIGN KEY (username) REFERENCES JURY(username),
    FOREIGN KEY (session_id) REFERENCES VOLLEYBALL_MATCH(session_id),
    PRIMARY KEY (username, session_id)
)

CREATE TABLE PLAYER_TEAM
(
    username CHAR(20) NOT NULL,
    team_id REAL NOT NULL,
    FOREIGN KEY (username) REFERENCES PLAYER(username) ON DELETE CASCADE  ON UPDATE CASCADE,
    FOREIGN KEY (team_id) REFERENCES TEAM(team_id) ON DELETE CASCADE  ON UPDATE CASCADE,
    PRIMARY KEY (username, team_id)
)
