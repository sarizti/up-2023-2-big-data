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

INSERT INTO players (name, flag, year_pro, weight, height, hand)
SELECT DISTINCT * FROM (
SELECT Winner, NULLIF(pl1_flag, ''), CAST(NULLIF(pl1_year_pro, '') as INTEGER), CAST(NULLIF(pl1_weight, '') as INTEGER), CAST(NULLIF(pl1_height, '') as INTEGER), NULLIF(pl1_hand, '')
FROM report
UNION
SELECT Loser, NULLIF(pl2_flag, ''), CAST(NULLIF(pl2_year_pro, '') as INTEGER), CAST(NULLIF(pl2_weight, '') as INTEGER), CAST(NULLIF(pl2_height, '') as INTEGER), NULLIF(pl2_hand, '')
FROM report) t;

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
    Round AS round, "Best of" AS best_of, Comment AS comment,
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
