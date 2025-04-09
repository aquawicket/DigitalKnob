@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::############################################################################
::# dk_httpStatus(<url>, <output>:optional)
::#
::#
:dk_httpStatus
setlocal
	%dk_call% dk_debugFunc 2

	%dk_call% dk_validate CURL_EXE "%dk_call% dk_CURL_EXE"
    for /f "tokens=*" %%a in ('%CURL_EXE% -sI -o nul -w "%%{http_code}" "%~1"') do (
 	    Set "dk_httpStatus=%%a"
 	    rem If [!dk_httpStatus!] EQU [503] (set "Status_URL=Service Unavailable")
 	    rem If [!dk_httpStatus!] EQU [500] (set "Status_URL=Internal Server Error")
 	    rem If [!dk_httpStatus!] EQU [404] (set "Status_URL=Not Found OFFLINE")
 	    rem If [!dk_httpStatus!] EQU [302] (set "Status_URL=Temporary Redirect")
 	    rem If [!dk_httpStatus!] EQU [301] (set "Status_URL=Redirect and Moved Permanently")
 	    rem If [!dk_httpStatus!] EQU [200] (set "Status_URL=OK ONLINE")
 	    rem If [!dk_httpStatus!] EQU [000] (set "Status_URL=TIMEOUT Server Rejected the Request")
    )
	endlocal & (
		set "%~2=%dk_httpStatus%"
		if "%2" neq "" set "%2=%dk_httpStatus%"
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_httpStatus "http://www.google.com" result
	%dk_call% dk_printVar result
%endfunction%
