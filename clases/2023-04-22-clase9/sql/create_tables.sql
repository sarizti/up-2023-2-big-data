DROP TABLE IF EXISTS report;
CREATE TABLE report(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    ATP, Location, Tournament, Date, Series, Court, Surface, Round, "Best of", Winner, Loser, WRank, LRank, WPts, LPts, W1, L1, W2, L2, W3, L3, W4, L4, W5, L5,
    Comment, pl1_flag, pl1_year_pro, pl1_weight, pl1_height, pl1_hand, pl2_flag, pl2_year_pro, pl2_weight, pl2_height, pl2_hand
);

DROP TABLE IF EXISTS matches;
CREATE TABLE matches(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date DATE NOT NULL, -- 'Date' comes formatted as 26/01/2022 and needs to be converted to 2022-01-26
    round TEXT NOT NULL, -- 'Round' e.g. '1st Round'
    best_of INTEGER NOT NULL, -- 'Best of' e.g. 3
    comment TEXT NOT NULL, -- 'Comment' e.g. 'completed'|'retired'
    event_id INTEGER REFERENCES events(id) NOT NULL,
    created_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL
);

DROP TABLE IF EXISTS events;
CREATE TABLE events( -- combination of tournament + location
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    year INTEGER NOT NULL, -- contained in 'Date'
    atp INTEGER NOT NULL, -- 'ATP' e.g. 1|2|3. looks like the number of the tournament in the year
    series TEXT NOT NULL, -- 'Series' e.g. ATP250
    tournament_id INTEGER REFERENCES tournaments(id) NOT NULL,
    created_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT year_atp UNIQUE (year, atp)
);

DROP TABLE IF EXISTS event_location;
CREATE TABLE event_location( -- there is just one case (Montpellier,Pune in 2020, APT7 where there were 2 locations per 1 event
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    event_id INTEGER REFERENCES events(id) NOT NULL,
    location_id INTEGER REFERENCES locations(id) NOT NULL,
    created_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT event_location UNIQUE (event_id, location_id)
);

DROP TABLE IF EXISTS tournaments;
CREATE TABLE tournaments(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL, -- 'Tournament' e.g. 'Melbourne Summer Set'
    created_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT name UNIQUE (name)
);

DROP TABLE IF EXISTS locations;
CREATE TABLE locations(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL, -- 'Location' e.g. 'Melbourne'
    created_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT name UNIQUE (name)
);

DROP TABLE IF EXISTS courts;
CREATE TABLE courts(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    court TEXT NOT NULL CHECK(court in ('Indoor', 'Outdoor')), -- 'Court'
    surface TEXT NOT NULL CHECK(surface in ('Hard', 'Grass', 'Clay', 'Carpet')), -- 'Surface'
    location_id INTEGER REFERENCES locations(id),
    created_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL
);

DROP TABLE IF EXISTS players;
CREATE TABLE players(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL, -- 'Winner'|'Loser' e.g. 'Djere L.'
    flag TEXT NOT NULL, -- 'pl1_flag' e.g. 'KOR'|'BRA'
    year_pro INTEGER NOT NULL, -- 'pl1_year_pro' e.g. 2015
    weight INTEGER, -- 'pl1_weight' e.g. 72
    height INTEGER, -- 'pl1_height' e.g.180
    hand TEXT CHECK(hand in ('Right-Handed', 'Left-Handed')), -- 'pl1_hand'
    created_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT name UNIQUE (name)
);

DROP TABLE IF EXISTS players_matches;
CREATE TABLE players_matches(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    new_rank INTEGER NOT NULL, -- 'WRank'|'LRank' e.g. 52
    new_points INTEGER NOT NULL, -- 'WPts'|'LPts' e.g. 1131
    win INTEGER NOT NULL, -- TRUE|FALSE
    match_id INTEGER REFERENCES matches(id) NOT NULL,
    player_id INTEGER REFERENCES players(id) NOT NULL,
    created_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL
);

DROP TABLE IF EXISTS players_matches_sets;
CREATE TABLE players_matches_sets(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    players_matches_id INTEGER REFERENCES players_matches(id) NOT NULL,
    set_num INTEGER NOT NULL, -- 'W1'|'L2'|... e.g. 1-5
    games INTEGER NOT NULL, -- 1-7
    created_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL
);
