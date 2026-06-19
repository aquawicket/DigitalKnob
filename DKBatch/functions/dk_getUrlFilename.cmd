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


rem ####################################################################
rem # dk_getUrlFilename(<url> <ret:optional>)
rem #
rem #	NOTE: is seems that curl must download the file when using --remote-header-name --remote-name to get the final filename.
rem # 
:dk_getUrlFilename
%setlocal%

	rem set "_url_=%~1"
	
	%dk_call% dk_basename "%~1" dk_getUrlFilename
	%dk_call% dk_validate curl.exe %dk_call% dk_depend curl.exe	
	%dk_call% dk_validate find.exe %dk_call% dk_findFile find.exe

	for /f "usebackq tokens=*" %%y in (
		`start "" /b /wait /min "!curl.exe:/=\!" "%~1" --silent --head --location ^| start "" /b /wait /min "!find.exe:/=\!" /i "Content-Disposition"`
	) do (		
		for %%x in (%%~y) do (
			if defined flag (
				(set "dk_getUrlFilename=%%~x")
				(goto:DONE)
			) else if "%%~x" equ "filename" (
				(set flag=1)
			)
		)
	)			
	:DONE

	:return
	endlocal & (
		set "dk_getUrlFilename=%dk_getUrlFilename%"
		set "curl.exe=%curl.exe%"
		set "find.exe=%find.exe%"
		if "%~2" neq "" (set %~2=%dk_getUrlFilename%)
	)
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	
	set "url=https://go.microsoft.com/fwlink/?linkid=2186537"
	%dk_call% dk_getUrlFilename "%url%"
	echo %url% = '%dk_getUrlFilename%'
	
	set "url=https://dotnet.microsoft.com/en-us/download/dotnet-framework/thank-you/net35-sp1-offline-installer"
	%dk_call% dk_getUrlFilename "%url%"
	echo %url% = '%dk_getUrlFilename%'
	
	set "url=https://aka.ms/vs/16/release/VC_redist.x86.exe"
	%dk_call% dk_getUrlFilename "%url%"
	echo %url% = '%dk_getUrlFilename%'
	
	set "url=https://github.com/madler/zlib/archive/5a82f71e.zip"
	%dk_call% dk_getUrlFilename "%url%"
	echo %url% = '%dk_getUrlFilename%'
	
	set "url=https://github.com/git-for-windows/git/releases/download/v2.46.2.windows.1/PortableGit-2.46.2-64-bit.7z.exe"
	%dk_call% dk_getUrlFilename "%url%"
	echo %url% = '%dk_getUrlFilename%'
%endfunction%
