@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# dk_isUrl(<in> rtn_var)
::#
::#  https://stackoverflow.com/a/17584764
::#
:dk_isUrl
setlocal
	%dk_call% dk_debugFunc 1 2
 
	set "_arg0_=%~0"
	
	:: if "%_arg0_%" MATCHES "^(http|HTTP|https|HTTPS|ftp|FTP|ftps|FTPS)://" (exit /b 0)
	echo "%~1" | findstr /i "http://" >nul 	&& exit /b 0
	echo "%~1" | findstr /i "https://" >nul && exit /b 0
	echo "%~1" | findstr /i "ftp://" >nul 	&& exit /b 0
	echo "%~1" | findstr /i "ftps://" >nul 	&& exit /b 0
	
	exit /b 1
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    ::### http:// ###
	%dk_call% dk_isUrl http://www.test.com 		&& echo http://www.test.com = true 		|| echo http://www.test.com = false
	
	%dk_call% dk_isUrl "http://www.test.com" 	&& echo "http://www.test.com" = true 	|| echo "http://www.test.com" = false
	
	::### HTTP:// ###
	%dk_call% dk_isUrl HTTP://www.test.com 		&& echo HTTP://www.test.com = true 		|| echo HTTP://www.test.com = false
	
	%dk_call% dk_isUrl "HTTP://WWW.TEST.COM" 	&& echo HTTP://WWW.TEST.COM = true 		|| echo HTTP://WWW.TEST.COM = false
	
	::### https:// ###
	%dk_call% dk_isUrl https://www.test.com		&& echo https://www.test.com = true 	|| echo https://www.test.com = false
	
	%dk_call% dk_isUrl "https://www.test.com"	&& echo "https://www.test.com" = true 	|| echo "https://www.test.com" = false
	
	::### HTTPS:// ###
	%dk_call% dk_isUrl HTTPS://www.test.com		&& echo HTTPS://www.test.com = true 	|| echo HTTPS://www.test.com = false
	
	%dk_call% dk_isUrl "HTTPS://WWW.TEST.COM"	&& echo HTTPS://WWW.TEST.COM = true 	|| echo HTTPS://WWW.TEST.COM = false
	
	::### ftp:// ###
	%dk_call% dk_isUrl ftp://www.test.com		&& echo ftp://www.test.com = true 		|| echo ftp://www.test.com = false
	
	%dk_call% dk_isUrl "ftp://www.test.com"		&& echo "ftp://www.test.com" = true 	|| echo "ftp://www.test.com" = false
	
	::### FTP:// ###
	%dk_call% dk_isUrl FTP://WWW.TEST.COM		&& echo FTP://WWW.TEST.COM = true 		|| echo FTP://WWW.TEST.COM = false
	
	%dk_call% dk_isUrl "FTP://WWW.TEST.COM"		&& echo "FTP://WWW.TEST.COM" = true		|| echo "FTP://WWW.TEST.COM" = false
	
	::### ftps:// ###
	%dk_call% dk_isUrl ftp://www.test.com		&& echo ftps://www.test.com = true 		|| echo ftps://www.test.com = false
	
	%dk_call% dk_isUrl "ftp://www.test.com"		&& echo "ftps://www.test.com" = true 	|| echo "ftps://www.test.com" = false
	
	::### FTPS:// ###
	%dk_call% dk_isUrl FTPS://WWW.TEST.COM		&& echo FTPS://WWW.TEST.COM = true 		|| echo FTPS://WWW.TEST.COM = false
	
	%dk_call% dk_isUrl "FTPS://WWW.TEST.COM"	&& echo "FTPS://WWW.TEST.COM" = true 	|| echo "FTPS://WWW.TEST.COM" = false
	
	
	%dk_call% dk_isUrl http://www.test.com && (
		%dk_call% dk_echo "http://www.test.com = TRUE"
	) || (
		%dk_call% dk_echo "http://www.test.com = FALSE"
	)
	
	%dk_call% dk_isUrl notAUrl && (
		%dk_call% dk_echo "notAUrl = TRUE"
	) || (
		%dk_call% dk_echo "notAUrl = FALSE"
	)
	
	::### NOT VALID ###
	%dk_call% dk_echo ""
	
	%dk_call% dk_isUrl www.test.com && %dk_call% dk_echo www.test.com = true || %dk_call% dk_echo www.test.com = false
	
	%dk_call% dk_isUrl 'https://www.test.com'
	%dk_call% dk_echo "'https://www.test.com' = %dk_isUrl%"

%endfunction%
