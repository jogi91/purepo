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

def getVoltage(source)
	case source
		when "zufall"
			result = rand(50)-20
			$log.debug("zufallswert ausgelesen")
			$log.debug(result)
		#when "temperatur"
		#hier adc auslesen
		else
			$log.warn("keine Auslesemethode fuer diese Quelle definiert")
	end
	result
end

class Spannung
	#Attribute werden festgelegt:
	attr_accessor :zahlwert, :quelle
	
	#initialisierung per default als Temperatur
	def initialize(zahlwert, quelle = "temperatur")
		@zahlwert = zahlwert
		@quelle = quelle
	end
	
	def to_i
		case @quelle
			when "temperatur"
				self.to_temp
				$log.debug("to_temp aufgerufen")
			when "humidity"
				self.to_humid
				$log.debug("to_humid aufgerufen")
			when "zufall"
				self.to_zufall
				$log.debug("to_zufall aufgerufen")
			else
				$log.warn "Spannung hat keine gueltige Quelle"
		end
	end
	
	def to_temp
	end
	def to_humid
	end
	def to_zufall
		return self.to_i
	end
	
	def debug
		puts "Zahlwert: "+zahlwert.to_s
		puts "quelle: "+quelle
		#self.to_wert
	end
	
end

end