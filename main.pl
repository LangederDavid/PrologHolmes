% === DYNAMISCHE FAKTEN ===

:- dynamic(player/2).
:- dynamic(inventory/1).
:- dynamic(clue_found/1).
:- dynamic(game_over/0).

% Include all other modules
:- include('locations.pl').
:- include('characters.pl').
:- include('items.pl').

% === SPIELER ===

player(travis, 'Eingangshalle').

setLocation(NewLocation) :-
    retract(player(travis, _)),
    asserta(player(travis, NewLocation)).

% === SPIELSTART ===

start :-
    retractall(clue_found(_)),
    retractall(game_over),
    retractall(inventory(_)),
    setLocation('Eingangshalle'),
    write('*Ring Ring*'), nl, nl,
    write('Eine verzerrte Stimme am Telefon:'), nl,
    write('"Eine Leiche wurde in der Villa gefunden... Niemand kam rein, niemand ging raus."'), nl,
    write('"Der Moerder ist noch im Haus, Detektiv. Finden Sie ihn... bevor er SIE findet."'), nl, nl,
    write('*** PROLOGHOLMES - DER FALL STEINFELD ***'), nl,
    write('Du bist Travis, ein erfahrener Detektiv.'), nl,
    write('Baron von Steinfeld wurde in seiner Villa erstochen aufgefunden.'), nl,
    write('Alle Verdaechtigen sind noch im Haus - einer von ihnen ist der Moerder!'), nl,
    write('Sammle Hinweise, verhoere die Verdaechtigen und finde den wahren Taeter.'), nl,
    write('WARNUNG: Wenn du den falschen beschuldigst, verlierst du!'), nl, nl,
    show_help,
    look.

% === HILFE ===

show_help :-
    write('*** VERFUEGBARE BEFEHLE ***'), nl,
    write('start.              -- Spiel starten'), nl,
    write('look.               -- Umgebung ansehen'), nl,
    write('ways.               -- Moegliche Richtungen anzeigen'), nl,
    write('n. s. e. w.         -- Nach Norden, Sueden, Osten, Westen gehen'), nl,
    write('u. d.               -- Nach oben/unten gehen (Treppen/Keller)'), nl,
    write('interrogate(Name).  -- Eine Person verhoeren'), nl,
    write('examine(Objekt).    -- Einen Gegenstand untersuchen'), nl,
    write('take(Objekt).       -- Einen Gegenstand aufnehmen'), nl,
    write('use(Objekt).        -- Einen Gegenstand verwenden'), nl,
    write('inventory.          -- Inventar anzeigen'), nl,
    write('clues.              -- Gefundene Hinweise anzeigen'), nl,
    write('accuse(Name).       -- Jemanden des Mordes beschuldigen'), nl,
    write('hint.               -- Kleiner Tipp'), nl,
    write('halt.               -- Spiel beenden'), nl, nl.

% === BEWEGUNG ===

n :- move('Norden').
s :- move('Sueden').
e :- move('Osten').
w :- move('Westen').
u :- move('Oben').
d :- move('Unten').

move(Direction) :-
    game_over,
    write('Das Spiel ist beendet! Starte mit start. neu.'), nl, !.
move(Direction) :-
    player(travis, Location),
    path(Location, Direction, NewLocation),
    setLocation(NewLocation),
    look,
    !.
move(_) :-
    write('Dorthin kannst du nicht gehen.'), nl.

% === UMGEBUNG ===

look :-
    game_over,
    write('Das Spiel ist beendet! Starte mit start. neu.'), nl, !.
look :-
    player(travis, Location),
    location(Location, Description),
    format('*** ~w ***~n', [Location]),
    format('~w~n~n', [Description]),
    
    % Zeige Verdaechtige
    findall(S, suspect_location(S, Location), Suspects),
    ( Suspects \= [] ->
        write('PERSONEN HIER: '),
        print_list(Suspects)
    ; true ),
    
    % Zeige Gegenstaende
    findall(I, item_location(I, Location), Items),
    ( Items \= [] ->
        write('GEGENSTAENDE HIER: '),
        print_list(Items)
    ; true ),
    !.

