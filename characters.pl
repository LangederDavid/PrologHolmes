% filepath: c:\HTL\Github\PoseThi\PrologHolmes\characters.pl
:- dynamic(suspect/2).
:- dynamic(suspect_location/2).
:- dynamic(clue_found/1).

% === VERDAECHTIGE ===
suspect('Oma Gerti', 'Sitzt vorm Fernseher, doch scheint nervoes zu sein. Sie murmelt etwas von einem Testament.').
suspect('Onkel Olaf', 'Wirkt besorgt, aber kooperativ. Seine Kleider sind verdaechtig sauber fuer jemanden der im Garten gearbeitet hat.').
suspect('Kayla', 'Hat Traenen in den Augen, schweigt jedoch. Sie war die Verlobte des Barons und sollte ihn naechste Woche heiraten.').
suspect('Hauskoch Josef', 'Vermeidet Blickkontakt, schwitzt stark. Er hat Zugang zu allen Messern in der Kueche.').
suspect('Dr. Weber', 'Der Hausarzt der Familie. Wirkt professionell, aber seine Tasche riecht nach Chemikalien.').
suspect('Anwalt Mueller', 'War heute Abend hier um das Testament zu besprechen. Seine Aktentasche ist verschlossen.').

% === STANDORTE DER VERDAECHTIGEN ===
suspect_location('Oma Gerti', 'Wohnzimmer').
suspect_location('Onkel Olaf', 'Garten').
suspect_location('Kayla', 'Schlafzimmer').
suspect_location('Hauskoch Josef', 'Kueche').
suspect_location('Dr. Weber', 'Bibliothek').
suspect_location('Anwalt Mueller', 'Garage').

% === VERHOER SYSTEM ===
interrogate(Suspect) :-
    player(travis, Location),
    suspect_location(Suspect, Location),
    suspect(Suspect, Description),
    format("~w sagt: '~w'~n", [Suspect, Description]),
    reveal_clue(Suspect),
    !.
interrogate(Suspect) :-
    suspect(Suspect, _),
    format("~w ist nicht hier.~n", [Suspect]),
    !.
interrogate(_) :-
    write('Diese Person kenne ich nicht.'), nl.

% === HINWEISE SYSTEM ===
reveal_clue('Oma Gerti') :-
    \+ clue_found(gerti_testament),
    assertz(clue_found(gerti_testament)),
    write('Hinweis: Oma Gerti erwaehnt, dass der Baron sein Testament heute geaendert hat!'), nl.

reveal_clue('Onkel Olaf') :-
    \+ clue_found(olaf_alibi),
    assertz(clue_found(olaf_alibi)),
    write('Hinweis: Onkel Olaf behauptet, er war die ganze Zeit im Garten, aber seine Schuhe sind sauber!'), nl.

reveal_clue('Kayla') :-
    \+ clue_found(kayla_erbschaft),
    assertz(clue_found(kayla_erbschaft)),
    write('Hinweis: Kayla erwaehnt, dass sie ohne Heirat nichts erben wuerde!'), nl.

reveal_clue('Hauskoch Josef') :-
    \+ clue_found(josef_messer),
    assertz(clue_found(josef_messer)),
    write('Hinweis: Josef gibt zu, dass das Messer aus seiner Kueche stammt!'), nl.

reveal_clue('Dr. Weber') :-
    \+ clue_found(weber_gift),
    assertz(clue_found(weber_gift)),
    write('Hinweis: Dr. Weber hatte Zugang zu Giften und war heute Abend sehr nervoes!'), nl.

reveal_clue('Anwalt Mueller') :-
    \+ clue_found(mueller_testament),
    assertz(clue_found(mueller_testament)),
    write('Hinweis: Anwalt Mueller verraet, dass das neue Testament einen unerwarteten Erben benennt!'), nl.

reveal_clue(_).