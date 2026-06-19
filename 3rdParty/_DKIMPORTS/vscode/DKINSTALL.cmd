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


::############ vscode ############
::# https://code.visualstudio.com/docs/editor/portable
::# https://fossies.org/windows/misc/VSCode-win32-x64-1.87.1.zip
::# https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/code-stable-armhf-1709684464.tar.gz
::# https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/code-stable-arm64-1709684476.tar.gz
::# https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/code-stable-x64-1709684476.tar.gz
::# https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/vscode-darwin-universal.zip
::# https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/vscode-win32-arm64-1.87.1.zip
::# https://vscode.download.prss.microsoft.com/dbazure/download/stable/1e790d77f81672c49be070e04474901747115651/vscode-win32-x64-1.87.1.zip

:DKINSTALL
::%setlocal%
	
	%dk_call% dk_import
	
	if /i "%Host_Os%" equ "Windows" ( 
		%dk_call% dk_set vscode_exe "%vscode_Install_Path%/Code.exe"
	) else ( 
		%dk_call% dk_set vscode_exe "%vscode_Install_Path%/code"
	)	
	%dk_call% dk_assertPath "%vscode_exe%"
	%dk_call% dk_firewallAllow "%vscode_exe%"
	
	%dk_call% dk_depend vscode/fileAssoc
%endfunction%
