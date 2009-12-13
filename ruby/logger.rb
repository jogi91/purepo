log="logdemo"
outputfile="graph.png"

system "ploticus -prefab chron data=../log/"+log+" header=yes x=1 y=2 datefmt=mm/dd/yyyy  xinc=\"1 day\" mode=line unittype=datetime title=\"temperatures this week\" -o ../graph/"+outputfile+" -png"