#Dies ein Modul, das verschiedene Funktionen fuer Logs und Plots enthaelt, kurz für das dataprocessing

module Dataprocessing

def writeLog(wert,log)
	#hier kommt der Code hin, der Logs schreibt
	puts wert
	puts log
end

def drawPlot(logfile, outputfile, titel)
	system "ploticus -prefab chron data=../$log/"+logfile+" header=yes x=1 y=2 datefmt=mm/dd/yyyy  xinc=\"1 day\" mode=line 	unittype=datetime title=\"#{titel}\" -o ../graph/"+outputfile+" -png"
end

class Spannung
	#Attribute werden festgelegt:
	attr_accessor :zahlwert, :quelle
	
	#initialisierung per default als Temperatur
	def initialize(zahlwert, quelle = "temperatur")
		@zahlwert = zahlwert
		@quelle = quelle
	end
	
	def to_wert
		case @quelle
			when "temperatur"
				self.to_temp
				$log.debug("to_temp aufgerufen")
			when "humidity"
				self.to_humid
				$log.debug("to_humid aufgerufen")
			else
				log.debug "Kein fall trifft zu"
		end
	end
	
	def to_temp
	end
	def to_humid
	end
	
	def debug
		puts "Zahlwert: "+zahlwert.to_s
		puts "quelle: "+quelle
		#self.to_wert
	end
	
end

end