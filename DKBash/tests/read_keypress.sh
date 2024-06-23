#!/bin/sh

# References:
# https://stackoverflow.com/a/70979348/4561887
echo "" > keys.txt
ESC=

echo "Press any key. Press Ctrl + C to exit."


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
#                                    KeyCode		Key				Code			Unicode		Description
#	''         echo '';;             	# 0	
#	''         echo '';;             	# 1
#	''         echo '';;             	# 2	    
#	''         echo 'Cancel';;       	# 3			Cancel			Pause						break
#	''         echo '';;             	# 4
#	''         echo '';;             	# 5
#	''         echo '';;             	# 6
#	''         echo '';;             	# 7
#	''         echo 'Backspace';;    	# 8			Backspace		Backspace		⌫			backspace / delete
#	''         echo 'Tab';           	# 9			Tab				Tab				↹			tab
#	''         echo '';;             	# 10
#	''         echo '';;             	# 11
#	''         echo 'Clear';;        	# 12		Clear			NumLock			⌧			clear
#	''         echo 'Enter';;        	# 13		Enter			Enter			↵			Enter / Return
#	''         echo '';;             	# 14
#	''         echo '';;             	# 15
#	''         echo 'Shift';;        	# 16   		Shift			ShiftLeft		⇧			shift
#	''         echo 'Shift';;        	# 16   		Shift			ShiftRight		⇧			shift
#	''         echo 'Control';;      	# 17		Control			ControlLeft		^			ctrl
#	''         echo 'Control';;      	# 17		Control			ControlRight	^			ctrl
#	''         echo 'Alt';;          	# 18		Alt				AltLeft			⎇ / ⌥		Alt / Option
#	''         echo 'Alt';;          	# 18		Alt				AltRight		⎇ / ⌥		Alt / Option
#	''         echo 'Pause';;          	# 19		Pause			Pause						pause/break
#	''         echo '';;             	# 20		CapsLock		CapsLock		⇪			caps lock
#	''         echo '';;             	# 21		Unidentified	Lang1						hangul
#	''         echo '';;             	# 22
#	''         echo '';;             	# 23
#	''         echo '';;             	# 24
#	''         echo '';;             	# 25		Unidentified	Lang2						hanja
#	''         echo '';;             	# 26
	$'\e')     echo 'Escape';;       	# 27		Escape			Escape			⎋			escape
#	''         echo '';;             	# 28		henkan										conversion
#	''         echo '';;             	# 29		muhenkan									non-conversion
#	''         echo '';;             	# 30
#	''         echo '';;             	# 31
#	''         echo '';;             	# 32		(blank space)	Space						spacebar
#	''         echo '';;             	# 33		PageUp			Numpad9			⇞			page up
#	''         echo '';;             	# 34		PageDown		Numpad3			⇟			page down
#	''         echo '';;             	# 35		End				Numpad1						end
	$'\e[H')   echo '';;             	# 36		Home			Numpad7			⌂			home
#	''         echo '';;             	# 37		ArrowLeft		ArrowLeft		←			left arrow
#	''         echo '';;             	# 38		ArrowUp			ArrowUp			↑			up arrow
#	''         echo '';;             	# 39		ArrowRight		ArrowRight		→			right arrow
#	''         echo '';;             	# 40		ArrowDown		ArrowDown		↓			down arrow
#	''         echo '';;             	# 41		Select										select
#	''         echo '';;             	# 42		Print										print
#	''         echo '';;             	# 43		Execute										execute
#	''         echo '';;             	# 44		F13				F13				⎙			Print Screen / F13 (firefox)
#	''         echo '';;             	# 45		Insert			Numpad0			x			insert
	$'\e[3~')  echo '';;             	# 46		Delete			NumpadDecimal	⌦			delete
#	''         echo '';;             	# 47		Help							⍰			help
#	''         echo '';;             	# 48		0				Digit0			⓪			0
#	''         echo '';;             	# 48		’				Digit0			’			apostrophe
#	''         echo '';;            	# 49		º				Digit0			º			ordinal indicator
	'1')       echo '';;            	# 49		1				Digit1			①			1 Key
