#------------------------------------ HEAD ------------------------------------
scenario = "Matrix sentences context/random paradigm";
# Used in PhD project: Exploring cognitive decline through the aging ear with natural speech-based computational neurophysiology
# modified by Elena <elena.bolt.uzh@gmail.com>


# Buttons & logging.
active_buttons = 5;
button_codes = 1, 2, 3, 4, 5;    
response_matching = simple_matching;
response_logging = log_active;
 
# EEG triggering necessities.
write_codes = true;
pulse_width = 40;
default_output_port = 1;

# Looks.
default_font_size = 36;
default_font = "Calibri";
default_formatted_text = true;
default_background_color = "0, 0, 0";
default_text_color = "255, 255, 255";
default_text_align = align_center;



#------------------------------------ SDL -------------------------------------
begin;


# SDL variables.
$text_width = 1000;
$fixation_size = 160;
$inter_duration = 500;


# Keys w/ color sticker.
$number_key = "220, 77, 54";  # RGB red sticker
$enter_key = "0, 114, 192"; # RGB blue sticker


# WAV.
sound {
	wavefile {
		filename = "";  # PCL
		preload = false;
	} wav;
} S_item;


# Screen elements.
picture {
	text {
		caption = "+";
		font_size = $fixation_size;
	};
	x = 0; y = 0;
} P_focus;

picture {
	text {
		caption =
			"Willkommen zum Satzverständnis-Teil des EEG-Experiments!
		 
			Auf den nächsten Folien wird Ihnen die Aufgabe erklärt.
			
			Bitte drücken Sie jeweils auf die Entertaste (auf der Tastatur markiert mit <font color='$enter_key'>⚫</font>), um zur nächsten Folie zu kommen.";
		max_text_width = $text_width;
	};
	x = 0; y = 0;
} P_welcome;

picture {
   text {
      caption =
         "In diesem Teil der Studie hören Sie aus dem Lautsprecher eine Sprecherin, die etwas erzählt. Bitte hören Sie aufmerksam zu.

         Im Anschuss daran zeigen wir Ihnen vier Worte. Wir bitten Sie, aus den vier Worten mit der Tastatur dasjenige auszuwählen, das die Sprecherin gesagt hat. Falls Sie die Antwort nicht wissen, bitten wir Sie, zu raten.
         
         Bitte drücken Sie die Entertaste <font color='$enter_key'>⚫</font>, um fortzufahren.";
      max_text_width = $text_width;
      };
   x = 0; y = 0;
} P_instruction_I;

picture {
   text {
      caption =
         "Immer, wenn die Sprecherin etwas sagt, erscheint das Kreuz in der Mitte des Bildschirms:
         <font size='$fixation_size'>+</font>
         Sobald das Kreuz erscheint, bitten wir Sie, den Blick auf die Mitte des Bildschirms gerichtet zu halten, aufmerksam zuzuhören und möglichst still zu sitzen.

         Bitte drücken Sie die Entertaste <font color='$enter_key'>⚫</font>, um fortzufahren.";
      max_text_width = $text_width;
   };
x = 0; y = 0;
} P_instruction_II;

picture {
   text {
      caption =
         "Wir beginnen mit ein paar Übungsbeispielen. Gleich kommt das Symbol und Sie werden die Sprecherin hören.
   
         Bitte drücken Sie die Entertaste <font color='$enter_key'>⚫</font>, um die Übung zu starten.";
      max_text_width = $text_width;
   };
   x = 0; y = 0;
} P_instruction_III;

picture {
   text {
      caption =
         "Die Übung ist beendet. Falls Sie noch fragen haben, wenden Sie sich bitte an die Versuchsleiterin.
         
         Wenn Sie bereit sind, drücken Sie bitte die Entertaste <font color='$enter_key'>⚫</font>, um das Experiment zu starten.";
      max_text_width = $text_width;
   };
   x = 0; y = 0;
} P_instruction_VI;

picture {
   text {
      caption =
         "Bitte drücken Sie die Entertaste <font color='$enter_key'>⚫</font>, um fortzufahren.";
      max_text_width = $text_width;
   };
   x = 0; y = 0;
} P_space;

picture {
   text {
      caption =
         "Bitte machen Sie eine kurze Pause.

         Die Versuchsleiterin wird gleich bei Ihnen sein.";
      max_text_width = $text_width;
   };
   x = 0; y = 0;
} P_break;

picture {
   text {
      caption =
      "Besten Dank, die Aufgabe ist beendet.

		Die Versuchsleiterin wird gleich bei Ihnen sein.";
      max_text_width = $text_width;
   };
   x = 0; y = 0;
} P_end;


# Trials: Speech wave onset is triggered via audio channel, the rest by NBSP.
trial {
   trial_duration = stimuli_length;
	all_responses = false;
   stimulus_event {
      picture P_focus;
      time = 0;  
      code = "fix cross";
   };
   stimulus_event {
      sound S_item;
      deltat = 0;
   };
   stimulus_event {  # NBSP coding of my condition.
		nothing {};
      deltat = 0;
   } E_item;
   stimulus_event {  # NBPS coding of target word.
      nothing {};
         # deltat
         # port_code
   } E_target;
} T_audio;

trial {
   trial_type = specific_response;
   terminator_button = 5;
   trial_duration = forever;
   stimulus_event {
      picture P_welcome;
      time = 0;
   } E_instruction;
} T_instruction;

trial {
	all_responses = false;
   stimulus_event {
   picture {
      text { caption = ""; };
      x = 0; y = 0;
      };
   time = 0;
   duration = $inter_duration;
   } E_inter;
} T_inter;


