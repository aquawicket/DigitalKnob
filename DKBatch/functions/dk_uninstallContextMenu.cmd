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
rem # dk_uninstallContextMenu(menuTitle, exe, command)
rem #
:dk_uninstallContextMenu
%setlocal%

    set "_menuTitle_=%~1"
    set "_exe_=%~2"
    set "_command_=%~3"
   
    %dk_call% dk_info "Uninstalling '%_menuTitle_%' context menu"
   
    rem ### delete existing key ###
    %dk_call% dk_registryDeleteKey "HKCR\AllFilesystemObjects\shell\%_menuTitle_%"
   
    rem ### Menu Title ###
    rem %dk_call% dk_registrySetKey "HKCR\*\shell\%_menuTitle_%" "" "" "&%_menuTitle_%"
    rem echo REG ADD "HKCR\*\shell\%_menuTitle_%" /ve /d "&%_menuTitle_%" /f
    rem REG ADD "HKCR\*\shell\%_menuTitle_%" /ve /d "&%_menuTitle_%" /f
   
    rem ### ICON ###
    rem %dk_call% dk_registrySetKey "HKCR\AllFilesystemObjects\shell\%_menuTitle_%" "Icon" "REG_SZ" "imageres.dll,-5324"
rem  echo REG ADD "HKCR\AllFilesystemObjects\shell\%_menuTitle_%" /v Icon /t REG_SZ /d "\"%_exe_%\"" /f
rem  REG ADD "HKCR\AllFilesystemObjects\shell\%_menuTitle_%" /v Icon /t REG_SZ /d "\"%_exe_%\"" /f
   
    rem ### COMMAND <args> ###
    rem %dk_call% dk_registrySetKey "HKCR\*\shell\%_menuTitle_%\command" "" "" "%_command_%"
rem  echo REG ADD "HKCR\AllFilesystemObjects\shell\%_menuTitle_%\command" /ve /d "%_command_%" /f
rem  REG ADD "HKCR\AllFilesystemObjects\shell\%_menuTitle_%\command" /ve /d "%_command_%" /f
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_validate DKIMPORTS_DIR %dk_call% dk_DKIMPORTS_DIR
    %dk_call% dk_validate git.exe %dk_call% dk_depend git
    %dk_call% dk_uninstallContextMenu "GITADD" "GIT ADD" "git.exe" "\"%git.exe%\" add \"%%1\""
%endfunction%