% filepath: c:\HTL\Github\PoseThi\PrologHolmes\items.pl
:- dynamic(item/2).
:- dynamic(item_location/2).
:- dynamic(examined/1).

% === GEGENSTAENDE UND BESCHREIBUNGEN ===
item('Blutiges Messer', 'Ein grausiges Kuechenmesser mit Blutflecken. Die Schneide ist scharf und das Blut ist noch frisch.').
item('Testament', 'Ein offizielles Dokument mit dem Siegel der Familie von Steinfeld. Es scheint heute unterschrieben worden zu sein.').
item('Giftflasche', 'Eine kleine Glasflasche mit einem Gift-Symbol. Sie riecht nach bitteren Mandeln - Zyankali!').
item('Schluessel', 'Ein alter Messingschluessel. Er passt zu einer der Truhen im Keller.').
item('Blutige Handschuhe', 'Lederhandschuhe mit Blutspritzern. Sie gehoeren eindeutig nicht dem Baron.').
item('Schmuckschatulle', 'Eine elegante Schatulle aus Ebenholz. Sie ist geoeffnet und leer - der Schmuck fehlt!').
item('Arztkoffer', 'Dr. Webers medizinische Tasche. Sie enthaelt Spritzen und verdaechtige Chemikalien.').
item('Schaufel', 'Eine Gartenschaufel mit frischer Erde. Wurde hier etwas vergraben?').
item('Mordwaffe', 'Das Tatmesser aus der Kueche. DNA-Spuren werden den Taeter ueberfuehren.').
item('Geheimbrief', 'Ein Brief an den Baron mit einer Erpressungsforderung. Die Handschrift ist weiblich.').

% === STANDORTE DER GEGENSTAENDE ===
item_location('Blutiges Messer', 'Eingangshalle').
item_location('Testament', 'Bibliothek').
item_location('Giftflasche', 'Bibliothek').
item_location('Schluessel', 'Schlafzimmer').
item_location('Blutige Handschuhe', 'Garage').
item_location('Schmuckschatulle', 'Schlafzimmer').
item_location('Arztkoffer', 'Bibliothek').
item_location('Schaufel', 'Garten').
item_location('Geheimbrief', 'Keller').

% === UNTERSUCHUNGS-SYSTEM ===
examine(Item) :-
    player(travis, Location),
    item_location(Item, Location),
    item(Item, Description),
    format("Du untersuchst ~w: ~w~n", [Item, Description]),
    reveal_item_clue(Item),
    assertz(examined(Item)),
    !.
examine(Item) :-
    item(Item, _),
    write('Dieses Objekt ist nicht hier.'), nl,
    !.
examine(_) :-
    write('Diesen Gegenstand gibt es nicht.'), nl.

% === ITEM HINWEISE ===
reveal_item_clue('Testament') :-
    \+ clue_found(testament_erbe),
    assertz(clue_found(testament_erbe)),
    write('WICHTIGER HINWEIS: Das Testament wurde heute geaendert! Kayla wurde als Alleinerbin gestrichen!'), nl.

reveal_item_clue('Giftflasche') :-
    \+ clue_found(zyankali_gift),
    assertz(clue_found(zyankali_gift)),
    write('WICHTIGER HINWEIS: Zyankali! Aber der Baron wurde erstochen, nicht vergiftet...'), nl.

reveal_item_clue('Geheimbrief') :-
    \+ clue_found(erpressung),
    assertz(clue_found(erpressung)),
    write('SCHOCKIEREND: Ein Erpressungsbrief! "Zahlen Sie 100.000 Euro oder Ihr Geheimnis kommt ans Licht!"'), nl.

reveal_item_clue('Blutige Handschuhe') :-
    \+ clue_found(handschuhe_beweis),
    assertz(clue_found(handschuhe_beweis)),
    write('BEWEISE: Diese Handschuhe gehoeren einer Frau! Sie sind zu klein fuer die maennlichen Verdaechtigen.'), nl.

reveal_item_clue('Schluessel') :-
    \+ clue_found(kellerschluessel),
    assertz(clue_found(kellerschluessel)),
    write('HINWEIS: Dieser Schluessel oeffnet eine der alten Truhen im Keller!'), nl.

reveal_item_clue(_).