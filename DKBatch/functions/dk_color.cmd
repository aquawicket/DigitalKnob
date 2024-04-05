:: dk_include_guard()
:: call dk_verbose "%0(%*)"

:::::: STYLES ::::::
set "clr=[0m"
set "bold=[1m"
set "underline=[4m"
set "inverse=[7m"
	
:::::: NORMAL FOREGROUND COLORS ::::::
set "black=[30m"
set "red=[31m"
set "green=[32m"
set "yellow=[33m"
set "blue=[34m"
set "magenta=[35m"
set "cyan=[36m"
set "white=[37m"

:::::: NORMAL BACKGROUND COLORS ::::::
set "bg_black=[40m"
set "bg_red=[41m"
set "bg_green=[42m"
set "bg_yellow=[43m"
set "bg_blue=[44m"
set "bg_magenta=[45m"
set "bg_cyan=[46m"
set "bg_white=[47m"

:::::: STRONG FOREGROUND COLORS ::::::
set "BLACK=[90m"
set "RED=[91m"
set "GREEN=[92m"
set "YELLOW=[93m"
set "BLUE=[94m"
set "MAGENTA=[95m"
set "CYAN=[96m"
set "WHITE=[97m"

:::::: STRONG BACKGROUND COLORS ::::::
set "BG_BLACK=[100m"
set "BG_RED=[101m"
set "BG_GREEN=[102m"
set "BG_YELLOW=[103m"
set "BG_BLUE=[104m"
set "BG_MAGENTA=[105m"
set "BG_CYAN=[106m"
set "BG_WHITE=[107m"


:::::::::::::::::::::::::::::::::::::::::::::
:: dk_color () {
::
::
::
:dk_color () {
    ::call dk_verbose "%0(%*)"
    call :dk_print_colors
goto:eof

:::::::::::::::::::::::::::::::::::::::::::::
:: dk_print_colors () {
::
::
::
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