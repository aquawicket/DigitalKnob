:strlen_init
if "!!"=="" (
	echo ERROR: Delayed Expansion must be disabled while defining macros
	pause
	exit /b
)
	
set ^"LF=^
%= This creates a variable containing a single linefeed (0x0A) character =%
^"

set ^"\n=^^^%LF%%LF%^%LF%%LF%^^"
set @strLen=for %%. in (1 2) do if %%.==2 (%\n%
  for /f "tokens=1,2 delims=, " %%1 in ("!argv!") do ( endlocal%\n%
    set "s=A!%%~1!"%\n%
    set "len=0"%\n%
    for %%P in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (%\n%
      if "!s:~%%P,1!" neq "" (%\n%
        set /a "len+=%%P"%\n%
        set "s=!s:~%%P!"%\n%
      )%\n%
    )%\n%
    for %%V in (!len!) do endlocal^&if "%%~2" neq "" (set "%%~2=%%V") else echo %%V%\n%
  )%\n%
) else setlocal enableDelayedExpansion^&setlocal^&set argv=,