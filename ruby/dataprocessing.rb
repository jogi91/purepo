#Dies ein Modul, das verschiedene Funktionen fuer Logs und Plots enthaelt, kurz für das dataprocessing

module Dataprocessing


  def writeLog(spannung,pfad)
  	FileUtils.mkdir_p("../log/"+pfad.reverse.gsub(/^.*?\//,'').reverse)	#Directory mit Regexp auslesen und erstellen, wenn es nicht existiert
  	File.new("../log/"+pfad, "w") unless File.exists?("../log/"+pfad) #File anlegen, wenn es nicht existiert
  	File.open("../log/"+pfad,"a+") do |datei|
  		datei.puts
  		datei.print Time.new.strftime("%m/%d/%Y.%H:%M")
  		datei.print " "
  		datei.print spannung
  	end
  end

def drawPlot(logfile, outputfile, titel)
	FileUtils.mkdir_p("../graph/"+outputfile.reverse.gsub(/^.*?\//,'').reverse)
	system "ploticus -prefab chron data=../log/"+logfile+" header=yes x=1 y=2 datefmt=mm/dd/yyyy  xinc=\"1 day\" mode=line 	unittype=datetime title=\"#{titel}\" -o ../graph/"+outputfile+" -png"
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
	attr_accessor :zahlwert, :quelle, :diagrammtiteljahr, :diagrammtitelmonat
	
	#initialisierung per default als Temperatur
	def initialize(zahlwert, quelle = "temperatur")
		@zahlwert = zahlwert
		@quelle = quelle
		#Hier wird der Diagrammtitel entschieden.
		case quelle
			when "zufall"
				@diagrammtiteljahr = "Zufälle des Jahres "+Time.now.year.to_s
				@diagrammtitelmonat = "Zufälle "+Time.now.strftime("%B %Y")
			when "temperatur"
				@diagrammtiteljahr = "Temperaturen des Jahres "+Time.now.year.to_s
				@diagrammtitelmonat = "Temperaturen "+Time.now.strftime("%B %Y")
			when "humidity"
				@diagrammtiteljahr = "Luftfeuchtigkeiten des Jahres "+Time.now.year.to_s
				@diagrammtitelmonat = "Leuftfeuchtigkeiten "+Time.now.strftime("%B %Y")
			else
				$log.warn("Wert "+wert.to_s+" ist nicht implementiert zum Graph zeichnen")
				$log.warn("skip")
				#nichts zeichnen, wenn der Wert nicht vorgesehen ist.
				next
		end
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
				ret = self.to_zufall
				$log.debug("to_zufall aufgerufen")
				return ret
			else
				$log.warn "Spannung hat keine gueltige Quelle"
		end
	end
	
	def to_temp
	end
	def to_humid
	end
	def to_zufall
		self.zahlwert
	end
	
	def debug
		puts "Zahlwert: "+zahlwert.to_s
		puts "quelle: "+quelle
		#self.to_wert
	end
	

end

end
