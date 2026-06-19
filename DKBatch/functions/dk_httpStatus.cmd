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
rem # dk_httpStatus(url)
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
:dk_httpStatus
%setlocal%
	set "_url_=%~1"
	%dk_call% dk_validate curl.exe "%dk_call% curl.exe --version" 1>nul 2>nul
	
	rem ############ curl options ############	 
	rem # 	-Z, --time-cond 				only download if server file newer than local
	rem #	-R, --remote-time 				preserve the downloaded files time-stamp
	rem #	-L, --location	 				follow redirects
	rem #	-s, --silent					Do not show progress meter or error messages. 
	rem #	-S, --show-error				When used with --silent, it makes curl show an error message if it fails.
	rem #	-o, --output <file>				Write output to the given file instead of stdout.
	rem #	-I, --head						Fetch the headers only.
	rem #	-H, --header <header/@file>		Extra header to include in information sent.
	rem #	-f, --fail						Fail with error code 22 and with no response body output
	rem # 	-w, --write-out <format>		Display information on stdout after a completed transfer.
	rem #       --remove-on-error 			Remove the output file if an error occurs.
	rem #	    --output-dir				Directory to download the file to
	rem #		--create-dirs				
	
	set "dk_httpStatus=0"
	for /f "usebackq tokens=*" %%a in (`%dk_start% "%curl.exe:/=\%" --output nul --silent --head --fail --write-out %%{http_code} %_url_%`) do (
		set /a "dk_httpStatus=%%~a"
	)
	
	:return
	rem %dk_call% dk_debug "%_url_%: dk_httpStatus = %dk_httpStatus%"
	endlocal & (
		set "curl.exe=%curl.exe%"
		set /a "dk_httpStatus=%dk_httpStatus%"
		if "%~2" neq "" (set /a "%~2=%dk_httpStatus%")
	)
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

rem	set "url=http://www.google.com/index.html"
rem	%dk_call% dk_httpStatus "%url%"
rem	%dk_call% dk_debug "%url%: dk_httpStatus = %dk_httpStatus%"
	
rem	set "url=http://www.nonexisting.com/nofile.no"
rem	%dk_call% dk_httpStatus "%url%"
rem	%dk_call% dk_debug "%url%: dk_httpStatus = %dk_httpStatus%"
	
rem	set "url=https://aka.ms/vs/16/release/VC_redist.x86.exe"
rem	%dk_call% dk_httpStatus "%url%"
rem	%dk_call% dk_debug "%url%: dk_httpStatus = %dk_httpStatus%"
	
rem	set "url=https://download.visualstudio.microsoft.com/download/pr/b635098a-2d1d-4142-bef6-d237545123cb/2651b87007440a15209cac29634a4e45/dotnetfx35.exe"
rem	%dk_call% dk_httpStatus "%url%"
rem	%dk_call% dk_debug "%url%: dk_httpStatus = %dk_httpStatus%"
	
	set "url=u108565871@access912915170.webspace-data.io/~/DigitalKnob"
	%dk_call% dk_httpStatus "%url%"
	%dk_call% dk_debug "%url%: dk_httpStatus = %dk_httpStatus%"
	
	set "url=http://www.nonexisting.nul/nofile.no"
	%dk_call% dk_httpStatus "%url%"
	%dk_call% dk_debug "%url%: dk_httpStatus = %dk_httpStatus%"
	
	set "url=file:///C:/Windows/System32/cmd.exe"
	%dk_call% dk_httpStatus "%url%"
	%dk_call% dk_debug "%url%: dk_httpStatus = %dk_httpStatus%"
	
	set "url=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-windows-x86_64.zip"
	%dk_call% dk_httpStatus "%url%"
	%dk_call% dk_debug "%url%: dk_httpStatus = %dk_httpStatus%"
	
	set "url=https://cosmo.zip/pub/cosmos/bin/wget"
	%dk_call% dk_httpStatus "%url%"
	%dk_call% dk_debug "%url%: dk_httpStatus = %dk_httpStatus%"
	
	set "url=%DKHttp_DKDownload_DIR%/PortableGit-2.46.2-64-bit.7z.exe"
	%dk_call% dk_httpStatus "%url%"
	%dk_call% dk_debug "%url%: dk_httpStatus = %dk_httpStatus%"
%endfunction%
