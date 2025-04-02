look :-
    player(travis, Location),
    location(Location, Description),
    format("Du bist in ~w. ~w~n", [Location, Description]),
    findall(S, suspect(S, _), Suspects),
    format("Hier sind: ~w~n", [Suspects]).

move(Direction) :-
    player(travis, Location),
    path(Location, Direction, NewLocation),
    setLocation(NewLocation),
    look.
