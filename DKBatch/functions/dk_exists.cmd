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
rem # dk_exists(path)
rem #
rem #		Reference: https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Status
rem #				   https://en.wikipedia.org/wiki/List_of_HTTP_status_codes
rem #
rem #	###### Informational responses (100 – 199) ######
rem # 	100 Continue
rem # 	101 Switching Protocols
rem # 	102 Processing
rem # 	103 Early Hints
rem #
rem #	###### Successful responses (200 – 299) ######
rem # 	200 OK
rem # 	201 Created
rem # 	202 Accepted
rem # 	203 Non-Authoritative Information
rem # 	204 No Content
rem # 	205 Reset Content
rem # 	206 Partial Content
rem # 	207 Multi-Status (WebDAV)
rem # 	208 Already Reported (WebDAV)
rem # 	226 IM Used (HTTP Delta encoding)
rem #
rem #	###### Redirection messages (300 – 399) ######
rem # 	300 Multiple Choices
rem # 	301 Moved Permanently
rem # 	302 Found
rem # 	303 See Other
rem # 	304 Not Modified
rem # 	305 Use Proxy Deprecated
rem # 	306 unused
rem # 	307 Temporary Redirect
rem # 	308 Permanent Redirect
rem #
rem #	##### Client error responses (400 – 499) ######
rem # 	400 Bad Request
rem # 	401 Unauthorized
rem # 	402 Payment Required
rem # 	403 Forbidden
rem # 	404 Not Found
rem # 	405 Method Not Allowed
rem # 	406 Not Acceptable
rem # 	407 Proxy Authentication Required
rem # 	408 Request Timeout
rem # 	409 Conflict
rem # 	410 Gone
rem # 	411 Length Required
rem # 	412 Precondition Failed
rem # 	413 Content Too Large
rem # 	414 URI Too Long
rem # 	415 Unsupported Media Type
rem # 	416 Range Not Satisfiable
rem # 	417 Expectation Failed
rem # 	418 I'm a teapot
rem # 	421 Misdirected Request
rem # 	422 Unprocessable Content (WebDAV)
rem # 	423 Locked (WebDAV)
rem # 	424 Failed Dependency (WebDAV)
rem # 	425 Too Early (Experimental)
rem # 	426 Upgrade Required
rem # 	428 Precondition Required
rem # 	429 Too Many Requests
rem # 	431 Request Header Fields Too Large
rem # 	451 Unavailable For Legal Reasons
rem #
rem #	##### Server error responses (500 – 599) ######
rem # 	500 Internal Server Error
rem # 	501 Not Implemented
rem # 	502 Bad Gateway
rem # 	503 Service Unavailable
rem # 	504 Gateway Timeout
rem # 	505 HTTP Version Not Supported
rem # 	506 Variant Also Negotiates
rem # 	507 Insufficient Storage (WebDAV)
rem # 	508 Loop Detected (WebDAV)
rem # 	510 Not Extended
rem # 	511 Network Authentication Required
rem #
:dk_exists
%setlocal%

	set "_path_=%~1"
	set /a "dk_exists=1"
	
	if exist "%_path_:file:///=%" (
		set /a "dk_exists=0"
		goto:return
	)
	
	%dk_call% dk_httpStatus "%_path_:ssh://=%"
	if %dk_httpStatus% gtr 0 (
		if %dk_httpStatus% lss 400 (
			set /a "dk_exists=0"
			goto:return
		) 
	)
	
	:return
	rem %dk_call% dk_debug "%_path_%: dk_exists = %dk_exists%"
	endlocal & (
		set /a "dk_exists=%dk_exists%"
		if "%~2" neq "" (set /a "%~2=%dk_exists%")
		rem exit /b %dk_exists
		%return% %dk_exists%
	)
%endfunction%







rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	rem ###### Using if return value
rem	echo.
rem	set "_path_=http://www.google.com/index.html"
rem	%dk_call% dk_exists "%_path_%"
rem	if %dk_exists% equ 0 (echo %_path_% exists) else (%clearerror% & echo %_path_% NOT FOUND)
rem	echo dk_exists = %dk_exists%
	
rem	echo.
rem	set "_path_=http://www.nonexisting.com/nofile.no"
rem	%dk_call% dk_exists "%_path_%"
rem	if %dk_exists% equ 0 (echo %_path_% exists) else (%clearerror% & echo %_path_% NOT FOUND)
rem	echo dk_exists = %dk_exists%
	
	rem ###### Using if ERRORLEVEL
rem	echo.
rem	set "_path_=http://www.google.com/index.html"
rem	%dk_call% dk_exists "%_path_%"
rem	if NOT ERRORLEVEL 1 (echo %_path_% exists) else (%clearerror% & echo %_path_% NOT FOUND)
rem	echo dk_exists = %dk_exists%
	
