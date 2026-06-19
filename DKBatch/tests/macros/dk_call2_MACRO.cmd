if "!!"=="" (
	echo ERROR: Delayed Expansion must be disabled while defining macros
	pause
	exit /b
)

set ^"LF=^
%= This creates a variable containing a single linefeed (0x0A) character =%
^"

set ^"\n=^^^%LF%%LF%^%LF%%LF%^^"
set @dk_call2_MACRO=for %%# in (1 2) do if %%#==2 (%\n%
	if defined argv (%\n%
		for /F "delims=" %%* in ("!argv:~1!") do ( endlocal%\n%
			endlocal%\n%
			rem ###############################################%\n%
			echo. ^&echo %ESC%[35m:dk_call2_MACRO^^^> '%%*'%ESC%[39m%\n%
			%%* ^&^& ^(%\n%
				echo %ESC%[32mOK%ESC%[39m%\n%
				echo.%\n%
			^) ^|^| ^(%\n%
				echo %ESC%[31mERROR:!errorlevel! @ %~nx0 ^^^>%%*%ESC%[39m%\n%
				echo.%\n%
			^)%\n%
			rem ###############################################%\n%
		)%\n%
	) else (%\n%
		echo %ESC%[31mERROR:1 @ %~nx0 ^^^>dk_call2 EMPTY COMMAND%ESC%[39m%\n%
		echo.%\n%
	)%\n%
) else setlocal enableDelayedExpansion^&setlocal^&set argv=