# Template question trial array.
array { 
   TEMPLATE "T_ms_question.tem" {
      item_quest	opt_1	opt_2	opt_3	opt_4	target_key	quest_port	;
      "quest_con003"	"<font color='$number_key'>⚫</font> <b>1</b> Ehefrau"	"<font color='$number_key'>⚫</font> <b>2</b> Bekannten"	"<font color='$number_key'>⚫</font> <b>3</b> Kollege"	"<font color='$number_key'>⚫</font> <b>4</b> Partnerin"	1	1	;
      "quest_con004"	"<font color='$number_key'>⚫</font> <b>1</b> Gärtnerin"	"<font color='$number_key'>⚫</font> <b>2</b> Fischerin"	"<font color='$number_key'>⚫</font> <b>3</b> Fahrerin"	"<font color='$number_key'>⚫</font> <b>4</b> Bäuerin"	2	2	;
      "quest_con006"	"<font color='$number_key'>⚫</font> <b>1</b> Gärtnerin"	"<font color='$number_key'>⚫</font> <b>2</b> Bäuerin"	"<font color='$number_key'>⚫</font> <b>3</b> Obsthändler"	"<font color='$number_key'>⚫</font> <b>4</b> Verkäufer"	3	3	;
      "quest_con012"	"<font color='$number_key'>⚫</font> <b>1</b> Bergbauer"	"<font color='$number_key'>⚫</font> <b>2</b> Obsthändler"	"<font color='$number_key'>⚫</font> <b>3</b> Zoolöwe"	"<font color='$number_key'>⚫</font> <b>4</b> Hirtenhund"	4	4	;
      "quest_con015"	"<font color='$number_key'>⚫</font> <b>1</b> Kaffeehaus"	"<font color='$number_key'>⚫</font> <b>2</b> Restaurant"	"<font color='$number_key'>⚫</font> <b>3</b> Konditorei"	"<font color='$number_key'>⚫</font> <b>4</b> Bäckerei"	1	1	;
      "quest_con020"	"<font color='$number_key'>⚫</font> <b>1</b> Schiedsrichter"	"<font color='$number_key'>⚫</font> <b>2</b> Zoolöwe"	"<font color='$number_key'>⚫</font> <b>3</b> Kampfmeister"	"<font color='$number_key'>⚫</font> <b>4</b> Hirtenhund"	2	2	;
      "quest_con025"	"<font color='$number_key'>⚫</font> <b>1</b> Tourist"	"<font color='$number_key'>⚫</font> <b>2</b> Besucher"	"<font color='$number_key'>⚫</font> <b>3</b> Hotelgast"	"<font color='$number_key'>⚫</font> <b>4</b> Einbrecher"	3	3	;
      "quest_con028"	"<font color='$number_key'>⚫</font> <b>1</b> Notruf"	"<font color='$number_key'>⚫</font> <b>2</b> Detektiv"	"<font color='$number_key'>⚫</font> <b>3</b> Einbruch"	"<font color='$number_key'>⚫</font> <b>4</b> Polizei"	4	4	;
      "quest_con030"	"<font color='$number_key'>⚫</font> <b>1</b> Schreinerin"	"<font color='$number_key'>⚫</font> <b>2</b> Gärtnerin"	"<font color='$number_key'>⚫</font> <b>3</b> Partnerin"	"<font color='$number_key'>⚫</font> <b>4</b> Jägerin"	1	1	;
      "quest_con034"	"<font color='$number_key'>⚫</font> <b>1</b> Nichte"	"<font color='$number_key'>⚫</font> <b>2</b> Enkelin"	"<font color='$number_key'>⚫</font> <b>3</b> Freundin"	"<font color='$number_key'>⚫</font> <b>4</b> Cousine"	2	2	;
      "quest_con036"	"<font color='$number_key'>⚫</font> <b>1</b> Tourist"	"<font color='$number_key'>⚫</font> <b>2</b> Gitarrist"	"<font color='$number_key'>⚫</font> <b>3</b> Pianist"	"<font color='$number_key'>⚫</font> <b>4</b> Polizistin"	3	3	;
      "quest_con038"	"<font color='$number_key'>⚫</font> <b>1</b> Kampfmeister"	"<font color='$number_key'>⚫</font> <b>2</b> Hotelgast"	"<font color='$number_key'>⚫</font> <b>3</b> Obsthändler"	"<font color='$number_key'>⚫</font> <b>4</b> Teenager"	4	4	;
      "quest_con042"	"<font color='$number_key'>⚫</font> <b>1</b> Grossmutter"	"<font color='$number_key'>⚫</font> <b>2</b> Grossvater"	"<font color='$number_key'>⚫</font> <b>3</b> Nachbarin"	"<font color='$number_key'>⚫</font> <b>4</b> Ehefrau"	1	1	;
      "quest_con044"	"<font color='$number_key'>⚫</font> <b>1</b> Gärtnerin"	"<font color='$number_key'>⚫</font> <b>2</b> Jägerin"	"<font color='$number_key'>⚫</font> <b>3</b> Försterin"	"<font color='$number_key'>⚫</font> <b>4</b> Polizistin"	2	2	;
      "quest_con046"	"<font color='$number_key'>⚫</font> <b>1</b> Sportlehrer"	"<font color='$number_key'>⚫</font> <b>2</b> Obsthändler"	"<font color='$number_key'>⚫</font> <b>3</b> Kampfmeister"	"<font color='$number_key'>⚫</font> <b>4</b> Hotelgast"	3	3	;
      "quest_con049"	"<font color='$number_key'>⚫</font> <b>1</b> Jägerin"	"<font color='$number_key'>⚫</font> <b>2</b> Polizistin"	"<font color='$number_key'>⚫</font> <b>3</b> Gärtnerin"	"<font color='$number_key'>⚫</font> <b>4</b> Bäuerin"	4	4	;
      "quest_con054"	"<font color='$number_key'>⚫</font> <b>1</b> Wissenschaft"	"<font color='$number_key'>⚫</font> <b>2</b> Medizin"	"<font color='$number_key'>⚫</font> <b>3</b> Wirtschaft"	"<font color='$number_key'>⚫</font> <b>4</b> Ausbildung"	1	1	;
      "quest_con057"	"<font color='$number_key'>⚫</font> <b>1</b> Einbrecher"	"<font color='$number_key'>⚫</font> <b>2</b> Fotograf"	"<font color='$number_key'>⚫</font> <b>3</b> Gitarrist"	"<font color='$number_key'>⚫</font> <b>4</b> Polizist"	2	2	;
      "quest_con058"	"<font color='$number_key'>⚫</font> <b>1</b> Sportlehrer"	"<font color='$number_key'>⚫</font> <b>2</b> Schiedsrichter"	"<font color='$number_key'>⚫</font> <b>3</b> Boxkämpfer"	"<font color='$number_key'>⚫</font> <b>4</b> Kampfmeister"	3	3	;
      "quest_con059"	"<font color='$number_key'>⚫</font> <b>1</b> Ausbildung"	"<font color='$number_key'>⚫</font> <b>2</b> Medizin"	"<font color='$number_key'>⚫</font> <b>3</b> Internet"	"<font color='$number_key'>⚫</font> <b>4</b> Fernsehen"	4	4	;
      "quest_con064"	"<font color='$number_key'>⚫</font> <b>1</b> fromme"	"<font color='$number_key'>⚫</font> <b>2</b> grosse"	"<font color='$number_key'>⚫</font> <b>3</b> fleissige"	"<font color='$number_key'>⚫</font> <b>4</b> kühle"	1	1	;
      "quest_con065"	"<font color='$number_key'>⚫</font> <b>1</b> frommen"	"<font color='$number_key'>⚫</font> <b>2</b> fleissigen"	"<font color='$number_key'>⚫</font> <b>3</b> strengen"	"<font color='$number_key'>⚫</font> <b>4</b> schüchternen"	2	2	;
      "quest_con066"	"<font color='$number_key'>⚫</font> <b>1</b> gebackene"	"<font color='$number_key'>⚫</font> <b>2</b> gemusterte"	"<font color='$number_key'>⚫</font> <b>3</b> gebügelte"	"<font color='$number_key'>⚫</font> <b>4</b> gewaschene"	3	3	;
      "quest_con068"	"<font color='$number_key'>⚫</font> <b>1</b> dicke"	"<font color='$number_key'>⚫</font> <b>2</b> kleine"	"<font color='$number_key'>⚫</font> <b>3</b> starke"	"<font color='$number_key'>⚫</font> <b>4</b> grosse"	4	4	;
      "quest_con075"	"<font color='$number_key'>⚫</font> <b>1</b> schwarze"	"<font color='$number_key'>⚫</font> <b>2</b> grüne"	"<font color='$number_key'>⚫</font> <b>3</b> flache"	"<font color='$number_key'>⚫</font> <b>4</b> kühle"	1	1	;
      "quest_con077"	"<font color='$number_key'>⚫</font> <b>1</b> weisse"	"<font color='$number_key'>⚫</font> <b>2</b> grosse"	"<font color='$number_key'>⚫</font> <b>3</b> schwarze"	"<font color='$number_key'>⚫</font> <b>4</b> breite"	2	2	;
      "quest_con078"	"<font color='$number_key'>⚫</font> <b>1</b> weisse"	"<font color='$number_key'>⚫</font> <b>2</b> kleine"	"<font color='$number_key'>⚫</font> <b>3</b> neue"	"<font color='$number_key'>⚫</font> <b>4</b> schwarze"	3	3	;
      "quest_con079"	"<font color='$number_key'>⚫</font> <b>1</b> Sturm"	"<font color='$number_key'>⚫</font> <b>2</b> Wohnung"	"<font color='$number_key'>⚫</font> <b>3</b> Spielplatz"	"<font color='$number_key'>⚫</font> <b>4</b> Lärm"	4	4	;
      "quest_con080"	"<font color='$number_key'>⚫</font> <b>1</b> Laufsteg"	"<font color='$number_key'>⚫</font> <b>2</b> Spielplatz"	"<font color='$number_key'>⚫</font> <b>3</b> Steinofen"	"<font color='$number_key'>⚫</font> <b>4</b> Esstisch"	1	1	;
      "quest_con081"	"<font color='$number_key'>⚫</font> <b>1</b> lärmenden"	"<font color='$number_key'>⚫</font> <b>2</b> knurrenden"	"<font color='$number_key'>⚫</font> <b>3</b> wissenden"	"<font color='$number_key'>⚫</font> <b>4</b> zerrenden"	2	2	;
      "quest_con083"	"<font color='$number_key'>⚫</font> <b>1</b> hingelegten"	"<font color='$number_key'>⚫</font> <b>2</b> aufgesetzten"	"<font color='$number_key'>⚫</font> <b>3</b> kleingedruckten"	"<font color='$number_key'>⚫</font> <b>4</b> eingeprägten"	3	3	;
      "quest_con084"	"<font color='$number_key'>⚫</font> <b>1</b> Kühlschrank"	"<font color='$number_key'>⚫</font> <b>2</b> Lesebrille"	"<font color='$number_key'>⚫</font> <b>3</b> Pistazieneis"	"<font color='$number_key'>⚫</font> <b>4</b> Vanillejoghurt"	4	4	;
      "quest_con088"	"<font color='$number_key'>⚫</font> <b>1</b> schlafenden"	"<font color='$number_key'>⚫</font> <b>2</b> lärmenden"	"<font color='$number_key'>⚫</font> <b>3</b> knurrenden"	"<font color='$number_key'>⚫</font> <b>4</b> zerrenden"	1	1	;
      "quest_con089"	"<font color='$number_key'>⚫</font> <b>1</b> zähe"	"<font color='$number_key'>⚫</font> <b>2</b> tiefe"	"<font color='$number_key'>⚫</font> <b>3</b> nahe"	"<font color='$number_key'>⚫</font> <b>4</b> kleine"	2	2	;
      "quest_con092"	"<font color='$number_key'>⚫</font> <b>1</b> glatte"	"<font color='$number_key'>⚫</font> <b>2</b> kühle"	"<font color='$number_key'>⚫</font> <b>3</b> grosse"	"<font color='$number_key'>⚫</font> <b>4</b> neue"	3	3	;
      "quest_con095"	"<font color='$number_key'>⚫</font> <b>1</b> gütige"	"<font color='$number_key'>⚫</font> <b>2</b> zeitige"	"<font color='$number_key'>⚫</font> <b>3</b> gültige"	"<font color='$number_key'>⚫</font> <b>4</b> heutige"	4	4	;
      "quest_con106"	"<font color='$number_key'>⚫</font> <b>1</b> rote"	"<font color='$number_key'>⚫</font> <b>2</b> tiefe"	"<font color='$number_key'>⚫</font> <b>3</b> nahe"	"<font color='$number_key'>⚫</font> <b>4</b> viele"	1	1	;
      "quest_con110"	"<font color='$number_key'>⚫</font> <b>1</b> schwarzen"	"<font color='$number_key'>⚫</font> <b>2</b> langen"	"<font color='$number_key'>⚫</font> <b>3</b> dünnen"	"<font color='$number_key'>⚫</font> <b>4</b> vielen"	2	2	;
      "quest_con112"	"<font color='$number_key'>⚫</font> <b>1</b> hingelegten"	"<font color='$number_key'>⚫</font> <b>2</b> gefährlichen"	"<font color='$number_key'>⚫</font> <b>3</b> langwierigen"	"<font color='$number_key'>⚫</font> <b>4</b> eingeprägten"	3	3	;
      "quest_con113"	"<font color='$number_key'>⚫</font> <b>1</b> beste"	"<font color='$number_key'>⚫</font> <b>2</b> tiefste"	"<font color='$number_key'>⚫</font> <b>3</b> kleinste"	"<font color='$number_key'>⚫</font> <b>4</b> letzte"	4	4	;
      "quest_con115"	"<font color='$number_key'>⚫</font> <b>1</b> Schwan"	"<font color='$number_key'>⚫</font> <b>2</b> Löwe"	"<font color='$number_key'>⚫</font> <b>3</b> Flügel"	"<font color='$number_key'>⚫</font> <b>4</b> Vogel"	1	1	;
      "quest_con119"	"<font color='$number_key'>⚫</font> <b>1</b> Stift"	"<font color='$number_key'>⚫</font> <b>2</b> Seide"	"<font color='$number_key'>⚫</font> <b>3</b> Sturm"	"<font color='$number_key'>⚫</font> <b>4</b> Satz"	2	2	;
      "quest_con122"	"<font color='$number_key'>⚫</font> <b>1</b> Theater"	"<font color='$number_key'>⚫</font> <b>2</b> Musik"	"<font color='$number_key'>⚫</font> <b>3</b> Solo"	"<font color='$number_key'>⚫</font> <b>4</b> Bühne"	3	3	;
      "quest_con125"	"<font color='$number_key'>⚫</font> <b>1</b> Garten"	"<font color='$number_key'>⚫</font> <b>2</b> Wohnung"	"<font color='$number_key'>⚫</font> <b>3</b> Zirkus"	"<font color='$number_key'>⚫</font> <b>4</b> Spielplatz"	4	4	;
      "quest_con127"	"<font color='$number_key'>⚫</font> <b>1</b> Spülmaschine"	"<font color='$number_key'>⚫</font> <b>2</b> Kühlschrank"	"<font color='$number_key'>⚫</font> <b>3</b> Esstisch"	"<font color='$number_key'>⚫</font> <b>4</b> Küchenschrank"	1	1	;
      "quest_con128"	"<font color='$number_key'>⚫</font> <b>1</b> Esstisch"	"<font color='$number_key'>⚫</font> <b>2</b> Steinofen"	"<font color='$number_key'>⚫</font> <b>3</b> Spülmaschine"	"<font color='$number_key'>⚫</font> <b>4</b> Kühlschrank"	2	2	;
      "quest_con129"	"<font color='$number_key'>⚫</font> <b>1</b> Tellern"	"<font color='$number_key'>⚫</font> <b>2</b> Stoffen"	"<font color='$number_key'>⚫</font> <b>3</b> Stiften"	"<font color='$number_key'>⚫</font> <b>4</b> Kreiden"	3	3	;
      "quest_con133"	"<font color='$number_key'>⚫</font> <b>1</b> Sturm"	"<font color='$number_key'>⚫</font> <b>2</b> Kreide"	"<font color='$number_key'>⚫</font> <b>3</b> Solo"	"<font color='$number_key'>⚫</font> <b>4</b> Streit"	4	4	;
      "quest_con135"	"<font color='$number_key'>⚫</font> <b>1</b> Stücke"	"<font color='$number_key'>⚫</font> <b>2</b> Stifte"	"<font color='$number_key'>⚫</font> <b>3</b> Teller"	"<font color='$number_key'>⚫</font> <b>4</b> Tische"	1	1	;
      "quest_con137"	"<font color='$number_key'>⚫</font> <b>1</b> Theaters"	"<font color='$number_key'>⚫</font> <b>2</b> Sturms"	"<font color='$number_key'>⚫</font> <b>3</b> Streits"	"<font color='$number_key'>⚫</font> <b>4</b> Walds"	2	2	;
      "quest_con139"	"<font color='$number_key'>⚫</font> <b>1</b> Dämon"	"<font color='$number_key'>⚫</font> <b>2</b> Wolf"	"<font color='$number_key'>⚫</font> <b>3</b> Teufel"	"<font color='$number_key'>⚫</font> <b>4</b> Hund"	3	3	;
      "quest_con140"	"<font color='$number_key'>⚫</font> <b>1</b> Keller"	"<font color='$number_key'>⚫</font> <b>2</b> Küche"	"<font color='$number_key'>⚫</font> <b>3</b> Wohnung"	"<font color='$number_key'>⚫</font> <b>4</b> Theater"	4	4	;
      "quest_con141"	"<font color='$number_key'>⚫</font> <b>1</b> Topf"	"<font color='$number_key'>⚫</font> <b>2</b> Stift"	"<font color='$number_key'>⚫</font> <b>3</b> Solo"	"<font color='$number_key'>⚫</font> <b>4</b> Nest"	1	1	;
      "quest_con143"	"<font color='$number_key'>⚫</font> <b>1</b> Topf"	"<font color='$number_key'>⚫</font> <b>2</b> Trick"	"<font color='$number_key'>⚫</font> <b>3</b> Nest"	"<font color='$number_key'>⚫</font> <b>4</b> Satz"	2	2	;
      "quest_con145"	"<font color='$number_key'>⚫</font> <b>1</b> neue"	"<font color='$number_key'>⚫</font> <b>2</b> gütige"	"<font color='$number_key'>⚫</font> <b>3</b> lange"	"<font color='$number_key'>⚫</font> <b>4</b> fromme"	3	3	;
      "quest_con149"	"<font color='$number_key'>⚫</font> <b>1</b> Wein"	"<font color='$number_key'>⚫</font> <b>2</b> Korb"	"<font color='$number_key'>⚫</font> <b>3</b> Schuh"	"<font color='$number_key'>⚫</font> <b>4</b> Wasser"	4	4	;
      "quest_con150"	"<font color='$number_key'>⚫</font> <b>1</b> Wein"	"<font color='$number_key'>⚫</font> <b>2</b> Wasser"	"<font color='$number_key'>⚫</font> <b>3</b> Schuh"	"<font color='$number_key'>⚫</font> <b>4</b> Korb"	1	1	;
      "quest_con152"	"<font color='$number_key'>⚫</font> <b>1</b> Spielplatz"	"<font color='$number_key'>⚫</font> <b>2</b> Weltraum"	"<font color='$number_key'>⚫</font> <b>3</b> Wissenschaft"	"<font color='$number_key'>⚫</font> <b>4</b> Küche"	2	2	;
      "quest_con153"	"<font color='$number_key'>⚫</font> <b>1</b> Trick"	"<font color='$number_key'>⚫</font> <b>2</b> Solo"	"<font color='$number_key'>⚫</font> <b>3</b> Witz"	"<font color='$number_key'>⚫</font> <b>4</b> Satz"	3	3	;
      "quest_con155"	"<font color='$number_key'>⚫</font> <b>1</b> Dämon"	"<font color='$number_key'>⚫</font> <b>2</b> Schwan"	"<font color='$number_key'>⚫</font> <b>3</b> Flügel"	"<font color='$number_key'>⚫</font> <b>4</b> Wunder"	4	4	;
      "quest_rand003"	"<font color='$number_key'>⚫</font> <b>1</b> Handwerker"	"<font color='$number_key'>⚫</font> <b>2</b> Bäuerin"	"<font color='$number_key'>⚫</font> <b>3</b> Obsthändler"	"<font color='$number_key'>⚫</font> <b>4</b> Gärtnerin"	1	1	;
      "quest_rand004"	"<font color='$number_key'>⚫</font> <b>1</b> Grossmutter"	"<font color='$number_key'>⚫</font> <b>2</b> Wanderer"	"<font color='$number_key'>⚫</font> <b>3</b> Fischerin"	"<font color='$number_key'>⚫</font> <b>4</b> Grossvater"	2	2	;
      "quest_rand006"	"<font color='$number_key'>⚫</font> <b>1</b> Obsthändler"	"<font color='$number_key'>⚫</font> <b>2</b> Kampfmeiser"	"<font color='$number_key'>⚫</font> <b>3</b> Gastgeber"	"<font color='$number_key'>⚫</font> <b>4</b> Ehemann"	3	3	;
      "quest_rand010"	"<font color='$number_key'>⚫</font> <b>1</b> Polizistin"	"<font color='$number_key'>⚫</font> <b>2</b> Gärtnerin"	"<font color='$number_key'>⚫</font> <b>3</b> Scheinerin"	"<font color='$number_key'>⚫</font> <b>4</b> Winzerin"	4	4	;
      "quest_rand012"	"<font color='$number_key'>⚫</font> <b>1</b> Giraffe"	"<font color='$number_key'>⚫</font> <b>2</b> Hund"	"<font color='$number_key'>⚫</font> <b>3</b> Wolf"	"<font color='$number_key'>⚫</font> <b>4</b> Vogel"	1	1	;
      "quest_rand015"	"<font color='$number_key'>⚫</font> <b>1</b> Försterin"	"<font color='$number_key'>⚫</font> <b>2</b> Schreinerin"	"<font color='$number_key'>⚫</font> <b>3</b> Ehemann"	"<font color='$number_key'>⚫</font> <b>4</b> Handweker"	2	2	;
      "quest_rand020"	"<font color='$number_key'>⚫</font> <b>1</b> Grossmuter"	"<font color='$number_key'>⚫</font> <b>2</b> Polizistin"	"<font color='$number_key'>⚫</font> <b>3</b> Königin"	"<font color='$number_key'>⚫</font> <b>4</b> Jägerin"	3	3	;
      "quest_rand025"	"<font color='$number_key'>⚫</font> <b>1</b> Enkelin"	"<font color='$number_key'>⚫</font> <b>2</b> Komiker"	"<font color='$number_key'>⚫</font> <b>3</b> Ehemann"	"<font color='$number_key'>⚫</font> <b>4</b> Grossmutter"	4	4	;
      "quest_rand028"	"<font color='$number_key'>⚫</font> <b>1</b> Musiker"	"<font color='$number_key'>⚫</font> <b>2</b> Nachbar"	"<font color='$number_key'>⚫</font> <b>3</b> Obsthändler"	"<font color='$number_key'>⚫</font> <b>4</b> Sportlehrer"	1	1	;
      "quest_rand029"	"<font color='$number_key'>⚫</font> <b>1</b> roten"	"<font color='$number_key'>⚫</font> <b>2</b> riesigen"	"<font color='$number_key'>⚫</font> <b>3</b> finnischen"	"<font color='$number_key'>⚫</font> <b>4</b> gefährlichen"	2	2	;
      "quest_rand034"	"<font color='$number_key'>⚫</font> <b>1</b> Jägerin"	"<font color='$number_key'>⚫</font> <b>2</b> Stürmerin"	"<font color='$number_key'>⚫</font> <b>3</b> Müllerin"	"<font color='$number_key'>⚫</font> <b>4</b> Königin"	3	3	;
      "quest_rand036"	"<font color='$number_key'>⚫</font> <b>1</b> Obsthändler"	"<font color='$number_key'>⚫</font> <b>2</b> Kampfmeister"	"<font color='$number_key'>⚫</font> <b>3</b> Zoolöwe"	"<font color='$number_key'>⚫</font> <b>4</b> Hirtenhund"	4	4	;
      "quest_rand038"	"<font color='$number_key'>⚫</font> <b>1</b> Zoowärter"	"<font color='$number_key'>⚫</font> <b>2</b> Hirtenhund"	"<font color='$number_key'>⚫</font> <b>3</b> Kampfmeister"	"<font color='$number_key'>⚫</font> <b>4</b> Bergbauer"	1	1	;
      "quest_rand041"	"<font color='$number_key'>⚫</font> <b>1</b> Weltraum"	"<font color='$number_key'>⚫</font> <b>2</b> Fernsehen"	"<font color='$number_key'>⚫</font> <b>3</b> Teufel"	"<font color='$number_key'>⚫</font> <b>4</b> Königin"	2	2	;
      "quest_rand042"	"<font color='$number_key'>⚫</font> <b>1</b> Musiker"	"<font color='$number_key'>⚫</font> <b>2</b> Wissende"	"<font color='$number_key'>⚫</font> <b>3</b> Gäubige"	"<font color='$number_key'>⚫</font> <b>4</b> Ehemann"	3	3	;
      "quest_rand046"	"<font color='$number_key'>⚫</font> <b>1</b> Gläubige"	"<font color='$number_key'>⚫</font> <b>2</b> Ehefrau"	"<font color='$number_key'>⚫</font> <b>3</b> Affäre"	"<font color='$number_key'>⚫</font> <b>4</b> Sünderin"	4	4	;
      "quest_rand052"	"<font color='$number_key'>⚫</font> <b>1</b> Stürmerin"	"<font color='$number_key'>⚫</font> <b>2</b> Försterin"	"<font color='$number_key'>⚫</font> <b>3</b> Müllerin"	"<font color='$number_key'>⚫</font> <b>4</b> Königin"	1	1	;
      "quest_rand054"	"<font color='$number_key'>⚫</font> <b>1</b> Ehemann"	"<font color='$number_key'>⚫</font> <b>2</b> Kollege"	"<font color='$number_key'>⚫</font> <b>3</b> Wirtschaft"	"<font color='$number_key'>⚫</font> <b>4</b> Medizin"	2	2	;
      "quest_rand057"	"<font color='$number_key'>⚫</font> <b>1</b> Nachbarin"	"<font color='$number_key'>⚫</font> <b>2</b> Auto"	"<font color='$number_key'>⚫</font> <b>3</b> Lehrerin"	"<font color='$number_key'>⚫</font> <b>4</b> Stift"	3	3	;
      "quest_rand058"	"<font color='$number_key'>⚫</font> <b>1</b> Wissenschaft"	"<font color='$number_key'>⚫</font> <b>2</b> Feuerwehr"	"<font color='$number_key'>⚫</font> <b>3</b> Medizin"	"<font color='$number_key'>⚫</font> <b>4</b> Ökonom"	4	4	;
      "quest_rand059"	"<font color='$number_key'>⚫</font> <b>1</b> brandneuen"	"<font color='$number_key'>⚫</font> <b>2</b> filmreifen"	"<font color='$number_key'>⚫</font> <b>3</b> kleingedruckten"	"<font color='$number_key'>⚫</font> <b>4</b> hingelegten"	1	1	;
      "quest_rand061"	"<font color='$number_key'>⚫</font> <b>1</b> fromme"	"<font color='$number_key'>⚫</font> <b>2</b> grosse"	"<font color='$number_key'>⚫</font> <b>3</b> weisse"	"<font color='$number_key'>⚫</font> <b>4</b> kühle"	2	2	;
      "quest_rand064"	"<font color='$number_key'>⚫</font> <b>1</b> gefährliche"	"<font color='$number_key'>⚫</font> <b>2</b> heutige"	"<font color='$number_key'>⚫</font> <b>3</b> gestürtzte"	"<font color='$number_key'>⚫</font> <b>4</b> gültige"	3	3	;
      "quest_rand065"	"<font color='$number_key'>⚫</font> <b>1</b> knurrenden"	"<font color='$number_key'>⚫</font> <b>2</b> zerrenden"	"<font color='$number_key'>⚫</font> <b>3</b> wissenden"	"<font color='$number_key'>⚫</font> <b>4</b> schlafenden"	4	4	;
      "quest_rand066"	"<font color='$number_key'>⚫</font> <b>1</b> goldene"	"<font color='$number_key'>⚫</font> <b>2</b> schwarze"	"<font color='$number_key'>⚫</font> <b>3</b> dünne"	"<font color='$number_key'>⚫</font> <b>4</b> kleine"	1	1	;
      "quest_rand067"	"<font color='$number_key'>⚫</font> <b>1</b> grosse"	"<font color='$number_key'>⚫</font> <b>2</b> finnische"	"<font color='$number_key'>⚫</font> <b>3</b> gefährliche"	"<font color='$number_key'>⚫</font> <b>4</b> langwierige"	2	2	;
      "quest_rand073"	"<font color='$number_key'>⚫</font> <b>1</b> Teufel"	"<font color='$number_key'>⚫</font> <b>2</b> Teenager"	"<font color='$number_key'>⚫</font> <b>3</b> Hotelgast"	"<font color='$number_key'>⚫</font> <b>4</b> Handweker"	3	3	;
      "quest_rand077"	"<font color='$number_key'>⚫</font> <b>1</b> kühlen"	"<font color='$number_key'>⚫</font> <b>2</b> alten"	"<font color='$number_key'>⚫</font> <b>3</b> dünnen"	"<font color='$number_key'>⚫</font> <b>4</b> vielen"	4	4	;
      "quest_rand078"	"<font color='$number_key'>⚫</font> <b>1</b> riesigen"	"<font color='$number_key'>⚫</font> <b>2</b> roten"	"<font color='$number_key'>⚫</font> <b>3</b> gütigen"	"<font color='$number_key'>⚫</font> <b>4</b> glatten"	1	1	;
      "quest_rand079"	"<font color='$number_key'>⚫</font> <b>1</b> Jägerin"	"<font color='$number_key'>⚫</font> <b>2</b> Autorin"	"<font color='$number_key'>⚫</font> <b>3</b> Baustelle"	"<font color='$number_key'>⚫</font> <b>4</b> Nachrichten"	2	2	;
      "quest_rand080"	"<font color='$number_key'>⚫</font> <b>1</b> tiefe"	"<font color='$number_key'>⚫</font> <b>2</b> gute"	"<font color='$number_key'>⚫</font> <b>3</b> neue"	"<font color='$number_key'>⚫</font> <b>4</b> weisse"	3	3	;
      "quest_rand083"	"<font color='$number_key'>⚫</font> <b>1</b> kaputte"	"<font color='$number_key'>⚫</font> <b>2</b> neue"	"<font color='$number_key'>⚫</font> <b>3</b> rote"	"<font color='$number_key'>⚫</font> <b>4</b> komplette"	4	4	;
      "quest_rand084"	"<font color='$number_key'>⚫</font> <b>1</b> ellenlangen"	"<font color='$number_key'>⚫</font> <b>2</b> brandneuen"	"<font color='$number_key'>⚫</font> <b>3</b> filmreifen"	"<font color='$number_key'>⚫</font> <b>4</b> kleingedruckten"	1	1	;
      "quest_rand088"	"<font color='$number_key'>⚫</font> <b>1</b> gefährlichen"	"<font color='$number_key'>⚫</font> <b>2</b> prominenten"	"<font color='$number_key'>⚫</font> <b>3</b> aufgesetzten"	"<font color='$number_key'>⚫</font> <b>4</b> dominanten"	2	2	;
      "quest_rand089"	"<font color='$number_key'>⚫</font> <b>1</b> Lesebrille"	"<font color='$number_key'>⚫</font> <b>2</b> Schreibmaschine"	"<font color='$number_key'>⚫</font> <b>3</b> Goldmedallie"	"<font color='$number_key'>⚫</font> <b>4</b> Steinofen"	3	3	;
      "quest_rand092"	"<font color='$number_key'>⚫</font> <b>1</b> filmreifen"	"<font color='$number_key'>⚫</font> <b>2</b> brandneuen"	"<font color='$number_key'>⚫</font> <b>3</b> eingeprägten"	"<font color='$number_key'>⚫</font> <b>4</b> schmackhaften"	4	4	;
      "quest_rand095"	"<font color='$number_key'>⚫</font> <b>1</b> neue"	"<font color='$number_key'>⚫</font> <b>2</b> zähe"	"<font color='$number_key'>⚫</font> <b>3</b> feine"	"<font color='$number_key'>⚫</font> <b>4</b> kurze"	1	1	;
      "quest_rand096"	"<font color='$number_key'>⚫</font> <b>1</b> kleine"	"<font color='$number_key'>⚫</font> <b>2</b> edle"	"<font color='$number_key'>⚫</font> <b>3</b> neue"	"<font color='$number_key'>⚫</font> <b>4</b> rote"	2	2	;
      "quest_rand104"	"<font color='$number_key'>⚫</font> <b>1</b> gütige"	"<font color='$number_key'>⚫</font> <b>2</b> heutige"	"<font color='$number_key'>⚫</font> <b>3</b> gräuliche"	"<font color='$number_key'>⚫</font> <b>4</b> weisse"	3	3	;
      "quest_rand106"	"<font color='$number_key'>⚫</font> <b>1</b> niedrigen"	"<font color='$number_key'>⚫</font> <b>2</b> eisigen"	"<font color='$number_key'>⚫</font> <b>3</b> heutigen"	"<font color='$number_key'>⚫</font> <b>4</b> riesigen"	4	4	;
      "quest_rand110"	"<font color='$number_key'>⚫</font> <b>1</b> Schere"	"<font color='$number_key'>⚫</font> <b>2</b> Wein"	"<font color='$number_key'>⚫</font> <b>3</b> Radio"	"<font color='$number_key'>⚫</font> <b>4</b> Seide"	1	1	;
      "quest_rand111"	"<font color='$number_key'>⚫</font> <b>1</b> Streit"	"<font color='$number_key'>⚫</font> <b>2</b> Kreide"	"<font color='$number_key'>⚫</font> <b>3</b> Topf"	"<font color='$number_key'>⚫</font> <b>4</b> Sturm"	2	2	;
      "quest_rand112"	"<font color='$number_key'>⚫</font> <b>1</b> Trick"	"<font color='$number_key'>⚫</font> <b>2</b> Satz"	"<font color='$number_key'>⚫</font> <b>3</b> Schlauch"	"<font color='$number_key'>⚫</font> <b>4</b> Nest"	3	3	;
      "quest_rand113"	"<font color='$number_key'>⚫</font> <b>1</b> Kühlschrank"	"<font color='$number_key'>⚫</font> <b>2</b> Steinofen"	"<font color='$number_key'>⚫</font> <b>3</b> Esstisch"	"<font color='$number_key'>⚫</font> <b>4</b> Schreibmaschine"	4	4	;
      "quest_rand115"	"<font color='$number_key'>⚫</font> <b>1</b> Schwan"	"<font color='$number_key'>⚫</font> <b>2</b> Wunder"	"<font color='$number_key'>⚫</font> <b>3</b> Dämon"	"<font color='$number_key'>⚫</font> <b>4</b> Pfarrerin"	1	1	;
      "quest_rand119"	"<font color='$number_key'>⚫</font> <b>1</b> Kreide"	"<font color='$number_key'>⚫</font> <b>2</b> Leine"	"<font color='$number_key'>⚫</font> <b>3</b> Wein"	"<font color='$number_key'>⚫</font> <b>4</b> Seide"	2	2	;
      "quest_rand122"	"<font color='$number_key'>⚫</font> <b>1</b> Musiker"	"<font color='$number_key'>⚫</font> <b>2</b> Kreide"	"<font color='$number_key'>⚫</font> <b>3</b> Solo"	"<font color='$number_key'>⚫</font> <b>4</b> Hotelgast"	3	3	;
      "quest_rand125"	"<font color='$number_key'>⚫</font> <b>1</b> Weltraum"	"<font color='$number_key'>⚫</font> <b>2</b> Zirkus"	"<font color='$number_key'>⚫</font> <b>3</b> Kaffeehaus"	"<font color='$number_key'>⚫</font> <b>4</b> Spielplatz"	4	4	;
      "quest_rand127"	"<font color='$number_key'>⚫</font> <b>1</b> Spülmaschine"	"<font color='$number_key'>⚫</font> <b>2</b> Teenager"	"<font color='$number_key'>⚫</font> <b>3</b> Führerschein"	"<font color='$number_key'>⚫</font> <b>4</b> Handweker"	1	1	;
      "quest_rand129"	"<font color='$number_key'>⚫</font> <b>1</b> Wunder"	"<font color='$number_key'>⚫</font> <b>2</b> Teufel"	"<font color='$number_key'>⚫</font> <b>3</b> Flügel"	"<font color='$number_key'>⚫</font> <b>4</b> Wald"	2	2	;
      "quest_rand133"	"<font color='$number_key'>⚫</font> <b>1</b> Sturm"	"<font color='$number_key'>⚫</font> <b>2</b> Nest"	"<font color='$number_key'>⚫</font> <b>3</b> Streit"	"<font color='$number_key'>⚫</font> <b>4</b> Mehl"	3	3	;
      "quest_rand137"	"<font color='$number_key'>⚫</font> <b>1</b> tiefen"	"<font color='$number_key'>⚫</font> <b>2</b> hohen"	"<font color='$number_key'>⚫</font> <b>3</b> neuen"	"<font color='$number_key'>⚫</font> <b>4</b> alten"	4	4	;
      "quest_rand141"	"<font color='$number_key'>⚫</font> <b>1</b> trockenen"	"<font color='$number_key'>⚫</font> <b>2</b> langwierigen"	"<font color='$number_key'>⚫</font> <b>3</b> kompletten"	"<font color='$number_key'>⚫</font> <b>4</b> dominanten"	1	1	;
      "quest_rand143"	"<font color='$number_key'>⚫</font> <b>1</b> Satz"	"<font color='$number_key'>⚫</font> <b>2</b> Trick"	"<font color='$number_key'>⚫</font> <b>3</b> Nest"	"<font color='$number_key'>⚫</font> <b>4</b> Solo"	2	2	;
      "quest_rand145"	"<font color='$number_key'>⚫</font> <b>1</b> Obsthändler"	"<font color='$number_key'>⚫</font> <b>2</b> Pfarrerin"	"<font color='$number_key'>⚫</font> <b>3</b> Universität"	"<font color='$number_key'>⚫</font> <b>4</b> Weltall"	3	3	;
      "quest_rand149"	"<font color='$number_key'>⚫</font> <b>1</b> Wein"	"<font color='$number_key'>⚫</font> <b>2</b> Leine"	"<font color='$number_key'>⚫</font> <b>3</b> Schlauch"	"<font color='$number_key'>⚫</font> <b>4</b> Wasser"	4	4	;
      "quest_rand150"	"<font color='$number_key'>⚫</font> <b>1</b> Stiften"	"<font color='$number_key'>⚫</font> <b>2</b> Sätzen"	"<font color='$number_key'>⚫</font> <b>3</b> Leinen"	"<font color='$number_key'>⚫</font> <b>4</b> Schläuchen"	1	1	;
      "quest_rand153"	"<font color='$number_key'>⚫</font> <b>1</b> Schlauch"	"<font color='$number_key'>⚫</font> <b>2</b> Witz"	"<font color='$number_key'>⚫</font> <b>3</b> Satz"	"<font color='$number_key'>⚫</font> <b>4</b> Trick"	2	2	;
      "quest_rand155"	"<font color='$number_key'>⚫</font> <b>1</b> Zirkus"	"<font color='$number_key'>⚫</font> <b>2</b> Wanderer"	"<font color='$number_key'>⚫</font> <b>3</b> Wunder"	"<font color='$number_key'>⚫</font> <b>4</b> Musiker"	3	3	;
      "quest_rand160"	"<font color='$number_key'>⚫</font> <b>1</b> Leine"	"<font color='$number_key'>⚫</font> <b>2</b> Trick"	"<font color='$number_key'>⚫</font> <b>3</b> Streit"	"<font color='$number_key'>⚫</font> <b>4</b> Zirkus"	4	4	;
   };
} T_question;

