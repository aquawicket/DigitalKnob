@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################

rem #   review this:     https://stackoverflow.com/a/35187347

rem ################################################################################
rem # dk_urlEncode(url rtn_var)
rem #
rem #
rem #		ASCII URL Encoding Reference 00-1F
rem # 		The ASCII control characters %00-%1F were originally designed to control hardware devices.
rem # 		Control characters have nothing to do inside a URL.
rem # 		https://www.w3schools.com/tags/ref_urlencode.ASP
rem # 		NUL		null character			%00
rem # 		SOH		start of header			%01
rem # 		STX		start of text			%02
rem # 		ETX		end of text				%03
rem # 		EOT		end of transmission		%04
rem # 		ENQ		enquiry					%05
rem # 		ACK		acknowledge				%06
rem # 		BEL		bell (ring)				%07
rem # 		BS		backspace				%08
rem # 		HT		horizontal tab			%09
rem # 		LF		line feed				%0A
rem # 		VT		vertical tab			%0B
rem # 		FF		form feed				%0C
rem # 		CR		carriage return			%0D
rem # 		SO		shift out				%0E
rem # 		SI		shift in				%0F
rem # 		DLE		data link escape		%10
rem # 		DC1		device control 1		%11
rem # 		DC2		device control 2		%12
rem # 		DC3		device control 3		%13
rem # 		DC4		device control 4		%14
rem # 		NAK		negative acknowledge	%15
rem # 		SYN		synchronize				%16
rem # 		ETB		end transmission block	%17
rem # 		CAN		cancel					%18
rem # 		EM		end of medium			%19
rem # 		SUB		substitute				%1A
rem # 		ESC		escape					%1B
rem # 		FS		file separator			%1C
rem # 		GS		group separator			%1D
rem # 		RS		record separator		%1E
rem # 		US		unit separator			%1F
rem # 	
rem #		ASCII Encoding Reference	20-C3 BF
rem # 		The default character-set in HTML5 is UTF-8.
rem # 		https://www.w3schools.com/tags/ref_urlencode.ASP
rem #		Character	From Win-1252	From UTF-8
rem #		space		%20				%20
rem #		!			%21				%21
rem #		"			%22				%22
rem #		#			%23				%23				
rem #		$			%24				%24				
rem #		%			%25				%25								
rem #		&			%26				%26				
rem #		'			%27				%27				
rem #		(			%28				%28				
rem #		)			%29				%29				
rem #		*			%2A				%2A
rem #		+			%2B				%2B
rem #		,			%2C				%2C
rem #		-			%2D				%2D
rem #		.			%2E				%2E
rem #		/			%2F				%2F
rem #		0			%30				%30
rem #		1			%31				%31
rem #		2			%32				%32
rem #		3			%33				%33
rem #		4			%34				%34
rem #		5			%35				%35
rem #		6			%36				%36				
rem #		7			%37				%37				
rem #		8			%38				%38				
rem #		9			%39				%39				
rem #		:			%3A				%3A
rem #		;			%3B				%3B
rem #		<			%3C				%3C
rem #		=			%3D				%3D
rem #		>			%3E				%3E
rem #		?			%3F				%3F
rem #		@			%40				%40
rem #		A			%41				%41
rem #		B			%42				%42
rem #		C			%43				%43
rem #		D			%44				%44
rem #		E			%45				%45
rem #		F			%46				%46
rem #		G			%47				%47
rem #		H			%48				%48
rem #		I			%49				%49
rem #		J			%4A				%4A
rem #		K			%4B				%4B
rem #		L			%4C				%4C
rem #		M			%4D				%4D
rem #		N			%4E				%4E
rem #		O			%4F				%4F
rem #		P			%50				%50
rem #		Q			%51				%51
rem #		R			%52				%52
rem #		S			%53				%53
rem #		T			%54				%54
rem #		U			%55				%55
rem #		V			%56				%56
rem #		W			%57				%57
rem #		X			%58				%58
rem #		Y			%59				%59
rem #		Z			%5A				%5A
rem #		[			%5B				%5B
rem #		\			%5C				%5C
rem #		]			%5D				%5D
rem #		^			%5E				%5E
rem #		_			%5F				%5F
rem #		`			%60				%60
rem #		a			%61				%61
rem #		b			%62				%62
rem #		c			%63				%63
rem #		d			%64				%64
rem #		e			%65				%65
rem #		f			%66				%66
rem #		g			%67				%67
rem #		h			%68				%68
rem #		i			%69				%69
rem #		j			%6A				%6A
rem #		k			%6B				%6B
rem #		l			%6C				%6C
rem #		m			%6D				%6D
rem #		n			%6E				%6E
rem #		o			%6F				%6F
rem #		p			%70				%70
rem #		q			%71				%71
rem #		r			%72				%72
rem #		s			%73				%73
rem #		t			%74				%74
rem #		u			%75				%75
rem #		v			%76				%76
rem #		w			%77				%77
rem #		x			%78				%78
rem #		y			%79				%79
rem #		z			%7A				%7A
rem #		{			%7B				%7B
rem #		|			%7C				%7C
rem #		}			%7D				%7D
rem #		~			%7E				%7E
rem #		 			%7F				%7F
rem #		€			%80				%E2%82%AC
rem #					%81				%81
rem #		‚			%82				%E2%80%9A
rem #		ƒ			%83				%C6%92
rem #		„			%84				%E2%80%9E
rem #		…			%85				%E2%80%A6
rem #		†			%86				%E2%80%A0
rem #		‡			%87				%E2%80%A1
rem #		ˆ			%88				%CB%86
rem #		‰			%89				%E2%80%B0
rem #		Š			%8A				%C5%A0
rem #		‹			%8B				%E2%80%B9
rem #		Œ			%8C				%C5%92
rem #					%8D				%C5%8D
rem #		Ž			%8E				%C5%BD
rem #					%8F				%8F
rem #					%90				%C2%90
rem #		‘			%91				%E2%80%98
rem #		’			%92				%E2%80%99
rem #		“			%93				%E2%80%9C
rem #		”			%94				%E2%80%9D
rem #		•			%95				%E2%80%A2
rem #		–			%96				%E2%80%93
rem #		—			%97				%E2%80%94
rem #		˜			%98				%CB%9C
rem #		™			%99				%E2%84
rem #		š			%9A				%C5%A1
rem #		›			%9B				%E2%80
rem #		œ			%9C				%C5%93
rem #					%9D				%9D
rem #		ž			%9E				%C5%BE
rem #		Ÿ			%9F				%C5%B8
rem #		 			%A0				%C2%A0
rem #		¡			%A1				%C2%A1
rem #		¢			%A2				%C2%A2
rem #		£			%A3				%C2%A3
rem #		¤			%A4				%C2%A4
rem #		¥			%A5				%C2%A5
rem #		¦			%A6				%C2%A6
rem #		§			%A7				%C2%A7
rem #		¨			%A8				%C2%A8
rem #		©			%A9				%C2%A9
rem #		ª			%AA				%C2%AA
rem #		«			%AB				%C2%AB
rem #		¬			%AC				%C2%AC
rem #		­			%AD				%C2%AD
rem #		®			%AE				%C2%AE
rem #		¯			%AF				%C2%AF
rem #		°			%B0				%C2%B0
rem #		±			%B1				%C2%B1
rem #		²			%B2				%C2%B2
rem #		³			%B3				%C2%B3
rem #		´			%B4				%C2%B4
rem #		µ			%B5				%C2%B5
rem #		¶			%B6				%C2%B6
rem #		·			%B7				%C2%B7
rem #		¸			%B8				%C2%B8
rem #		¹			%B9				%C2%B9
rem #		º			%BA				%C2%BA
rem #		»			%BB				%C2%BB
rem #		¼			%BC				%C2%BC
rem #		½			%BD				%C2%BD
rem #		¾			%BE				%C2%BE
rem #		¿			%BF				%C2%BF
rem #		À			%C0				%C3%80
rem #		Á			%C1				%C3%81
rem #		Â			%C2				%C3%82
rem #		Ã			%C3				%C3%83
rem #		Ä			%C4				%C3%84
rem #		Å			%C5				%C3%85
rem #		Æ			%C6				%C3%86
rem #		Ç			%C7				%C3%87
rem #		È			%C8				%C3%88
rem #		É			%C9				%C3%89
rem #		Ê			%CA				%C3%8A
rem #		Ë			%CB				%C3%8B
rem #		Ì			%CC				%C3%8C
rem #		Í			%CD				%C3%8D
rem #		Î			%CE				%C3%8E
rem #		Ï			%CF				%C3%8F
rem #		Ð			%D0				%C3%90
rem #		Ñ			%D1				%C3%91
rem #		Ò			%D2				%C3%92
rem #		Ó			%D3				%C3%93
rem #		Ô			%D4				%C3%94
rem #		Õ			%D5				%C3%95
rem #		Ö			%D6				%C3%96
rem #		×			%D7				%C3%97
rem #		Ø			%D8				%C3%98
rem #		Ù			%D9				%C3%99
rem #		Ú			%DA				%C3%9A
rem #		Û			%DB				%C3%9B
rem #		Ü			%DC				%C3%9C
rem #		Ý			%DD				%C3%9D
rem #		Þ			%DE				%C3%9E
rem #		ß			%DF				%C3%9F
rem #		à			%E0				%C3%A0
rem #		á			%E1				%C3%A1
rem #		â			%E2				%C3%A2
rem #		ã			%E3				%C3%A3
rem #		ä			%E4				%C3%A4
rem #		å			%E5				%C3%A5
rem #		æ			%E6				%C3%A6
rem #		ç			%E7				%C3%A7
rem #		è			%E8				%C3%A8
rem #		é			%E9				%C3%A9
rem #		ê			%EA				%C3%AA
rem #		ë			%EB				%C3%AB
rem #		ì			%EC				%C3%AC
rem #		í			%ED				%C3%AD
rem #		î			%EE				%C3%AE
rem #		ï			%EF				%C3%AF
rem #		ð			%F0				%C3%B0
rem #		ñ			%F1				%C3%B1
rem #		ò			%F2				%C3%B2
rem #		ó			%F3				%C3%B3
rem #		ô			%F4				%C3%B4
rem #		õ			%F5				%C3%B5
rem #		ö			%F6				%C3%B6
rem #		÷			%F7				%C3%B7
rem #		ø			%F8				%C3%B8
rem #		ù			%F9				%C3%B9
rem #		ú			%FA				%C3%BA
rem #		û			%FB				%C3%BB
rem #		ü			%FC				%C3%BC
rem #		ý			%FD				%C3%BD
rem #		þ			%FE				%C3%BE
rem #		ÿ			%FF				%C3%BF

