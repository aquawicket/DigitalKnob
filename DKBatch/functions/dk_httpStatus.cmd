@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::############################################################################
::# dk_httpStatus(url rtn:httpcode)
::#
::#
:dk_httpStatus
setlocal
	%dk_call% dk_debugFunc 2

	%dk_call% dk_validate CURL_EXE "%dk_call% dk_CURL_EXE"
    for /f "tokens=*" %%a in ('%CURL_EXE% -sI -o nul -w "%%{http_code}" "%~1"') do (
 	    Set "httpCode=%%a"
 	    rem If [!httpcode!] EQU [503] (set "Status_URL=Service Unavailable")
 	    rem If [!httpcode!] EQU [500] (set "Status_URL=Internal Server Error")
 	    rem If [!httpcode!] EQU [404] (set "Status_URL=Not Found OFFLINE")
 	    rem If [!httpcode!] EQU [302] (set "Status_URL=Temporary Redirect")
 	    rem If [!httpcode!] EQU [301] (set "Status_URL=Redirect and Moved Permanently")
 	    rem If [!httpcode!] EQU [200] (set "Status_URL=OK ONLINE")
 	    rem If [!httpcode!] EQU [000] (set "Status_URL=TIMEOUT Server Rejected the Request")
    )
	endlocal & set "%~2=%httpcode%"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_httpStatus "http://www.google.com" result
	%dk_call% dk_printVar result
%endfunction%
