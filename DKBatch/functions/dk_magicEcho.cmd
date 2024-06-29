@echo off
call :dk_magicEcho.init
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd



:dk_magicEcho.init
    set "dk_magicEcho=call :gn & REM # #"
goto:eof

:dk_magicEcho
    setlocal EnableDelayedExpansion
    set /a skip=ln-2
    setlocal DisableDelayedExpansion
    FOR /F "usebackq skip=%skip% delims=" %%L in (`findstr /n "^" "%~f0"`) do (
        set "line=%%L"
        setlocal EnableDelayedExpansion
        set "line=!line:*:=!"
        set "line=!line:*echo%% =!"
        if defined line echo(!line!
        endlocal
        goto:eof
    )
goto:eof

:gn
    setlocal EnableDelayedExpansion
    for %%F in ("%~f0") do set /a size=%%~zF
    set "empty=."
    for /L %%n in (1 1 13) DO set "empty=!empty:~0,4000!!empty:~0,4000!"

    set LF=^


    REM ***
    set /a blockSizeHalf=4000, blockSize2=blockSizeHalf*2+2
    copy "%~f0" "%~f0.tmp" > NUL && (
    set /a charCount=0, lo=0, sl=0, preChars=0, lnr=0, cnt=0
for /F "usebackq delims=:" %%O in (`findstr /o "^" "%~f0"`) DO (
    set "offset=%%O"
    set /a lnr+=1
    set /a diff=offset-lo, lo=offset
    set /a charCount+=diff
    if !diff! GEQ 12 (
        set "output=%%#:#=!sl!,!preChars!%%"
        set "s=!output!#"
        set "len=0"
        for %%P in (16 8 4 2 1) do (
            if "!s:~%%P,1!" neq "" (
                set /a "len+=%%P"
                set "s=!s:~%%P!"
            )
        )
        set /a fill=charCount-len-1
        for /F %%L in ("!fill!") DO set "output=!output!!empty:~0,%%L!!LF!"                
        set /a cnt+=1
        set "line!cnt!=!output!"                
        set /a charCount=0, sl=lnr, preChars=offset
    )
)
(
    (
        for /L %%n in (1 1 !cnt!) DO (
            <nul set /p ".=!line%%n!"
        )
        (echo()
        echo :"
        echo (
        echo    setlocal EnableDelayedExpansion
        echo    FOR /F "tokens=1,2 delims=," %%%%A in ("^!offset^!"^) DO set /a line=%%%%A,label=%%%%B
        echo    copy "%~f0.tmp" "%~f0" > NUL
        echo    set /a size=%size%
        echo    set L=^^
        (echo()
        (echo()
        echo    for /L %%%%n in (1 1 13^) DO set "L=^!L:~0,%blockSizeHalf%^!^!L:~0,%blockSizeHalf%^!"
        echo    set /a remainSize=label-11, blocks=remainSize/%blockSize2%, remainSize=remainSize-%blockSize2%*blocks-2
        echo    if ^^!remainSize^^! LSS 2 set /a remainSize+=%blockSize2%, blocks-=1
        echo    FOR /F %%%%R in ("^!remainSize^!"^) DO set "lastBlock=^!L:~-%%%%R^!)"
        echo    (
        echo        (echo :#^)
        echo        (echo (%%%%#%%%%^)
        echo        FOR /L %%%%n in (1 1 ^^!blocks^^!^) DO (echo(^^!L^^!^)
        echo        (echo(^^!lastBlock^^!^)
        echo        echo(
        echo    ^) ^> "%~f0"
        echo    set ^^^^^"#=endlocal ^^^^^& (copy "%~f0.tmp" "%~f0" ^^^^^&^^^^^& del "%~f0.tmp"^^^^^) ^^^^^> nul ^^^^^& set "ln=^!line^!" ^^^^^& call :dk_magicEcho"
        echo    goto :#
        echo ^)
    ) > "%~f0"

    endlocal
    set "#=<nul set offset=# & goto :":"
    goto:eof
)
)
echo FAIL
goto:eof




:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	call dk_debugFunc
	
    %dk_magicEcho% This is impossible %path% ^& | <> "^& | <>" ^
    echo Or not?
goto:eof   
