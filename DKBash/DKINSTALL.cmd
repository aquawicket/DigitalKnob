rem shebang
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


rem ##########################################
:DKINSTALL
    set "DKBash_Env=GIT"
    rem set "DKBash_Env=MSYS2"
    rem set "DKBash_Env=WSL"
    rem set "DKBash_Env=WSL2"
%setlocal%
	if "%~1" neq ":DKINSTALL" (
        echo :DKINSTALL %*
		%dk_call% dk_fatal "DKBash/DKINSTALL.cmd does NOT take arguments"
		exit /b -1
	)

	::###### Install DKBash ######
	echo Installing DKBash . . .
	rem set "PATH=%PATH%"
	
	rem ########### (GIT) #############
	if /i "%DKBash_Env%" equ "GIT" (
        %dk_call% dk_validate bash_exe %dk_call% dk_depend bash_exe git
        %dk_call% dk_validate cygpath_exe %dk_call% dk_depend cygpath_exe
  )
	
	::########### (MSYS2) #############
	if /i "%DKBash_Env%" equ "MSYS2" (%dk_call% dk_validate bash_exe %dk_call% dk_depend bash_exe msys2)
	if /i "%DKBash_Env%" equ "MSYS2" (%dk_call% dk_assertPath bash_exe)
rem	if /i "%DKBash_Env%" equ "MSYS2" (set bash_exe="%bash_exe%")
	if /i "%DKBash_Env%" equ "MSYS2" (set "BASH_C_DIVE=/x")
	
	::############ (WSL) ############
	if /i "%DKBash_Env%" equ "WSL" (%dk_call% dk_validate bash_exe %dk_call% dk_depend bash_exe wsl)
	if /i "%DKBash_Env%" equ "WSL" (%dk_call% dk_assertPath bash_exe)
rem	if /i "%DKBash_Env%" equ "WSL" (set bash_exe="%bash_exe%")
	if /i "%DKBash_Env%" equ "WSL" (set "BASH_C_DIVE=/mnt/x")
	
	::############ (WSL2) ############
	if /i "%DKBash_Env%" equ "WSL2" (%dk_call% dk_validate wsl.exe %dk_call% dk_depend wsl.exe)
	if /i "%DKBash_Env%" equ "WSL2" (%dk_call% dk_assertPath wsl.exe)
	if /i "%DKBash_Env%" equ "WSL2" (set "BASH_ICON=%wsl.exe%")
	if /i "%DKBash_Env%" equ "WSL2" (set bash_exe="%wsl.exe%" bash)
	if /i "%DKBash_Env%" equ "WSL2" (set "BASH_C_DIVE=/mnt/x")
	
	
	rem for /F %%Z in (%ComSpec%) do (set ComSpec=%%~fZ)
	rem for %%G in ("%ComSpec%") do set "ComSpec=%%~G"
	rem %dk_call% dk_assertPath "%ComSpec%"
    rem %dk_call% dk_assertPath "%cygpath_exe%"
    rem %dk_call% dk_assertPath "%bash_exe%"
	
	::### Add the DKBash command to the registry ###
	rem ### "%ComSpec%" /V:ON /k FOR /F "usebackq delims=" %%a IN (`"X:\Users\Default\Digital Knob\DKTools\git-portable-2.46.2-64-bit\usr\bin\cygpath.exe" '%1'`) DO "X:\Users\Default\Digital Knob\DKTools\git-portable-2.46.2-64-bit\usr\bin\bash.exe" "%%a"
	ftype DKBash="%ComSpec:/=\%" /V:ON /k FOR /F "usebackq delims=" %%%%a IN (`"%cygpath_exe:/=\%" '%%1'`^) DO "%bash_exe:/=\%" "%%%%a"
	rem  "C:/Users/Administrator/Digital Knob/Development/3rdParty/msys2-base-x86_64-20241208/usr/bin/bash.exe" -c "/c/Users/Administrator/Digital Knob/Development/DKBash/functions/dk_debug.sh"
	rem  "C:/Users/Administrator/Digital Knob/Development/3rdParty/msys2-base-x86_64-20241208/usr/bin/env.exe" MSYSTEM=MSYS /usr/bin/bash "/c/Users/Administrator/Digital Knob/Development/DKBash/functions/dk_debug.sh"
	
	::### associate .sh with DKBash ###	
	assoc .sh=DKBash
	
	::########### ICON #############
	::%dk_call% dk_assertPath BASH_ICON
	%dk_call% dk_registrySetKey "HKCR/DKBash/DefaultIcon" "" "REG_SZ" "%BASH_ICON%"
	
	%dk_call% dk_success "DKBash install complete"
%endfunction%
