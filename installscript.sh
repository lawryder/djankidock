#!/bin/sh

# Ins Stammverzeichnis wechseln
cd /

# Aktuelle Tools installieren
apt-get update && apt-get install -y \
git \
nginx \
python3 \
python3-distutils \
python3-pip8


# Variablen festlegen
portorig=8001		# Der Port, auf dem die Daten empfangen und an Nginx weitergeleitet werden ("Externer" Port)
portunclutter=8002	# Der Port, an den die Daten von Nginx weitergeleitet werden (in ankisyncd.conf festlegen)

ip="hostname -I|cut -f1 -d ' '"		# IP auslesen; Hinweis beachten!
# ip="127.0.0.1" # So könnte eine Direktvergabe aussehen :-)

#### Hinweis! ################################################################################################################
# Bei den Variablen "$portorig" und "$portunclutter" beachten:								     #
# Port-orig bestimmt den von "außen" erreichbaren Port. Dieser leitet die Daten dann "bereinigt" an Port-unclutter weiter.   #
#															     #
# Bei der Variable "$ip" beachten:											     #
# Diese wird über "hostname -I" ausgelesen. Ist die IP des Containers schon beim Build bekannt, so kann diese auch direkt    #
# eingetragen werden.													     #
# Liegen mehrere mögliche Verbindungen vor, sollte die IP direkt vergeben werden					     #
##############################################################################################################################


# Und jetzt zum Hauptprogramm!

# Anki-Sync-Server von Github klonen. Es wird ein Ordner "Anki-Sync-Server" im Hauptverzeichnis angelegt.
git install djankiserv[mysql]

SYNC_ENDPOINT_MEDIA='http://localhost:8002/djs/msync/' SYNC_ENDPOINT='http://localhost:8002/djs/sync/' anki
