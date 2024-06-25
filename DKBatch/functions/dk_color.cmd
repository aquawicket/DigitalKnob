@echo off
call DK.cmd

::##################################################################################
::# dk_color(on/off)
::#
::#	Enable / Disable console text and background coloring
::#
::#   on/off:  Default ON
::#
::#   https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797
::#   https://en.wikipedia.org/wiki/ANSI_escape_code#Colors
::#   https://learn.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences
::#
:dk_color () {
	call dk_debugFunc
	if %__ARGC__% gtr 1 (call dk_error "%__FUNCTION__%(%__ARGC__%): too many arguments")

	set "USE_COLOR=1"
	if defined %1 if %1 equ 0 call dk_unset USE_COLOR 

	
	:USE_COLOR_if
	if not defined USE_COLOR goto:USE_COLOR_else
		set "ESC="						&:: escape character
		
		::# Attributes on
		set "clr=%ESC%[0m"					&:: Default						- Returns all attributes to the default state prior to modification
		set "bold=%ESC%[1m"					&:: Bold/Bright 				- Applies brightness/intensity flag to foreground color
		set "dim=%ESC%[2m"					&:: Dim
		set "italic=%ESC%[3m"				&:: Italic
		set "underline=%ESC%[4m"			&:: Underline       			- Adds underline
		set "blink=%ESC%[5m"				&:: Blink
		set "fblink=%ESC%[6m"				&:: Rapid Blink
		set "negative=%ESC%[7m"   			&:: Negative	    			- Swaps foreground and background colors
		set "invisible=%ESC%[8m"			&:: Invisible
		set "strike=%ESC%[9m"				&:: Strike Through
		
		::# Attributes off
		::set "20m=%ESC%[20m"				&:: 20
		::set "21m=%ESC%[21m"				&:: 21
		set "nobold=%ESC%[22m"				&:: No bold/bright				- Removes brightness/intensity flag from foreground color
		set "noitalic=%ESC%[23m"			&:: No italic
		set "nounderline=%ESC%[24m"			&:: No underline				- Removes underline
		set "noblink=%ESC%[25m"				&:: No Blink
		::set "26m=%ESC%[26m"				&:: 26
		set "nonegative=%ESC%[27m"  		&:: Positive(No negative)		- Returns foreground/background to normal
		set "visible=%ESC%[28m"				&:: Visible(No invisible)
		set "nostrike=%ESC%[29m"			&:: No Strike Through
		
		::# Foreground Colors
		set "black=%ESC%[30m"				&:: Foreground Black			- Applies non-bold/bright black to foreground
		set "red=%ESC%[31m"					&:: Foreground Red				- Applies non-bold/bright red to foreground
		set "green=%ESC%[32m"				&:: Foreground Green			- Applies non-bold/bright green to foreground
		set "yellow=%ESC%[33m"				&:: Foreground Yellow			- Applies non-bold/bright yellow to foreground
		set "blue=%ESC%[34m"				&:: Foreground Blue				- Applies non-bold/bright blue to foreground
		set "magenta=%ESC%[35m"				&:: Foreground Magenta			- Applies non-bold/bright magenta to foreground
		set "cyan=%ESC%[36m"				&:: Foreground Cyan				- Applies non-bold/bright cyan to foreground
		set "white=%ESC%[37m"				&:: Foreground White			- Applies non-bold/bright white to foreground
		set "extended=%ESC%[38m"			&:: Foreground Extended			- Applies extended color value to the foreground
		set "default=%ESC%[39m"				&:: Foreground Default			- Applies only the foreground portion of the defaults
		
		::# Background Colors
		set "bg_black=%ESC%[40m"			&:: Background Black			- Applies non-bold/bright black to background
		set "bg_red=%ESC%[41m"				&:: Background Red				- Applies non-bold/bright red to background
		set "bg_green=%ESC%[42m"			&:: Background Green			- Applies non-bold/bright green to background
		set "bg_yellow=%ESC%[43m"			&:: Background Yellow			- Applies non-bold/bright yellow to background
		set "bg_blue=%ESC%[44m"				&:: Background Blue				- Applies non-bold/bright blue to background
		set "bg_magenta=%ESC%[45m"			&:: Background Magenta			- Applies non-bold/bright magenta to background
		set "bg_cyan=%ESC%[46m"				&:: Background Cyan				- Applies non-bold/bright cyan to background
		set "bg_white=%ESC%[47m"			&:: Background White			- Applies non-bold/bright white to background
		set "bg_extended=%ESC%[48m"			&:: Background Extended			- Applies extended color value to the background
		set "bg_default=%ESC%[49m"			&:: Background Default			- Applies only the background portion of the defaults
		
		::# Foreground Colors (light)
		set "lblack=%ESC%[90m"				&:: Bright Foreground Black		- Applies bold/bright black to foreground
		set "lred=%ESC%[91m"				&:: Bright Foreground Red		- Applies bold/bright red to foreground
		set "lgreen=%ESC%[92m"				&:: Bright Foreground Green		- Applies bold/bright green to foreground
		set "lyellow=%ESC%[93m"				&:: Bright Foreground Yellow	- Applies bold/bright yellow to foreground
		set "lblue=%ESC%[94m"				&:: Bright Foreground Blue		- Applies bold/bright blue to foreground
		set "lmagenta=%ESC%[95m"			&:: Bright Foreground Magenta	- Applies bold/bright magenta to foreground
		set "lcyan=%ESC%[96m"				&:: Bright Foreground Cyan		- Applies bold/bright cyan to foreground
		set "lwhite=%ESC%[97m"				&:: Bright Foreground White		- Applies bold/bright white to foreground

		::# Background Colors (light)
		set "bg_lblack=%ESC%[100m"			&:: Bright Background Black		- Applies bold/bright black to background
		set "bg_lred=%ESC%[101m"			&:: Bright Background Red		- Applies bold/bright red to background
		set "bg_lgreen=%ESC%[102m"			&:: Bright Background Green		- Applies bold/bright green to background
		set "bg_lyellow=%ESC%[103m"			&:: Bright Background Yellow	- Applies bold/bright yellow to background
		set "bg_lblue=%ESC%[104m"			&:: Bright Background Blue		- Applies bold/bright blue to background
		set "bg_lmagenta=%ESC%[105m"		&:: Bright Background Magenta	- Applies bold/bright magenta to background
		set "bg_lcyan=%ESC%[106m"			&:: Bright Background Cyan		- Applies bold/bright cyan to background
		set "bg_lwhite=%ESC%[107m"			&:: Bright Background White		- Applies bold/bright white to background
		
		::# Foreground RGB Colors
		set "RGB=%ESC%[38;2;"				&:: %RGB%50;100;150m         = %ESC%[38;2;50;100;150m
		
		::# Background RGB Colors
		set "bg_RGB=%ESC%[48;2;"			&:: %bg_RGB%150;100;50m      = %ESC%[38;2;150;100;50m
		
		
		if defined %1 call dk_echo "%blue%C%green%O%red%L%magenta%O%cyan%R %blue%O%green%N%clr%"
	goto:USE_COLOR_endif	
	:USE_COLOR_else
		::call dk_unset ESC
		::call dk_unset clr
		
		::# Styles
		call dk_unset bold
		call dk_unset nobold
		call dk_unset underline
		call dk_unset nounderline
		call dk_unset negative
		call dk_unset nonegative
		
		::# Foreground Colors
		call dk_unset black
		call dk_unset red
		call dk_unset green
		call dk_unset yellow
		call dk_unset blue
		call dk_unset magenta
		call dk_unset cyan
		call dk_unset white
		
		::# Background Colors
		call dk_unset bg_black
		call dk_unset bg_red
		call dk_unset bg_green
		call dk_unset bg_yellow
		call dk_unset bg_blue
		call dk_unset bg_magenta
		call dk_unset bg_cyan
		call dk_unset bg_white
		
		::# Foreground Colors (bright)
		call dk_unset lblack
		call dk_unset lred
		call dk_unset lgreen
		call dk_unset lyellow
		call dk_unset lblue
		call dk_unset lmagenta
		call dk_unset lcyan
		call dk_unset lwhite
		
		::# Background Colors (bright)
		call dk_unset bg_lblack
		call dk_unset bg_lred
		call dk_unset bg_lgreen
		call dk_unset bg_lyellow
		call dk_unset bg_lblue
		call dk_unset bg_lmagenta
		call dk_unset bg_lcyan
		call dk_unset bg_lwhite
		
		call dk_unset RGB
		call dk_unset bg_RGB
	
		dk_echo "%clr% COLOR OFF"
	:USE_COLOR_endif
goto:eof
call dk_color 1



:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	call dk_debugFunc
	
	::call dk_color 1
	::call dk_color 0
	call dk_color 1
	
	echo.
	call dk_echo "%black% %S_BG_BLACK%           Styles            %clr%"
	call dk_echo "clr        %clr% default %clr%"
	call dk_echo "bold       %bold% bold %clr%"
	call dk_echo "underline  %underline% underline %clr%"
	call dk_echo "negative    %negative% negative %clr%"
	echo.
	call dk_echo "%black% %S_BG_BLACK%      Foreground Colors      %clr%"
	call dk_echo "black      %black% black %clr%"
	call dk_echo "red        %red% red %clr%"
	call dk_echo "green      %green% green %clr%"
	call dk_echo "yellow     %yellow% yellow %clr%"
	call dk_echo "blue       %blue% blue %clr%"
	call dk_echo "magenta    %magenta% magenta %clr%"
	call dk_echo "cyan       %cyan% cyan %clr%"
	call dk_echo "white      %white% white %clr%"
	echo.
	call dk_echo "%black% %S_BG_BLACK%      Background Colors      %clr%"
	call dk_echo "bg_black   %bg_black% bg_black %clr%"
	call dk_echo "bg_red     %bg_red% bg_red %clr%"
	call dk_echo "bg_green   %bg_green% bg_green %clr%"
	call dk_echo "bg_yellow  %bg_yellow% bg_yellow %clr%"
	call dk_echo "bg_blue    %bg_blue% bg_blue %clr%"
	call dk_echo "bg_magenta %bg_magenta% bg_magenta %clr%"
	call dk_echo "bg_cyan    %bg_cyan% bg_cyan %clr%"
	call dk_echo "bg_white   %bg_white% bg_white %clr%"
	echo.
	call dk_echo "%black% %S_BG_BLACK% Foreground Colors  bright  %clr%"
	call dk_echo "lblack      %lblack% lblack %clr%"
	call dk_echo "lred        %lred% lred %clr%"
	call dk_echo "lgreen      %lgreen% lgreen %clr%"
	call dk_echo "lyellow     %lyellow% lyellow %clr%"
	call dk_echo "lblue       %lblue% lblue %clr%"
	call dk_echo "lmagenta    %lmagenta% lmagenta %clr%"
	call dk_echo "lcyan       %lcyan% lcyan %clr%"
	call dk_echo "lwhite      %lwhite% lwhite %clr%"
	echo.
	call dk_echo "%black% %S_BG_BLACK% Background Colors  bright  %clr%"
	call dk_echo "bg_lblack   %bg_lblack% bg_lblack %clr%"
	call dk_echo "bg_lred     %bg_lred% bg_lred %clr%"
	call dk_echo "bg_lgreen   %bg_lgreen% bg_lgreen %clr%"
	call dk_echo "bg_lyellow  %bg_lyellow% bg_lyellow %clr%"
	call dk_echo "bg_lblue    %bg_lblue% bg_lblue %clr%"
	call dk_echo "bg_lmagenta %bg_lmagenta% bg_lmagenta %clr%"
	call dk_echo "bg_lcyan    %bg_lcyan% bg_lcyan %clr%"
	call dk_echo "bg_lwhite   %bg_lwhite% bg_lwhite %clr%"
	echo.
	call dk_echo " %RGB%255;10;10m    RGB test (255;0;10)    %clr%"
	call dk_echo " %RGB%10;255;10m    RGB test (0;255;10)    %clr%"
	call dk_echo " %RGB%0;0;255m    RGB test (0;0;255)     %clr%"
	call dk_echo " %RGB%0;0;250m    RGB test (0;0;250)     %clr%"
	call dk_echo " %RGB%0;0;245m    RGB test (0;0;245)     %clr%"
	call dk_echo " %RGB%0;0;240m    RGB test (0;0;240)     %clr%"
	call dk_echo " %RGB%0;0;235m    RGB test (0;0;235)     %clr%"
	call dk_echo " %RGB%0;0;230m    RGB test (0;0;230)     %clr%"
	call dk_echo " %RGB%0;0;225m    RGB test (0;0;225)     %clr%"
	call dk_echo " %RGB%0;0;220m    RGB test (0;0;220)     %clr%"
	call dk_echo " %RGB%0;0;215m    RGB test (0;0;215)     %clr%"
	call dk_echo " %RGB%0;0;210m    RGB test (0;0;210)     %clr%"
	call dk_echo " %RGB%0;0;205m    RGB test (0;0;205)     %clr%"
	call dk_echo " %RGB%0;0;200m    RGB test (0;0;200)     %clr%"
	call dk_echo " %RGB%0;0;195m    RGB test (0;0;195)     %clr%"
	call dk_echo " %RGB%0;0;190m    RGB test (0;0;190)     %clr%"
	call dk_echo " %RGB%0;0;185m    RGB test (0;0;185)     %clr%"
	call dk_echo " %RGB%0;0;180m    RGB test (0;0;180)     %clr%"
	call dk_echo " %RGB%0;0;175m    RGB test (0;0;175)     %clr%"
	call dk_echo " %RGB%0;0;170m    RGB test (0;0;170)     %clr%"
	call dk_echo " %RGB%0;0;165m    RGB test (0;0;165)     %clr%"
	call dk_echo " %RGB%0;0;160m    RGB test (0;0;160)     %clr%"
	call dk_echo " %RGB%0;0;155m    RGB test (0;0;155)     %clr%"
	call dk_echo " %RGB%0;0;150m    RGB test (0;0;150)     %clr%"
	call dk_echo " %RGB%0;0;145m    RGB test (0;0;145)     %clr%"
	call dk_echo " %RGB%0;0;140m    RGB test (0;0;140)     %clr%"
	call dk_echo " %RGB%0;0;135m    RGB test (0;0;135)     %clr%"
	call dk_echo " %RGB%0;0;130m    RGB test (0;0;130)     %clr%"
	call dk_echo " %RGB%0;0;125m    RGB test (0;0;125)     %clr%"
	call dk_echo " %RGB%0;0;120m    RGB test (0;0;120)     %clr%"
	call dk_echo " %RGB%0;0;115m    RGB test (0;0;115)     %clr%"
	call dk_echo " %RGB%0;0;110m    RGB test (0;0;110)     %clr%"
	call dk_echo " %RGB%0;0;105m    RGB test (0;0;105)     %clr%"
	call dk_echo " %RGB%0;0;100m    RGB test (0;0;100)     %clr%"
	call dk_echo " %RGB%0;0;95m    RGB test (0;0;95)      %clr%"
	call dk_echo " %RGB%0;0;90m    RGB test (0;0;90)      %clr%"
	call dk_echo " %RGB%0;0;85m    RGB test (0;0;85)      %clr%"
	call dk_echo " %RGB%0;0;80m    RGB test (0;0;80)      %clr%"
	call dk_echo " %RGB%0;0;75m    RGB test (0;0;75)      %clr%"
	call dk_echo " %RGB%0;0;70m    RGB test (0;0;70)      %clr%"
	call dk_echo " %RGB%0;0;65m    RGB test (0;0;65)      %clr%"
	call dk_echo " %RGB%0;0;60m    RGB test (0;0;60)      %clr%"
	call dk_echo " %RGB%0;0;55m    RGB test (0;0;55)      %clr%"
	call dk_echo " %RGB%0;0;50m    RGB test (0;0;50)      %clr%"
	call dk_echo " %RGB%0;0;45m    RGB test (0;0;45)      %clr%"
	call dk_echo " %RGB%0;0;40m    RGB test (0;0;40)      %clr%"
	call dk_echo " %RGB%0;0;35m    RGB test (0;0;35)      %clr%"
	call dk_echo " %RGB%0;0;30m    RGB test (0;0;30)      %clr%"
	call dk_echo " %RGB%0;0;25m    RGB test (0;0;25)      %clr%"
	call dk_echo " %RGB%0;0;20m    RGB test (0;0;20)      %clr%"
	call dk_echo " %RGB%0;0;15m    RGB test (0;0;15)      %clr%"
	call dk_echo " %RGB%0;0;10m    RGB test (0;0;10)      %clr%"
	call dk_echo " %RGB%0;0;5m    RGB test (0;0;5)       %clr%"
	call dk_echo " %RGB%0;0;0m    RGB test (0;0;0)       %clr%"
	echo.
	call dk_echo "%black% %bg_lblack%        Combinations         %clr%"
	call dk_echo "negative                            %negative%   inverse foreground <-> background   %clr%"
	call dk_echo "bg_yellow red                     %bg_yellow% %red%   yellow backgroud / red foreground   %clr%"
	call dk_echo "bg_yellow red negative           %bg_yellow% %red% %negative%        yellow / red inversed          %clr%"
	call dk_echo "bg_red.. bg_green.. bg_blue     %bg_red%    nested   %bg_green%    colors    %bg_blue%    text    %clr%"
	echo.
	echo.
	call dk_echo " %bg_blue% * * * * * * * * * %bg_red%                                  %clr%"
	call dk_echo " %bg_blue%  * * * * * * * *  %bg_white%                                  %clr%"
	call dk_echo " %bg_blue% * * * * * * * * * %bg_red%                                  %clr%" 
	call dk_echo " %bg_blue%  * * * * * * * *  %bg_white%                                  %clr%"
	call dk_echo " %bg_blue% * * * * * * * * * %bg_red%                                  %clr%"
	call dk_echo " %bg_blue%  * * * * * * * *  %bg_white%                                  %clr%"
	call dk_echo " %bg_blue% * * * * * * * * * %bg_red%                                  %clr%"
	call dk_echo " %bg_white%                                                     %clr%"
	call dk_echo " %bg_red%                                                     %clr%"
	call dk_echo " %bg_white%                                                     %clr%"
	call dk_echo " %bg_red%                                                     %clr%"
	call dk_echo " %bg_white%                                                     %clr%"
	call dk_echo " %bg_red%                                                     %clr%"
goto:eof