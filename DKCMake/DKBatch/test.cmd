%DKBATCH%

:: https://github.com/ClicketyClickDK/Underscore
set TEST_DKVARIABLES=1
set TEST_DKERRORS=1
set TEST_DKNESTING=1
set TEST_DKPRINT=1
set TEST_DKTEMPLATE=1
set TEST_DKSENDDATA=1
set TEST_DKGETDATA=1
set TEST_DKSENDANDGETDATA=1
set TEST_DKCOLOR=1
set TEST_DKSLEEP=1


::::::::::::::::::::::::::::::::::::::::::
if not defined TEST_DKVARIABLES goto :end
	echo #################################
	echo ##      TESTING Variables      ##
	echo #################################
	echo creating Test_variableA
	set Test_variableA=Some string data
	echo Test_variableA: !Test_variableA!
	echo appending Test_variableA
	set "Test_variableA=!Test_variableA! added some data to the end"
	echo Test_variableA: !Test_variableA!
	echo:
:end


::::::::::::::::::::::::::::::::::::::::::
if not defined TEST_DKNESTING goto :end
	echo #################################
	echo ##      TESTING Nesting        ##
	echo #################################
	call NestedNodes1
	echo:
:end


::::::::::::::::::::::::::::::::::::::::::
if not defined TEST_DKPRINT goto :end
	echo #################################
	echo ##      TESTING dkprint        ##
	echo #################################
	call dkprint this is a test of dkprint
	echo:
:end


:::::::::::::::::::::::::::::::::::::::::::
if not defined TEST_DKTEMPLATE goto :end
	echo ##################################
	echo ##      TESTING TEMPLATE        ##
	echo ##################################
	call TEMPLATE 369 string result1 result2
	echo TemplateFunc returned: !result1! !result2!
	echo:
:end


:::::::::::::::::::::::::::::::::::::::::::
if not defined TEST_DKSENDDATA goto :end
	echo ##################################
	echo ##      TESTING SendData        ##
	echo ##################################
	call SendData apple
	echo:
:end


::::::::::::::::::::::::::::::::::::::::::
if not defined TEST_DKGETDATA goto :end
	echo #################################
	echo ##      TESTING GetData        ##
	echo #################################
	call GetData result 
	echo GetData returned: !result!
	echo:
:end


:::::::::::::::::::::::::::::::::::::::::::::::
if not defined TEST_DKSENDANDGETDATA goto :end
	echo ######################################
	echo ##      TESTING SendAndGetData      ##
	echo ######################################
	call SendAndGetData orange result
	echo SendAndGetData returned: !result!
	echo:
:end


:::::::::::::::::::::::::::::::::::::::
if not defined TEST_DKCOLOR goto :end
	echo ##############################
	echo ##      TESTING Color       ##
	echo ##############################
	call Color
	echo:
:end

:::::::::::::::::::::::::::::::::::::::
if not defined TEST_DKSLEEP goto :end
	echo ##############################
	echo ##      TESTING Sleep       ##
	echo ##############################
	call Sleep 2
	echo:
:end


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if not defined TEST_DKERRORS goto :end
	echo ################################
	echo ##      TESTING Errors        ##
	echo ################################
	set "ERRORLEVEL=0"
	!IF_ERROR! "IF_ERROR: This throws an error if ERRLVL in not 0, and continues"
	echo:
	
	set "ERRORLEVEL=1"
	!IF_ERROR! "IF_ERROR: This throws an error if ERRLVL in not 0, and continues"
	echo: 

	!ERROR! "ERROR: This throws an error, and continues"
	echo:

	set "ERRORLEVEL=0"
	!IF_FATAL! "IF_FATAL: This thows an error if ERRLVL in not 0, and exits the program"
	echo:
	
	set "ERRORLEVEL=1"
	!IF_FATAL! "IF_FATAL: This thows an error if ERRLVL in not 0, and exits the program"
	echo:

	!FATAL! "FATAL: This throws an error, and exits the program"
	echo:
:end



%DKEND%
