#------------------------------------ HEAD ------------------------------------
scenario = "Digit span forward task";
# Used in PhD project: Exploring cognitive decline through the aging ear with natural speech-based computational neurophysiology
# by Firat Solyu <http://www.neurobs.com/ex_files/expt_view?id=218>
# modified by Elena <elena.bolt.uzh@gmail.com>

# Modified by Elena <elena.bolt@uzh.ch>
# WARNING: This is a bad example of a NBSP script. If you want to reproduce,
# then do better!

# Buttons & logging.
scenario_type = trials;
active_buttons = 10;
button_codes = 1, 2, 3, 4, 5, 6, 7, 8, 9, 10;
response_matching = simple_matching;
response_logging = log_active;
no_logfile = true;

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
$font_big = 60;
$font_digits = 120;
$enter_key = "0, 114, 192"; # RGB blue sticker


# Pictures.
picture {
	text {
		caption =
			"Bei dieser Aufgabe wird Ihnen eine Zahlenreihe präsentiert. Wir bitten Sie, sich die Zahlen zu merken und im Anschluss mit der Tastatur einzugeben. Beispiel: Sie sehen die Zahlen <b>456</b>. Bitte geben Sie dann <b>456</b> ein.
			
			Wir beginnen mit zwei Übungsbeispielen.			
			
			Bitte drücken Sie die Entertaste (auf der Tastatur markiert mit <font color='$enter_key'>⚫</font>), um fortzufahren.";
		max_text_width = $text_width;
	};
	x = 0; y = 0;
} P_start;

picture {
	text {
		caption =
			"Bitte drücken Sie auf die Entertaste <font color='$enter_key'>⚫</font>, um die Übung zu beginnen.";
		max_text_width = $text_width;
	};
	x = 0; y = 0;
} P_ready;

picture {
	text {
		caption =
			"Falls Sie noch Fragen haben, wenden Sie sich bitte an die Versuchsleiterin.

			Wenn Sie keine Fragen mehr haben, drücken Sie bitte die Entertaste <font color='$enter_key'>⚫</font>, um die Aufgabe zu beginnen.";
		max_text_width = $text_width;
	};
	x = 0; y = 0;
} P_inter;

picture {
   text {
      caption =
			"Besten Dank, der erste Teil der Aufgabe ist beendet.

			Die Versuchsleiterin wird gleich bei Ihnen sein.";
      max_text_width = $text_width;
   };
   x = 0; y = 0;
} P_end;


# Trials.
trial {
   trial_type = specific_response;
   terminator_button = 10;
   trial_duration = forever;
   stimulus_event {
      picture P_start;
      time = 0;
   } E_instruction;
} T_instruction;

trial {
	trial_type = fixed;
	terminator_button = 10;
	stimulus_event {
		picture {
			text {
				caption = " ";
				text_align = align_center;
				font_size = $font_digits;
			} S_digits_presented;
			x = 0; y = 0;
		};
	time = 100;
	duration = 900;
	};
} T_digit_span;

trial {
	stimulus_event {
		picture {
			text {
				caption = "Bitte nutzen Sie die Zahlentasten der Tastatur, um die Zahlen einzugeben. Drücken Sie im Anschluss die Entertaste <font color='$enter_key'>⚫</font>, um fortzufahren.";
				max_text_width = $text_width;
			} S_practice_text;
			x = 0; y = 400;
			text {
				caption = "Zahlenreihe:";
				font_size = $font_big;
			};
			x = 0; y = 200;
			text {
				caption = " ";
				font_size = $font_digits;
			} S_response_in;
			x = 0; y = 0;
		} P_response;
	code = "temp";
	} E_response;
} T_response;


#------------------------------------ PCL -------------------------------------
begin_pcl;


array<string> A_digits[208];
array<int> A_seq_no[26] = {2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10,11,11,12,12,13,13,14,14};

# Intput file.
input_file TXT_spans = new input_file;
TXT_spans.open("digit_span.txt");
TXT_spans.set_delimiter('\n');

