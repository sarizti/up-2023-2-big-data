-- Glitches

-- The CSV file contains some glitches that complicate the relationships between the chosen table structure. Before starting to feed the data to the tables lets cleanup the data first

-- see csv row 3152 (in context)
UPDATE report SET ATP='6' WHERE CAST(SUBSTR(Date, 7, 4) AS INTEGER)=2020 AND atp='7' AND location='Montpellier';

-- see csv row 4216 (in context)
UPDATE report SET Date=REPLACE(Date, '2018', '2019') WHERE CAST(SUBSTR(Date, 7, 4) AS INTEGER)=2018 AND atp='3' AND Tournament='Maharashtra Open';

-- some locations end with a ' ' and cause duplication
UPDATE report SET Location=TRIM(Location), Tournament=TRIM(Tournament) WHERE TRUE;

-- last few rows are glitchy and cannot be worked with
DELETE FROM report WHERE Location = '';

-- Data inserts

INSERT INTO players (name, flag, year_pro, weight, height, hand)
SELECT DISTINCT * FROM (
    SELECT Winner, NULLIF(pl1_flag, ''), CAST(NULLIF(pl1_year_pro, '') as INTEGER), CAST(NULLIF(pl1_weight, '') as INTEGER), CAST(NULLIF(pl1_height, '') as INTEGER), NULLIF(pl1_hand, '')
    FROM report
    UNION
    SELECT Loser, NULLIF(pl2_flag, ''), CAST(NULLIF(pl2_year_pro, '') as INTEGER), CAST(NULLIF(pl2_weight, '') as INTEGER), CAST(NULLIF(pl2_height, '') as INTEGER), NULLIF(pl2_hand, '')
    FROM report
) t;

INSERT INTO locations (name)
SELECT DISTINCT Location
FROM report;

INSERT INTO tournaments (name)
SELECT DISTINCT Tournament
FROM report;

INSERT INTO events (year, atp, series, tournament_id, location_id)
SELECT DISTINCT
    CAST(SUBSTR(Date, 7, 4) AS INTEGER) AS yr,
    CAST(ATP as INTEGER) AS atp,
    Series,
    (SELECT id FROM tournaments WHERE name=Tournament) AS tournament_id,
    (SELECT id FROM locations WHERE name=Location) AS location_id
FROM report;

INSERT INTO courts (court, surface, location_id)
SELECT DISTINCT Court, Surface,
    (SELECT id FROM locations WHERE name=Location) AS location_id
FROM report;

INSERT INTO matches (id, date, round, best_of, comment, event_id, court_id)
SELECT id,
    SUBSTR(Date, 7, 4) || '-' || SUBSTR(Date, 4, 2) || '-' || SUBSTR(Date, 1, 2) AS date,
    Round AS round, CAST("Best of" AS INTEGER) AS best_of, Comment AS comment,
    (SELECT e.id
        FROM events e JOIN locations l on e.location_id=l.id
        WHERE l.name=Location AND e.year=CAST(SUBSTR(Date, 7, 4) AS INTEGER) AND e.atp=CAST(ATP as INTEGER)
    ) AS event_id,
    (SELECT c.id
        FROM events e JOIN locations l on e.location_id=l.id JOIN courts c on l.id=c.location_id
        WHERE l.name=Location AND e.year=CAST(SUBSTR(Date, 7, 4) AS INTEGER) AND e.atp=CAST(ATP as INTEGER)
        AND c.court=Court AND c.surface=Surface
    ) AS court_id
FROM report;

INSERT INTO players_matches (new_rank, new_points, win, match_id, player_id)
SELECT * FROM (
    SELECT
        CAST(WRank AS INTEGER) AS new_rank,
        CAST(WPts AS INTEGER) AS new_points,
        TRUE AS win,
        id AS match_id,
        (SELECT id FROM players WHERE name=Winner) as player_id
    FROM report
    UNION
    SELECT
        CAST(LRank AS INTEGER) AS new_rank,
        CAST(LPts AS INTEGER) AS new_points,
        FALSE AS win,
        id AS match_id,
        (SELECT id FROM players WHERE name=Loser) as player_id
    FROM report
) t;

INSERT INTO players_matches_sets (players_matches_id, set_num, games)
SELECT m.id, 1, CAST(r.W1 AS INTEGER) FROM report r, players_matches m, players p WHERE r.id=m.match_id AND p.id=m.player_id AND r.Winner=p.name AND r.W1 <> ''
UNION
SELECT m.id, 2, CAST(r.W2 AS INTEGER) FROM report r, players_matches m, players p WHERE r.id=m.match_id AND p.id=m.player_id AND r.Winner=p.name AND r.W2<>''
UNION
SELECT m.id, 3, CAST(r.W3 AS INTEGER) FROM report r, players_matches m, players p WHERE r.id=m.match_id AND p.id=m.player_id AND r.Winner=p.name AND r.W3<>''
UNION
SELECT m.id, 4, CAST(r.W4 AS INTEGER) FROM report r, players_matches m, players p WHERE r.id=m.match_id AND p.id=m.player_id AND r.Winner=p.name AND r.W4<>''
UNION
SELECT m.id, 5, CAST(r.W5 AS INTEGER) FROM report r, players_matches m, players p WHERE r.id=m.match_id AND p.id=m.player_id AND r.Winner=p.name AND r.W5<>''
UNION
SELECT m.id, 1, CAST(r.L1 AS INTEGER) FROM report r, players_matches m, players p WHERE r.id=m.match_id AND p.id=m.player_id AND r.Loser=p.name AND r.W1<>''
UNION
SELECT m.id, 2, CAST(r.L2 AS INTEGER) FROM report r, players_matches m, players p WHERE r.id=m.match_id AND p.id=m.player_id AND r.Loser=p.name AND r.W2<>''
UNION
SELECT m.id, 3, CAST(r.L3 AS INTEGER) FROM report r, players_matches m, players p WHERE r.id=m.match_id AND p.id=m.player_id AND r.Loser=p.name AND r.L3<>''
UNION
SELECT m.id, 4, CAST(r.L4 AS INTEGER) FROM report r, players_matches m, players p WHERE r.id=m.match_id AND p.id=m.player_id AND r.Loser=p.name AND r.L4<>''
UNION
SELECT m.id, 5, CAST(r.L5 AS INTEGER) FROM report r, players_matches m, players p WHERE r.id=m.match_id AND p.id=m.player_id AND r.Loser=p.name AND r.L5 <> '';
