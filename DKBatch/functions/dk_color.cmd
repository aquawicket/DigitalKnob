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
		set "ESC="
		
		::# Styles
		set "clr=%ESC%[0m"				&:: Default						- Returns all attributes to the default state prior to modification
		set "bold=%ESC%[1m"				&:: Bold/Bright 				- Applies brightness/intensity flag to foreground color
		set "nobold=%ESC%[22m"			&:: No bold/bright				- Removes brightness/intensity flag from foreground color
		set "underline=%ESC%[4m"		&:: Underline       			- Adds underline
		set "nounderline=%ESC%[24m"		&:: No underline				- Removes underline
		set "negative=%ESC%[7m"   		&:: Negative	    			- Swaps foreground and background colors
		set "nonegative=%ESC%[27m"  	&:: Positive(No negative)		- Returns foreground/background to normal

		::# Foreground Colors
		set "black=%ESC%[30m"			&:: Foreground Black			- Applies non-bold/bright black to foreground
		set "red=%ESC%[31m"				&:: Foreground Red				- Applies non-bold/bright red to foreground
		set "green=%ESC%[32m"			&:: Foreground Green			- Applies non-bold/bright green to foreground
		set "yellow=%ESC%[33m"			&:: Foreground Yellow			- Applies non-bold/bright yellow to foreground
		set "blue=%ESC%[34m"			&:: Foreground Blue				- Applies non-bold/bright blue to foreground
		set "magenta=%ESC%[35m"			&:: Foreground Magenta			- Applies non-bold/bright magenta to foreground
		set "cyan=%ESC%[36m"			&:: Foreground Cyan				- Applies non-bold/bright cyan to foreground
		set "white=%ESC%[37m"			&:: Foreground White			- Applies non-bold/bright white to foreground
		set "extended=%ESC%[38m"		&:: Foreground Extended			- Applies extended color value to the foreground
		set "default=%ESC%[39m"			&:: Foreground Default			- Applies only the foreground portion of the defaults
		
		::# Background Colors
		set "bg_black=%ESC%[40m"		&:: Background Black			- Applies non-bold/bright black to background
		set "bg_red=%ESC%[41m"			&:: Background Red				- Applies non-bold/bright red to background
		set "bg_green=%ESC%[42m"		&:: Background Green			- Applies non-bold/bright green to background
		set "bg_yellow=%ESC%[43m"		&:: Background Yellow			- Applies non-bold/bright yellow to background
		set "bg_blue=%ESC%[44m"			&:: Background Blue				- Applies non-bold/bright blue to background
		set "bg_magenta=%ESC%[45m"		&:: Background Magenta			- Applies non-bold/bright magenta to background
		set "bg_cyan=%ESC%[46m"			&:: Background Cyan				- Applies non-bold/bright cyan to background
		set "bg_white=%ESC%[47m"		&:: Background White			- Applies non-bold/bright white to background
		set "bg_extended=%ESC%[48m"		&:: Background Extended			- Applies extended color value to the background
		set "bg_white=%ESC%[49m"		&:: Background Default			- Applies only the background portion of the defaults
		
		::# Foreground Colors (light)
		set "lblack=%ESC%[90m"			&:: Bright Foreground Black		- Applies bold/bright black to foreground
		set "lred=%ESC%[91m"			&:: Bright Foreground Red		- Applies bold/bright red to foreground
		set "lgreen=%ESC%[92m"			&:: Bright Foreground Green		- Applies bold/bright green to foreground
		set "lyellow=%ESC%[93m"			&:: Bright Foreground Yellow	- Applies bold/bright yellow to foreground
		set "lblue=%ESC%[94m"			&:: Bright Foreground Blue		- Applies bold/bright blue to foreground
		set "lmagenta=%ESC%[95m"		&:: Bright Foreground Magenta	- Applies bold/bright magenta to foreground
		set "lcyan=%ESC%[96m"			&:: Bright Foreground Cyan		- Applies bold/bright cyan to foreground
		set "lwhite=%ESC%[97m"			&:: Bright Foreground White		- Applies bold/bright white to foreground

		::# Background Colors (light)
		set "bg_lblack=%ESC%[100m"		&:: Bright Background Black		- Applies bold/bright black to background
		set "bg_lred=%ESC%[101m"		&:: Bright Background Red		- Applies bold/bright red to background
		set "bg_lgreen=%ESC%[102m"		&:: Bright Background Green		- Applies bold/bright green to background
		set "bg_lyellow=%ESC%[103m"		&:: Bright Background Yellow	- Applies bold/bright yellow to background
		set "bg_lblue=%ESC%[104m"		&:: Bright Background Blue		- Applies bold/bright blue to background
		set "bg_lmagenta=%ESC%[105m"	&:: Bright Background Magenta	- Applies bold/bright magenta to background
		set "bg_lcyan=%ESC%[106m"		&:: Bright Background Cyan		- Applies bold/bright cyan to background
		set "bg_lwhite=%ESC%[107m"		&:: Bright Background White		- Applies bold/bright white to background
	

		::#########################
		::#  RGB color schemes
		
		::set "rgb=%ESC%[38;2;255;0;0m"
		
		call dk_echo "%blue%C%green%O%red%L%magenta%O%cyan%R %blue%O%green%N%clr%"
	goto:USE_COLOR_endif	
	:USE_COLOR_else
		::call dk_unset ESC
		::call dk_unset clr
		
		::# Styles
		call dk_unset bold
		call dk_unset underline
		call dk_unset inverse
		
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
	call dk_echo "clr        %clr% Default %clr%"
	call dk_echo "bold       %bold% Bold %clr%"
	call dk_echo "underline  %underline% Underline %clr%"
	call dk_echo "inverse    %inverse% Inverse %clr%"
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
	call dk_echo "%rgb%       RGB test         %clr%"
	echo.
	call dk_echo "%black% %S_BG_BLACK%        Combinations         %clr%"
	call dk_echo "inverse                            %inverse%   inverse foreground <-> background   %clr%"
	call dk_echo "bg_yellow red                     %bg_yellow% %red%   yellow backgroud / red foreground   %clr%"
	call dk_echo "bg_yellow red inverse           %bg_yellow% %red% %inverse%        yellow / red inversed          %clr%"
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