rem	echo.
rem	set "_path_=http://www.nonexisting.com/nofile.no"
rem	%dk_call% dk_exists "%_path_%"
rem	if NOT ERRORLEVEL 1 (echo %_path_% exists) else (%clearerror% & echo %_path_% NOT FOUND)
rem	echo dk_exists = %dk_exists%
	
	echo.
	set "_path_=ssh://u108565871@access912915170.webspace-data.io/~/DigitalKnob/Development"
	%dk_call% dk_exists "%_path_%" && (%dk_call% dk_debug "'%_path_%' Exists") || (%clearerror% & %dk_call% dk_debug "'%_path_%' NOT FOUND")
	
	rem ###### Using && and || conditionals
	echo.
	set "_path_=C:/Windows/System32"
	%dk_call% dk_exists "%_path_%" && (%dk_call% dk_debug "'%_path_%' Exists") || (%clearerror% & %dk_call% dk_debug "'%_path_%' NOT FOUND")
	
	echo.
	set "_path_=C:\Windows\System32"
	%dk_call% dk_exists "%_path_%" && (%dk_call% dk_debug "'%_path_%' Exists") || (%clearerror% & %dk_call% dk_debug "'%_path_%' NOT FOUND")
	
	echo.
	set "_path_=C://Windows//System32"
	%dk_call% dk_exists "%_path_%" && (%dk_call% dk_debug "'%_path_%' Exists") || (%clearerror% & %dk_call% dk_debug "'%_path_%' NOT FOUND")
	
	echo.
	set "_path_=C:\\Windows\\System32"
	%dk_call% dk_exists "%_path_%" && (%dk_call% dk_debug "'%_path_%' Exists") || (%clearerror% & %dk_call% dk_debug "'%_path_%' NOT FOUND")
	
	echo.
	set "_path_=file:///C:/Windows/System32"
	%dk_call% dk_exists "%_path_%" && (%dk_call% dk_debug "'%_path_%' Exists") || (%clearerror% & %dk_call% dk_debug "'%_path_%' NOT FOUND")
	
	echo.
	set "_path_=http://www.google.com/index.html"
	%dk_call% dk_exists "%_path_%" && (%dk_call% dk_debug "'%_path_%' Exists") || (%clearerror% & %dk_call% dk_debug "'%_path_%' NOT FOUND")
	
	echo.
	set "_path_=http://www.nonexisting.nul/nofile.no" 
	%dk_call% dk_exists "%_path_%" && (%dk_call% dk_debug "'%_path_%' Exists") || (%clearerror% & %dk_call% dk_debug "'%_path_%' NOT FOUND")
	
	echo.
	set "_path_=https://aka.ms/vs/16/release/VC_redist.x86.exe"
	%dk_call% dk_exists "%_path_%" && (%dk_call% dk_debug "'%_path_%' Exists") || (%clearerror% & %dk_call% dk_debug "'%_path_%' NOT FOUND")
	
	echo.
	set "_path_=https://aka.ms/vs/16/release/VC_redist.x64.exe"
	%dk_call% dk_exists "%_path_%" && (%dk_call% dk_debug "'%_path_%' Exists") || (%clearerror% & %dk_call% dk_debug "'%_path_%' NOT FOUND")
	
	echo.
	set "_path_=https://cosmo.zip/pub/cosmos/bin/wget"
	%dk_call% dk_exists "%_path_%" && (%dk_call% dk_debug "'%_path_%' Exists") || (%clearerror% & %dk_call% dk_debug "'%_path_%' NOT FOUND")
	
	echo.
	set "_path_=%DKHttp_DKDownload_DIR%/cosmos/wget"
	%dk_call% dk_exists "%_path_%" && (%dk_call% dk_debug "'%_path_%' Exists") || (%clearerror% & %dk_call% dk_debug "'%_path_%' NOT FOUND")
	
	rem ###### Experimental
	rem  echo.
	rem  set "_path_=http://www.google.com/index.html"
	rem  %dk_call% dk_exists "%_path_%"
	rem  if %dk_exists% (echo %_path_% exists) else (echo %_path_% NOT FOUND)
	rem 
	rem  echo.
	rem  set "_path_=http://www.nonexisting.com/nofile.no"
	rem  %dk_call% dk_exists "%_path_%"
	rem  if %dk_exists% (echo %_path_% exists) else (echo %_path_% NOT FOUND)
	rem  if NOT ERRORLEVEL 1 (echo ERRORLEVEL is 0) else (echo ERRORLEVEL is 1)
%endfunction%
