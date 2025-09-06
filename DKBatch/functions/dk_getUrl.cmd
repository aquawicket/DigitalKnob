@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_getUrl(<url> <ret:optional>)
::#
:dk_getUrl
	%dk_call% dk_debugFunc 1 2

	set "curl_exe=C:/Windows/System32/curl.exe"
	
	set command=%curl_exe% %~1 -sI -o nul -w %%{redirect_url}
	
	set command=%curl_exe% "%~1" -sI -o nul -w "%%%%%%%%{redirect_url}\n"
	%dk_call% dk_exec %command%
	if defined dk_exec (
		set "dk_getUrl=%dk_exec%"
	) else (
		set "dk_getUrl=%~1"
	)
	
	::###### output ######
	endlocal & (
		set "dk_getUrl=%dk_getUrl%"
		if "%~2" neq "" (
			set "%~2=%dk_getUrl%"
		) else (
			echo %dk_getUrl%
		)
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	set "url=http://www.google.com/index.html"
	%dk_call% dk_getUrl "%url%"
	echo url:'%url%' dk_getUrl = %dk_getUrl%
	
	set "url=http://www.nonexisting.com/nofile.no"
	%dk_call% dk_getUrl "%url%"
	echo url:'%url%' dk_getUrl = %dk_getUrl%
	
	set "url=https://aka.ms/vs/16/release/VC_redist.x86.exe"
	%dk_call% dk_getUrl "%url%"
	echo url:'%url%' dk_getUrl = %dk_getUrl%
	
	set "url=https://dotnet.microsoft.com/en-us/download/dotnet-framework/thank-you/net35-sp1-offline-installer"
	%dk_call% dk_getUrl "%url%"
	echo url:'%url%' dk_getUrl = %dk_getUrl%

%endfunction%
