#!/bin/sh
###### DK.sh #####################################################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


ESC=
##################################################################################
# dk_keyboard()
#
#
dk_keyboard() {
	dk_debugFunc 0

	
	dk_echo "Press any key. Press Ctrl + C to exit."
	ReadKey() {
	  if read -sN1 KEY; then
		while read -sN1 -t 0.001 ; do
		  KEY+="${REPLY}"
		done
	  fi
	}

	while ReadKey; do
	  case "${KEY}" in
	#  https://www.toptal.com/developers/keycode/table
	#                                   	 KeyCode		Key				Code			Unicode		Description
	#	'')         dk_echo '';;           	     	# 0	
	#	'')         dk_echo '';;           	  	    # 1
	#	'')         dk_echo '';;           	    	# 2	    
	#	'')         dk_echo 'Cancel';;     	    	# 3			Cancel			Pause						break
	#	'')         dk_echo '';;           	    	# 4
	#	'')         dk_echo '';;           	    	# 5
	#	'')         dk_echo '';;           	    	# 6
	#	'')         dk_echo '';;           	    	# 7
	#	'')         dk_echo 'Backspace';;  	    	# 8			Backspace		Backspace		⌫			backspace / delete
	#	'')         dk_echo 'Tab';         	    	# 9			Tab				Tab				↹			tab
	#	'')         dk_echo '';;           	     	# 10
	#	'')         dk_echo '';;           	    	# 11
	#	'')         dk_echo 'Clear';;      	     	# 12		Clear			NumLock			⌧			clear
	#	'')         dk_echo 'Enter';;      	      	# 13		Enter			Enter			↵			Enter / Return
	#	'')         dk_echo '';;           	      	# 14
	#	'')         dk_echo '';;           	      	# 15
	#	'')         dk_echo 'Shift';;      	      	# 16   		Shift			ShiftLeft		⇧			shift
	#	'')         dk_echo 'Shift';;      	  	    # 16   		Shift			ShiftRight		⇧			shift
	#	'')         dk_echo 'Control';;    	  	    # 17		Control			ControlLeft		^			ctrl
	#	'')         dk_echo 'Control';;    	  	    # 17		Control			ControlRight	^			ctrl
	#	'')         dk_echo 'Alt';;        	  	    # 18		Alt				AltLeft			⎇ / ⌥		Alt / Option
	#	'')         dk_echo 'Alt';;        	  	    # 18		Alt				AltRight		⎇ / ⌥		Alt / Option
	#	'')         dk_echo 'Pause';;      	        # 19		Pause			Pause						pause/break
	#	'')         dk_echo 'CapsLock';;   	    	# 20		CapsLock		CapsLock		⇪			caps lock
	#	'')         dk_echo '';;           	    	# 21		Unidentified	Lang1						hangul
	#	'')         dk_echo '';;           	    	# 22
	#	'')         dk_echo '';;           	    	# 23
	#	'')         dk_echo '';;           	    	# 24
	#	'')         dk_echo '';;           	    	# 25		Unidentified	Lang2						hanja
	#	'')         dk_echo '';;           	    	# 26
		$'\e')		dk_echo 'Escape';;      	 	# 27		Escape			Escape			⎋			escape
	#	'')         dk_echo 'henkan';;     	     	# 28		henkan										conversion
	#	'')         dk_echo 'muhenkan';;   	     	# 29		muhenkan									non-conversion
	#	'')         dk_echo '';;           	     	# 30
	#	'')         dk_echo '';;           	     	# 31
		' ')       	dk_echo '';;            	 	# 32		(blank space)	Space						spacebar
		$'\e[5~')  	dk_echo 'PageUp';;      	    # 33		PageUp			Numpad9			⇞			page up
		$'\e[6~')  	dk_echo 'PageDown';;    	    # 34		PageDown		Numpad3			⇟			page down
	#	'')         dk_echo 'End';;        	        # 35		End				Numpad1						end
		$'\e[H')   	dk_echo 'Home';;        	    # 36		Home			Numpad7			⌂			home
		$'\e[D')   	dk_echo 'ArrowLeft';;   	    # 37		ArrowLeft		ArrowLeft		←			left arrow
		$'\e[A')   	dk_echo 'ArrowUp';;     	    # 38		ArrowUp			ArrowUp			↑			up arrow
		$'\e[C')   	dk_echo 'ArrowRight';;  	    # 39		ArrowRight		ArrowRight		→			right arrow
		$'\e[B')   	dk_echo 'ArrowDown';;   	    # 40		ArrowDown		ArrowDown		↓			down arrow
	#	'')        	dk_echo 'Select';;      	  	# 41		Select										select
	#	'')        	dk_echo 'Print';;       	   	# 42		Print										print
	#	'')        	dk_echo 'Execute';;     	   	# 43		Execute										execute
	#	'')        	dk_echo 'F13';;         	  	# 44		F13				F13				⎙			Print Screen / F13 (firefox)
	#	'') 	   	dk_echo 'Insert';;      	   	# 45		Insert			Numpad0			x			insert
		$'\e[3~')  	dk_echo 'Delete';;      	    # 46		Delete			NumpadDecimal	⌦			delete
	#	'')        	dk_echo 'Help';;        	    # 47		Help							⍰			help
		'0')       	dk_echo '0';;            	 	# 48		0				Digit0			⓪			0
		'’')       	dk_echo '’';;            	 	# 48		’				Digit0			’			apostrophe
		')')   	   	dk_echo ')';;            	 	# 48		)				Digit0			’			
		'º')       	dk_echo 'º';;            		# 49		º				Digit0			º			ordinal indicator
		'1')       	dk_echo '1';;            		# 49		1				Digit1			①			1 Key
		'!')       	dk_echo '!';;            		# 49		!				Digit1			!			exclamation mark
		'2')       	dk_echo '2';;            	 	# 50		2				Digit2			②			2 Key
		'@')       	dk_echo '@';;            	 	# 50		@				Digit2			@			at sign
		'²')        dk_echo '²';;           	  	# 50		²				Digit2			²			sqaure
		'™')        dk_echo '™';;          	     	# 50		™				Digit2			™			trademark
		'3')       	dk_echo '3';;            	 	# 51		3				Digit3			③			3 Key
		'#')       	dk_echo '#';;            	 	# 51		#				Digit3			#			hash
		'³')        dk_echo '³';;          	     	# 51		³				Digit3			³			cube
		'£')        dk_echo '£';;          	     	# 51		£				Digit3			£			pound
		'4')       	dk_echo '4';;            	 	# 52		4				Digit4			④			4 Key
		'$')       	dk_echo '$';;            	 	# 52		$				Digit4
		'¤')        dk_echo '¤';;            	 	# 52		¤				Digit4			¤			currency
		'¢')       	dk_echo '¢';;            	 	# 52		¢				Digit4			¢			cent
		'5')       	dk_echo '5';;            	 	# 53		5				Digit5			⑤			5 Key
		'%')       	dk_echo '%';;            	 	# 53		%				Digit5			%			percent
		'€')        dk_echo '€';;           	  	# 53		€				Digit5			€			euro
		'∞')        dk_echo '∞';;           	  	# 53		∞				Digit5			∞			infinity
		'6')  	   	dk_echo '6';;            	 	# 54		6				Digit6			⑥			6 Key
		'§')        dk_echo '§';;           	  	# 54		§				Digit6			§			section sign
		'%')        dk_echo '%';;           	  	# 54		¼				Digit6			¼			one quarter
		'7')      	dk_echo '7';;            	 	# 55		7	            Digit7	        ⑦	  		7 Key
		'&')       	dk_echo '&';;            	 	# 55		&				Digit7			&			and
		'%')        dk_echo '%';;           	  	# 55		½				Digit7			½			half
		'*')	   	dk_echo '*';;            	 	# 56		*				Digit8						*
		'8')       	dk_echo '8';;            	 	# 56		8				Digit8			⑧			8 Key
		'¾')        dk_echo '¾';;           	  	# 56		¾				Digit8			¾			three quarters
		'•')        dk_echo '•';;           	  	# 56		•				Digit8			•			bullet
		'9')       	dk_echo '9';;            	 	# 57		9				Digit9			⑨			9 Key
		'(')       	dk_echo '(';;            	 	# 57		(				Digit9			(			parentheses left
		'‘')        dk_echo '‘';;           	  	# 57		‘				Digit9			‘			inverted apostrophe
		'ª')        dk_echo 'ª';;           	  	# 57		ª				Digit9			ª			feminine ordinal indicator
		':')        dk_echo ':';;           	  	# 58		:				Period			:
		';')        dk_echo ';';;           	  	# 59		;				Semicolon					semicolon (firefox), equals
		'<')        dk_echo '<';;           	  	# 60		<				Backquote		<
		'=')        dk_echo '=';;           	  	# 61		=				Equal						equals (firefox)
		'ß')        dk_echo 'ß';;           	  	# 63		ß				Minus			ß / ?
		'@')        dk_echo '@';;           	  	# 64		@											@ (firefox)
		'a')        dk_echo 'a';;           	  	# 65		a				KeyA			a
		'á')        dk_echo 'á';;           	  	# 65		á				KeyA			á			a acute
		'b')        dk_echo 'b';;           	  	# 66		b				KeyB			b
		'∫')        dk_echo '∫';;           	  	# 66		∫				KeyB			∫			integral
		'c')        dk_echo 'c';;           	 	# 67		c				KeyC			c
		'©')        dk_echo '©';;           	  	# 67		©				KeyC			©			copywright
		'd')        dk_echo 'd';;           	  	# 68		d				KeyD			d
		'ð')        dk_echo 'ð';;           	  	# 68		ð				KeyD			ð			voiced dental fricative
		'∂')        dk_echo '∂';;           	  	# 68		∂				KeyD			∂			partial
		'e')        dk_echo 'e';;           	  	# 69		e				KeyE			e
	#	'')         dk_echo '';;           	  	    # 69		Dead			KeyE			e
		'é')        dk_echo 'é';;           	  	# 69		é				KeyE			é			e acute
		'f')        dk_echo 'f';;           	  	# 70		f				KeyF			f
		'ƒ')        dk_echo 'ƒ';;           	  	# 70		ƒ				KeyF			ƒ			f with hook
		'g')        dk_echo 'g';;           	  	# 71		g				KeyG			g
		'h')        dk_echo 'h';;           	  	# 72		h				KeyH			h
		'˙')        dk_echo '˙';;           	  	# 72		˙				KeyH			˙			overdot
		'˚')        dk_echo '˚';;           	  	# 72		˚				KeyH			˚			small degree
		'i')        dk_echo 'i';;           	  	# 73		i				KeyI			i
	#	'')         dk_echo '';;           	     	# 73		Dead			KeyI			i
		'^')        dk_echo '^';;           	  	# 73		^				KeyI			^			caret
		'í')        dk_echo 'í';;           	  	# 73		í				KeyI			í			i acute
		'j')        dk_echo 'j';;           	  	# 74		j				KeyJ			j
		'∆')        dk_echo '∆';;           	  	# 74		∆				KeyJ			∆			delta
		'k')        dk_echo 'k';;           	  	# 75		k				KeyK			k
		'°')        dk_echo '°';;           	  	# 75		°				KeyK			°			degree
		'l')        dk_echo 'l';;           	  	# 76		l				KeyL			l
		'ø')        dk_echo 'ø';;           	  	# 76		ø				KeyL			ø			close mid front rounded vowel
		'm')       	dk_echo 'm';;           	  	# 77		m				KeyM			m
		'µ')       	dk_echo 'µ';;           	  	# 77		µ				KeyM			µ			one millionth
		'n')        dk_echo 'n';;           	  	# 78		n				KeyN			n
	#	'')         dk_echo '';;           	     	# 78		Dead			KeyN			n	
		'ñ')        dk_echo 'ñ';;           	  	# 78		ñ				KeyN			ñ			n with tilde
		'~')        dk_echo '~';;           	  	# 78		~				KeyN			~			tilde
		'o')        dk_echo 'o';;           	  	# 79		o				KeyO			o
		'ó')        dk_echo 'ó';;           	  	# 79		ó				KeyO			ó			o acute
		'p')        dk_echo 'p';;           	  	# 80		p				KeyP			p
		'ö')        dk_echo 'ö';;           	 	# 80		ö				KeyP			ö			o with umlaut
		'π')        dk_echo 'π';;           	 	# 80		π				KeyP			π			pi
		'q')        dk_echo 'q';;           	 	# 81		q				KeyQ			q	
		'ä')        dk_echo 'ä';;           	 	# 81		ä				KeyQ			ä			open central unrounded vowel
	#	'')         dk_echo '';;           		    # 81		œ				KeyQ			œ			open mid front rounded vowel
		'r')        dk_echo 'r';;           	  	# 82		r				KeyR			r
		'®')        dk_echo '®';;           	  	# 82		®				KeyR			®			registered trademark
		's')        dk_echo 's';;           	  	# 83		s				KeyS			s
		'ß')        dk_echo 'ß';;           	  	# 83		ß				KeyS			ß			sharp s
		't')        dk_echo 't';;           	  	# 84		t				KeyT			t
		'þ')        dk_echo 'þ';;           	  	# 84		þ				KeyT			þ			thorn
		'†')        dk_echo '†';;           	  	# 84		†				KeyT			†			obelus
		'u')        dk_echo 'u';;           	  	# 85		u				KeyU			u
	#	'')         dk_echo '';;           	     	# 85		Dead			KeyU			u
		'ú')        dk_echo 'ú';;           	  	# 85		ú				KeyU			ú			u acute
		'¨')        dk_echo '¨';;           	  	# 85		¨				KeyU			¨			umlaut
		'v')        dk_echo 'v';;           	  	# 86		v				KeyV			v
		'√')        dk_echo '√';;          		    # 86		√				KeyV			√			sqaure root
		'w')        dk_echo 'w';;          	   	    # 87		w				KeyW			w
		'å')        dk_echo 'å';;          	     	# 87		å				KeyW			å			open mid back unrounded vowel
		'Σ')        dk_echo 'Σ';;          	    	# 87		Σ				KeyW			Σ			sigma
		'∑')        dk_echo '∑';;           	  	# 87		∑				KeyW			∑			summation sigma
		'x')        dk_echo 'x';;           	  	# 88		x				KeyX			x
		'≈')        dk_echo '≈';;           	  	# 88		≈				KeyX			≈			approximate
		'y')        dk_echo 'y';;           	  	# 89		y				KeyY			y
		'¥')        dk_echo '¥';;           	  	# 89		¥				KeyY			¥			yen
		'ü')        dk_echo 'ü';;           	  	# 89		ü				KeyY			ü			u with umlaut
		'z')        dk_echo 'z';;          	   	    # 90		z				KeyZ			z
		'æ')        dk_echo 'æ';;          	        # 90		æ				KeyZ			æ			near open front unrounded vowel
		'Ω')        dk_echo 'Ω';;          	   	    # 90		Ω				KeyZ			Ω			ohm
	#	'')         dk_echo 'Meta';;       	  	    # 91		Meta			MetaLeft		⌘ ⊞		Windows Key / Left ⌘ / Chromebook Search key
	#	'')         dk_echo 'Meta';;       	        # 92		Meta			MetaRight		⌘ ⊞		Right Windows
	#	'')         dk_echo 'Cont';;       	        # 93		Cont			extMenu	ContextMenu	▤		Windows Menu / Right ⌘
	#	'')         dk_echo 'Stan';;       	        # 95		Stan			dby				☾			sleep
		'0')        dk_echo '0';;          	    	# 96		0				Numpad0			⓪			Number Pad 0
		'1')        dk_echo '1';;          	    	# 97		1				Numpad1			①			Number Pad 1
		'2')        dk_echo '2';;          	    	# 98		2				Numpad2			②			Number Pad 2
		'3')        dk_echo '3';;          	    	# 99		3				Numpad3			③			Number Pad 3
		'4')        dk_echo '4';;          	    	# 100		4				Numpad4			④			Number Pad 4
		'5')        dk_echo '5';;          	    	# 101		5				Numpad5			⑤			Number Pad 5
		'6')        dk_echo '6';;          	    	# 102		6				Numpad6			⑥			Number Pad 6
		'7')        dk_echo '7';;          	    	# 103		7				Numpad7			⑦			Number Pad 7
		'8')        dk_echo '8';;          	    	# 104		8				Numpad8			⑧			Number Pad 8
		'9')        dk_echo '9';;          	    	# 105		9				Numpad9			⑨			Number Pad 9
		'*')        dk_echo '*';;          	     	# 106		*				NumpadMultiply	×			multiply
		'+')        dk_echo '+';;           	  	# 107		+				NumpadAdd					add
		',')        dk_echo ',';;           		# 108		,				NumpadDecimal				numpad period (firefox)
		'-')        dk_echo '-';;           	  	# 109		-				NumpadSubtract				subtract
		'.')        dk_echo '.';;           	  	# 110		.				NumpadDecimal				decimal point
		'/')        dk_echo '/';;           	  	# 111		/				NumpadDivide	÷			divide
		$'\eOP')   	dk_echo 'F1';;           		# 112		F1				F1				f1
		$'\eOQ')   	dk_echo 'F2';;           		# 113		F2				F2				f2
		$'\eOR')   	dk_echo 'F3';;           		# 114		F3				F3				f3  
		$'\eOS')   	dk_echo 'F4';;           		# 115		F4				F4				f4
		$'\e[15~') 	dk_echo 'F5';;           		# 116		F5				F5				f5
		$'\e[17~') 	dk_echo 'F6';;           		# 117		F6				F6				f6
		$'\e[18~') 	dk_echo 'F7';;           		# 118		F7				F7				f7
		$'\e[19~') 	dk_echo 'F8';;           		# 119		F8				F8				f8
		$'\e[20~') 	dk_echo 'F9';;           		# 120		F9				F9				f9
		$'\e[21~') 	dk_echo 'F10';;          		# 121		F10				F10				f10
		$'\e[23~') 	dk_echo 'F11';;          		# 122		F11				F11				f11
		$'\e[24~') 	dk_echo 'F12';;          		# 123		F12				F12				f12
	#	'')         dk_echo 'F13';;         	 	# 124		F13				F13				f13
	#	'')         dk_echo 'F14';;         	 	# 125		F14				F14				f14
	#	'')         dk_echo 'F15';;         	 	# 126		F15				F15				f15
	#	'')         dk_echo 'F16';;         	 	# 127		F16				F16				f16
	#	'')         dk_echo 'F17';;         	 	# 128		F17				F17				f17
	#	'')         dk_echo 'F18';;         	 	# 129		F18				F18				f18
	#	'')         dk_echo 'F19';;         	 	# 130		F19				F19				f19
	#	'')         dk_echo 'F20';;         	 	# 131		F20				F20				F20
	#	'')         dk_echo 'F21';;          		# 132		F21				F21				F21
	#	'')         dk_echo 'F22';;          		# 133		F22				F22				F22
	#	'')         dk_echo 'F23';;          		# 134		F23				F23				F23
	#	'')         dk_echo 'F24';;          		# 135		F24				F24				F24
	#	'')         dk_echo 'F25';;          		# 136		F25				F25				F25
	#	'')         dk_echo 'F26';;          		# 137		F26				F26				F26
	#	'')         dk_echo 'F27';;          		# 138		F27				F27				F27
	#	'')         dk_echo 'F28';;          		# 139		F28				F28				F28
	#	'')         dk_echo 'F29';;          		# 140		F29				F29				F29
	#	'')         dk_echo 'F30';;          		# 141		F30				F30				F30
	#	'')         dk_echo 'F31';;          		# 142		F31				F31				F31
	#	'')         dk_echo 'F32';;          		# 143		F32				F32				F32
	#	'')         dk_echo 'NumLock';;      		# 144		NumLock			NumLock			⇭			num lock
	#	'')         dk_echo 'ScrollLock';;   		# 145		ScrollLock		ScrollLock		⤓			scroll lock
	#	'')         dk_echo 'airplane mode';;       # 151		airplane mode
	#	'^')        dk_echo '^';;            		# 160		^				BracketLeft		^
	#	'')         dk_echo '';;             		# 161		Dead			BracketRight	!
	#	'')         dk_echo '';;             		# 162										؛ 			(arabic semicolon) / " / ¢
		'#')        dk_echo '#';;             		# 163		#				Backquote		#
		'$')        dk_echo '$';;            		# 164		$				Backslash		$
		'ù')        dk_echo 'ù';;             		# 165		ù				Quote			ù
	#	'')         dk_echo 'BrowserBack';;     	# 166		BrowserBack		browser page backward
	#	'')         dk_echo 'BrowserForward';;      # 167		BrowserForward	browser page forward
	#	'')         dk_echo 'BrowserRefresh';;		# 168		BrowserRefresh	browser refresh
		')')        dk_echo ')';;           		# 169		)				Minus						closing paren (AZERTY)
		'*')        dk_echo '*';;           	  	# 170		*				Backslash		*
		'+')        dk_echo '+';;             		# 171		+				BracketRight				~ + * key
		'|')        dk_echo '|';;             		# 172		|				home key, pipe key
		'-')        dk_echo '-';;             		# 173		-				Minus						minus (firefox), mute/unmute
	#	'')         dk_echo 'AudioVolumeDown';;     # 174		AudioVolumeDown	decrease volume level
	#	'')         dk_echo 'AudioVolumeUp';;       # 175		AudioVolumeUp	increase volume level
	#	'')         dk_echo 'MediaTrackNext';;      # 176		MediaTrackNext	MediaTrackNext				next
	#	'')         dk_echo 'MediaTrackPrevious';;  # 177		MediaTrackPrevious	MediaTrackPrevious		previous
	#	'')         dk_echo 'MediaStop';;           # 178		MediaStop			stop
	#	'')         dk_echo 'MediaPlayPause';;      # 179		MediaPlayPause			play/pause
	#	'')         dk_echo 'LaunchMail';;          # 180		LaunchMail		✉	e-mail
	#	'')         dk_echo 'AudioVolumeMute';;     # 181		AudioVolumeMute	VolumeMute					mute/unmute (firefox)
	#	'')         dk_echo 'AudioVolumeDown';;     # 182		AudioVolumeDown	VolumeDown					decrease volume level (firefox)
	#	'')         dk_echo 'AudioVolumeUp';;       # 183		AudioVolumeUp	VolumeUp					increase volume level (firefox)
		';')        dk_echo ';';;             		# 186		;				Semicolon					semi-colon / ñ
		'¶')        dk_echo '¶';;             		# 186		¶				Semicolon		¶			pilcrow
		'…')        dk_echo '…';;             		# 186		…				Semicolon		…			ellipsis
		'=')       	dk_echo '=';;             		# 187		=				Equal						equal sign
		'±')        dk_echo '±';;             		# 187		±				Equal			±			plus minus
		'×')        dk_echo '×';;             		# 187		×				Equal			×			multiply
		'≠')        dk_echo '≠';;             		# 187		≠				Equal			≠			not equal
		',')        dk_echo ',';;             		# 188		,				Comma						comma
		'ç')        dk_echo 'ç';;             		# 188		ç				Comma			ç			c cedilla
		'≥')        dk_echo '≥';;             		# 188		≥				Comma			≥			greater than or equal
		'-')        dk_echo '-';;             		# 189		-				Minus						dash
		'–')        dk_echo '–';;             		# 189		–				Minus			–			dash
		'_')        dk_echo '_';;             		# 189		_				Minus			_			underscore
		'.')        dk_echo '.';;             		# 190		.				Period						period
		'>')        dk_echo '>';;             		# 190		>				Period			>			greater than
		'≤')        dk_echo '≤';;             		# 190		≤				Period			≤			less than or equal
		'/')        dk_echo '/';;             		# 191		/				Slash						forward slash / ç
		'?')        dk_echo '?';;             		# 191		?				Slash			?			question mark
		'¿')        dk_echo '¿';;             		# 191		¿				Slash			¿			inverted question mark
		'÷')        dk_echo '÷';;             		# 191		÷				Slash			÷			division
		'`')        dk_echo '`';;             		# 192		`				Backquote					Backtick / grave accent / ñ / æ / ö / § / ±
		'~')        dk_echo '~';;             		# 192		Dead			IntlBackslash				Backtick / grave accent / ñ / æ / ö / § / ±
	#	'')         dk_echo '';;             		# 193		/IntlRo			?, / or °
		'.')        dk_echo '.';;             		# 194		.				NumpadComma					numpad period (chrome)
		'[')        dk_echo '[';;             		# 219		[				BracketLeft					open bracket
		'{')        dk_echo '{';;             		# 219		{				BracketLeft		{			braces left
		'«')        dk_echo '«';;             		# 219		«				BracketLeft		«			left guillemet
		'”')        dk_echo '”';;             		# 219		”				BracketLeft		”			right double quotation
		'“')        dk_echo '“';;             		# 219		“				BracketLeft		“			inverted double quotation
		'\`')       dk_echo '\`';;            		# 220		\				Backslash					back slash
		"¬")        dk_echo '¬';;           		# 220		¬				Backslash		¬			logical negation
		']')        dk_echo ']';;             		# 221		]				BracketRight				close bracket / å
		'}')        dk_echo '}';;             		# 221		}				BracketRight	}			braces right
		'»')        dk_echo '»';;             		# 221		»				BracketRight	»			right guillemet
		"'")        dk_echo "'";;             		# 222		'				Quote						single quote / ø / ä
		'"')        dk_echo '"';;             		# 222		"				Quote			"			double quote
		'´')        dk_echo '´';;             		# 222		´				Quote			´			accent
		'`')        dk_echo '`';;             		# 223		`				Backquote		`
	#	'')         dk_echo 'Meta';;           	    # 224		Meta			OSLeft			⌘			left or right ⌘ key (firefox)
	#	'')         dk_echo 'AltGraph';;         	# 225		AltGraph		AltRight		⎇ or ⌥	altgr
		'\')        dk_echo '\';;            		# 226		\				IntlBackslash				< /git >, left back slash
	#	'')         dk_echo '';;             		# 229		Dead			Backquote		
	#	'')         dk_echo '';;             		# 230						GNOME Compose Key
	#	'')         dk_echo '';;             		# 231						ç
	#	'')         dk_echo '';;             		# 233													XF86Forward / é
	#	'')         dk_echo '';;             		# 234													XF86Back / ê
	#	'')         dk_echo '';;             		# 235													non-conversion / ë
	#	'')         dk_echo 'Alphanumeric';;        # 240		Alphanumeric								alphanumeric / ð
	#	'')         dk_echo 'HiraganaKatakana';;    # 242		HiraganaKatakana							hiragana/katakana / ò
	#	'')         dk_echo 'ZenkakuHankaku';;      # 243		ZenkakuHankaku								half-width/full-width / ó
	#	'')         dk_echo 'KanjiMode';;           # 244		KanjiMode									kanji / ô
	#	'')         dk_echo '';;             		# 251													unlock track pad (Chrome/Edge) / û
	#	'')         dk_echo 'WakeUp';;            	# 255		WakeUp			WakeUp						WakeUp
		*) dk_echo   "Keys pressed: '${KEY}'";;
	  esac
	  #dk_echo ${KEY} >> keys.txt
	done
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_keyboard
}
