#------------------------------------ HEAD ------------------------------------
scenario = "Audiobook paradigm `The Bell Jar`";
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
$inter_duration = 2000;
$onset_latency = 1000;


# Keys w/ color sticker.
$number_key = "220, 77, 54";  # RGB red sticker
$enter_key = "0, 114, 192"; # RGB blue sticker


# WAV.
sound {
	wavefile {
		filename = "";  # PCL
		preload = false;
	} wav;
} S_snip;


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
			"Willkommen zum Hörbuch-Teil des EEG-Experiments!
		 
			Auf den nächsten Folien wird Ihnen die Aufgabe erklärt.
			
			Bitte drücken Sie jeweils auf die Entertaste (auf der Tastatur markiert mit <font color='$enter_key'>⚫</font>), um zur nächsten Folie zu kommen.";
		max_text_width = $text_width;
	};
	x = 0; y = 0;
} P_welcome;

picture {
	text {
	caption =
			"In diesem Teil der Studie hören Sie Ausschnitte aus dem Hörbuch «Die Glasglocke» von Sylvia Plath.

			Wir bitten Sie, aufmerksam zuzuhören.

			Zwischendurch stellen wir Ihnen eine Frage und bitten Sie, eine von vier Antwortmöglichkeiten mit der Tastatur auszuwählen. Falls Sie die Antwort nicht wissen, bitten wir Sie, zu raten.
				
			Bitte drücken Sie die Entertaste <font color='$enter_key'>⚫</font>, um fortzufahren.";
	max_text_width = $text_width;
		};
	x = 0; y = 0;
} P_instruction_I;

