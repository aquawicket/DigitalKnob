@Echo off
cls
setlocal DisableDelayedExpansion
set LF=^


::Above 2 blank lines are required - do not remove
set ^"\n=^^^%LF%%LF%^%LF%%LF%^^"

set _macrofunc=for /L %%n in (1 1 2) do if %%n==2 (		%\n%
      for /F "tokens=2 delims=, " %%G in ("!argv!") do (%\n%
		 set "argv1=%%G"								%\n%
		 set "argv2=%%H"								%\n%
      ) 												%\n%
	  echo !argv1!										%\n%
	  echo !argv2!										%\n%
) ELSE setlocal enableDelayedExpansion ^& set argv=,



%_macrofunc% A B
pause