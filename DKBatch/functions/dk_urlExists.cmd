@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::####################################################################
::# dk_urlExists(url rtn_var)
::#
:dk_urlExists
 setlocal
    call dk_debugFunc 1 2
    
    :curl
        if defined DISABLE_curl goto:end_curl_exists
        for /f "usebackq tokens=*" %%f in (`curl -sI -o nul -w "%%{http_code}" "%~1"`) do set "httpCode=%%f"

        :: if !httpCode! equ 503 echo !httpCode! Service Unavailable
        :: if !httpCode! equ 500 echo !httpCode! Internal Server Error
        :: if !httpCode! equ 404 echo !httpCode! Not Found 
        :: if !httpCode! equ 302 echo !httpCode! Temporary Redirect 
        :: if !httpCode! equ 301 echo !httpCode! Permament Redirect 
        :: if !httpCode! equ 200 echo !httpCode! OK
        :: if !httpCode! equ 000 echo !httpCode! Server Rejected the Request
        
        if !httpCode! equ 200 (
            if "%~2" neq "" (endlocal & set "%2=true")
            exit /b 0
        )
        if !httpCode! equ 302 (
            if "%~2" neq "" (endlocal & set "%2=true")
            exit /b 0
        )
    :end_curl

    if "%~2" neq "" (endlocal & set "%2=false")
    exit /b 1
 endlocal
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
    call dk_debugFunc 0

    ::###### Using if return value
    %dk_call% dk_echo
    set "url=http://www.google.com/index.html"
    %dk_call% dk_urlExists "%url%" result
    if "%result%" equ "true" (echo %url% exists) else (echo %url% does NOT exists)
    
    %dk_call% dk_echo
    set "url=http://www.nonexisting.com/nofile.no"
    %dk_call% dk_urlExists "%url%" result
    if "%result%" equ "true" (echo %url% exists) else (echo %url% does NOT exists)
    ::FIXME: ERRORLEVEL is still 1 
    
    
    ::###### Using if ERRORLEVEL
    %dk_call% dk_echo
    set "url=http://www.google.com/index.html"
    %dk_call% dk_urlExists "%url%"
    if not ERRORLEVEL 1 (echo %url% exists) else (echo %url% does NOT exists)
    
    %dk_call% dk_echo
    set "url=http://www.nonexisting.com/nofile.no"
    %dk_call% dk_urlExists "%url%"
    if not ERRORLEVEL 1 (echo %url% exists) else (echo %url% does NOT exists)
    ::FIXME: ERRORLEVEL is still 1 
    
    
    ::###### Using && and || conditionals
    %dk_call% dk_echo
    set "url=http://www.google.com/index.html"
    %dk_call% dk_urlExists "%url%" && (echo %url% exists) || (echo %url% does NOT exists)
    
    %dk_call% dk_echo
    set "url=http://www.nonexisting.com/nofile.no"  
    %dk_call% dk_urlExists "%url%" && (echo %url% exists) || (echo %url% does NOT exists)
    ::FIXME: ERRORLEVEL is still 1 
    
    
    ::###### Experimental
    ::  %dk_call% dk_echo
    ::  set "url=http://www.google.com/index.html"
    ::  %dk_call% dk_urlExists "%url%"
    ::  if %dk_urlExists% (echo %url% exists) else (echo %url% does NOT exists)
    ::
    ::  %dk_call% dk_echo
    ::  set "url=http://www.nonexisting.com/nofile.no"
    ::  %dk_call% dk_urlExists "%url%"
    ::  if %dk_urlExists% (echo %url% exists) else (echo %url% does NOT exists)
    ::  if not ERRORLEVEL 1 (echo ERRORLEVEL is 0) else (echo ERRORLEVEL is 1)
 endlocal
goto:eof