picture {
	text {
	caption =
		"Immer, wenn ein Ausschnitt beginnt, erscheint das Kreuz in der Mitte des Bildschirms: 
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
			"Wir beginnen mit einem Übungsbeispiel. Gleich kommt das Symbol und Sie werden einen Ausschnitt aus dem Hörbuch hören.

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


# Trials.
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
	trial_duration = stimuli_length;
	all_responses = false;
	stimulus_event {
	   picture P_focus;
	   time = 0;  
	   code = "fix cross";
	};
	stimulus_event {
	   sound S_snip;
	   time = $onset_latency;
	   # port_code = 100;  # wav start -- speech onst is on audio channel
	} E_audio;
} T_audio;

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
	TEMPLATE "T_gg_question.tem" {
	item_quest	quest	opt_1	opt_2	opt_3	opt_4	target_key	quest_port	;
	"question01"	"Wohin geht der Ausflug der Ich-Erzählerin? Bitte geben Sie die Antwort, indem Sie Zahlentaste <b>1</b>, <b>2</b>, <b>3</b> oder <b>4</b> auf der Tastatur (jeweils mit <font color='$number_key'>⚫</font> markiert) drücken."	"<font color='$number_key'>⚫</font> <b>1</b> Los Angeles"	"<font color='$number_key'>⚫</font> <b>2</b> New York"	"<font color='$number_key'>⚫</font> <b>3</b> Washington"	"<font color='$number_key'>⚫</font> <b>4</b> Seattle"	2	2	;
	"question04"	"Wohin fahren die Ich-Erzählerin und ihre Freundin Doreen?"	"<font color='$number_key'>⚫</font> <b>1</b> zu einer Ausstellung"	"<font color='$number_key'>⚫</font> <b>2</b> zu einer Hochzeit"	"<font color='$number_key'>⚫</font> <b>3</b> zu einer Vorlesung"	"<font color='$number_key'>⚫</font> <b>4</b> zu einer Party"	4	4	;
	"question07"	"Was für ein Abdruck ist auf dem Glas?"	"<font color='$number_key'>⚫</font> <b>1</b> ein Lasso"	"<font color='$number_key'>⚫</font> <b>2</b> eine Pfeife"	"<font color='$number_key'>⚫</font> <b>3</b> ein Ballon"	"<font color='$number_key'>⚫</font> <b>4</b> ein Ring"	1	1	;
	"question10"	"Was macht die Ich-Erzählerin im Bad?"	"<font color='$number_key'>⚫</font> <b>1</b> die Wäsche waschen"	"<font color='$number_key'>⚫</font> <b>2</b> die Toilette benutzen"	"<font color='$number_key'>⚫</font> <b>3</b> ein Telefonat führen"	"<font color='$number_key'>⚫</font> <b>4</b> ein Bad nehmen"	4	4	;
	"question13"	"Was macht die Ich-Erzählerin vor dem Spiegel?"	"<font color='$number_key'>⚫</font> <b>1</b> Grimassen schneiden"	"<font color='$number_key'>⚫</font> <b>2</b> Haare kämmen"	"<font color='$number_key'>⚫</font> <b>3</b> Lippenstift auftragen"	"<font color='$number_key'>⚫</font> <b>4</b> Zähne putzen"	3	3	;
	"question16"	"Wohin wollte die Ich-Erzählerin nicht gehen?"	"<font color='$number_key'>⚫</font> <b>1</b> zur Pelzschau"	"<font color='$number_key'>⚫</font> <b>2</b> zum Museum"	"<font color='$number_key'>⚫</font> <b>3</b> zur Hundeschau"	"<font color='$number_key'>⚫</font> <b>4</b> zum Theater"	1	1	;
	"question19"	"Was hält Mister Manzi in der Hand?"	"<font color='$number_key'>⚫</font> <b>1</b> eine Kaffeetasse"	"<font color='$number_key'>⚫</font> <b>2</b> eine Holzkugel"	"<font color='$number_key'>⚫</font> <b>3</b> eine Pelzjacke"	"<font color='$number_key'>⚫</font> <b>4</b> ein Autoschlüssel"	2	2	;
	"question22"	"Wonach riecht die Rauchwolke?"	"<font color='$number_key'>⚫</font> <b>1</b> nach neuem Auto"	"<font color='$number_key'>⚫</font> <b>2</b> nach frischen Blumen"	"<font color='$number_key'>⚫</font> <b>3</b> nach alten Schuhen"	"<font color='$number_key'>⚫</font> <b>4</b> nach faulen Eiern"	4	4	;
	"question25"	"Welchen Beruf hat die Gönnerin des Stipendiums?"	"<font color='$number_key'>⚫</font> <b>1</b> Romanautorin"	"<font color='$number_key'>⚫</font> <b>2</b> Kunstreiterin"	"<font color='$number_key'>⚫</font> <b>3</b> Oberärztin"	"<font color='$number_key'>⚫</font> <b>4</b> Rechtsanwältin"	1	1	;
	};
 } T_question;



#------------------------------------ PCL -------------------------------------
begin_pcl;


# ********************** PCL parameters **********************