print_list([]).
print_list([H]) :- 
    format('~w~n', [H]).
print_list([H|T]) :- 
    format('~w, ', [H]),
    print_list(T).

% === INVENTAR ===

take(Item) :-
    game_over,
    write('Das Spiel ist beendet! Starte mit start. neu.'), nl, !.
take(Item) :-
    player(travis, Location),
    item_location(Item, Location),
    retract(item_location(Item, Location)),
    assertz(inventory(Item)),
    format('Du hast ~w aufgenommen.~n', [Item]),
    !.
take(_) :-
    write('Dieses Objekt ist nicht hier.'), nl.

inventory :-
    findall(I, inventory(I), Items),
    ( Items = [] ->
        write('Dein Inventar ist leer.'), nl
    ; 
        write('DU TRAEGST: '),
        print_list(Items)
    ), !.

% === HINWEISE SYSTEM ===

clues :-
    findall(C, clue_found(C), FoundClues),
    ( FoundClues = [] ->
        write('Du hast noch keine Hinweise gefunden.'), nl
    ; 
        write('*** GEFUNDENE HINWEISE ***'), nl,
        show_clue_details(FoundClues)
    ).

show_clue_details([]).
show_clue_details([H|T]) :-
    clue_description(H, Desc),
    format('- ~w~n', [Desc]),
    show_clue_details(T).

clue_description(gerti_testament, 'Testament wurde heute geaendert').
clue_description(olaf_alibi, 'Olafs Alibi ist fragwuerdig - saubere Schuhe').
clue_description(kayla_erbschaft, 'Kayla wuerde ohne Heirat nichts erben').
clue_description(josef_messer, 'Mordwaffe stammt aus Josefs Kueche').
clue_description(weber_gift, 'Dr. Weber hatte Zugang zu Giften').
clue_description(mueller_testament, 'Neues Testament hat unerwarteten Erben').
clue_description(testament_erbe, 'Kayla wurde als Alleinerbin gestrichen').
clue_description(zyankali_gift, 'Zyankali gefunden, aber Baron wurde erstochen').
clue_description(erpressung, 'Erpressungsbrief mit weiblicher Handschrift').
clue_description(handschuhe_beweis, 'Blutige Handschuhe gehoeren einer Frau').
clue_description(kellerschluessel, 'Schluessel fuer Kellertruhe gefunden').

% === BESCHULDIGUNG UND SPIELENDE ===

accuse(Murderer) :-
    game_over,
    write('Das Spiel ist beendet! Starte mit start. neu.'), nl, !.
accuse('Kayla') :-
    % Kayla ist die Taeterin!
    assertz(game_over),
    nl,
    write('*** HERZLICHEN GLUECKWUNSCH! ***'), nl,
    write('Du hast den Fall geloest!'), nl, nl,
    write('DIE LOESUNG:'), nl,
    write('Kayla war die Taeterin! Als der Baron sein Testament aenderte und'), nl,
    write('sie als Alleinerbin strich, wurde sie wahnsinnig vor Wut.'), nl,
    write('Sie nahm das Messer aus der Kueche, erstach den Baron und'), nl,
    write('versuchte die Tat zu vertuschen. Die blutigen Handschuhe'), nl,
    write('in der Garage und der Erpressungsbrief waren ihre Spuren.'), nl,
    write('Der Arzt Dr. Weber sollte nur abgelenkt werden mit dem Gift.'), nl, nl,
    write('*** FALL ABGESCHLOSSEN ***'), nl,
    !.
