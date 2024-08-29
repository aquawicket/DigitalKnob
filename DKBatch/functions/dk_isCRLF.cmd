@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::####################################################################
::# dk_isCRLF(file rtn_var)
::#
::#
:dk_isCRLF
 setlocal
	call dk_debugFunc 1 2

	call type "%~1" | c:\Windows\System32\find.exe "" /v > "%~1.temp"
	set size1=%~z1
	rem add 2 in case the file doesn't have a trailing newline, since find will add it
	set /a size1plus2=%size1%+2
	call :setsize2 "%~1.temp%"
	
	for /f %%a in ('c:\Windows\System32\findstr /R /N "^" "%~1" ^| c:\Windows\System32\find /C ":"') do set lines=%%a
	del "%~1.temp"
	
	if %size1plus2% equ %size2% (
		if %lines% equ 2 (
			rem echo File uses LF line endings!
		) else (
			rem echo File uses CRLF or has no line endings!
			if defined "%~2" (endlocal & set "%2=true")
			(call ) %NO_STD%
			goto:eof
		)
	) else (
		if %size1% lss %size2% (
			rem echo File uses LF line endings!
		) else (
			rem echo File uses CR+LF line endings!
			if defined "%~2" (endlocal & set "%2=true")
			(call ) %NO_STD%
			goto:eof
		)
	)
	
	if defined "%~2" (endlocal & set "%2=false")
	(call) %NO_STD%
%endfunction%

:setsize2
	set size2=%~z1
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_isCRLF DK.cmd && %dk_call% dk_echo "DK.cmd is CRLF" || %dk_call% dk_echo "DK.cmd is NOT CRLF"
	
	%dk_call% dk_validate DKBASH_FUNCTIONS_DIR "%dk_call% dk_validateBranch"
	%dk_call% dk_isCRLF %DKBASH_FUNCTIONS_DIR%\DK.sh && %dk_call% dk_echo "DK.sh is CRLF" || %dk_call% dk_echo "DK.sh is NOT CRLF"
%endfunction%
