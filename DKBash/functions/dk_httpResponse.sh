#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################



####################################################################
# dk_httpResponse(<url> <ret:optional>)
#
#		Reference: https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Status
#				   https://en.wikipedia.org/wiki/List_of_HTTP_status_codes
#				   https://superuser.com/a/442395
#
#	###### Informational responses (100 – 199) ######
# 	100 Continue
# 	101 Switching Protocols
# 	102 Processing 
# 	103 Early Hints
#
#	###### Successful responses (200 – 299) ######
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
#	###### Redirection messages (300 – 399) ######
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
#	##### Client error responses (400 – 499) ######
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
#	##### Server error responses (500 – 599) ######
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
dk_httpResponse() {
	#dk_debugFunc 1 2

	dk_call dk_validate CURL_EXE "dk_call dk_CURL_EXE"
	
	dk_httpResponse=$(${CURL_EXE} -sI -o nul -w "%{http_code}" ${1})

	export dk_httpResponse="${dk_httpResponse}"
#	[ -n "${2-}" ] && ${2}=${dk_httpResponse}
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	#dk_debugFunc 0

	url="http://www.google.com/index.html"
	dk_call dk_httpResponse "${url}"
	echo "url:'${url}' dk_httpResponse = ${dk_httpResponse}"
	
	url="http://www.nonexisting.com/nofile.no"
	dk_call dk_httpResponse "${url}"
	echo "url:'${url}' dk_httpResponse = ${dk_httpResponse}"
	
	url="https://aka.ms/vs/16/release/VC_redist.x86.exe"
	dk_call dk_httpResponse "${url}"
	echo "url:'${url}' dk_httpResponse = ${dk_httpResponse}"
	
	url="https://aka.ms/vs/16/release/VC_redist.x64.exe" 
	dk_call dk_httpResponse "${url}"
	echo "url:'${url}' dk_httpResponse = ${dk_httpResponse}"
}
