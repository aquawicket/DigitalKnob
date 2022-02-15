:echoLine uniqueStr formatter offset -- outputs a formatted string, substitutes file name and line number
::                                   -- uniqueStr [in]     - a unique string to identify the line
::                                   -- formatter [in,opt] - a string using __FILE__ and/or __LINE__ to be substituted and echoed
::                                   -- offset    [in,opt] - offset to be added to the line number
:$reference https://www.dostips.com/forum/viewtopic.php?t=369
:$created 20080512 :$changed 20080512 :$categories Echo,Debug
:$source https://www.dostips.com
Setlocal Disabledelayedexpansion
Set "Fmt=%~2"
If Not Defined Fmt Set "Fmt=__FILE__(__LINE__): ERROR"
For /F "Delims=:" %%A In ('"Findstr /N "%~1" "%~f0""') Do Set /A "lineNr=%%A+%~30/10"
Call Set "Fmt=%%Fmt:__LINE__=%lineNr%%%"
Call Echo.%%Fmt:__FILE__=%~nx0%%
EXIT /b