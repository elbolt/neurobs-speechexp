#------------------------------------ HEAD ------------------------------------
scenario = "Click-ABR";
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
$fixation_size = 144;
$onset_latency = 2000;


# Clicks.
sound {
	wavefile {
		filename = "ABR_3000.wav";
		preload = true;
	} wav;
} S_clicks;


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
		caption = "Bitte warten Sie.";
		max_text_width = $text_width;
	};
	x = 0; y = 0;
} P_instruction_I;

picture {
	text {
		caption = "Bitte warten Sie. Gleich werden die Klick-Töne gespielt.";
		max_text_width = $text_width;
	};
	x = 0; y = 0;
} P_instruction_II;

picture {
    text {
        caption =
			"Besten Dank, die Aufnahme ist beendet.

			Die Versuchsleiterin wird gleich bei Ihnen sein.";
        max_text_width = $text_width;
        };
    x = 0; y = 0;
} P_end;


# Trials. 
trial {
	trial_duration = stimuli_length;
   all_responses = false;
	stimulus_event {
	   picture P_focus;
	   time = 0;
	} E_focus;
	stimulus_event {
		sound S_clicks;
		deltat = $onset_latency;
	};
} T_ABR;

 trial {
	trial_type = first_response;
	trial_duration = forever;
	stimulus_event {
	   picture P_instruction_I;
	   time = 0;
	   target_button = 1;
	} E_instruction;
 } T_instruction;

#------------------------------------ PCL -------------------------------------
begin_pcl;


E_instruction.set_stimulus( P_instruction_I );
T_instruction.present();
E_instruction.set_stimulus( P_instruction_II );
T_instruction.present();

T_ABR.present();

E_instruction.set_stimulus( P_end );
T_instruction.present();

#------------------------------------------------------------------------------