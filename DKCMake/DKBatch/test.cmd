%DKBATCH%
:: https://github.com/ClicketyClickDK/Underscore


set TEST_DKERRORS=1
set TEST_DKNESTING=1
set TEST_DKPRINT=1
set TEST_DKTEMPLATE=1
set TEST_DKSENDDATA=1
set TEST_DKGETDATA=1
set TEST_DKSENDANDGETDATA=1
set TEST_DKCOLOR=1
set TEST_DKSLEEP=1

::::::::::::::::::::::::::::
if defined TEST_DKNESTING (
	echo #################################
	echo ##      TESTING Nesting        ##
	echo #################################
	call NestedNodes1
	echo:
)
:::::::::::::::::::::::::::


:::::::::::::::::::::::::
if defined TEST_DKPRINT (
	echo #################################
	echo ##      TESTING dkprint        ##
	echo #################################
	call dkprint this is a test of dkprint
	echo:
)
:::::::::::::::::::::::::


::::::::::::::::::::::::::::
if defined TEST_DKTEMPLATE (
	echo ##################################
	echo ##      TESTING TEMPLATE        ##
	echo ##################################
	call TEMPLATE 369 string result
	echo TemplateFunc returned: %result%
	echo:
)
:::::::::::::::::::::::::::


::::::::::::::::::::::::::::
if defined TEST_DKSENDDATA (
	echo ##################################
	echo ##      TESTING SendData        ##
	echo ##################################
	call SendData apple
	echo:
)
:::::::::::::::::::::::::::


::::::::::::::::::::::::::::
if defined TEST_DKGETDATA (
	echo #################################
	echo ##      TESTING GetData        ##
	echo #################################
	call GetData result 
	echo GetData returned: %result%
	echo:
)
:::::::::::::::::::::::::::


::::::::::::::::::::::::::::::::::
if defined TEST_DKSENDANDGETDATA (
	echo ######################################
	echo ##      TESTING SendAndGetData      ##
	echo ######################################
	call SendAndGetData orange result
	echo SendAndGetData returned: %result%
	echo:
)
::::::::::::::::::::::::::::::::::


:::::::::::::::::::::::::
if defined TEST_DKCOLOR (
	echo ##############################
	echo ##      TESTING Color       ##
	echo ##############################
	call Color :ShowColors
	echo:
)
::::::::::::::::::::::::


:::::::::::::::::::::::::
if defined TEST_DKSLEEP (
	echo ##############################
	echo ##      TESTING Sleep       ##
	echo ##############################
	call Sleep 2
	echo:
)
::::::::::::::::::::::::


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if defined TEST_DKERRORS (
	echo ################################
	echo ##      TESTING Errors        ##
	echo ################################
	set "ERRORLEVEL=0"
	%IF_ERROR% "IF_ERROR: This throws an error if ERRLVL in not 0, and continues"
	echo:
	
	set "ERRORLEVEL=1"
	%IF_ERROR% "IF_ERROR: This throws an error if ERRLVL in not 0, and continues"
	echo: 

	%ERROR% "ERROR: This throws an error, and continues"
	echo:

	set "ERRORLEVEL=0"
	%IF_FATAL% "IF_FATAL: This thows an error if ERRLVL in not 0, and exits the program"
	echo:
	
	set "ERRORLEVEL=1"
	%IF_FATAL% "IF_FATAL: This thows an error if ERRLVL in not 0, and exits the program"
	echo:

	%FATAL% "FATAL: This throws an error, and exits the program"
	echo:
)
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


:end
%DKEND%