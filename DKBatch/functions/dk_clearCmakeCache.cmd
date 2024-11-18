@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_clearCmakeCache(app, triple, type)
::#
::#
:dk_clearCmakeCache
    call dk_debugFunc 0 3
 setlocal
 
    %dk_call% dk_info "Deleting CMake cache files. . ."

	:: for /r "C:\Users\Administrator\digitalknob\Development\3rdParty" %i in (CMakeCache.*) do if exist "%i" del "%i"
    ::for /r %~1 %%i in (CMakeCache.*) do @if exist "%%i" del "%%i"
	:: for /d /r "C:\Users\Administrator\digitalknob\Development\DKApps" %i in (CMakeFiles) do @if exist "%i" rd /s/q "%i"
	::for /d /r "%~1" %%i in (CMakeFiles) do if exist "%%i" rd /s/q "%%i"
	::for /d /r "%~1" %%i in (CMakeFiles) do if exist "%%i" echo "%%i"
	::for /d %%i in (%~1) do echo "%%i"
	
	::for /f "tokens=*" %%G in ('dir /b /s /a:d "C:\Users\Administrator\digitalknob\3rdParty*"') do echo Found %%G
	::for /f "tokens=*" %%G in ('dir /b /s /a:d "%~1*"') do echo Found %%G
	
	%dk_call% dk_validate DK3RDPARTY_DIR "%dk_call% dk_DKBRANCH_DIR"
	for /f "tokens=*" %%G in ('dir /b /a:d %DK3RDPARTY_DIR%') do (
        if exist "!DK3RDPARTY_DIR!\%%G\%~2\CMakeFiles"           rd /s/q "!DK3RDPARTY_DIR!\%%G\%~2\CMakeFiles"
		if exist "!DK3RDPARTY_DIR!\%%G\%~2\CMakeCache.txt"       del "!DK3RDPARTY_DIR!\%%G\%~2\CMakeCache.txt"
        if exist "!DK3RDPARTY_DIR!\%%G\%~2\%~3\CMakeFiles"       rd /s/q "!DK3RDPARTY_DIR!\%%G\%~2\%~3\CMakeFiles"
		if exist "!DK3RDPARTY_DIR!\%%G\%~2\%~3\CMakeCache.txt"   del "!DK3RDPARTY_DIR!\%%G\%~2\%~3\CMakeCache.txt"
	)
	
	%dk_call% dk_validate DKPLUGINS_DIR "%dk_call% dk_DKBRANCH_DIR"
	for /f "tokens=*" %%G in ('dir /b /a:d %DKPLUGINS_DIR%') do (
        if exist "!DKPLUGINS_DIR!\%%G\%~2\CMakeFiles"           rd /s/q "!DKPLUGINS_DIR!\%%G\%~2\CMakeFiles"
		if exist "!DKPLUGINS_DIR!\%%G\%~2\CMakeCache.txt"       del "!DKPLUGINS_DIR!\%%G\%~2\CMakeCache.txt"
        if exist "!DKPLUGINS_DIR!\%%G\%~2\%~3\CMakeFiles"       rd /s/q "!DKPLUGINS_DIR!\%%G\%~2\%~3\CMakeFiles"
		if exist "!DKPLUGINS_DIR!\%%G\%~2\%~3\CMakeCache.txt"   del "!DKPLUGINS_DIR!\%%G\%~2\%~3\CMakeCache.txt"
	)
	
	%dk_call% dk_validate DKAPPS_DIR "%dk_call% dk_DKBRANCH_DIR"
        if exist "!DKAPPS_DIR!\%~1\%~2\CMakeFiles"           rd /s/q "!DKAPPS_DIR!\%~1\%~2\CMakeFiles"
		if exist "!DKAPPS_DIR!\%~1\%~2\CMakeCache.txt"       del "!DKAPPS_DIR!\%~1\%~2\CMakeCache.txt"
        if exist "!DKAPPS_DIR!\%~1\%~2\%~3\CMakeFiles"       rd /s/q "!DKAPPS_DIR!\%~1\%~2\%~3\CMakeFiles"
		if exist "!DKAPPS_DIR!\%~1\%~2\%~3\CMakeCache.txt"   del "!DKAPPS_DIR!\%~1\%~2\%~3\CMakeCache.txt"
	)
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_clearCmakeCache appname win_x86_64_clang Debug
%endfunction%