array {
   TEMPLATE "T_ms_practice.tem" {
      item_quest	opt_1	opt_2	opt_3	opt_4	target_key	quest_port	;
      "quest_con074"	"<font color='$number_key'>⚫</font> <b>1</b> Kopf"	"<font color='$number_key'>⚫</font> <b>2</b> Stift"	"<font color='$number_key'>⚫</font> <b>3</b> Trick"	"<font color='$number_key'>⚫</font> <b>4</b> Topf"	4	1	;
      "quest_con061"	"<font color='$number_key'>⚫</font> <b>1</b> Tourist"	"<font color='$number_key'>⚫</font> <b>2</b> Besucher"	"<font color='$number_key'>⚫</font> <b>3</b> Einbrecher"	"<font color='$number_key'>⚫</font> <b>4</b> Wanderer"	1	4	;
      "quest_rand090"	"<font color='$number_key'>⚫</font> <b>1</b> kühle"	"<font color='$number_key'>⚫</font> <b>2</b> dicke"	"<font color='$number_key'>⚫</font> <b>3</b> schmackhafte"	"<font color='$number_key'>⚫</font> <b>4</b> langwierige"	3	3	;
      "quest_rand140"	"<font color='$number_key'>⚫</font> <b>1</b> grünen"	"<font color='$number_key'>⚫</font> <b>2</b> berühmten"	"<font color='$number_key'>⚫</font> <b>3</b> gültigen"	"<font color='$number_key'>⚫</font> <b>4</b> zeitigen"	2	2	;
   };
} T_pracice_question;