# Output file.
output_file TXT_log = new output_file;
TXT_log.open( logfile.subject() + "-digit_span_forward.txt", true );
TXT_log.print( "seq" + "	" + "resp" + "	" + "hit" + "\n" );

# Assign values in  `digit_span.txt` to the `A_digits` (1-75) and randomize.
loop int i = 1 until i > 208 begin
	A_digits[i] = TXT_spans.get_string();
	i = i + 1;
end;
A_digits.shuffle(); 


int seq_rep_2 = 0;
int seq_rep_1;
int repeat;
int digits_presented_int;
int response_in_int;
string trial_hit;
string digit_span_result;


# *********************** Run experiment **********************

# Instructions.
T_instruction.present();
E_instruction.set_stimulus( P_ready );
T_instruction.present();

# Practice.
loop
	int practice_round = 1
until
	practice_round > 2
begin
	string practice_in;
	int practice_in_int;
	array<string> A_practice[3];

	if practice_round == 1 then
		A_practice = {"1","2","3"};
	end;
	if practice_round == 2 then
		A_practice = {"5","4","1"};
	end;

	loop
		int t = 1
	until
		t > 3
	begin
		practice_in.append( A_practice[t] );
		term.print_line( A_practice[t] );
		S_digits_presented.set_caption( A_practice[t] );
		S_digits_presented.redraw();
		T_digit_span.present();
		t = t + 1;
	end;

	system_keyboard.set_delimiter( '\n' );
	system_keyboard.set_max_length( 16 );
	system_keyboard.set_inactivity_time_out( 20000 );
	system_keyboard.set_time_out( 20000 );

	string practice_presented = system_keyboard.get_input( P_response, S_response_in );
	int practice_presented_int = int( practice_presented );
	practice_in_int = int( practice_in );

	if digits_presented_int != practice_in_int then
		T_response.present();
	end;
	practice_round = practice_round + 1;
end;

# Okay?
E_instruction.set_stimulus( P_inter ); 
T_instruction.present();
S_practice_text.set_caption( " " ); # remove instructional shit
S_practice_text.redraw();

# Digit span test starts!
loop
	int k = 1
until
	k > 26
begin
	seq_rep_1 = seq_rep_2 + 1;	
	seq_rep_2 = seq_rep_2 + A_seq_no[k];
	string response_in;
		
	loop
		int i = seq_rep_1
	until
		i > seq_rep_2
	begin
		response_in.append( A_digits[i] );
		term.print_line( A_digits[i] );
		S_digits_presented.set_caption( A_digits[i] );
		S_digits_presented.redraw();
		T_digit_span.present();
		i = i + 1;
	end;
		
	system_keyboard.set_delimiter( '\n' );
	system_keyboard.set_max_length( 16 );
	system_keyboard.set_inactivity_time_out( 20000 );
	system_keyboard.set_time_out( 20000 );
	
	string digits_presented = system_keyboard.get_input( P_response, S_response_in );
	digits_presented_int = int( digits_presented );
	response_in_int = int( response_in );
	
	if digits_presented_int == response_in_int then
		trial_hit = "1";
		repeat = 0;
	end;
	
	if digits_presented_int != response_in_int then
		trial_hit = "0";
		if repeat == 0 then
			repeat = 1;
			k = k - 1;
		elseif repeat == 1 then
			digit_span_result = ( "final digit span = " );
			int Result = A_seq_no[k]-1;
			digit_span_result.append( string( Result ) );
			E_response.set_event_code( digit_span_result );
			T_response.present();
			k = 27;
		end;
	end;
		
	TXT_log.print( response_in + "	" + digits_presented + "	" + trial_hit + "\n" );
	
	if k == 26 then
		digit_span_result = ( "final digit span = 14!" );
	end;
	
	k = k + 1;
	
end;
TXT_log.print( digit_span_result );

E_instruction.set_stimulus( P_end );
T_instruction.present();

#------------------------------------------------------------------------------