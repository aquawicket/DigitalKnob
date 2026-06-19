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


rem ####################################################################
rem # dk_install()
rem #
:DKINSTALL
%setlocal%
	%dk_call% dk_validate git.exe		%dk_call% dk_depend git
	%dk_call% dk_validate git_bash_exe  %dk_call% dk_depend git
	
	rem ### Icon ###
	rem "C:\Users\Administrator\DigitalKnob\DKTools\git-portable-2.46.2-64-bit\git-bash.exe"	
	rem ### Command ###
	rem "C:\Windows\System32\cmd.exe" /c ("C:\Users\Administrator\Digita lKnob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" add "%1") || pause	
	rem %dk_call% dk_installContextMenu "Git Add" "%git_bash_exe:/=\%" "\"%ComSpec%\" /c (\"%git.exe:/=\%\" add \"%%%%%%%%1\") & pause"

	rem "reg.exe" ADD "HKCR\AllFilesystemObjects\shell\Git Add" /v Icon /t REG_SZ /d "%git_bash_exe:/=\%" /f
	%dk_call% reg.exe ADD "HKCR\AllFilesystemObjects\shell\Git Add" /v Icon /t REG_SZ /d "%git_bash_exe:/=\%" /f
	%dk_call% reg.exe ADD "HKCR\AllFilesystemObjects\shell\Git Add\command" /ve /d "\"%ComSpec%\" /c (\"%git.exe:/=\%\" add \"%%1\") ^|^| pause" /f

	rem ### Icon ###
	rem "C:\Users\Administrator\DigitalKnob\DKTools\git-portable-2.46.2-64-bit\git-bash.exe"
	rem ### Command ###	
	rem "C:\Windows\System32\cmd.exe" /c ("C:\Users\Administrator\DigitalKnob\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" clean -d -x -f "%1") || pause
	rem %dk_call% dk_installContextMenu "Git Clean" "%git_bash_exe:/=\%" "\"%ComSpec%\" /c (\"%git.exe:/=\%\" clean -d -x -f \"%%%%%%%%1\") & pause"
	%dk_call% reg.exe ADD "HKCR\AllFilesystemObjects\shell\Git Clean" /v Icon /t REG_SZ /d "%git_bash_exe:/=\%" /f
	%dk_call% reg.exe ADD "HKCR\AllFilesystemObjects\shell\Git Clean\command" /ve /d "\"%ComSpec%\" /c (\"%git.exe:/=\%\" clean -d -x -f \"%%1\") || pause" /f
%endfunction%







rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
    %dk_call% dk_depend git/contextMenu
%endfunction%
