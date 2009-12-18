require "dataprocessing"
require "logger"

$log = Logger.new(STDERR)

include Dataprocessing

$log.debug("App launched")



# Array mit allen zu verarbeitenden Werten fuellen als Konfiguration:
werte = ["temperatur", "weiterer Wert"]
$log.debug("folgende Werte werden ausgegeben")
$log.debug(werte)

foo = Spannung.new 4

foo.to_wert

#drawPlot("temperatur/#{Time.now.year}temperatur$log","temperatur/#{Time.now.year}temperatur$log.png","Temperaturen des Jahres #{Time.now.year}")