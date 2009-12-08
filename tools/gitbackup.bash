#!/bin/bash

cd /home/jogi/.gitbackup/
touch /home/jogi/.gitbackup/test
# wenn das Skript einen Fehler Produziert hat, nicht mehr weiter ausführen.
if test -f /home/jogi/.gitbackup/scriptblock
	then
	echo "Um Backups wieder aufzunehmen, fehler Beheben und scriptblock löschen" >> fehlerlog.txt
	mail -s ".gitbackup failed" root < fehlerlog.txt
	exit 1
fi

# Alte Backupdatei temporär umbenennen
mv /home/jogi/.gitbackup/purepo/ /home/jogi/.gitbackup/purepo.old/

# aktuellsten Stand klonen, fehler in Datei umleiten, Rückgabewert speichern
git clone git@github.com:jogi91/purepo.git 2> fehlerlog.txt >> fehlerlog.txt
r=$?


# Wenn clone erfolgreich, dann altes backup löschen, sonst fehlermeldung ausgeben
if [ $r -eq 0 ]
	then rm -rf /home/jogi/.gitbackup/purepo.old/
else
	rm -rf /home/jogi/.gitbackup/purepo
	mv /home/jogi/.gitbackup/purepo.old/ /home/jogi/.gitbackup/purepo/
	echo "Fehler beim Clonen Aufgetreten, altest Backup nicht gelöscht" >> fehlerlog.txt
	date >> fehlerlog.txt
	touch scriptblock
	/home/jogi/.gitbackup/gitbackup.bash
fi
