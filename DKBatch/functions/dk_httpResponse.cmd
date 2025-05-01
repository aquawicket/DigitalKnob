@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# dk_httpResponse(<url> <ret:optional>)
::#
::#		Reference: https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Status
::#				   https://en.wikipedia.org/wiki/List_of_HTTP_status_codes
::#
::#		###### Informational responses (100 – 199) ######
::# 	100 Continue
::# 	101 Switching Protocols
::# 	102 Processing 
::# 	103 Early Hints
::#
::#		###### Successful responses (200 – 299) ######
::# 	200 OK
::# 	201 Created
::# 	202 Accepted
::# 	203 Non-Authoritative Information
::# 	204 No Content
::# 	205 Reset Content
::# 	206 Partial Content
::# 	207 Multi-Status (WebDAV)
::# 	208 Already Reported (WebDAV)
::# 	226 IM Used (HTTP Delta encoding)
::#
::#		###### Redirection messages (300 – 399) ######
::# 	300 Multiple Choices
::# 	301 Moved Permanently
::# 	302 Found
::# 	303 See Other
::# 	304 Not Modified
::# 	305 Use Proxy Deprecated
::# 	306 unused
::# 	307 Temporary Redirect
::# 	308 Permanent Redirect
::#
::#		##### Client error responses (400 – 499) ######
::# 	400 Bad Request
::# 	401 Unauthorized
::# 	402 Payment Required
::# 	403 Forbidden
::# 	404 Not Found
::# 	405 Method Not Allowed
::# 	406 Not Acceptable
::# 	407 Proxy Authentication Required
::# 	408 Request Timeout
::# 	409 Conflict
::# 	410 Gone
::# 	411 Length Required
::# 	412 Precondition Failed
::# 	413 Content Too Large
::# 	414 URI Too Long
::# 	415 Unsupported Media Type
::# 	416 Range Not Satisfiable
::# 	417 Expectation Failed
::# 	418 I'm a teapot
::# 	421 Misdirected Request
::# 	422 Unprocessable Content (WebDAV)
::# 	423 Locked (WebDAV)
::# 	424 Failed Dependency (WebDAV)
::# 	425 Too Early (Experimental)
::# 	426 Upgrade Required
::# 	428 Precondition Required
::# 	429 Too Many Requests
::# 	431 Request Header Fields Too Large
::# 	451 Unavailable For Legal Reasons
::#
::#		##### Server error responses (500 – 599) ######
::# 	500 Internal Server Error
::# 	501 Not Implemented
::# 	502 Bad Gateway
::# 	503 Service Unavailable
::# 	504 Gateway Timeout
::# 	505 HTTP Version Not Supported
::# 	506 Variant Also Negotiates
::# 	507 Insufficient Storage (WebDAV)
::# 	508 Loop Detected (WebDAV)
::# 	510 Not Extended
::# 	511 Network Authentication Required
::#
:dk_httpResponse
%setlocal%
	%dk_call% dk_debugFunc 1 2

	%dk_call% dk_validate CURL_EXE "%dk_call% dk_CURL_EXE"
	
	::"C:\Windows\System32\curl.exe" -sI -o nul -w "%{http_code}" "http://www.google.com/index.html"
	
	::%dk_call% dk_setEx command "%CURL_EXE% -sI -o nul -w %%{http_code} %~1"
	::set command=%CURL_EXE% -sI -o nul -w "%%{http_code}" "%~1"

	set command=%CURL_EXE% "%~1" -sI -o nul -w "%%%%%%%%{http_code}\n"
	%dk_call% dk_exec %command%
	set "dk_httpResponse=%dk_exec%"
	
	
::	for /f "usebackq tokens=*" %%A in (`%command%`) do (
::		set "dk_httpResponse=%%A"
::	)
::
	endlocal & (
		set "dk_httpResponse=%dk_httpResponse%"
		rem if "%~2" neq "" (set "%~2=%dk_httpResponse%")
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	set "url=http://www.google.com/index.html"
	%dk_call% dk_httpResponse "%url%"
	echo url:'%url%' dk_httpResponse = %dk_httpResponse%
	
	set "url=http://www.nonexisting.com/nofile.no"
	%dk_call% dk_httpResponse "%url%"
	echo url:'%url%' dk_httpResponse = %dk_httpResponse%
	
	set "url=https://aka.ms/vs/16/release/VC_redist.x86.exe"
	%dk_call% dk_httpResponse "%url%"
	echo url:'%url%' dk_httpResponse = %dk_httpResponse%
	
	set "url=https://aka.ms/vs/16/release/VC_redist.x64.exe" 
	%dk_call% dk_httpResponse "%url%"
	echo url:'%url%' dk_httpResponse = %dk_httpResponse%

%endfunction%
