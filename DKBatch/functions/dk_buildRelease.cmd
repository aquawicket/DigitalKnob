@echo off
if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::####################################################################
::# dk_buildRelease()
::#
::#
:dk_buildRelease
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_assertVar TARGET_PATH
	
    if defined MSYSTEM (
		(set cmnd=%MSYS2%/usr/bin/env MSYSTEM=%MSYSTEM% /usr/bin/bash -lc "'%CMAKE_EXE%' --build %CMAKE_TARGET_PATH%/%target_triple%/%target_type% --config %target_type% --verbose")
    )
	
    if exist "%TARGET_PATH%\%target_triple%\%target_type%\CMakeCache.txt" (
		(set cmnd="%CMAKE_EXE%" --build %TARGET_PATH%/%target_triple%/%target_type% --config %target_type% --verbose)
    )
	
    if exist "%TARGET_PATH%\%target_triple%\CMakeCache.txt" (
		(set cmnd="%CMAKE_EXE%" --build %TARGET_PATH%/%target_triple% --config %target_type% --verbose)
    )
	
	%cmnd% && (
		%dk_call% dk_success "CMake Build Successful" 
	) || (
		%dk_call% dk_error "CMake Build Failed"
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_buildRelease
%endfunction%
