@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::if defined include_guard_dk_includeGuard (%return%) else set include_guard_dk_includeGuard=1
::if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %* & call :TEST_dk_includeGuard

::##################################################################################
::# dk_includeGuard()
::#
::#
:dk_includeGuard
    call dk_debugFunc 0
 setlocal
 
    :: since batch calls scripts by file and not by function, there is no need to use include guards
    
::  (
::      setlocal DisableDelayedExpansion
::      (goto) 2>nul
::      call set parent=%%~0
::      if "%parent%" neq "" (
::          if defined include_guard_%parent% (
::              ::echo %parent% is already included
::              call %return%
::          ) else (
::              ::echo setting include_guard_%parent% to 1
::              set include_guard_%parent%=1
::          )
::      )
::  )
::  echo THIS IS NEVER REACHED
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal

	::(goto) 2>nul & call set caller=%%~0 & echo %caller%
    
    ::(goto) 2>nul & call set caller=%%~0 & echo %caller% & goto resume
    :::resume
    ::echo :resume
%endfunction%
