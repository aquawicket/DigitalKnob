::dk_include_guard()

::####################################################################
::# dk_print_colors()
::#
::#
:dk_print_colors () {
	::call dk_verbose "%0(%*)"
	
	echo.
	echo [101;93m STYLES %clr%
	echo %%clr%%        %clr%Reset%clr%
	echo %%bold%%       %bold%Bold%clr%
	echo %%underline%%  %underline%Underline%clr%
	echo %%inverse%%    %inverse%Inverse%clr%
	echo.
	echo [101;93m NORMAL FOREGROUND COLORS %clr%
	echo %%black%%      %black%Black%clr%
	echo %%red%%        %red%Red%clr%
	echo %%green%%      %green%Green%clr%
	echo %%yellow%%     %yellow%Yellow%clr%
	echo %%blue%%       %blue%Blue%clr%
	echo %%magenta%%    %magenta%Magenta%clr%
	echo %%cyan%%       %cyan%Cyan%clr%
	echo %%white%%      %white%White%clr%
	echo.
	echo [101;93m NORMAL BACKGROUND COLORS %clr%
	echo %%bg_black%%   %bg_black%Black%clr%
	echo %%bg_red%%     %bg_red%Red%clr%
	echo %%bg_green%%   %bg_green%Green%clr%
	echo %%bg_yellow%%  %bg_yellow%Yellow%clr%
	echo %%bg_blue%%    %bg_blue%Blue%clr%
	echo %%bg_magenta%% %bg_magenta%Magenta%clr%
	echo %%bg_cyan%%    %bg_cyan%Cyan%clr%
	echo %%bg_white%%   %bg_white%White%clr%
	echo.
	echo [101;93m STRONG FOREGROUND COLORS %clr%
	echo %%BLACK%%      %BLACK%Black%clr%
	echo %%RED%%        %RED%Red%clr%
	echo %%GREEN%%      %GREEN%Green%clr%
	echo %%YELLOW%%     %YELLOW%Yellow%clr%
	echo %%BLUE%%       %BLUE%Blue%clr%
	echo %%MAGENTA%%    %MAGENTA%Magenta%clr%
	echo %%CYAN%%       %CYAN%Cyan%clr%
	echo %%WHITE%%      %WHITE%White%clr%
	echo.
	echo [101;93m STRONG BACKGROUND COLORS %clr%
	echo %%BG_BLACK%%   %BG_BLACK%Black%clr%
	echo %%BG_RED%%     %BG_RED%Red%clr%
	echo %%BG_GREEN%%   %BG_GREEN%Green%clr%
	echo %%BG_YELLOW%%  %BG_YELLOW%Yellow%clr%
	echo %%BG_BLUE%%    %BG_BLUE%Blue%clr%
	echo %%BG_MAGENTA%% %BG_MAGENTA%Magenta%clr%
	echo %%BG_CYAN%%    %BG_CYAN%Cyan%clr%
	echo %%BG_WHITE%%   %BG_WHITE%White%clr%
	echo.
	echo [101;93m COMBINATIONS %clr%
	echo ^<ESC^>[31m                     [31mred foreground color%clr%
	echo ^<ESC^>[7m                      [7minverse foreground ^<-^> background%clr%
	echo ^<ESC^>[7;31m                   [7;31minverse red foreground color%clr%
	echo ^<ESC^>[7m and nested ^<ESC^>[31m [7mbefore [31mnested%clr%
	echo ^<ESC^>[31m and nested ^<ESC^>[7m [31mbefore [7mnested%clr%

	pause
goto:eof