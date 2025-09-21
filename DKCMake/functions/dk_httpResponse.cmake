#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


####################################################################
# dk_httpResponse(<url> <ret:optional>)
#
#		Reference: https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Status
#				   https://en.wikipedia.org/wiki/List_of_HTTP_status_codes
#
#		###### Informational responses (100 – 199) ######
# 	100 Continue
# 	101 Switching Protocols
# 	102 Processing
# 	103 Early Hints
#
#		###### Successful responses (200 – 299) ######
# 	200 OK
# 	201 Created
# 	202 Accepted
# 	203 Non-Authoritative Information
# 	204 No Content
# 	205 Reset Content
# 	206 Partial Content
# 	207 Multi-Status (WebDAV)
# 	208 Already Reported (WebDAV)
# 	226 IM Used (HTTP Delta encoding)
#
#		###### Redirection messages (300 – 399) ######
# 	300 Multiple Choices
# 	301 Moved Permanently
# 	302 Found
# 	303 See Other
# 	304 Not Modified
# 	305 Use Proxy Deprecated
# 	306 unused
# 	307 Temporary Redirect
# 	308 Permanent Redirect
#
#		##### Client error responses (400 – 499) ######
# 	400 Bad Request
# 	401 Unauthorized
# 	402 Payment Required
# 	403 Forbidden
# 	404 Not Found
# 	405 Method Not Allowed
# 	406 Not Acceptable
# 	407 Proxy Authentication Required
# 	408 Request Timeout
# 	409 Conflict
# 	410 Gone
# 	411 Length Required
# 	412 Precondition Failed
# 	413 Content Too Large
# 	414 URI Too Long
# 	415 Unsupported Media Type
# 	416 Range Not Satisfiable
# 	417 Expectation Failed
# 	418 I'm a teapot
# 	421 Misdirected Request
# 	422 Unprocessable Content (WebDAV)
# 	423 Locked (WebDAV)
# 	424 Failed Dependency (WebDAV)
# 	425 Too Early (Experimental)
# 	426 Upgrade Required
# 	428 Precondition Required
# 	429 Too Many Requests
# 	431 Request Header Fields Too Large
# 	451 Unavailable For Legal Reasons
#
#		##### Server error responses (500 – 599) ######
# 	500 Internal Server Error
# 	501 Not Implemented
# 	502 Bad Gateway
# 	503 Service Unavailable
# 	504 Gateway Timeout
# 	505 HTTP Version Not Supported
# 	506 Variant Also Negotiates
# 	507 Insufficient Storage (WebDAV)
# 	508 Loop Detected (WebDAV)
# 	510 Not Extended
# 	511 Network Authentication Required
#
function(dk_httpResponse)
	dk_debugFunc(1 2)

	dk_validate(curl_exe "dk_depend(curl_exe)")
	
	#dk_set(dk_exec_ECHO_OUTPUT 0)
	set(command ${curl_exe} ${ARGV0} -sI -o nul -w %{http_code})
	dk_exec(${command})
	dk_assertVar(dk_exec)
	set(dk_httpResponse "${dk_exec}")

	
	###### output ######
	set(dk_httpResponse ${dk_httpResponse} PARENT_SCOPE)
	if(ARGV1)
		set(${ARGV1} ${dk_httpResponse} PARENT_SCOPE)
	else()
		message("${dk_httpResponse}") 
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	set(url "http://www.google.com/index.html")
	dk_httpResponse("${url}")
	dk_echo("url:'${url}' dk_httpResponse = ${dk_httpResponse}")
	
	set(url "http://www.nonexisting.com/nofile.no")
	dk_httpResponse("${url}")
	dk_echo("url:'${url}' dk_httpResponse = ${dk_httpResponse}")
	
	set(url "https://aka.ms/vs/16/release/VC_redist.x86.exe")
	dk_httpResponse("${url}")
	dk_echo("url:'${url}' dk_httpResponse = ${dk_httpResponse}")
	
	set(url "https://aka.ms/vs/16/release/VC_redist.x64.exe")
	dk_httpResponse("${url}")
	dk_echo("url:'${url}' dk_httpResponse = ${dk_httpResponse}")

endfunction()
