#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

##############################################################################
# dk_isUrl(arg)
# 
#	Test if a string is a url
#
#	@arg		- The argument to test
#	@dk_isUrl 	- 1 if arg is a url, 0 if otherwise.
#
function(dk_isUrl)
	dk_debugFunc(1)
	
	dk_getArg(0 _arg0_)
	
	if("${_arg0_}" MATCHES "^(http|HTTP|https|HTTPS|ftp|FTP|ftps|FTPS)://")
		set(dk_isUrl 1 PARENT_SCOPE)
	else()
		set(dk_isUrl 0 PARENT_SCOPE)
	endif()	
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	### http:// ###
	dk_isUrl(http://www.test.com)
	dk_echo("http://www.test.com = ${dk_isUrl}")
	
	dk_isUrl("http://www.test.com")
	dk_echo("\"http://www.test.com\" = ${dk_isUrl}")
	
	### HTTP:// ###
	dk_isUrl(HTTP://www.test.com)
	dk_echo("HTTP://www.test.com = ${dk_isUrl}")
	
	dk_isUrl("HTTP://WWW.TEST.COM")
	dk_echo("\"HTTP://WWW.TEST.COM\" = ${dk_isUrl}")
	
	### https:// ###
	dk_isUrl(https://www.test.com)
	dk_echo("https://www.test.com = ${dk_isUrl}")
	
	dk_isUrl("https://www.test.com")
	dk_echo("\"https://www.test.com\" = ${dk_isUrl}")
	
	### HTTPS:// ###
	dk_isUrl(HTTPS://www.test.com)
	dk_echo("HTTPS://www.test.com = ${dk_isUrl}")
	
	dk_isUrl("HTTPS://WWW.TEST.COM")
	dk_echo("\"HTTPS://WWW.TEST.COM\" = ${dk_isUrl}")
	
	### ftp:// ###
	dk_isUrl(ftp://www.test.com)
	dk_echo("ftp://www.test.com = ${dk_isUrl}")
	
	dk_isUrl("ftp://www.test.com")
	dk_echo("\"ftp://www.test.com\" = ${dk_isUrl}")
	
	### FTP:// ###
	dk_isUrl(FTP://WWW.TEST.COM)
	dk_echo("FTP://WWW.TEST.COM = ${dk_isUrl}")
	
	dk_isUrl("FTP://WWW.TEST.COM")
	dk_echo("\"FTP://WWW.TEST.COM\" = ${dk_isUrl}")
	
	### ftp:// ###
	dk_isUrl(ftp://www.test.com)
	dk_echo("ftp://www.test.com = ${dk_isUrl}")
	
	dk_isUrl("ftp://www.test.com")
	dk_echo("\"ftp://www.test.com\" = ${dk_isUrl}")
	
	### FTPS:// ###
	dk_isUrl(FTPS://WWW.TEST.COM)
	dk_echo("FTPS://WWW.TEST.COM = ${dk_isUrl}")
	
	dk_isUrl("FTPS://WWW.TEST.COM")
	dk_echo("\"FTPS://WWW.TEST.COM\" = ${dk_isUrl}")
	
	dk_isUrl(http://www.test.com)
	if(dk_isUrl)
		dk_echo("http://www.test.com = TRUE")
	else()
		dk_echo("http://www.test.com = FALSE")
	endif()
	
	dk_isUrl(notAUrl)
	if(dk_isUrl)
		dk_echo("notAUrl = TRUE")
	else()
		dk_echo("notAUrl = FALSE")
	endif()
	
	### NOT VALID ###
	dk_echo("")
	
	dk_isUrl(www.test.com)
	dk_echo("www.test.com = ${dk_isUrl}")
	
	dk_isUrl('https://www.test.com')
	dk_echo("'https://www.test.com' = ${dk_isUrl}")
	
endfunction()
