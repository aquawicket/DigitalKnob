@echo off&::###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_installContextMenu(menuTitle, icon_exe, command)
::#
:dk_installContextMenu
%setlocal%
	%dk_call% dk_debugFunc 3
	
    set "_menuTitle_=%~1"
    set "_icon_exe_=%~2"
	set "_command_=%~3"
	::set "_icon_exe_=%_icon_exe_:/=\%"
	::set "_command_=%_command_:/=\%"
   
    %dk_call% dk_debug "Adding '%_menuTitle_%' context menu to Registry"
	%dk_call% dk_debug "Using '%_icon_exe_%' for the icon"
   
	%dk_call% dk_validate REG_EXE "%dk_call% dk_REG_EXE"
    ::### delete existing key ###
 ::   %dk_call% dk_registryDeleteKey "HKCR/AllFilesystemObjects/shell/%_menuTitle_%"
   
    ::### Menu Title ###
    ::%dk_call% dk_registrySetKey "HKCR/*/shell/%_menuTitle_%" "" "" "&%_menuTitle_%"
    ::echo REG ADD "HKCR/*/shell/%_menuTitle_%" /ve /d "&%_menuTitle_%" /f
    ::REG ADD "HKCR/*/shell/%_menuTitle_%" /ve /d "&%_menuTitle_%" /f
   
    ::### ICON ###
::echo %REG_EXE% ADD "HKCR\AllFilesystemObjects\shell\%_menuTitle_%" /v Icon /t REG_SZ /d "\"%_icon_exe_%\"" /f
     %REG_EXE% ADD "HKCR\AllFilesystemObjects\shell\%_menuTitle_%" /v Icon /t REG_SZ /d "\"%_icon_exe_%\"" /f
::echo %dk_call% dk_registrySetKey "HKCR\AllFilesystemObjects\shell\%_menuTitle_%" "Icon" "REG_SZ" "\"%_icon_exe_%\""
::	 %dk_call% dk_registrySetKey "HKCR\AllFilesystemObjects\shell\%_menuTitle_%" "Icon" "REG_SZ" "\"%_icon_exe_%\""
   
    ::### COMMAND <args> ###
::echo %REG_EXE% ADD "HKCR\AllFilesystemObjects\shell\%_menuTitle_%\command" /ve /d "%_command_%" /f
     %REG_EXE% ADD "HKCR\AllFilesystemObjects\shell\%_menuTitle_%\command" /ve /d "%_command_%" /f
::echo %dk_call% dk_registrySetKey "HKCR/AllFilesystemObjects/shell/%_menuTitle_%/command" "" "" "%_command_%"
::     %dk_call% dk_registrySetKey "HKCR/AllFilesystemObjects/shell/%_menuTitle_%/command" "" "" "%_command_%"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_depend git
    %dk_call% dk_installContextMenu "GITADD" "GIT ADD" "GIT_EXE" "\"%GIT_EXE%\" add \"%%1\""
%endfunction%
