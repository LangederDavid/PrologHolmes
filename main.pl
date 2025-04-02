:- include('locations.pl').
:- include('characters.pl').
:- include('items.pl').
:- include('game_logic.pl').


:- dynamic(player/2). % Spielername, aktueller Ort

% Startposition
player(travis, 'Wohnzimmer').

setLocation(NewLocation) :-
    retract(player(travis, _)),
    asserta(player(travis, NewLocation)).


start :-
    format("Willkommen zu PrologHolmes!~n"),
    look.
