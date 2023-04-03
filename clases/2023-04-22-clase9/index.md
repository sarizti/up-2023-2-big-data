Aprendizaje Automático Para Grandes Volúmenes de Datos
======================================================

Sábado 22 de abril de 2023, clase 9

Asistencia
----------

- [ ] 0214177@up.edu.mx Arroyo Vázquez, Jorge Armando (Armando, IIN) 
- [ ] ediazm@up.edu.mx  Díaz Medina, Eduardo (Lalo, Ext.)
- [ ] 0214020@up.edu.mx Escoto Aceves, María Andrea (Andrea, IID)
- [ ] 0248440@up.edu.mx Estrada Hernández, Héctor Raúl (Raúl, Ext. economía y gestión de negocios)
- [ ] 0214611@up.edu.mx Macías Álvarez, Judith (Judith, IIN)
- [ ] 0205608@up.edu.mx Orozco Alarcón, Javier (Javier, IIN) 
- [ ] 0216072@up.edu.mx Perez, Andrea (Andrea, IID)
- [ ] 0211501@up.edu.mx Ramirez Gonzalez, Jose Carlos (José Carlos, IIN)
- [ ] 0213865@up.edu.mx Valdivia Mendoza, Juan Manuel (JuanMa, Ext. Industrial Ags.)
- [ ] 0215080@up.edu.mx Villalpando Chávez, Natalia (Natalia, IID)

```mermaid
---
title: Tennis Data
---
classDiagram
    class players {
        id INT
    }
    class locations {
        id INT
    }
    class courts {
        id INT
        location_id INT
    }
    class tournaments {
        id INT
        location_id INT
    }
    class matches {
        id INT
        event_id INT
        court_id INT
    }
    class events {
        id INT
        tournament_id INT
    }
    class event_locations {
        id INT
        event_id INT
        location_id INT
    }
    class players_matches {
        id INT
        match_id INT
        player_id INT
    }
    class players_matches_sets {
        id INT
        players_matches_id INT
    }
        
    
    event_locations --> events
    event_locations --> locations
    events --> tournaments
    matches --> events
    matches --> courts
    players_matches --> players
    players_matches --> matches
    players_matches_sets --> players_matches
    courts --> locations
```



AQUÍ
nombre, lengua, fisica, quimica, gimnasia
"