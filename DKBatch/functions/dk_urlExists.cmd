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
rem # dk_urlExists(url)
rem #
rem #		Reference: https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Status
rem #				   https://en.wikipedia.org/wiki/List_of_HTTP_status_codes
rem #
rem #		###### Informational responses (100 – 199) ######
rem # 	100 Continue
rem # 	101 Switching Protocols
rem # 	102 Processing
rem # 	103 Early Hints
rem #
rem #		###### Successful responses (200 – 299) ######
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
rem #		###### Redirection messages (300 – 399) ######
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
rem #		##### Client error responses (400 – 499) ######
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
rem #		##### Server error responses (500 – 599) ######
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
:dk_urlExists
%setlocal%

	set "url=%~1"
	set /a "dk_urlExists=false"
	
	if exist "%url:file:///=%" (
		echo searching for %url:file:///=% 
		set /a "dk_urlExists=true"
		goto:return
	)
	
	%dk_call% dk_httpStatus "%~1"
	if %dk_httpStatus% gtr 0 (
		if %dk_httpStatus% lss 400 (
			set /a "dk_urlExists=true"
		) 
	)
	
	:return
	%dk_call% dk_debug "dk_urlExists = %dk_urlExists%"
	endlocal & (
		set "dk_urlExists=%dk_urlExists%"
		rem if "%~2" neq "" (set "%~2=%dk_urlExists%")
		rem exit /b %dk_urlExists%
		%return% %dk_urlExists%
	)
%endfunction%







rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_findFile curl.exe
	
	rem ###### Using if return value
	%dk_call% dk_echo
	set "url=http://www.google.com/index.html"
	%dk_call% dk_urlExists "%url%"
	if %dk_urlExists% equ 0 (echo %url% exists) else (%clearerror% & echo %url% NOT FOUND)
	echo dk_urlExists = %dk_urlExists%
	
	%dk_call% dk_echo
	set "url=http://www.nonexisting.com/nofile.no"
	%dk_call% dk_urlExists "%url%"
	if %dk_urlExists% equ 0 (echo %url% exists) else (%clearerror% & echo %url% NOT FOUND)
	echo dk_urlExists = %dk_urlExists%
	
	
	rem ###### Using if ERRORLEVEL
	%dk_call% dk_echo
	set "url=http://www.google.com/index.html"
	%dk_call% dk_urlExists "%url%"
	if NOT ERRORLEVEL 1 (echo %url% exists) else (%clearerror% & echo %url% NOT FOUND)
	echo dk_urlExists = %dk_urlExists%
	
	%dk_call% dk_echo
	set "url=http://www.nonexisting.com/nofile.no"
	%dk_call% dk_urlExists "%url%"
	if NOT ERRORLEVEL 1 (echo %url% exists) else (%clearerror% & echo %url% NOT FOUND)
	echo dk_urlExists = %dk_urlExists%
	
	
	rem ###### Using && and || conditionals
	%dk_call% dk_echo
	set "url=http://www.google.com/index.html"
	%dk_call% dk_urlExists "%url%" && (echo %url% exists) || (%clearerror% & echo %url% NOT FOUND)
	echo dk_urlExists = %dk_urlExists%
	
	%dk_call% dk_echo
	set "url=http://www.nonexisting.com/nofile.no" 
	%dk_call% dk_urlExists "%url%" && (echo %url% exists) || (%clearerror% & echo %url% NOT FOUND)
	echo dk_urlExists = %dk_urlExists%
	
	
	
	rem ###### Using && and || conditionals
	echo.
	set "url=https://aka.ms/vs/16/release/VC_redist.x86.exe"
	%dk_call% dk_urlExists "%url%" && (echo %url% exists) || (%clearerror% & echo %url% NOT FOUND)
	echo dk_urlExists = %dk_urlExists%
	
	echo.
	set "url=https://aka.ms/vs/16/release/VC_redist.x64.exe"
	%dk_call% dk_urlExists "%url%" && (echo %url% exists) || (%clearerror% & echo %url% NOT FOUND)
	echo dk_urlExists = %dk_urlExists%
	
	echo.
	set "url=https://cosmo.zip/pub/cosmos/bin/wget"
	%dk_call% dk_urlExists "%url%" && (echo %url% exists) || (%clearerror% & echo %url% NOT FOUND)
	echo dk_urlExists = %dk_urlExists%
	
	set "url=%DKHttp_DKDownload_DIR%/cosmos/wget"
	%dk_call% dk_urlExists "%url%" && (echo %url% exists) || (%clearerror% & echo %url% NOT FOUND)
	echo dk_urlExists = %dk_urlExists%
	
	rem ###### Experimental
	rem  %dk_call% dk_echo
	rem  set "url=http://www.google.com/index.html"
	rem  %dk_call% dk_urlExists "%url%"
	rem  if %dk_urlExists% (echo %url% exists) else (echo %url% NOT FOUND)
	rem 
	rem  %dk_call% dk_echo
	rem  set "url=http://www.nonexisting.com/nofile.no"
	rem  %dk_call% dk_urlExists "%url%"
	rem  if %dk_urlExists% (echo %url% exists) else (echo %url% NOT FOUND)
	rem  if NOT ERRORLEVEL 1 (echo ERRORLEVEL is 0) else (echo ERRORLEVEL is 1)
%endfunction%
