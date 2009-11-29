#!/bin/bash

# wenn das Skript einen Fehler Produziert hat, nicht mehr weiter ausführen.
if test -f ~/.gitbackup/scriptblock
	then
	echo "Um Backups wieder aufzunehmen, fehler Beheben und scriptblock löschen" >> fehlerlog.txt
	mail -s ".gitbackup failed" root < fehlerlog.txt
	exit 1
fi

# Alte Backupdatei temporär umbenennen
mv ~/.gitbackup/purepo/ ~/.gitbackup/purepo.old/

# aktuellsten Stand klonen, fehler in Datei umleiten, Rückgabewert speichern
git clone http://wetterstation.kanti-wohlen.ch/purepo 2> fehlerlog.txt
r=$?


# Wenn clone erfolgreich, dann altes backup löschen, sonst fehlermeldung ausgeben
if [ $r -eq 0 ]
	then rm -rf ~/.gitbackup/purepo.old/
	echo "alles Ordnungsgemäss abgelaufen"
else
	rm -rf ~/.gitbackup/purepo
	mv ~/.gitbackup/purepo.old/ ~/.gitbackup/purepo/
	echo "Fehler beim Clonen Aufgetreten, altest Backup nicht gelöscht" >> fehlerlog.txt
	touch scriptblock

fi
