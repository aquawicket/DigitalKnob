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


rem ################################################################################
rem # dk_listToArray(<list> rtn_var)
rem #
rem #
:dk_listToArray
%setlocal%
   
    set "_list_=%~1"
    if defined !_list_! (set "_list_=!%_list_%!")
%endfunction%	
    set /a i=0
    for %%a in (%_list_%) do (
		set "dk_listToArray[!i!]=%%a"
        rem if "%~2" neq "" (
		rem	set "%~2[!i!]=%%a"
		rem )
        set /a i+=1
    )
   
    rem Return the array to the calling scope
    set "_SCOPE_=%~n0"
    for /F "usebackq delims=" %%a in (`set dk_listToArray[ 2^>nul`) do (
       if "%_SCOPE_%" equ "%~n0" endlocal
       set "%%a"
	   set "line=%%a"
	   set "!line:dk_listToArray=%~2!"
    )
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_set myList "a;b;c;d;e;f;g"
	%dk_call% dk_printVar myList
    %dk_call% dk_listToArray "%myList%"
    %dk_call% dk_printVar dk_listToArray
	
	%dk_call% dk_set myListB "https:;;github.com;git-for-windows;git;releases;download;v2.44.0.windows.1;PortableGit-2.44.0-64-bit.7z.exe"
	rem %dk_call% dk_set myListB "https:;github.com;git-for-windows;git;releases;download;v2.44.0.windows.1;PortableGit-2.44.0-64-bit.7z.exe"
	%dk_call% dk_printVar myListB
	%dk_call% dk_listToArray "%myListB%" myArrayB
    %dk_call% dk_printVar dk_listToArray
	%dk_call% dk_printVar myArrayB
	
	%dk_call% dk_set PLUGIN.URL_List "https:;;github.com;git-for-windows;git;releases;download;v2.44.0.windows.1;PortableGit-2.44.0-64-bit.7z.exe"
	%dk_call% dk_printVar PLUGIN.URL_List
	%dk_call% dk_listToArray "%PLUGIN.URL_List%" PLUGIN.URL_Array
	%dk_call% dk_printVar dk_listToArray
	%dk_call% dk_printVar PLUGIN.URL_Array
%endfunction%
