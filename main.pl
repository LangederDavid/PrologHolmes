% === DYNAMISCHE FAKTEN ===

:- dynamic(player/2).
:- dynamic(suspect/2).
:- dynamic(item/2).
:- dynamic(inventory/1).

% === ORTE UND WEGE ===

location('Wohnzimmer', 'Ein gemütlicher Raum mit einem alten Kamin.').
location('Küche', 'Die Küche riecht nach frischen Gewürzen, doch ein Messer fehlt.').
location('Garten', 'Draußen ist es düster. Ein kalter Wind weht durch die Nacht.').

path('Wohnzimmer', 'Osten', 'Küche').
path('Küche', 'Westen', 'Wohnzimmer').
path('Wohnzimmer', 'Süden', 'Garten').

% === SPIELER ===

player(travis, 'Wohnzimmer').

setLocation(NewLocation) :-
    retract(player(travis, _)),
    asserta(player(travis, NewLocation)).

% === SPIELSTART ===

start :-
    write('*Ring Ring*'), nl, nl,
    write('Eine verzerrte Stimme am Telefon:'), nl,
    write('''Eine Leiche wurde in der Villa gefunden... Niemand kam rein, niemand ging raus.'''), nl,
    write('''Der Mörder ist noch im Haus, Detektiv. Finden Sie ihn... bevor er SIE findet.'''), nl, nl,
    write('Willkommen zu PrologHolmes'), nl,
    write('Du bist Travis, ein erfahrener Detektiv.'), nl,
    write('Ein Mord wurde begangen – und der Täter ist noch unter den Bewohnern der Villa.'), nl,
    write('Verhöre die Verdächtigen, finde Hinweise, und überlebe die Nacht!'), nl, nl,
    show_help,
    look.

% === HILFE ===

show_help :-
    write('Verfügbare Befehle:'), nl,
    write('start.              -- Spiel starten'), nl,
    write('n. s. e. w.         -- Nach Norden, Süden, Osten, Westen gehen'), nl,
    write('look.               -- Umgebung ansehen'), nl,
    write('interrogate(Name).  -- Eine Person verhören (z. B. interrogate(''Oma Gerti'').)'), nl,
    write('take(Objekt).       -- Einen Gegenstand aufnehmen'), nl,
    write('drop(Objekt).       -- Einen Gegenstand ablegen'), nl,
    write('inventory.          -- Zeigt dein Inventar'), nl,
    write('accuse(Name).       -- Einen Verdächtigen beschuldigen'), nl,
    write('halt.               -- Spiel beenden'), nl, nl.

% === BEWEGUNG ===

n :- move('Norden').
s :- move('Süden').
e :- move('Osten').
w :- move('Westen').

move(Direction) :-
    player(travis, Location),
    path(Location, Direction, NewLocation),
    setLocation(NewLocation),
    look.
move(_) :-
    write('Dorthin kannst du nicht gehen.'), nl.

% === UMGEBUNG ===

look :-
    player(travis, Location),
    location(Location, Description),
    write('Du bist in '), write(Location), write('. '), write(Description), nl,
    findall(S, (suspect(S, _), player(travis, Location)), Suspects),
    ( Suspects \= [] ->
        write('Personen hier: '), write(Suspects), nl
    ; true ),
    findall(I, item(I, Location), Items),
    ( Items \= [] ->
        write('Gegenstände hier: '), write(Items), nl
    ; true ).

% === VERDÄCHTIGE ===

suspect('Oma Gerti', 'Sitzt vorm Fernseher, doch scheint nervös zu sein.').
suspect('Onkel Olaf', 'Wirkt besorgt, aber kooperativ.').
suspect('Kayla', 'Hat Tränen in den Augen, schweigt jedoch.').
suspect('Hauskoch Josef', 'Vermeidet Blickkontakt, schwitzt stark.').

interrogate(Name) :-
    suspect(Name, Aussage),
    write(Name), write(' sagt: '''), write(Aussage), write(''''), nl.
interrogate(_) :-
    write('Diese Person ist nicht verdächtig oder nicht in deiner Nähe.'), nl.

% === GEGENSTÄNDE ===

item('Blutiges Messer', 'Küche').

take(Item) :-
    player(travis, Location),
    item(Item, Location),
    assertz(inventory(Item)),
    retract(item(Item, Location)),
    write('Du hast '), write(Item), write(' aufgenommen.'), nl.
take(_) :-
    write('Dieses Objekt ist nicht hier.'), nl.

drop(Item) :-
    inventory(Item),
    player(travis, Location),
    retract(inventory(Item)),
    assertz(item(Item, Location)),
    write('Du hast '), write(Item), write(' abgelegt.'), nl.
drop(_) :-
    write('Du hast diesen Gegenstand nicht.'), nl.

inventory :-
    findall(I, inventory(I), Items),
    ( Items = [] ->
        write('Dein Inventar ist leer.'), nl
    ; write('Du trägst: '), write(Items), nl
    ).

% === BESCHULDIGUNG ===

accuse(Name) :-
    suspect(Name, _),
    write('Du beschuldigst '), write(Name), write('. Doch war es wirklich der Täter...?'), nl.
accuse(_) :-
    write('Diese Person kennst du nicht.'), nl.
