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
::#
:dk_color () {
	call dk_debugFunc
	if %__ARGC__% gtr 1 (call dk_error "%__FUNCTION__%(%__ARGC__%): too many arguments")

	set "USE_COLOR=1"
	if defined %1 if %1 equ 0 call dk_unset USE_COLOR 

	
	:USE_COLOR_if
	if not defined USE_COLOR goto:USE_COLOR_else
		set "ESC="
		set "clr=%ESC%[0m"
	
		::# Styles
		set "bold=%ESC%[1m"
		set "underline=%ESC%[4m"
		set "inverse=%ESC%[7m"
		
		::# Foreground Colors
		set "black=%ESC%[30m"
		set "red=%ESC%[31m"
		set "green=%ESC%[32m"
		set "yellow=%ESC%[33m"
		set "blue=%ESC%[34m"
		set "magenta=%ESC%[35m"
		set "cyan=%ESC%[36m"
		set "white=%ESC%[37m"
		
		::# Background Colors
		set "bg_black=%ESC%[40m"
		set "bg_red=%ESC%[41m"
		set "bg_green=%ESC%[42m"
		set "bg_yellow=%ESC%[43m"
		set "bg_blue=%ESC%[44m"
		set "bg_magenta=%ESC%[45m"
		set "bg_cyan=%ESC%[46m"
		set "bg_white=%ESC%[47m"
		
		::# Foreground Colors (Bright)
		set "S_BLACK=%ESC%[90m"
		set "S_RED=%ESC%[91m"
		set "S_GREEN=%ESC%[92m"
		set "S_YELLOW=%ESC%[93m"
		set "S_BLUE=%ESC%[94m"
		set "S_MAGENTA=%ESC%[95m"
		set "S_CYAN=%ESC%[96m"
		set "S_WHITE=%ESC%[97m"

		::# Background Colors (Bright)
		set "S_BG_BLACK=%ESC%[100m"
		set "S_BG_RED=%ESC%[101m"
		set "S_BG_GREEN=%ESC%[102m"
		set "S_BG_YELLOW=%ESC%[103m"
		set "S_BG_BLUE=%ESC%[104m"
		set "S_BG_MAGENTA=%ESC%[105m"
		set "S_BG_CYAN=%ESC%[106m"
		set "S_BG_WHITE=%ESC%[107m"
		
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
		call dk_unset S_BLACK
		call dk_unset S_RED
		call dk_unset S_GREEN
		call dk_unset S_YELLOW
		call dk_unset S_BLUE
		call dk_unset S_MAGENTA
		call dk_unset S_CYAN
		call dk_unset S_WHITE
		
		::# Background Colors (bright)
		call dk_unset S_BG_BLACK
		call dk_unset S_BG_RED
		call dk_unset S_BG_GREEN
		call dk_unset S_BG_YELLOW
		call dk_unset S_BG_BLUE
		call dk_unset S_BG_MAGENTA
		call dk_unset S_BG_CYAN
		call dk_unset S_BG_WHITE
	
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
	call dk_echo "clr        %clr% Reset %clr%"
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
	call dk_echo "BLACK      %S_BLACK% BLACK %clr%"
	call dk_echo "RED        %S_RED% RED %clr%"
	call dk_echo "GREEN      %S_GREEN% GREEN %clr%"
	call dk_echo "YELLOW     %S_YELLOW% YELLOW %clr%"
	call dk_echo "BLUE       %S_BLUE% BLUE %clr%"
	call dk_echo "MAGENTA    %S_MAGENTA% MAGENTA %clr%"
	call dk_echo "CYAN       %S_CYAN% CYAN %clr%"
	call dk_echo "WHITE      %S_WHITE% WHITE %clr%"
	echo.
	call dk_echo "%black% %S_BG_BLACK% Background Colors  bright  %clr%"
	call dk_echo "BG_BLACK   %S_BG_BLACK% BG_BLACK %clr%"
	call dk_echo "BG_RED     %S_BG_RED% BG_RED %clr%"
	call dk_echo "BG_GREEN   %S_BG_GREEN% BG_GREEN %clr%"
	call dk_echo "BG_YELLOW  %S_BG_YELLOW% BG_YELLOW %clr%"
	call dk_echo "BG_BLUE    %S_BG_BLUE% BG_BLUE %clr%"
	call dk_echo "BG_MAGENTA %S_BG_MAGENTA% BG_MAGENTA %clr%"
	call dk_echo "BG_CYAN    %S_BG_CYAN% BG_CYAN %clr%"
	call dk_echo "BG_WHITE   %S_BG_WHITE% BG_WHITE %clr%"
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