#Dies ein Modul, das verschiedene Funktionen fuer Logs und Plots enthaelt, kurz für das dataprocessing

module Dataprocessing

def writeLog(wert,log)
	#hier kommt der Code hin, der Logs schreibt
	puts wert
	puts log
end

def drawPlot(logfile, outputfile, titel)
	system "ploticus -prefab chron data=../log/"+logfile+" header=yes x=1 y=2 datefmt=mm/dd/yyyy  xinc=\"1 day\" mode=line 	unittype=datetime title=\"#{titel}\" -o ../graph/"+outputfile+" -png"
end

class Spannung
	#Attribute werden festgelegt:
	attr_accessor :wert, :quelle
	
	def to_temp
		@wert*5
	end
end

end