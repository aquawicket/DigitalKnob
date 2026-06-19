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


rem #####################################################################
rem # Target_App(RTN:Target_App)
rem #
rem #
:Target_App
%setlocal%

	rem ###### SET ######
	if "%~1" neq "" (
		set "Target_App=%~1"
		goto:return
	)
	rem ###### GET ######
	rem else (
		rem ### Load DKBuilder.cache ###
		%dk_call% dk_validate DKCACHE_DIR %dk_call% dk_DKCACHE_DIR
		set "DKBuilder_cache=!DKCACHE_DIR!/DKBuilder.cache"
		if EXIST "!DKBuilder_cache!" (
			%dk_call% dk_fileVariables "!DKBuilder_cache!"
		)

		rem ### get a list of the directories in DKCpp/apps ###
		%dk_call% dk_validate DKCPP_APPS_DIR %dk_call% dk_DKBRANCH_DIR

		%dk_call% dk_deleteArray dk_getDirectories
		%dk_call% dk_getDirectories "!DKCPP_APPS_DIR!"
		set "dk_getDirectories=!dk_getDirectories!"
		%dk_call% dk_deleteArray commands

		rem ### rename the list elements to the folder basename and add a matching command ###
		set /a "n=0"
		:loop1
			if NOT defined dk_getDirectories[!n!] goto:endloop1
			for %%Z in ("!dk_getDirectories[%n%]!") do set "dk_getDirectories[!n!]=%%~nxZ"
			set "commands[!n!]=%dk_call% dk_set Target_App !dk_getDirectories[%n%]!"
			set /a n+=1
			goto:loop1
		:endloop1

		rem ### prepend cache selection if available ###
		if defined Target_App_Cache (
			%dk_call% Array/dk_unshift dk_getDirectories "!Target_App_Cache!"
			%dk_call% Array/dk_unshift commands "call:runCache"
		)
		goto:end_runCache
		:runCache
			%dk_call% dk_set Target_App		%Target_App_Cache%
			%return%
		:end_runCache

		rem ### Append remaining dk_getDirectories with commands ###
		%dk_call% Array/dk_push dk_getDirectories "Enter Manually"
		%dk_call% Array/dk_push commands %dk_call% dk_enterManually
		
		%dk_call% Array/dk_push dk_getDirectories "Clear Screen"
		%dk_call% Array/dk_push commands %dk_call% dk_clearScreen

		%dk_call% Array/dk_push dk_getDirectories "Reload"
		%dk_call% Array/dk_push commands %dk_call% dk_reload

		%dk_call% Array/dk_push dk_getDirectories "Go Back"
		%dk_call% Array/dk_push commands %dk_call% dk_unset pickUpdate

		%dk_call% Array/dk_push dk_getDirectories "Exit"
		%dk_call% Array/dk_push commands %dk_call% dk_exit

		rem ### Print the dk_getDirectories list ###
		set /a "n=0"
		:loop2
			if NOT defined dk_getDirectories[!n!] goto:endloop2
			echo !n!: !dk_getDirectories[%n%]!
			if "!n!" equ "0" (echo. )
			set /a n+=1
			goto loop2
		:endloop2

		%dk_call% dk_echo
		%dk_call% dk_echo "Please select a Target_App to build"

		%dk_call% dk_keyboardInput
		rem %dk_call% dk_keyboardInputTimeout 23 60

		rem %dk_call% dk_echo "dk_getDirectories[%dk_keyboardInput%] = '!dk_getDirectories[%dk_keyboardInput%]!'"

		if NOT defined commands[!dk_keyboardInput!] (
			%dk_call% dk_echo "!dk_keyboardInput!: invalid selection, please try again"
			endlocal
			goto:Target_App
			%return%
		)
	rem )
	
rem	endlocal & (
		!commands[%dk_keyboardInput%]!
rem	)
	
	%dk_call% dk_deleteArray dk_getDirectories
	%dk_call% dk_deleteArray commands
	
	:return
	endlocal & (
		set "Target_App=%Target_App%"
		set "pickUpdate=%pickUpdate%"
	)

	rem TODO
	rem %dk_call% dk_echo "%dk_keyboardInput%: invalid selection, please try again"
	rem %dk_call% dk_unset Target_App
%endfunction%



rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% DKBuilder/Target_App
	%dk_call% dk_debug "Target_App = %Target_App%"
%endfunction%
