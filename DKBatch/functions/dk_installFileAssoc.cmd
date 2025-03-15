@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::#################################################################################
::# dk_installFileAssoc(extension, exe, arguments)
::#
::#
:dk_installFileAssoc
setlocal
	%dk_call% dk_debugFunc 2 3
 
    ::if "%~4" equ "OVERWRITE" ( set "OVERWRITE=1" ) else ( set "OVERWRITE=0" )
    
    :: <_extension_>  i.e. ".txt"
    set "_extension_=%~1"
    
    :: <_exe_>  i.e. "%WINDIR%\System32\calc.exe"
    set "_exe_=%~2"
    if not exist %_exe_% %dk_call% dk_error "%_exe_% does not exist"
    %dk_call% dk_basename "%~2" _exeName_
    %dk_call% dk_basename "%~2" _exeFilename_
    set "_dkname_=dk_%_exeName_%"
    
    :: <arguments>
    set "_arguments_=%~3"
    
    ::  Computer\HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts
    ::  Seems to be a better place to change file associations. They take precidence over ftype and assoc commands
    ::
    :: https://ss64.com/nt/ftype.html
    
::  Example
::      %dk_call% dk_registryDeleteKey "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.ps1"
::      ftype DKPowershell=%POWERSHELL_EXE% "%%1"
::      assoc .ps1=DKPowershell
    %dk_call% dk_registryDeleteKey "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%_extension_%"
    ftype %_dkname_%=%_exe_% "%%1"
    assoc %_extension_%=%_dkname_%
    
    

    

    
    :: set file association through registry
    
    ::HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cpp\OpenWithList REG_SZ:a=program.exe
    ::%dk_call% dk_registrySetKey "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%_extension_%\OpenWithList" "a" "REG_SZ" "%~2"
    
    ::HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cpp\OpenWithList REG_SZ:MRUList=program.a
    ::%dk_call% dk_registrySetKey "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%_extension_%\OpenWithList" "MRUList" "REG_SZ" "a"
    
    ::HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cpp\UserChoice REG_SZ:ProgId=Applications\program.exe
    ::%dk_call% dk_registrySetKey "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%_extension_%\UserChoice" "ProgId" "REG_SZ" "Applications\%_exeFilename_%"

    ::[HKCR\.txt]
    ::@="emeditor.txt"
    ::%dk_call% dk_registrySetKey "HKCR\%_extension_%" "" "REG_SZ" "%_dkname_%"

    ::[HKCR\emeditor.txt]
    ::@="Text Document"
    ::set "_description_=Text Document"
    ::%dk_call% dk_registrySetKey "HKCR\%_dkname_%" "" "REG_SZ" "%_description_%"

    ::[HKCR\emeditor.txt\DefaultIcon]
    ::@="%SystemRoot%\\SysWow64\\imageres.dll,-102"
    ::%dk_call% dk_registrySetKey "HKCR\%_dkname_%\DefaultIcon" "" "REG_SZ" "%SystemRoot%\\SysWow64\\imageres.dll,-102"

    ::[HKCR\emeditor.txt\shell]

    ::[HKCR\emeditor.txt\shell\open]

    ::[HKCR\emeditor.txt\shell\open\command]
    ::@="\"C:\\Program Files\\EmEditor\\EMEDITOR.EXE\" \"%1\""
    ::%dk_call% dk_registrySetKey "HKCR\%_dkname_%\shell\open\command" "" "REG_EXPAND_SZ" "\"%_exe_%\" \"%%%%^1\""
    
    ::[HKCR\emeditor.txt\shell\print]

    ::[HKCR\emeditor.txt\shell\print\command]
    ::@="\"C:\\Program Files\\EmEditor\\EMEDITOR.EXE\" /p \"%1\""
    ::%dk_call% dk_registrySetKey "HKCR\%_dkname_%\shell\print\command" "@" "REG_SZ" "\"%_exe_%\" /p \"%1\""
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_installFileAssoc ".txt" "%WINDIR%\System32\notepad.exe"
%endfunction%
    