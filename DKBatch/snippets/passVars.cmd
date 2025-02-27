@echo off
setlocal

call :initMacro

%$set% ipOutput="ipconfig"
call :ShowVariable ipOutput
echo First line is %ipOutput[0]%

echo( 
%$set% driveNames="wmic logicaldisk get name /value | findstr "Name""
call :ShowVariable driveNames

pause
exit /b
::##################################################################

:ShowVariable
setlocal EnableDelayedExpansion
for /L %%n in (0 1 !%~1.max!) do (
    echo %%n: !%~1[%%n]!
)
echo(
exit /b

:initMacro
if "!!"=="" (
    echo ERROR: Delayed Expansion must be disabled while defining macros
    (goto) 2>nul
    (goto) 2>nul
)
(set LF=^
%=empty=%
)
(set \n=^^^
%=empty=%
)

set $set=FOR /L %%N in (1 1 2) dO IF %%N==2 ( %\n%
    setlocal EnableDelayedExpansion                                 %\n%
    for /f "tokens=1,* delims== " %%1 in ("!argv!") do (            %\n%
        endlocal                                                    %\n%
        endlocal                                                    %\n%
        set "%%~1.Len=0"                                            %\n%
        set "%%~1="                                                 %\n%
        if "!!"=="" (                                               %\n%
            %= Used if delayed expansion is enabled =%              %\n%
                setlocal DisableDelayedExpansion                    %\n%
                for /F "delims=" %%O in ('"%%~2 | findstr /N ^^"') do ( %\n%
                if "!!" NEQ "" (                                    %\n%
                    endlocal                                        %\n%
                    )                                               %\n%
                setlocal DisableDelayedExpansion                    %\n%
                set "line=%%O"                                      %\n%
                setlocal EnableDelayedExpansion                     %\n%
                set pathExt=:                                       %\n%
                set path=;                                          %\n%
                set "line=!line:^=^^!"                              %\n%
                set "line=!line:"=q"^""!"                           %\n%
                call set "line=%%line:^!=q""^!%%"                   %\n%
                set "line=!line:q""=^!"                             %\n%
                set "line="!line:*:=!""                             %\n%
                for /F %%C in ("!%%~1.Len!") do (                   %\n%
                    FOR /F "delims=" %%L in ("!line!") Do (         %\n%
                        endlocal                                    %\n%
                        endlocal                                    %\n%
                        set "%%~1[%%C]=%%~L" !                      %\n%
                        if %%C == 0 (                               %\n%
                            set "%%~1=%%~L" !                       %\n%
                        ) ELSE (                                    %\n%
                            set "%%~1=!%%~1!!LF!%%~L" !             %\n%
                        )                                           %\n%
                    )                                               %\n%
                    set /a %%~1.Len+=1                              %\n%
                )                                                   %\n%
            )                                                       %\n%
        ) ELSE (                                                    %\n%
            %= Used if delayed expansion is disabled =%             %\n%
            for /F "delims=" %%O in ('"%%~2 | findstr /N ^^"') do ( %\n%
                setlocal DisableDelayedExpansion                    %\n%
                set "line=%%O"                                      %\n%
                setlocal EnableDelayedExpansion                     %\n%
                set "line="!line:*:=!""                             %\n%
                for /F %%C in ("!%%~1.Len!") DO (                   %\n%
                    FOR /F "delims=" %%L in ("!line!") DO (         %\n%
                        endlocal                                    %\n%
                        endlocal                                    %\n%
                        set "%%~1[%%C]=%%~L"                        %\n%
                    )                                               %\n%
                    set /a %%~1.Len+=1                              %\n%
                )                                                   %\n%
            )                                                       %\n%
        )                                                           %\n%
        set /a %%~1.Max=%%~1.Len-1                                  %\n%
)                                                                   %\n%
    ) else setlocal DisableDelayedExpansion^&set argv=

goto :eof