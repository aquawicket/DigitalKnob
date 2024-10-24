@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::#################################################################################
::# dk_uninstallFileAssoc(extension)
::#
::#
:dk_uninstallFileAssoc
    call dk_debugFunc 1
 setlocal
 
    :: <_extension_>  i.e. ".txt"
    set "_extension_=%~1"
    
    ::  Computer\HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts
    ::  Seems to be a better place to change file associations. They take precidence over ftype and assoc commands
    ::
    :: https://ss64.com/nt/ftype.html
    
::  Example
::      %dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.ps1"
::      ftype DKPowershell=%POWERSHELL_EXE% "%%1"
::      assoc .ps1=DKPowershell
    %dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%_extension_%"
    
    

    

    
    :: set file association through registry
    
    ::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cpp\OpenWithList REG_SZ:a=program.exe
    ::%dk_call% dk_registrySetKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%_extension_%\OpenWithList" "a" "REG_SZ" "%~2"
    
    ::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cpp\OpenWithList REG_SZ:MRUList=program.a
    ::%dk_call% dk_registrySetKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%_extension_%\OpenWithList" "MRUList" "REG_SZ" "a"
    
    ::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cpp\UserChoice REG_SZ:ProgId=Applications\program.exe
    ::%dk_call% dk_registrySetKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%_extension_%\UserChoice" "ProgId" "REG_SZ" "Applications\%_exeFilename_%"

    ::[HKEY_CLASSES_ROOT\.txt]
    ::@="emeditor.txt"
    ::%dk_call% dk_registrySetKey "HKEY_CLASSES_ROOT\%_extension_%" "" "REG_SZ" "%_dkname_%"

    ::[HKEY_CLASSES_ROOT\emeditor.txt]
    ::@="Text Document"
    ::set "_description_=Text Document"
    ::%dk_call% dk_registrySetKey "HKEY_CLASSES_ROOT\%_dkname_%" "" "REG_SZ" "%_description_%"

    ::[HKEY_CLASSES_ROOT\emeditor.txt\DefaultIcon]
    ::@="%SystemRoot%\\SysWow64\\imageres.dll,-102"
    ::%dk_call% dk_registrySetKey "HKEY_CLASSES_ROOT\%_dkname_%\DefaultIcon" "" "REG_SZ" "%SystemRoot%\\SysWow64\\imageres.dll,-102"

    ::[HKEY_CLASSES_ROOT\emeditor.txt\shell]

    ::[HKEY_CLASSES_ROOT\emeditor.txt\shell\open]

    ::[HKEY_CLASSES_ROOT\emeditor.txt\shell\open\command]
    ::@="\"C:\\Program Files\\EmEditor\\EMEDITOR.EXE\" \"%1\""
    ::%dk_call% dk_registrySetKey "HKEY_CLASSES_ROOT\%_dkname_%\shell\open\command" "" "REG_EXPAND_SZ" "\"%_exe_%\" \"%%%%^1\""
    
    ::[HKEY_CLASSES_ROOT\emeditor.txt\shell\print]

    ::[HKEY_CLASSES_ROOT\emeditor.txt\shell\print\command]
    ::@="\"C:\\Program Files\\EmEditor\\EMEDITOR.EXE\" /p \"%1\""
    ::%dk_call% dk_registrySetKey "HKEY_CLASSES_ROOT\%_dkname_%\shell\print\command" "@" "REG_SZ" "\"%_exe_%\" /p \"%1\""
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_uninstallFileAssoc ".txt"
%endfunction%
    