#	''         echo '';;             	# 50		2				Digit2			②			2 Key
#	''         echo '';;             	# 50		@				Digit2			@			at sign
#	''         echo '';;             	# 50		²				Digit2			²			sqaure
#	''         echo '';;             	# 50		™				Digit2			™			trademark
#	''         echo '';;             	# 51		3				Digit3			③			3 Key
#	''         echo '';;             	# 51		#				Digit3			#			hash
#	''         echo '';;             	# 51		³				Digit3			³			cube
#	''         echo '';;             	# 51		£				Digit3			£			pound
#	''         echo '';;             	# 52		4				Digit4			④			4 Key
#	''         echo '';;             	# 52		¤				Digit4			¤			currency
#	''         echo '';;             	# 52		¢				Digit4			¢			cent
#	''         echo '';;             	# 53		5				Digit5			⑤			5 Key
#	''         echo '';;             	# 53		%				Digit5			%			percent
#	''         echo '';;             	# 53		€				Digit5			€			euro
#	''         echo '';;             	# 53		∞				Digit5			∞			infinity
#	''         echo '';;             	# 54		6				Digit6			⑥			6 Key
#	''         echo '';;             	# 54		§				Digit6			§			section sign
#	''         echo '';;             	# 54		¼				Digit6			¼			one quarter
#	''         echo '';;             	# 55		7	            Digit7	        ⑦	  		7 Key
#	''         echo '';;             	# 55		&				Digit7			&			and
#	''         echo '';;             	# 55		½				Digit7			½			half
#	''         echo '';;             	# 56		8				Digit8			⑧			8 Key
#	''         echo '';;             	# 56		¾				Digit8			¾			three quarters
#	''         echo '';;             	# 56		•				Digit8			•			bullet
#	''         echo '';;             	# 57		9				Digit9			⑨			9 Key
#	''         echo '';;             	# 57		(				Digit9			(			parentheses left
#	''         echo '';;             	# 57		‘				Digit9			‘			inverted apostrophe
#	''         echo '';;             	# 57		ª				Digit9			ª			feminine ordinal indicator
#	''         echo '';;             	# 58		:				Period			:
#	''         echo '';;             	# 59		;				Semicolon					semicolon (firefox), equals
#	''         echo '';;             	# 60		<				Backquote		<
#	''         echo '';;             	# 61		=				Equal						equals (firefox)
#	''         echo '';;             	# 63		ß				Minus			ß / ?
#	''         echo '';;             	# 64		@											@ (firefox)
#	''         echo '';;             	# 65		a				KeyA			a
#	''         echo '';;             	# 65		á				KeyA			á			a acute
#	''         echo '';;             	# 66		b				KeyB			b
#	''         echo '';;             	# 66		∫				KeyB			∫			integral
#	''         echo '';;            	# 67		c				KeyC			c
#	''         echo '';;             	# 67		©				KeyC			©			copywright
#	''         echo '';;             	# 68		d				KeyD			d
#	''         echo '';;             	# 68		ð				KeyD			ð			voiced dental fricative
#	''         echo '';;             	# 68		∂				KeyD			∂			partial
#	''         echo '';;             	# 69		e				KeyE			e
#	''         echo '';;             	# 69		Dead			KeyE			e
#	''         echo '';;             	# 69		é				KeyE			é			e acute
#	''         echo '';;             	# 70		f				KeyF			f
#	''         echo '';;             	# 70		ƒ				KeyF			ƒ			f with hook
#	''         echo '';;             	# 71		g				KeyG			g
#	''         echo '';;             	# 72		h				KeyH			h
#	''         echo '';;             	# 72		˙				KeyH			˙			overdot
#	''         echo '';;             	# 72		˚				KeyH			˚			small degree
#	''         echo '';;             	# 73		i				KeyI			i
#	''         echo '';;             	# 73		Dead			KeyI			i
#	''         echo '';;             	# 73		^				KeyI			^			caret
#	''         echo '';;             	# 73		í				KeyI			í			i acute
#	''         echo '';;             	# 74		j				KeyJ			j
#	''         echo '';;             	# 74		∆				KeyJ			∆			delta
#	''         echo '';;             	# 75		k				KeyK			k
#	''         echo '';;             	# 75		°				KeyK			°			degree
#	''         echo '';;             	# 76		l				KeyL			l
#	''         echo '';;             	# 76		ø				KeyL			ø			close mid front rounded vowel
#	''         echo '';;             	# 77		m				KeyM			m
#	''         echo '';;             	# 77		µ				KeyM			µ			one millionth
#	''         echo '';;             	# 78		n				KeyN			n
#	''         echo '';;             	# 78		Dead			KeyN			n	
#	''         echo '';;             	# 78		ñ				KeyN			ñ			n with tilde
#	''         echo '';;             	# 78		~				KeyN			~			tilde
#	''         echo '';;             	# 79		o				KeyO			o
#	''         echo '';;             	# 79		ó				KeyO			ó			o acute
#	''         echo '';;             	# 80		p				KeyP			p
#	''         echo '';;            	# 80		ö				KeyP			ö			o with umlaut
#	''         echo '';;            	# 80		π				KeyP			π			pi
#	''         echo '';;            	# 81		q				KeyQ			q	
#	''         echo '';;            	# 81		ä				KeyQ			ä			open central unrounded vowel
#	''         echo '';;           		# 81		œ				KeyQ			œ			open mid front rounded vowel
#	''         echo '';;             	# 82		r				KeyR			r
#	''         echo '';;             	# 82		®				KeyR			®			registered trademark
#	''         echo '';;             	# 83		s				KeyS			s
#	''         echo '';;             	# 83		ß				KeyS			ß			sharp s
#	''         echo '';;             	# 84		t				KeyT			t
#	''         echo '';;             	# 84		þ				KeyT			þ			thorn
#	''         echo '';;             	# 84		†				KeyT			†			obelus
#	''         echo '';;             	# 85		u				KeyU			u
#	''         echo '';;             	# 85		Dead			KeyU			u
#	''         echo '';;             	# 85		ú				KeyU			ú			u acute
#	''         echo '';;             	# 85		¨				KeyU			¨			umlaut
#	''         echo '';;             	# 86		v				KeyV			v
#	''         echo '';;             	# 86		√				KeyV			√			sqaure root
#	''         echo '';;             	# 87		w				KeyW			w
#	''         echo '';;             	# 87		å				KeyW			å			open mid back unrounded vowel
#	''         echo '';;             	# 87		Σ				KeyW			Σ			sigma
#	''         echo '';;             	# 87		∑				KeyW			∑			summation sigma
#	''         echo '';;             	# 88		x				KeyX			x
#	''         echo '';;             	# 88		≈				KeyX			≈			approximate
#	''         echo '';;             	# 89		y				KeyY			y
#	''         echo '';;             	# 89		¥				KeyY			¥			yen
#	''         echo '';;             	# 89		ü				KeyY			ü			u with umlaut
#	''         echo '';;             	# 90		z				KeyZ			z
#	''         echo '';;             	# 90		æ				KeyZ			æ			near open front unrounded vowel
#	''         echo '';;             	# 90		Ω				KeyZ			Ω			ohm
#	''         echo '';;             	# 91		Meta			MetaLeft		⌘ ⊞		Windows Key / Left ⌘ / Chromebook Search key
#	''         echo '';;             	# 92		Meta			MetaRight		⌘ ⊞		Right Windows
#	''         echo '';;             	# 93		Cont			extMenu	ContextMenu	▤		Windows Menu / Right ⌘
#	''         echo '';;             	# 95		Stan			dby				☾			sleep
#	''         echo '';;             	# 96		0				Numpad0			⓪			Number Pad 0
#	''         echo '';;             	# 97		1				Numpad1			①			Number Pad 1
#	''         echo '';;             	# 98		2				Numpad2			②			Number Pad 2
#	''         echo '';;             	# 99		3				Numpad3			③			Number Pad 3
#	''         echo '';;             	# 100		4				Numpad4			④			Number Pad 4
#	''         echo '';;             	# 101		5				Numpad5			⑤			Number Pad 5
#	''         echo '';;             	# 102		6				Numpad6			⑥			Number Pad 6
#	''         echo '';;             	# 103		7				Numpad7			⑦			Number Pad 7
#	''         echo '';;             	# 104		8				Numpad8			⑧			Number Pad 8
#	''         echo '';;             	# 105		9				Numpad9			⑨			Number Pad 9
#	''         echo '';;             	# 106		*				NumpadMultiply	×			multiply
#	''         echo '';;             	# 107		+				NumpadAdd					add
#	''         echo '';;             	# 108		,				NumpadDecimal				numpad period (firefox)
#	''         echo '';;             	# 109		-				NumpadSubtract				subtract
#	''         echo '';;             	# 110		.				NumpadDecimal				decimal point
#	''         echo '';;             	# 111		/				NumpadDivide	÷			divide
	$'\eOP')   echo 'F1';;           	# 112		F1				F1				f1
	$'\eOQ')   echo 'F2';;           	# 113		F2				F2				f2
	$'\eOR')   echo 'F3';;           	# 114		F3				F3				f3  
	$'\eOS')   echo 'F4';;           	# 115		F4				F4				f4
	$'\e[15~') echo 'F5';;           	# 116		F5				F5				f5
	$'\e[17~') echo 'F6';;           	# 117		F6				F6				f6
	$'\e[18~') echo 'F7';;           	# 118		F7				F7				f7
	$'\e[19~') echo 'F8';;           	# 119		F8				F8				f8
	$'\e[20~') echo 'F9';;           	# 120		F9				F9				f9
	$'\e[21~') echo 'F10';;          	# 121		F10				F10				f10
	$'\e[23~') echo 'F11';;          	# 122		F11				F11				f11
	$'\e[24~') echo 'F12';;          	# 123		F12				F12				f12
