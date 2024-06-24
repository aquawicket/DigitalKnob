@echo off
call DK.cmd

::####################################################################
::# dk_printColors()
::#
:dk_printColors () {
	call dk_debugFunc
	if %__ARGC__% neq 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	call dk_echo
	call dk_info "[101;93m STYLES %clr%"
	call dk_info "%%clr%%        %clr%Reset%clr%"
	call dk_info "%%bold%%       %bold%Bold%clr%"
	call dk_info "%%underline%%  %underline%Underline%clr%"
	call dk_info "%%inverse%%    %inverse%Inverse%clr%"
	call dk_echo
	call dk_info "[101;93m NORMAL FOREGROUND COLORS %clr%"
	call dk_info "%%black%%      %black%Black%clr%"
	call dk_info "%%red%%        %red%Red%clr%"
	call dk_info "%%green%%      %green%Green%clr%"
	call dk_info "%%yellow%%     %yellow%Yellow%clr%"
	call dk_info "%%blue%%       %blue%BLUE%clr%"
	call dk_info "%%magenta%%    %magenta%Magenta%clr%"
	call dk_info "%%cyan%%       %cyan%Cyan%clr%"
	call dk_info "%%white%%      %white%White%clr%"
	call dk_echo
	call dk_info "[101;93m NORMAL BACKGROUND COLORS %clr%"
	call dk_info "%%bg_black%%   %bg_black%Black%clr%"
	call dk_info "%%bg_red%%     %bg_red%Red%clr%"
	call dk_info "%%bg_green%%   %bg_green%Green%clr%"
	call dk_info "%%bg_yellow%%  %bg_yellow%Yellow%clr%"
	call dk_info "%%bg_blue%%    %bg_blue%BLUE%clr%"
	call dk_info "%%bg_magenta%% %bg_magenta%Magenta%clr%"
	call dk_info "%%bg_cyan%%    %bg_cyan%Cyan%clr%"
	call dk_info "%%bg_white%%   %bg_white%White%clr%"
	call dk_echo
	call dk_info "[101;93m STRONG FOREGROUND COLORS %clr%"
	call dk_info "%%BLACK%%      %BLACK%Black%clr%"
	call dk_info "%%RED%%        %RED%Red%clr%"
	call dk_info "%%GREEN%%      %GREEN%Green%clr%"
	call dk_info "%%YELLOW%%     %YELLOW%Yellow%clr%"
	call dk_info "%%BLUE%%       %BLUE%BLUE%clr%"
	call dk_info "%%MAGENTA%%    %MAGENTA%Magenta%clr%"
	call dk_info "%%CYAN%%       %CYAN%Cyan%clr%"
	call dk_info "%%WHITE%%      %WHITE%White%clr%"
	call dk_echo
	call dk_info "[101;93m STRONG BACKGROUND COLORS %clr%"
	call dk_info "%%BG_BLACK%%   %BG_BLACK%Black%clr%"
	call dk_info "%%BG_RED%%     %BG_RED%Red%clr%"
	call dk_info "%%BG_GREEN%%   %BG_GREEN%Green%clr%"
	call dk_info "%%BG_YELLOW%%  %BG_YELLOW%Yellow%clr%"
	call dk_info "%%BG_BLUE%%    %BG_BLUE%BLUE%clr%"
	call dk_info "%%BG_MAGENTA%% %BG_MAGENTA%Magenta%clr%"
	call dk_info "%%BG_CYAN%%    %BG_CYAN%Cyan%clr%"
	call dk_info "%%BG_WHITE%%   %BG_WHITE%White%clr%"
	call dk_echo
	call dk_info "[101;93m COMBINATIONS %clr%"
	call dk_info "^<ESC^>[31m                     [31mred foreground color%clr%"
	call dk_info "^<ESC^>[7m                      [7minverse foreground ^<-^> background%clr%"
	call dk_info "^<ESC^>[7;31m                   [7;31minverse red foreground color%clr%"
	call dk_info "^<ESC^>[7m and nested ^<ESC^>[31m [7mbefore [31mnested%clr%"
	call dk_info "^<ESC^>[31m and nested ^<ESC^>[7m [31mbefore [7mnested%clr%"
goto:eof


:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	
	call dk_printColors