:dk_urlEncode
setlocal EnableDelayedExpansion

	set "STRING=!%~1:%%=%%25!"
	set "STRING=!STRING: =%%20!"
	set ^"STRING=!STRING:"=%%22!"
	for %%x in ("# 23" "$ 24" "& 26" "+ 2B" ", 2C" "/ 2F" ": 3A"
			"; 3B" "< 3C" "> 3E" "? 3F" "@ 40" "\ 5C" "^ 5E"
		) do for /f "tokens=1,2" %%a in (%%x) do (
        set "STRING=!STRING:%%a=%%%%b!"
    )
	rem # Special case for the ! character, which can only be replaced in a set %STRING%
	set "STRING=%STRING:!= %" & set "STRING=!STRING: =%%21!" &rem # Prerequisite: No more " and ^
	rem # Special case for the = character, which cannot be replaced by any set command
	rem set "REPL=%%3D" & %dk_call% :ReplaceEquals STRING REPL
	endlocal & set "%~1=%STRING%"
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	
	
rem #   ALL: "  ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~"
rem # VALID: "      # $   & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~"
	set url="     # $   & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~"
rem	set "url=https://example.com/api?query=test^&test=test"
	echo url = %url%
    %dk_call% dk_urlEncode url
	echo url = %url%
%endfunction%
