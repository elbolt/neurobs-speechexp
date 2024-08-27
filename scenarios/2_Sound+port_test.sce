#------------------------------------ HEAD ------------------------------------
scenario = "Port testing";
# Used in PhD project: Exploring cognitive decline through the aging ear with natural speech-based computational neurophysiology
# modified by Elena <elena.bolt.uzh@gmail.com>

# Buttons & logging.
active_buttons = 1;
response_logging = log_active;
no_logfile = true;

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
$fixation_size = 58;

# Test sounds.
sound {
	wavefile {
		filename = "";
		preload = false;
	} wav;
} S_test;


# Screen elemens.
picture {
	text {
		caption =
			"Starte den Kopfhörertest im EEG Booth. Drücke Enter, um den Test zu starten.";
		max_text_width = $text_width;
	};
	x = 0; y = 0;
} P_headphones_I;

picture {
	text {
		caption =
			"Kopfhörertest";
		font_size = $fixation_size;
		max_text_width = $text_width;
	};
	x = 0; y = 0;
} P_headphones_II;

picture {
	text {
		caption =
			"Starte den Port-Test ausserhalb vom EEG-Both. Drücke Enter, um den Test zu starten.";
		max_text_width = $text_width;
	};
	x = 0; y = 0;
} P_port_I;

picture {
	text {
		caption =
			"Port-Test";
		font_size = $fixation_size;
		max_text_width = $text_width;
	};
	x = 0; y = 0;
} P_port_II;

picture {
	text {
		caption =
			" ";
		max_text_width = $text_width;
	};
	x = 0; y = 0;
} P_black;



# Trials. 
trial {
	trial_type = first_response;
	trial_duration = forever;
	stimulus_event {
	   picture P_headphones_I;
	   time = 0;
	   target_button = 1;
	} E_instruction;
 } T_instruction;

trial {
	trial_duration = stimuli_length;
	all_responses = false;
	stimulus_event {
	   picture P_headphones_II;
	   time = 0;
	} E_focus;
	stimulus_event {
		sound S_test;
	};
	stimulus_event {
		nothing {};
		deltat = 0;
		port_code = 4;
	};
} T_audio;

trial {
	trial_type = first_response;
	trial_duration = 250;
	stimulus_event {
	   picture P_black;
	   time = 0;
	};
 } T_black;


#------------------------------------ PCL -------------------------------------
begin_pcl;


array<string> A_wavs[] = {
	"bio_check_1_70dB_cued.wav",
	"bio_check_2_70dB_cued.wav",
	"bio_check_3_70dB_cued.wav"
};

# Randomize the order of the wavs.
A_wav.shuffle();

int wavs = 3;

# Headphones test.
T_instruction.present();
T_black.present();
loop
   int c = 1
until
   c > wavs
begin
	wav.set_filename( A_wavs[c] );
	wav.load();
	T_audio.present();
	wav.unload();
	T_black.present();
	
	c = c + 1;
end;

# Port test.
E_instruction.set_stimulus( P_port_I );
E_focus.set_stimulus( P_port_II );

T_instruction.present();
T_black.present();
loop
   int c = 1
until
   c > wavs
begin
	wav.set_filename( A_wavs[c] );
	wav.load();
	T_audio.present();
	wav.unload();
	T_black.present();
	
	c = c + 1;
end;
