@echo off&::###### DK.cmd #########################################################################################################################
if NOT exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_listToArray(<list> rtn_var)
::#
::#
:dk_listToArray
%setlocal%
    %dk_call% dk_debugFunc 2
   
    set "_list_=%~1"
	
    if defined !_list_! (
		set "_list_=!%_list_%!"
	)
    set /a i=0
    for %%a in (%_list_%) do (
		set "dk_listToArray[!i!]=%%a"
        rem if "%~2" neq "" (
		rem	set "%~2[!i!]=%%a"
		rem )
        set /a i+=1
    )
   
    rem Return the array to the calling scope
    set "currentScope=1"
    for /F "delims=" %%a in ('set dk_listToArray[') do (
       if defined currentScope endlocal
       set "%%a"
	   set "line=%%a"
	   set "!line:dk_listToArray=%~2!"
    )
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

    %dk_call% dk_set myList "a;b;c;d;e;f;g"
	%dk_call% dk_printVar myList
    %dk_call% dk_listToArray "%myList%"
    %dk_call% dk_printVar dk_listToArray
	
	%dk_call% dk_set myListB "https:;;github.com;git-for-windows;git;releases;download;v2.44.0.windows.1;PortableGit-2.44.0-64-bit.7z.exe"
	::%dk_call% dk_set myListB "https:;github.com;git-for-windows;git;releases;download;v2.44.0.windows.1;PortableGit-2.44.0-64-bit.7z.exe"
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
