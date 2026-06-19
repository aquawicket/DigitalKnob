@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	if NOT DEFINED DK.cmd (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	call "%%DK.cmd:/=\%%" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ##################################################################################
rem # dk_fileContains(<file>, <string>, optional:<rtn_var>)
rem #
rem #
:dk_fileContains
%setlocal%

	set "_file_=%~1"
	
	set "dk_fileContains=1"
	%dk_call% dk_validate findstr.exe   %dk_call% dk_findFile findstr.exe
	if exist "%_file_%" (
		>nul "%findstr.exe:/=\%" /c:"%~2" "%_file_:/=\%" &&  (
			set "dk_fileContains=0"
		)
	)
   
	:return
	endlocal & (
		set "dk_fileContains=%dk_fileContains%"
		if "%~3" neq "" (set "%~3=%dk_fileContains%")
		exit /b %dk_fileContains%
		rem "%ComSpec%" /c exit /b %dk_fileContains%
	)
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    rem create test
    %dk_call% dk_fileAppend "fileContains_TEST.txt" "find the needle in the haystack"
   
    rem test
    %dk_call% dk_echo
    %dk_call% dk_set substring needle
    %dk_call% dk_fileContains "fileContains_TEST.txt" "%substring%" && (echo file contains substring) || (call & echo file does NOT contain substring)
   
    %dk_call% dk_echo
    %dk_call% dk_set substring "not_in_file"
    %dk_call% dk_fileContains "fileContains_TEST.txt" "%substring%" && (echo file contains substring) || (call & echo file does NOT contain substring)
%endfunction%
