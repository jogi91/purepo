require "dataprocessing"
require "logger"

$log = Logger.new(STDERR)

include Dataprocessing

$log.debug("App launched")



# Array mit allen zu verarbeitenden Werten fuellen als Konfiguration:
werte = ["temperatur", "weiterer Wert"]
$log.info("folgende Werte werden ausgegeben")
$log.info(werte)

#Fuer jeden Wert folgendes tun:
werte.each { |wert|
	#Spannungsobjekt erstellen
	zahlwert = 5
	wert = Spannung.new(zahlwert, wert)
	$log.info(wert)
	wert.to_i
	#writeLog()
	}

#erst wenn alle Logs geschrieben sind, die Graphen zeichnen.
werte.each {|wert|
	#drawPlot("temperatur/#{Time.now.year}temperatur$log","temperatur/#{Time.now.year}temperatur$log.png","Temperaturen des Jahres #{Time.now.year}")	}
	}
