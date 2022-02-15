%dkbatch%

echo ################################
echo ##      TESTING Errors        ##
echo ################################
set ERRORLEVEL=0
%IF_ERROR% "IF_ERROR: This throws an error if ERRLVL is not 0, and continues"
echo:
	
set ERRORLEVEL=1
%IF_ERROR% "IF_ERROR: This throws an error if ERRLVL is not 0, and continues"
echo: 

%ERROR% "ERROR: This throws an error, and continues"
echo:

set ERRORLEVEL=0
%IF_FATAL% "IF_FATAL: This will be skipped since ERRORLEVEL = 0"
echo IF_FATAL was called but skipped since ERRORLEVEL = 0
echo:
	
echo Setting ERRORLEVEL to 1 and calling IF_FATAL again.
echo.
set ERRORLEVEL=1
%IF_FATAL% "IF_FATAL: This thows an error if ERRLVL is not 0, and exits the program"
echo:

echo This will never be reached since the IF_FATAL above exits the program
%FATAL% "FATAL: This throws an error, and exits the program"
echo:

 
%DKEND% 