#	''         echo 'F13';;          	# 124		F13				F13				f13
#	''         echo 'F14';;          	# 125		F14				F14				f14
#	''         echo 'F15';;          	# 126		F15				F15				f15
#	''         echo 'F16';;          	# 127		F16				F16				f16
#	''         echo 'F17';;          	# 128		F17				F17				f17
#	''         echo 'F18';;          	# 129		F18				F18				f18
#	''         echo 'F19';;          	# 130		F19				F19				f19
#	''         echo 'F20';;          	# 131		F20				F20				F20
#	''         echo 'F21';;          	# 132		F21				F21				F21
#	''         echo 'F22';;          	# 133		F22				F22				F22
#	''         echo 'F23';;          	# 134		F23				F23				F23
#	''         echo 'F24';;          	# 135		F24				F24				F24
#	''         echo 'F25';;          	# 136		F25				F25				F25
#	''         echo 'F26';;          	# 137		F26				F26				F26
#	''         echo 'F27';;          	# 138		F27				F27				F27
#	''         echo 'F28';;          	# 139		F28				F28				F28
#	''         echo 'F29';;          	# 140		F29				F29				F29
#	''         echo 'F30';;          	# 141		F30				F30				F30
#	''         echo 'F31';;          	# 142		F31	F31			F31
#	''         echo 'F32';;          	# 143		F32	F32			F32
#	''         echo 'NumLock';;      	# 144		NumLock			NumLock			⇭			num lock
#	''         echo 'ScrollLock';;   	# 145		ScrollLock		ScrollLock		⤓			scroll lock
#	''         echo '';;             	# 151		airplane mode
#	''         echo '^';;            	# 160		^				BracketLeft		^
#	''         echo '';;             	# 161		Dead			BracketRight	!
#	''         echo '';;             	# 162										؛ 			(arabic semicolon) / " / ¢
#	''         echo '#';;             	# 163		#				Backquote		#
#	''         echo '$';;            	# 164		$				Backslash		$
#	''         echo '';;             	# 165		^ù				Quote			ù
#	''         echo 'BrowserBack';;     # 166		BrowserBack		browser page backward
#	''         echo 'BrowserForward';;  # 167		BrowserForward	browser page forward
#	''         echo 'BrowserRefresh';;	# 168		BrowserRefresh	browser refresh
#	''         echo '';;           		# 169		)				Minus						closing paren (AZERTY)
#	''         echo '';;           	  	# 170		*				Backslash		*
#	''         echo '';;             	# 171		+				BracketRight				~ + * key
#	''         echo '';;             	# 172		|				home key, pipe key
#	''         echo '';;             	# 173		-				Minus						minus (firefox), mute/unmute
#	''         echo '';;             	# 174		AudioVolumeDown	decrease volume level
#	''         echo '';;             	# 175		AudioVolumeUp	increase volume level
#	''         echo '';;             	# 176		MediaTrackNext	MediaTrackNext				next
#	''         echo '';;             	# 177		MediaTrackPrevious	MediaTrackPrevious		previous
#	''         echo '';;             	# 178		MediaStop			stop
#	''         echo '';;             	# 179		MediaPlayPause			play/pause
#	''         echo '';;             	# 180		LaunchMail		✉	e-mail
#	''         echo '';;             	# 181		AudioVolumeMute	VolumeMute					mute/unmute (firefox)
#	''         echo '';;             	# 182		AudioVolumeDown	VolumeDown					decrease volume level (firefox)
#	''         echo '';;             	# 183		AudioVolumeUp	VolumeUp					increase volume level (firefox)
#	''         echo '';;             	# 186		;				Semicolon					semi-colon / ñ
#	''         echo '';;             	# 186		¶				Semicolon		¶			pilcrow
#	''         echo '';;             	# 186		…				Semicolon		…			ellipsis
#	''         echo '';;             	# 187		=				Equal						equal sign
#	''         echo '';;             	# 187		±				Equal			±			plus minus
#	''         echo '';;             	# 187		×				Equal			×			multiply
#	''         echo '';;             	# 187		≠				Equal			≠			not equal
#	''         echo '';;             	# 188		,				Comma						comma
#	''         echo '';;             	# 188		ç				Comma			ç			c cedilla
#	''         echo '';;             	# 188		≥				Comma			≥			greater than or equal
#	''         echo '';;             	# 189		-				Minus						dash
#	''         echo '';;             	# 189		–				Minus			–			dash
#	''         echo '';;             	# 189		_				Minus			_			underscore
#	''         echo '';;             	# 190		.				Period						period
#	''         echo '';;             	# 190		>				Period			>			greater than
#	''         echo '';;             	# 190		≤				Period			≤			less than or equal
#	''         echo '';;             	# 191		/				Slash						forward slash / ç
#	''         echo '';;             	# 191		?				Slash			?			question mark
#	''         echo '';;             	# 191		¿				Slash			¿			inverted question mark
#	''         echo '';;             	# 191		÷				Slash			÷			division
#	''         echo '';;             	# 192		`				Backquote					Backtick / grave accent / ñ / æ / ö / § / ±
	'~')       echo '';;             	# 192		Dead			IntlBackslash				Backtick / grave accent / ñ / æ / ö / § / ±
