#------------------------------------ HEAD ------------------------------------
scenario = "Resting state";
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
$two_min = 120000;  # 120 000 ms
$text_width = 1000;
$fixation_size = 160;
$inter_duration = 750;
$onset_latency = 750;


# Keys w/ color sticker.
$number_key = "220, 77, 54";  # RGB red sticker
$enter_key = "0, 114, 192"; # RGB blue sticker


# Jingle for beginning & end of task.
sound {
	wavefile {
		filename = "glocke_mono_trim_3_70dB_cue.wav";
		preload = true;
	} wav_jingle;
} S_jingle;


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
		caption = "";
	};
	x = 0; y = 0;
} P_black;

picture {
	text {
		caption =
			"Zum Beginn des EEG starten wir mit einer «Ruhemessung». Auf den nächsten Folien wird Ihnen die Aufgabe erklärt.

			Bitte drücken Sie jeweils auf die Entertaste (auf der Tastatur markiert mit <font color='$enter_key'>⚫</font>) um zur nächsten Folie zu kommen.";
		max_text_width = $text_width;
	};
	x = 0; y = 0;
} P_welcome;

picture {
    text {
        caption =
			"Bei der Ruhemessung bitten wir Sie, zwei Minuten mit geöffneten Augen ruhig im Stuhl zu sitzen. Anschliessend bitten wir Sie, die Aufgabe noch einmal mit geschlossenen Augen zu wiederholen.
			
			Bitte drücken Sie die Entertaste <font color='$enter_key'>⚫</font>, um fortzufahren.";
        max_text_width = $text_width;
        };
    x = 0; y = 0;
} P_instruction_I;

picture {
    text {
		caption =
			"Sobald die Ruhemessung beginnt, werden Sie in der Mitte des Bildschirms dieses Kreuz sehen:

			<font size='$fixation_size'>+</font>

			Dazu erklingen drei Glockenklänge. Das ist das Startsignal für die Ruhemessung.

			Bitte drücken Sie die Entertaste <font color='$enter_key'>⚫</font>, um fortzufahren.";
        max_text_width = $text_width;
    };
    x = 0; y = 0;
} P_instruction_II;

picture {
    text {
        caption =
			"Wenn das Startsignal kommt, bitten wir Sie, den Blick auf das Kreuz in der Mitte des Bildschirms gerichtet zu halten, zwei Minuten lang still dazusitzen und ruhig zu atmen. Wenn die Zeit um ist, verschwindet das Kreuz und die Glocke erklingt ein zweites Mal.

			Bitte drücken Sie die Entertaste <font color='$enter_key'>⚫</font>, um die erste Ruhemessung zu starten.";
        max_text_width = $text_width;
        };
    x = 0; y = 0;
} P_instruction_III;

picture {
    text {
        caption =
			"Vielen Dank. Jetzt bitten wir Sie, dieselbe Aufgabe mit geschlossenen Augen zu wiederholen.

			Wir bitten Sie, die Augen zu schliessen, sobald das Startsignal kommt und zwei Minuten lang still dazusitzen und ruhig zu atmen. Bitte öffnen Sie die Augen erst wieder, wenn die Zeit um ist und die Glocke erklingt.

			Wenn Sie bereit sind, drücken Sie bitte die Entertaste <font color='$enter_key'>⚫</font>, um die zweite Ruhemessung zu starten.";
        max_text_width = $text_width;
        };
    x = 0; y = 0;
} P_instruction_VI;

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
	trial_type = first_response;
	trial_duration = forever;
	stimulus_event {
	   picture P_welcome;
	   time = 0;
	   target_button = 1;
	} E_instruction;
 } T_instruction;

# `T_resting_state`:
# 1. trial start: show cross & play jingle (some latency)
# 2. wait for 10 ("post-jingle accomodation")
# 3. send port code - resting state starts
# 4. after 2.5 min, send port code again
# 5. play jingle
trial {
	trial_duration = stimuli_length;
    all_responses = false;
	stimulus_event {
	   picture P_focus;
	   time = 0;
	} E_focus;
	stimulus_event {
		sound S_jingle;
		time = 500;
		code = "jingle";
		parallel = false;  # what about this?
	};
	stimulus_event {
		nothing {};
		deltat = 10000;  # 10 s accomodation
	} E_start;
	stimulus_event {
		nothing {};
		deltat = $two_min;  # 2 min rs
	} E_end;
	stimulus_event {
		sound S_jingle;
		deltat = 0;  # right after port code
		code = "jingle";
	};
} T_resting_state;


#------------------------------------ PCL -------------------------------------
begin_pcl;


# ********************** PCL parameters **********************

# Port.
int eyes_open_start = 10;
int eyes_open_end = 11;
int eyes_closed_start = 20;
int eyes_closed_end = 21;
string eyes_open = "eyes open";
string eyes_closed = "eyes closed";
string resting_end = "resting end";


# *********************** Run experiment **********************

# Instructions (and start logging in the middle ...)
E_instruction.set_stimulus( P_welcome );
T_instruction.present();
E_instruction.set_stimulus( P_instruction_I );
T_instruction.present();
E_instruction.set_stimulus( P_instruction_II );
T_instruction.present();
E_instruction.set_stimulus( P_instruction_III );
T_instruction.present();

# Eyes open starts!
E_start.set_event_code( eyes_open );
E_start.set_port_code( eyes_open_start );
E_end.set_event_code( resting_end );
E_end.set_port_code( eyes_open_end );
T_resting_state.present();

# Intermezzo.
E_instruction.set_stimulus( P_instruction_VI );
T_instruction.present();

# Eyes closed starts!
E_start.set_event_code( eyes_closed );
E_start.set_port_code( eyes_closed_start );
E_end.set_event_code( resting_end );
E_end.set_port_code( eyes_closed_end );
T_resting_state.present();

# End message.
E_instruction.set_stimulus( P_end );
T_instruction.present();

#------------------------------------------------------------------------------