#------------------------------------ PCL -------------------------------------
begin_pcl;


# ********************** PCL parameters **********************

# Stimuli.
array<string> A_wavs_practice[] = {
   "context074_70dB_cued.wav",
   "context061_70dB_cued.wav",
   "random090_70dB_cued.wav",
   "random140_70dB_cued.wav"
};
array<string> A_wavs_ordered[] = {
   "context003_70dB_cued.wav",
   "context004_70dB_cued.wav",
   "context006_70dB_cued.wav",
   "context012_70dB_cued.wav",
   "context015_70dB_cued.wav",
   "context020_70dB_cued.wav",
   "context025_70dB_cued.wav",
   "context028_70dB_cued.wav",
   "context030_70dB_cued.wav",
   "context034_70dB_cued.wav",
   "context036_70dB_cued.wav",
   "context038_70dB_cued.wav",
   "context042_70dB_cued.wav",
   "context044_70dB_cued.wav",
   "context046_70dB_cued.wav",
   "context049_70dB_cued.wav",
   "context054_70dB_cued.wav",
   "context057_70dB_cued.wav",
   "context058_70dB_cued.wav",
   "context059_70dB_cued.wav",
   "context064_70dB_cued.wav",
   "context065_70dB_cued.wav",
   "context066_70dB_cued.wav",
   "context068_70dB_cued.wav",
   "context075_70dB_cued.wav",
   "context077_70dB_cued.wav",
   "context078_70dB_cued.wav",
   "context079_70dB_cued.wav",
   "context080_70dB_cued.wav",
   "context081_70dB_cued.wav",
   "context083_70dB_cued.wav",
   "context084_70dB_cued.wav",
   "context088_70dB_cued.wav",
   "context089_70dB_cued.wav",
   "context092_70dB_cued.wav",
   "context095_70dB_cued.wav",
   "context106_70dB_cued.wav",
   "context110_70dB_cued.wav",
   "context112_70dB_cued.wav",
   "context113_70dB_cued.wav",
   "context115_70dB_cued.wav",
   "context119_70dB_cued.wav",
   "context122_70dB_cued.wav",
   "context125_70dB_cued.wav",
   "context127_70dB_cued.wav",
   "context128_70dB_cued.wav",
   "context129_70dB_cued.wav",
   "context133_70dB_cued.wav",
   "context135_70dB_cued.wav",
   "context137_70dB_cued.wav",
   "context139_70dB_cued.wav",
   "context140_70dB_cued.wav",
   "context141_70dB_cued.wav",
   "context143_70dB_cued.wav",
   "context145_70dB_cued.wav",
   "context149_70dB_cued.wav",
   "context150_70dB_cued.wav",
   "context152_70dB_cued.wav",
   "context153_70dB_cued.wav",
   "context155_70dB_cued.wav",
   "random003_70dB_cued.wav",
   "random004_70dB_cued.wav",
   "random006_70dB_cued.wav",
   "random010_70dB_cued.wav",
   "random012_70dB_cued.wav",
   "random015_70dB_cued.wav",
   "random020_70dB_cued.wav",
   "random025_70dB_cued.wav",
   "random028_70dB_cued.wav",
   "random029_70dB_cued.wav",
   "random034_70dB_cued.wav",
   "random036_70dB_cued.wav",
   "random038_70dB_cued.wav",
   "random041_70dB_cued.wav",
   "random042_70dB_cued.wav",
   "random046_70dB_cued.wav",
   "random052_70dB_cued.wav",
   "random054_70dB_cued.wav",
   "random057_70dB_cued.wav",
   "random058_70dB_cued.wav",
   "random059_70dB_cued.wav",
   "random061_70dB_cued.wav",
   "random064_70dB_cued.wav",
   "random065_70dB_cued.wav",
   "random066_70dB_cued.wav",
   "random067_70dB_cued.wav",
   "random073_70dB_cued.wav",
   "random077_70dB_cued.wav",
   "random078_70dB_cued.wav",
   "random079_70dB_cued.wav",
   "random080_70dB_cued.wav",
   "random083_70dB_cued.wav",
   "random084_70dB_cued.wav",
   "random088_70dB_cued.wav",
   "random089_70dB_cued.wav",
   "random092_70dB_cued.wav",
   "random095_70dB_cued.wav",
   "random096_70dB_cued.wav",
   "random104_70dB_cued.wav",
   "random106_70dB_cued.wav",
   "random110_70dB_cued.wav",
   "random111_70dB_cued.wav",
   "random112_70dB_cued.wav",
   "random113_70dB_cued.wav",
   "random115_70dB_cued.wav",
   "random119_70dB_cued.wav",
   "random122_70dB_cued.wav",
   "random125_70dB_cued.wav",
   "random127_70dB_cued.wav",
   "random129_70dB_cued.wav",
   "random133_70dB_cued.wav",
   "random137_70dB_cued.wav",
   "random141_70dB_cued.wav",
   "random143_70dB_cued.wav",
   "random145_70dB_cued.wav",
   "random149_70dB_cued.wav",
   "random150_70dB_cued.wav",
   "random153_70dB_cued.wav",
   "random155_70dB_cued.wav",
   "random160_70dB_cued.wav"
};
array<int> A_code_condition[] = {
   80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80,
   80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80,
   80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80,
   80, 80, 80, 80, 80, 80, 80, 80, 80, 90, 90, 90, 90, 90, 90, 90, 90,
   90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90,
   90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90,
   90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90,
   90
};
array<int> A_code_target[] = {
   82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82,
   82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82,
   82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82,
   82, 82, 82, 82, 82, 82, 82, 82, 82, 92, 92, 92, 92, 92, 92, 92, 92,
   92, 92, 92, 92, 92, 92, 92, 92, 92, 92, 92, 92, 92, 92, 92, 92, 92,
   92, 92, 92, 92, 92, 92, 92, 92, 92, 92, 92, 92, 92, 92, 92, 92, 92,
   92, 92, 92, 92, 92, 92, 92, 92, 92, 92, 92, 92, 92, 92, 92, 92, 92,
   92
};
array<int> A_time_target[] = {
   5600, 5810, 5890, 5909, 6616, 5716, 6026, 6470, 5869, 6401, 5944,
   5007, 5542, 6242, 6117, 6011, 6176, 6266, 5744, 5450, 5931, 6213,
   5898, 5811, 6006, 6198, 6086, 6373, 5913, 6022, 5277, 5485, 6089,
   5976, 5741, 6556, 5511, 5947, 6041, 5445, 5576, 3896, 5338, 5267,
   4755, 5476, 5705, 5467, 5409, 6342, 5066, 5564, 4960, 5578, 4710,
   4798, 5705, 5815, 5261, 5593, 5942, 6337, 5971, 5487, 6153, 6495,
   6512, 5781, 7408, 6547, 5984, 6699, 5455, 5533, 6123, 6049, 5921,
   5853, 5775, 5738, 6155, 5504, 5450, 6113, 5618, 5715, 6224, 6278,
   6018, 6296, 5687, 6524, 6431, 6559, 5031, 6329, 6572, 5667, 5286,
   6242, 5577, 6068, 5712, 5142, 5943, 4910, 5867, 5549, 4960, 5518,
   5959, 5709, 5329, 5806, 4791, 5366, 5253, 5064, 5769, 5380
};