#	''         echo '';;             	# 193		/IntlRo			?, / or °
#	''         echo '';;             	# 194		.				NumpadComma					numpad period (chrome)
#	''         echo '';;             	# 219		[				BracketLeft					open bracket
#	''         echo '';;             	# 219		{				BracketLeft		{			braces left
#	''         echo '';;             	# 219		«				BracketLeft		«			left guillemet
#	''         echo '';;             	# 219		”				BracketLeft		”			right double quotation
#	''         echo '';;             	# 219		“				BracketLeft		“			inverted double quotation
#	''         echo '';;             	# 220		\				Backslash					back slash
	"\`")      echo '';;             	# 220		¬				Backslash		¬			logical negation
#	''         echo '';;             	# 221		]				BracketRight				close bracket / å
#	''         echo '';;             	# 221		}				BracketRight	}			braces right
#	''         echo '';;             	# 221		»				BracketRight	»			right guillemet
#	''         echo '';;             	# 222		'				Quote						single quote / ø / ä
#	''         echo '';;             	# 222		"				Quote			"			double quote
#	''         echo '';;             	# 222		´				Quote			´			accent
#	''         echo '';;             	# 223		`				Backquote		`
#	''         echo '';;            	# 224		Meta			OSLeft			⌘			left or right ⌘ key (firefox)
#	''         echo '';;            	# 225		AltGraph		AltRight		⎇ or ⌥	altgr
#	''         echo '';;            	# 226		\				IntlBackslash				< /git >, left back slash
#	''         echo '';;             	# 229		Dead			Backquote		
#	''         echo '';;             	# 230						GNOME Compose Key
#	''         echo '';;             	# 231						ç
#	''         echo '';;             	# 233													XF86Forward / é
#	''         echo '';;             	# 234													XF86Back / ê
#	''         echo '';;             	# 235													non-conversion / ë
#	''         echo '';;             	# 240		Alphanumeric								alphanumeric / ð
#	''         echo '';;             	# 242		HiraganaKatakana							hiragana/katakana / ò
#	''         echo '';;             	# 243		ZenkakuHankaku								half-width/full-width / ó
#	''         echo '';;             	# 244		KanjiMode									kanji / ô
#	''         echo '';;             	# 251													unlock track pad (Chrome/Edge) / û
#	''         echo '';;             	# 255		WakeUp			WakeUp						WakeUp

	$'\e[5~')  echo 'PageUp';;
	$'\e[6~')  echo 'PageDn';;
	'\`') 
	'!') 
	'2') 
	'@')
	'3')
	'#')
	'4')
	'$')
	'5')
	'%')
	'6')
	'&')
	'7')
	'*')
	'8')
	'(')   
	'9')   
	')')     
	'0')     
	')')   
	'-')   
	'=')     
	'=')    
	'')   
    '')    
	'/')    
	'*')    
	'-')    
	'')  
	'q') 
	'Q')  
	'w')   
	'e')   
	'r') 
	't') 
	'y')  
	'u')  
	'i')   
	'o')   
	'p')   
	'[')    
	']')   
	'\')   
	'7')  
	'8')  
	'9')   
	'+')    
	'')        echo 'CapsLock';;
	'a')    
	's')  
	'd')    
	'f')   
	'g')   
	'h')    
	'j')     
	'k')  
	'l') 
	';')  
	"'")    
	"\"")  
	'')        echo 'Enter';;
	'4')      
	'5')      
	'6')      
	'')        echo 'LShift';;
	'z')
	'x')
	'c')
	'v')
	'b')  
	'n')   
	'm') 
	',') 
	'.') 
	'/')
	'')        echo 'RShift';;
	$'\e[A')   echo 'Up';;
	'1')       echo '1';;
	'2')       echo '2';;
	'3')       echo '3';;
	'')        echo 'Enter';;
	'')        echo 'LCtrl';;
	'')        echo 'fn';;
	'')        echo 'Windows';;
	'')        echo 'LAlt';;
	'')        echo 'Space';;
	'')        echo 'RAlt';;
	'')        echo 'Context';;
	'')        echo 'RCtrl';;
	$'\e[D')   echo 'Left';;
	$'\e[B')   echo 'Down';;
	$'\e[C')   echo 'Right';;
	'0') 
	'.')
    *) echo   "Keys pressed: ${KEY}";;
  esac
  echo ${KEY} >> keys.txt
done


	

	


