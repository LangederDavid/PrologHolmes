location('Wohnzimmer', 'Ein gemütlicher Raum mit einem alten Kamin.').
location('Küche', 'Die Küche riecht nach frischen Gewürzen, doch ein Messer fehlt.').
location('Garten', 'Draußen ist es düster. Ein kalter Wind weht durch die Nacht.').

path('Wohnzimmer', 'Osten', 'Küche').
path('Küche', 'Westen', 'Wohnzimmer').
path('Wohnzimmer', 'Süden', 'Garten').