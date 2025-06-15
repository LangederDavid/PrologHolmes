# PrologHolmes - Der Fall Steinfeld

Willkommen zu *PrologHolmes*, einem interaktiven Kriminal-Textadventure in Prolog, das dich in die Rolle des erfahrenen Detektivs Travis versetzt.

Baron von Steinfeld wurde in seiner Villa brutal ermordet. Die Überwachungskameras zeigen: Niemand hat das Anwesen verlassen oder betreten. Der Mörder ist einer der Bewohner - und er ist noch immer im Haus!

## Spielstart

### Spiel starten
1. **Hauptdatei laden:**
   ```prolog
   ?- consult('main.pl').
   ```
3. **Spiel starten:**
   ```prolog
   ?- start.
   ```

### Spielbefehle
- `look.` - Umgebung betrachten
- `n.` `s.` `e.` `w.` - Bewegung (Norden, Süden, Osten, Westen)
- `unten.` `oben.` - Treppen benutzen
- `interrogate('Name').` - Verdächtige verhören
- `examine('Objekt').` - Gegenstände untersuchen
- `take('Objekt').` - Gegenstände aufnehmen
- `inventory.` - Inventar anzeigen
- `clues.` - Gesammelte Hinweise anzeigen
- `accuse('Name').` - Jemanden des Mordes beschuldigen
- `hint.` - Hilfestellung erhalten
- `halt.` - Spiel beenden

**Wichtig:** Alle Namen und Objekte müssen in Anführungszeichen stehen!

## Die Villa und ihre Bewohner

### Orte
- **Eingangshalle** - Tatort (Startpunkt)
- **Wohnzimmer** - Gemütlicher Aufenthaltsraum
- **Küche** - Hier fehlt ein Messer...
- **Bibliothek** - Voller Geheimnisse und Dokumente
- **Schlafzimmer** - Des Barons private Räume
- **Keller** - Dunkle Geheimnisse
- **Garten** - Verdächtige Spuren
- **Garage** - Versteckte Beweise

### Verdächtige Personen
- **Oma Gerti** - Die nervöse Großmutter (Wohnzimmer)
- **Onkel Olaf** - Der verdächtig saubere Gärtner (Garten)
- **Kayla** - Die trauernde Verlobte (Schlafzimmer)
- **Hauskoch Josef** - Der schwitzende Koch (Küche)
- **Dr. Weber** - Der Hausarzt mit Geheimnissen (Bibliothek)
- **Anwalt Mueller** - Der geheimnisvolle Jurist (Garage)

## Spielziel

**Finde den wahren Mörder von Baron von Steinfeld!**

Sammle Hinweise, verhöre alle Verdächtigen und untersuche verdächtige Gegenstände. Aber Vorsicht: Beschuldigst du die falsche Person, verlierst du das Spiel! Nur mit allen wichtigen Beweisen kannst du den Fall lösen.

### Spieltipps
- Besuche alle Räume und untersuche alle Gegenstände
- Verhöre jeden Verdächtigen mindestens einmal
- Nutze `clues.` um deine gesammelten Hinweise zu überprüfen
- Der `hint.` Befehl hilft, wenn du nicht weiterkommst
- Achte besonders auf Widersprüche in den Aussagen

**Viel Glück, Detective.**


**Team**
- Langeder David
- Dollhäubl Arian
