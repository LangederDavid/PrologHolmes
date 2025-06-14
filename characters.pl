:- dynamic(suspect/2).

suspect('Oma Gerti', 'Sitzt vorm Fernseher, doch scheint nervös zu sein.').
suspect('Onkel Olaf', 'Wirkt besorgt, aber kooperativ.').
suspect('Kayla', 'Hat Tränen in den Augen, schweigt jedoch.').
suspect('Hauskoch Josef', 'Vermeidet Blickkontakt, schwitzt stark.').

interrogate(Suspect) :-
    suspect(Suspect, Description),
    format("~w sagt: '~w'~n", [Suspect, Description]).