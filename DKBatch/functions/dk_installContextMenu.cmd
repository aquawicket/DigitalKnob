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


rem ################################################################################
rem # dk_installContextMenu(menuTitle, icon_exe, command)
rem #
:dk_installContextMenu
%setlocal%
	
    set "_menuTitle_=%~1"
    set "_icon_exe_=%~2"
	for /f "tokens=2*" %%a in ("%*") do (set _command_=%%b)
	echo _command_ = %_command_:/=\%
	
	rem set "_icon_exe_=%_icon_exe_:/=\%"
	rem set "_command_=%_command_:/=\%"
   
    %dk_call% dk_debug "Adding '%_menuTitle_:/=\%' context menu to Registry"
	%dk_call% dk_debug "Using '%_icon_exe_:/=\%' for the icon"
   
	%dk_call% dk_validate reg.exe %dk_call% dk_findFile reg.exe
    rem ### delete existing key ###
 rem   %dk_call% dk_registryDeleteKey "HKCR/AllFilesystemObjects/shell/%_menuTitle_%"
   
    rem ### Menu Title ###
    rem %dk_call% dk_registrySetKey "HKCR/*/shell/%_menuTitle_%" "" "" "&%_menuTitle_%"
    rem echo REG ADD "HKCR/*/shell/%_menuTitle_%" /ve /d "&%_menuTitle_%" /f
    rem REG ADD "HKCR/*/shell/%_menuTitle_%" /ve /d "&%_menuTitle_%" /f
   
    rem ### ICON ###
	rem # NOTE: DO NOT surround icon exe path in esacped quotes. Example: "\"app.exe\"" is INCORRECT! Should be "app.exe"   
rem echo %reg.exe% ADD "HKCR\AllFilesystemObjects\shell\%_menuTitle_%" /v Icon /t REG_SZ /d "\"%_icon_exe_%\"" /f
    "%reg.exe:/=\%" ADD "HKCR\AllFilesystemObjects\shell\%_menuTitle_:/=\%" /v Icon /t REG_SZ /d "%_icon_exe_:/=\%" /f
rem echo %dk_call% dk_registrySetKey "HKCR\AllFilesystemObjects\shell\%_menuTitle_%" "Icon" "REG_SZ" "\"%_icon_exe_%\""
rem	 %dk_call% dk_registrySetKey "HKCR\AllFilesystemObjects\shell\%_menuTitle_%" "Icon" "REG_SZ" "\"%_icon_exe_%\""
   
    rem ### COMMAND <args> ###
rem echo %reg.exe% ADD "HKCR\AllFilesystemObjects\shell\%_menuTitle_%\command" /ve /d "%_command_%" /f
     "%reg.exe:/=\%" ADD "HKCR\AllFilesystemObjects\shell\%_menuTitle_:/=\%\command" /ve /d "%_command_:/=\%" /f
rem echo %dk_call% dk_registrySetKey "HKCR/AllFilesystemObjects/shell/%_menuTitle_%/command" "" "" "%_command_%"
rem     %dk_call% dk_registrySetKey "HKCR/AllFilesystemObjects/shell/%_menuTitle_%/command" "" "" "%_command_%"
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_validate git %dk_call% dk_depend git
    %dk_call% dk_installContextMenu "GIT ADD" "%git.exe%" \"%git.exe%\" add \"%%~1\"
%endfunction%
