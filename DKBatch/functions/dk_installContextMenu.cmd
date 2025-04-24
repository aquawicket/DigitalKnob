<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

>>>>>>> Development

::################################################################################
::# dk_installContextMenu(menuTitle, icon_exe, command)
::#
:dk_installContextMenu
<<<<<<< HEAD
    call dk_debugFunc 3
 setlocal
 
	set "_menuTitle_=%~1"
    set "_icon_exe_=%~2"
    set "_command_=%~3"
=======
setlocal
	%dk_call% dk_debugFunc 3
	set "_menuTitle_=%~1"
    set "_icon_exe_=%~2"
	set "_icon_exe_=%_icon_exe_:/=\%"
    set "_command_=%~3"
	set "_command_=%_command_:/=\%"
>>>>>>> Development
    
    %dk_call% dk_info "Adding '%_menuTitle_%' context menu to Registry"
	%dk_call% dk_info "using %_icon_exe_% for the icon"
    
    ::### delete existing key ###
<<<<<<< HEAD
    %dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\%_menuTitle_%"
    
    ::### Menu Title ###
    ::%dk_call% dk_registrySetKey "HKEY_CLASSES_ROOT\*\shell\%_menuTitle_%" "" "" "&%_menuTitle_%"
    ::echo REG ADD "HKEY_CLASSES_ROOT\*\shell\%_menuTitle_%" /ve /d "&%_menuTitle_%" /f
    ::REG ADD "HKEY_CLASSES_ROOT\*\shell\%_menuTitle_%" /ve /d "&%_menuTitle_%" /f
    
    ::### ICON ###
    ::%dk_call% dk_registrySetKey "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\%_menuTitle_%" "Icon" "REG_SZ" "imageres.dll,-5324"
    echo REG ADD "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\%_menuTitle_%" /v Icon /t REG_SZ /d "\"%_icon_exe_%\"" /f
    REG ADD "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\%_menuTitle_%" /v Icon /t REG_SZ /d "\"%_icon_exe_%\"" /f
    
    ::### COMMAND <args> ###
    ::%dk_call% dk_registrySetKey "HKEY_CLASSES_ROOT\*\shell\%_menuTitle_%\command" "" "" "%_command_%"
    echo REG ADD "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\%_menuTitle_%\command" /ve /d "%_command_%" /f
    REG ADD "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\%_menuTitle_%\command" /ve /d "%_command_%" /f
=======
 ::   %dk_call% dk_registryDeleteKey "HKCR\AllFilesystemObjects\shell\%_menuTitle_%"
    
    ::### Menu Title ###
    ::%dk_call% dk_registrySetKey "HKCR\*\shell\%_menuTitle_%" "" "" "&%_menuTitle_%"
    ::echo REG ADD "HKCR\*\shell\%_menuTitle_%" /ve /d "&%_menuTitle_%" /f
    ::REG ADD "HKCR\*\shell\%_menuTitle_%" /ve /d "&%_menuTitle_%" /f
    
    ::### ICON ###
    ::%dk_call% dk_registrySetKey "HKCR\AllFilesystemObjects\shell\%_menuTitle_%" "Icon" "REG_SZ" "imageres.dll,-5324"
    echo REG ADD "HKCR\AllFilesystemObjects\shell\%_menuTitle_%" /v Icon /t REG_SZ /d "\"%_icon_exe_%\"" /f
    REG ADD "HKCR\AllFilesystemObjects\shell\%_menuTitle_%" /v Icon /t REG_SZ /d "\"%_icon_exe_%\"" /f
    
    ::### COMMAND <args> ###
    ::%dk_call% dk_registrySetKey "HKCR\*\shell\%_menuTitle_%\command" "" "" "%_command_%"
    echo REG ADD "HKCR\AllFilesystemObjects\shell\%_menuTitle_%\command" /ve /d "%_command_%" /f
    REG ADD "HKCR\AllFilesystemObjects\shell\%_menuTitle_%\command" /ve /d "%_command_%" /f
>>>>>>> Development
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKBRANCH_DIR"
    %dk_call% dk_validate GIT_EXE "call %DKIMPORTS_DIR%\git\dk_installGit"
=======
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
    %dk_call% dk_validate GIT_EXE "%dk_call% %DKIMPORTS_DIR%\git\DKINSTALL.cmd"
>>>>>>> Development
    %dk_call% dk_installContextMenu "GITADD" "GIT ADD" "GIT_EXE" "\"%GIT_EXE%\" add \"%%1\""
%endfunction%