# Iteration.
array<string> A_wavs[] = {
	"snip01_trunc_70dB_cued.wav",
	"snip02_trunc_70dB_cued.wav",
	"snip03_trunc_70dB_cued.wav",
	"snip04_trunc_70dB_cued.wav",
	"snip05_trunc_70dB_cued.wav",
	"snip06_trunc_70dB_cued.wav",
	"snip07_trunc_70dB_cued.wav",
	"snip08_trunc_70dB_cued.wav",
	"snip09_trunc_70dB_cued.wav",
	"snip10_trunc_70dB_cued.wav",
	"snip11_trunc_70dB_cued.wav",
	"snip12_trunc_70dB_cued.wav",
	"snip13_trunc_70dB_cued.wav",
	"snip14_trunc_70dB_cued.wav",
	"snip15_trunc_70dB_cued.wav",
	"snip16_trunc_70dB_cued.wav",
	"snip17_trunc_70dB_cued.wav",
	"snip18_trunc_70dB_cued.wav",
	"snip19_trunc_70dB_cued.wav",
	"snip20_trunc_70dB_cued.wav",
	"snip21_trunc_70dB_cued.wav",
	"snip22_trunc_70dB_cued.wav",
	"snip23_trunc_70dB_cued.wav",
	"snip24_trunc_70dB_cued.wav",
	"snip25_trunc_70dB_cued.wav"	
};
array<string> A_snips[] = {
	"snip01_p",
	"snip02",
	"snip03",
	"snip04",
	"snip05",
	"snip06",
	"snip07",
	"snip08",
	"snip09",
	"snip10",
	"snip11",
	"snip12",
	"snip13",
	"snip14",
	"snip15",
	"snip16",
	"snip17",
	"snip18",
	"snip19",
	"snip20",
	"snip21",
	"snip22",
	"snip23",
	"snip24",
	"snip25"
};
array<string> A_questions[] = {
	"question01",
	"question04",
	"question07",
	"question10",
	"question13",
	"question16",
	"question19",
	"question22",
	"question25"
};
array<int> A_port_codes[] = {
	101,
	102,
	103,
	104,
	105,
	106,
	107,
	108,
	109,
	110,
	111,
	112,
	113,
	114,
	115,
	116,
	117,
	118,
	119,
	120,
	121,
	122,
	123,
	124,
	125,
};

# Break time & questions.
int break_time = 13;  # after 13th stimulus (since start at no 2)
int last_trial = 25;
int question_time = 4;  # question after every 3th question start at no 4
int next_question = 2;  # start at no 2 because no 1 is practice
int increase_qt = 3;  # question after every 3th
int q = 1;  # iterate over `A_questions`

# Log responses (hit = 1, false = 0) to questions.
output_file TXT_log = new output_file;
TXT_log.open( logfile.subject() + "-audiobook_order.txt", true );
TXT_log.print( "quest_item" + "	" + "hit" + "	" + "RT" + "\n" );


# *********************** Run experiment **********************

# Instructions.
T_instruction.present();
E_instruction.set_stimulus( P_instruction_I );
T_instruction.present();
E_instruction.set_stimulus( P_instruction_II );
T_instruction.present();
E_instruction.set_stimulus( P_instruction_III );
T_instruction.present();

# Practice trial (there is only one).
int p_trial = 1;
wav.set_filename( A_wavs[p_trial] );
wav.load();
E_audio.set_port_code( A_port_codes[p_trial] );
E_audio.set_event_code( A_snips[p_trial] );
T_audio.present();
wav.unload();
T_inter.present();
T_question[p_trial].present();

# Post-practice instructions.
E_instruction.set_stimulus( P_instruction_VI );
T_instruction.present();
E_instruction.set_stimulus( P_space );
T_instruction.present();

# Audiobook experiment starts!
loop
   int i = 2
until
   i > last_trial
begin
	# Main trial: play WAV-file.
	wav.set_filename( A_wavs[i] );
	wav.load();
	E_audio.set_port_code( A_port_codes[i] );
	E_audio.set_event_code( A_snips[i] );
	T_audio.present();
	wav.unload();

	# ITI.
	T_inter.present();

	# Time for a question?
	if i == question_time then
		T_question[next_question].present();
		string quest_no = A_questions[q];
		
		# Log RT and correctness of response.
		stimulus_data last_item = stimulus_manager.last_stimulus_data();
		string react_time = string( last_item.reaction_time() );
		string quest_hit;
		if last_item.type() == stimulus_hit then 
			quest_hit = "1";
		elseif last_item.type() == stimulus_incorrect then
			quest_hit = "0";
		end;
		
		question_time = question_time + increase_qt;
		next_question = next_question + 1;  # increaste `next_question` number
		
		TXT_log.print( quest_no + "	" + quest_hit + "	" + react_time + "\n" );
		q = q + 1;
	end;

	# Time for a break?
	if i == break_time then
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