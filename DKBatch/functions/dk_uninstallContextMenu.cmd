@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_uninstallContextMenu(menuTitle, exe, command)
::#
:dk_uninstallContextMenu
setlocal
    %dk_call% dk_debugFunc 1 3
 
    set "_menuTitle_=%~1"
    set "_exe_=%~2"
    set "_command_=%~3"
    
    %dk_call% dk_info "Uninstalling '%_menuTitle_%' context menu"
    
    ::### delete existing key ###
    %dk_call% dk_registryDeleteKey "HKCR\AllFilesystemObjects\shell\%_menuTitle_%"
    
    ::### Menu Title ###
    ::%dk_call% dk_registrySetKey "HKCR\*\shell\%_menuTitle_%" "" "" "&%_menuTitle_%"
    ::echo REG ADD "HKCR\*\shell\%_menuTitle_%" /ve /d "&%_menuTitle_%" /f
    ::REG ADD "HKCR\*\shell\%_menuTitle_%" /ve /d "&%_menuTitle_%" /f
    
    ::### ICON ###
    ::%dk_call% dk_registrySetKey "HKCR\AllFilesystemObjects\shell\%_menuTitle_%" "Icon" "REG_SZ" "imageres.dll,-5324"
::  echo REG ADD "HKCR\AllFilesystemObjects\shell\%_menuTitle_%" /v Icon /t REG_SZ /d "\"%_exe_%\"" /f
::  REG ADD "HKCR\AllFilesystemObjects\shell\%_menuTitle_%" /v Icon /t REG_SZ /d "\"%_exe_%\"" /f
    
    ::### COMMAND <args> ###
    ::%dk_call% dk_registrySetKey "HKCR\*\shell\%_menuTitle_%\command" "" "" "%_command_%"
::  echo REG ADD "HKCR\AllFilesystemObjects\shell\%_menuTitle_%\command" /ve /d "%_command_%" /f
::  REG ADD "HKCR\AllFilesystemObjects\shell\%_menuTitle_%\command" /ve /d "%_command_%" /f
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
    %dk_call% dk_validate GIT_EXE "%dk_call% %DKIMPORTS_DIR%\git\dk_install.cmd"
    %dk_call% dk_uninstallContextMenu "GITADD" "GIT ADD" "GIT_EXE" "\"%GIT_EXE%\" add \"%%1\""
%endfunction%