# Start & stop & other configurations.
string condition_str = "";

# Break time.
int trials_total = 120;
int first_break_time = trials_total / 3;
int second_break_time = trials_total / 3 * 2;

# Randomization (create array 1--trials_total and then shuffle).
array <int> A_wavs_rand[0];
loop
   int t = 1
until
   t > trials_total
begin
   A_wavs_rand.add( t );
   t = t + 1;
end;
A_wavs_rand.shuffle();

# Log responses to questions (hit = 1, false = 0) and reaction times (ms).
output_file TXT_log = new output_file;
TXT_log.open( logfile.subject() + "-matrix_senteces_order.txt", true );
TXT_log.print( "file" + "	" + "hit" + "	" + "RT" + "\n" );


# *********************** Run experiment **********************

# Instructions (and start logging in the middle ...)
T_instruction.present();
E_instruction.set_stimulus( P_instruction_I );
T_instruction.present();
E_instruction.set_stimulus( P_instruction_II );
T_instruction.present();
E_instruction.set_stimulus( P_instruction_III );
T_instruction.present();

# Practice trials.
int p_trials = 4;
loop
   int p = 1
until
   p > p_trials
begin
   wav.set_filename( A_wavs_practice[p] );
   wav.load();
   E_item.set_event_code( A_wavs_practice[p] );
   T_audio.present();
   wav.unload();
   T_inter.present();
   T_pracice_question[p].present();
   p = p + 1;
