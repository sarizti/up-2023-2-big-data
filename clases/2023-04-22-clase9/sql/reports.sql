-- direct emulation of the CSV file
SELECT
    matches.id,
    events.atp AS "ATP",
    locations.name AS "Location",
    tournaments.name AS "Tournament",
    matches.date AS "Date",
    events.series AS "Series",
    courts.court AS "Court",
    courts.surface AS "Surface",
    matches.round AS "Round",
    matches.best_of AS "Best of",
    winner_player.name AS "Winner",
    loser_player.name AS "Loser",
    winner_player_m.new_rank AS "WRank",
    loser_player_m.new_rank AS "LRank",
    winner_player_m.new_points AS "WPts",
    loser_player_m.new_points AS "LPts",
    (SELECT games FROM players_matches_sets WHERE players_matches_id=winner_player_m.id AND set_num=1) AS "W1",
    (SELECT games FROM players_matches_sets WHERE players_matches_id=loser_player_m.id AND set_num=1) AS "L1",
    (SELECT games FROM players_matches_sets WHERE players_matches_id=winner_player_m.id AND set_num=2) AS "W2",
    (SELECT games FROM players_matches_sets WHERE players_matches_id=loser_player_m.id AND set_num=2) AS "L2",
    (SELECT games FROM players_matches_sets WHERE players_matches_id=winner_player_m.id AND set_num=3) AS "W3",
    (SELECT games FROM players_matches_sets WHERE players_matches_id=loser_player_m.id AND set_num=3) AS "L3",
    (SELECT games FROM players_matches_sets WHERE players_matches_id=winner_player_m.id AND set_num=4) AS "W4",
    (SELECT games FROM players_matches_sets WHERE players_matches_id=loser_player_m.id AND set_num=4) AS "L4",
    (SELECT games FROM players_matches_sets WHERE players_matches_id=winner_player_m.id AND set_num=5) AS "W5",
    (SELECT games FROM players_matches_sets WHERE players_matches_id=loser_player_m.id AND set_num=5) AS "L5",
    matches.comment as "Comment",
    winner_player.flag AS "pl1_flag",
    winner_player.year_pro AS "pl1_year_pro",
    winner_player.weight AS "pl1_weight",
    winner_player.height AS "pl1_height",
    winner_player.hand AS "pl1_hand",
    loser_player.flag AS "pl2_flag",
    loser_player.year_pro AS "pl2_year_pro",
    loser_player.weight AS "pl2_weight",
    loser_player.height AS "pl2_height",
    loser_player.hand AS "pl2_hand"
FROM matches
JOIN events ON matches.event_id=events.id
JOIN tournaments ON events.tournament_id=tournaments.id
JOIN locations ON events.location_id=locations.id
JOIN courts ON matches.court_id=courts.id
JOIN players_matches AS winner_player_m ON winner_player_m.match_id=matches.id AND winner_player_m.win=TRUE
JOIN players AS winner_player ON winner_player.id=winner_player_m.player_id
JOIN players_matches AS loser_player_m ON loser_player_m.match_id=matches.id AND loser_player_m.win=FALSE
JOIN players AS loser_player ON loser_player.id=loser_player_m.player_id
ORDER BY matches.id;
