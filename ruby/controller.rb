#Diese Klasse bietet die Funktionen an, um mit dem Oktopus-Controller zu kommunizieren
#Sie basiert auf dem RubyInline Gem, um auf die C-Libraries zuzugreifen
#http://www.zenspider.com/ZSS/Products/RubyInline/

class Controller

	inline do |builder|
		builder.c ' 
		void initialize() { //Initialisierung -> octopus init und open
		struct octopus_context octopus;
		if (!octopus_init (&octopus))
			printf ("%s\n", octopus.error_str);
		if (octopus_open (&octopus) < 0) {
			printf ("%s\n", octopus.error_str);
			exit (0);
		}'
	end
	
	inline do |builder|
		builder.c '
		void close() { //close
		if (octopus_close (&octopus) < 1)
	 		printf ("ERROR: %s\n", octopus.error_str);
		}'
	end
	
	inline do |builder|
		builder.c '
		void hwdesc(){
		char desc[64];
		octopus_get_hwdesc (&octopus, desc);
		printf ("Device: %s\n", desc);
		}'
	end

end