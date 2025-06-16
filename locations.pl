% filepath: c:\HTL\Github\PoseThi\PrologHolmes\locations.pl

% === ORTE ===
location('Eingangshalle', 'Eine grosse Halle mit Marmorboden. Hier wurde die Leiche von Baron von Steinfeld gefunden.').
location('Wohnzimmer', 'Ein gemuetlicher Raum mit einem alten Kamin und Ledersesseln.').
location('Kueche', 'Die Kueche riecht nach frischen Gewuerzen, doch ein Messer fehlt im Messerblock.').
location('Bibliothek', 'Hohe Regale voller alter Buecher. Ein Schreibtisch steht in der Ecke.').
location('Schlafzimmer', 'Das Schlafzimmer des Barons. Alles ist ordentlich, bis auf eine offene Schublade.').
location('Keller', 'Ein dunkler, feuchter Keller mit Weinregalen und alten Truhen.').
location('Garten', 'Der Garten ist gepflegt, aber eine Schaufel liegt achtlos herum.').
location('Garage', 'Eine alte Garage mit Werkzeugen und einem alten Auto.').
location('Dachboden', 'Ein staubiger Dachboden voller alter Moebel und Erinnerungen.').
location('Geheimkammer', 'Eine versteckte Kammer hinter einem Buecherregal. Was wurde hier versteckt?').

% === WEGE ===
path('Eingangshalle', 'Norden', 'Wohnzimmer').
path('Wohnzimmer', 'Sueden', 'Eingangshalle').
path('Eingangshalle', 'Osten', 'Kueche').
path('Kueche', 'Westen', 'Eingangshalle').
path('Eingangshalle', 'Westen', 'Bibliothek').
path('Bibliothek', 'Osten', 'Eingangshalle').
path('Wohnzimmer', 'Norden', 'Schlafzimmer').
path('Schlafzimmer', 'Sueden', 'Wohnzimmer').
path('Kueche', 'Unten', 'Keller').
path('Keller', 'Oben', 'Kueche').
path('Eingangshalle', 'Sueden', 'Garten').
path('Garten', 'Norden', 'Eingangshalle').
path('Garten', 'Osten', 'Garage').
path('Garage', 'Westen', 'Garten').
path('Schlafzimmer', 'Oben', 'Dachboden').
path('Dachboden', 'Unten', 'Schlafzimmer').
path('Bibliothek', 'Unten', 'Geheimkammer').
path('Geheimkammer', 'Oben', 'Bibliothek').