end;

# Post-practice instructions.
E_instruction.set_stimulus( P_instruction_VI );
T_instruction.present();
E_instruction.set_stimulus( P_space );
T_instruction.present();

# Matrix sentences experiment starts!
loop
   int i = 1
until
   i > trials_total
begin
   int item = A_wavs_rand[i];
   
   # Main trial: play WAV-file.
   wav.set_filename( A_wavs_ordered[item] );
   wav.load();

   if A_code_condition[item] == 80 then 
      condition_str = A_wavs_ordered[item].substring( 1, 10 );
   elseif A_code_condition[item] == 90 then 
      condition_str = A_wavs_ordered[item].substring( 1, 9 );
   end;
   
   E_item.set_event_code( condition_str );
   E_item.set_port_code( A_code_condition[item] );
   
   E_target.set_deltat( A_time_target[item]);
   E_target.set_port_code( A_code_target[item] );
	E_target.set_event_code( "target word" );
   
   T_audio.present();
   wav.unload();

   # ITI.
   T_inter.present();
   
   # Question trial: display question & log answer.
   T_question[item].present();
   
   stimulus_data last_item = stimulus_manager.last_stimulus_data();
   string react_time = string( last_item.reaction_time() );
   
   string quest_hit;  # trial hit = 1 or false = 0 to txt-file
   if last_item.type() == stimulus_hit then 
      quest_hit = "1";
   elseif last_item.type() == stimulus_incorrect then
      quest_hit = "0";
   end;

	TXT_log.print( condition_str + "	" + quest_hit + "	" + react_time + "\n" );
   
   # ITI
   T_inter.present();
   
   # Break time?
   if i == first_break_time then
      E_instruction.set_stimulus( P_break );
      T_instruction.present();
      E_instruction.set_stimulus( P_space );
      T_instruction.present();
   elseif i == second_break_time then
      E_instruction.set_stimulus( P_break );
      T_instruction.present();
      E_instruction.set_stimulus( P_space );
      T_instruction.present();
   end;
   
   i = i + 1;
end;

# End message.
E_instruction.set_stimulus( P_end );
T_instruction.present();

#------------------------------------------------------------------------------