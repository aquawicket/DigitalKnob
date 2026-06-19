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


rem #################################################################################
rem # dk_installFileAssoc(extension, exe, arguments)
rem #
rem #
:dk_installFileAssoc
%setlocal%

    rem if /i "%~4" equ "OVERWRITE" ( set "OVERWRITE=1" ) else ( set "OVERWRITE=0" )
   
    rem <_extension_>  i.e. ".txt"
    set "_extension_=%~1"
   
    rem <_exe_>  i.e. "%SystemRoot\=/%/System32/calc.exe"
    set "_exe_=%~2"
    if NOT EXIST "%_exe_%" %dk_call% dk_error "_exe_:%_exe_% NOT FOUND"
    %dk_call% dk_basename "%~2" _exeName_
    %dk_call% dk_basename "%~2" _exeFilename_
    set "_dkname_=dk_%_exeName_%"
   
    rem <arguments>
    set "_arguments_=%~3"
   
    rem  Computer/HKCU/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/FileExts
    rem  Seems to be a better place to change file associations. They take precidence over ftype and assoc commands
    rem 
    rem https://ss64.com/nt/ftype.html
   
rem  Example
rem      %dk_call% dk_registryDeleteKey "HKCU/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/FileExts/.ps1"
rem      ftype DKPowershell=%powershell.exe% "%%1"
rem      assoc .ps1=DKPowershell
    %dk_call% dk_registryDeleteKey "HKCU/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/FileExts/%_extension_%"
    ftype %_dkname_%=%_exe_% "%%1"
    assoc %_extension_%=%_dkname_%
   
   

   

   
    rem set file association through registry
   
    rem HKCU/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/FileExts/.cpp/OpenWithList REG_SZ:a=program.exe
    rem %dk_call% dk_registrySetKey "HKCU/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/FileExts/%_extension_%/OpenWithList" "a" "REG_SZ" "%~2"
   
    rem HKCU/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/FileExts/.cpp/OpenWithList REG_SZ:MRUList=program.a
    rem %dk_call% dk_registrySetKey "HKCU/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/FileExts/%_extension_%/OpenWithList" "MRUList" "REG_SZ" "a"
   
    rem HKCU/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/FileExts/.cpp/UserChoice REG_SZ:ProgId=Applications/program.exe
    rem %dk_call% dk_registrySetKey "HKCU/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/FileExts/%_extension_%/UserChoice" "ProgId" "REG_SZ" "Applications/%_exeFilename_%"

    rem [HKCR/.txt]
    rem @="emeditor.txt"
    rem %dk_call% dk_registrySetKey "HKCR/%_extension_%" "" "REG_SZ" "%_dkname_%"

    rem [HKCR/emeditor.txt]
    rem @="Text Document"
    rem set "_description_=Text Document"
    rem %dk_call% dk_registrySetKey "HKCR/%_dkname_%" "" "REG_SZ" "%_description_%"

    rem [HKCR/emeditor.txt/DefaultIcon]
    rem @="%SystemRoot:\=/%/SysWow64/imageres.dll,-102"
    rem %dk_call% dk_registrySetKey "HKCR/%_dkname_%/DefaultIcon" "" "REG_SZ" "%SystemRoot:\=/%/SysWow64/imageres.dll,-102"

    rem [HKCR/emeditor.txt/shell]

    rem [HKCR/emeditor.txt/shell/open]

    rem [HKCR/emeditor.txt/shell/open/command]
    rem @="\"%ProgramFiles:\=/%/EmEditor/EMEDITOR.EXE\" \"%1\""
    rem %dk_call% dk_registrySetKey "HKCR/%_dkname_%/shell/open/command" "" "REG_EXPAND_SZ" "\"%_exe_%\" \"%%%%^1\""
   
    rem [HKCR/emeditor.txt/shell/print]

    rem [HKCR/emeditor.txt/shell/print/command]
    rem @="\"%ProgramFiles:\=/%/EmEditor/EMEDITOR.EXE\" /p \"%1\""
    rem %dk_call% dk_registrySetKey "HKCR/%_dkname_%/shell/print/command" "@" "REG_SZ" "\"%_exe_%\" /p \"%1\""
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_installFileAssoc ".txt" "%SystemRoot\=/%/System32/notepad.exe"
%endfunction%
    