accuse(Suspect) :-
    suspect(Suspect, _),
    assertz(game_over),
    nl,
    write('*** GAME OVER ***'), nl,
    format('Du hast ~w beschuldigt, aber das war falsch!~n', [Suspect]),
    write('Kayla war die wahre Taeterin. Sie hoerte deine falsche'), nl,
    write('Beschuldigung und konnte unbemerkt entkommen!'), nl,
    write('Der Fall bleibt ungeloest...'), nl, nl,
    write('Starte mit start. neu, um es nochmal zu versuchen.'), nl,
    !.
accuse(_) :-
    write('Diese Person ist nicht verdaechtig.'), nl.

% === TIPP SYSTEM ===

hint :-
    game_over,
    write('Das Spiel ist beendet! Starte mit start. neu.'), nl, !.
hint :-
    findall(C, clue_found(C), Clues),
    length(Clues, NumClues),
    ( NumClues < 3 ->
        write('TIPP: Untersuche mehr Gegenstaende und verhoere alle Verdaechtigen!')
    ; NumClues < 6 ->
        write('TIPP: Achte auf die Handschuhe und das Testament - wer profitiert vom Tod?')
    ; NumClues < 9 ->
        write('TIPP: Eine Frau hat kleine Haende... und ein Motiv!')
    ; 
        write('TIPP: Du hast genug Hinweise! Wer wurde vom Testament gestrichen?')
    ), nl.

% === RICHTUNGEN ANZEIGEN ===
ways :-
    player(travis, Location),
    write('Moegliche Richtungen von '), write(Location), write(':'), nl,
    findall([Direction, Destination], path(Location, Direction, Destination), Paths),
    (Paths = [] ->
        write('Keine Ausgaenge verfuegbar.'), nl
    ;
        show_paths(Paths)
    ).

show_paths([]).
show_paths([[Direction, Destination]|Rest]) :-
    format("  ~w -> ~w~n", [Direction, Destination]),
    show_paths(Rest).

% === GEGENSTAENDE VERWENDEN ===
use(Item) :-
    inventory(Item),
    player(travis, Location),
    use_item(Item, Location),
    !.
use(Item) :-
    inventory(Item),
    write('Du kannst '), write(Item), write(' hier nicht verwenden.'), nl,
    !.
use(_) :-
    write('Du hast diesen Gegenstand nicht im Inventar.'), nl.

% === SPEZIELLE VERWENDUNGEN ===
use_item('Fernrohr', 'Garten') :-
    \+ clue_found(fernrohr_beobachtung),
    assertz(clue_found(fernrohr_beobachtung)),
    write('Du richtest das Fernrohr auf die Garage...'), nl,
    write('SCHOCKIEREND: Du siehst frische Reifenspuren! Jemand war heute Nacht unterwegs!'), nl,
    write('WICHTIGER HINWEIS: Die Spuren fuehren zur Garage - wer hat das Auto benutzt?'), nl,
    !.

use_item('Fernrohr', Location) :-
    format('Das Fernrohr ist hier in ~w nicht besonders nuetzlich. Versuche es im Garten.~n', [Location]).

use_item('Schluessel', 'Keller') :-
    \+ clue_found(truhe_geoeffnet),
    assertz(clue_found(truhe_geoeffnet)),
    write('Du verwendest den Schluessel an einer alten Truhe...'), nl,
    write('KLICK! Die Truhe oeffnet sich!'), nl,
    write('SCHOCKIERENDER FUND: Gestohlener Schmuck und eine blutige Bluse!'), nl,
    write('WICHTIGER HINWEIS: Die Bluse gehoert einer Frau - und sie riecht nach Kaylas Parfuem!'), nl,
    assertz(clue_found(kayla_beweis)),
    !.

use_item('Schluessel', Location) :-
    format('Der Schluessel passt hier in ~w nicht. Versuche es im Keller.~n', [Location]).

use_item('Giftflasche', _) :-
    write('Das Gift ist zu gefaehrlich zum Experimentieren!'), nl.

use_item(Item, _) :-
    format('Du weisst nicht, wie du ~w verwenden sollst.~n', [Item]).
