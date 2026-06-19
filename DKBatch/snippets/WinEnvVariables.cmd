@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


echo #### Windows Environment Variables ####
set

::echo ALLUSERSPROFILE = %ALLUSERSPROFILE%
::echo APPDATA = %APPDATA%
::echo CommonProgramFiles = %CommonProgramFiles%
::echo CommonProgramFiles(x86) = %CommonProgramFiles(x86)%
::echo CommonProgramW6432 = %CommonProgramW6432%
::echo COMPUTERNAME = %COMPUTERNAME%
::echo ComSpec = %ComSpec%
::echo DEFLOGDIR = %DEFLOGDIR%
::echo FP_NO_HOST_CHECK = %FP_NO_HOST_CHECK%
::echo HOMEDRIVE = %HOMEDRIVE%
::echo HOMEPATH = %HOMEPATH%
::echo LOCALAPPDATA = %LOCALAPPDATA%
::echo LOGONSERVER = %LOGONSERVER%
::echo NUMBER_OF_PROCESSORS = %NUMBER_OF_PROCESSORS%
::echo OS = %OS%
::echo Path = %Path%
::echo PATHEXT = %PATHEXT%
::echo PROCESSOR_ARCHITECTURE = %PROCESSOR_ARCHITECTURE%
::echo PROCESSOR_IDENTIFIER = %PROCESSOR_IDENTIFIER%
::echo PROCESSOR_LEVEL = %PROCESSOR_LEVEL%
::echo PROCESSOR_REVISION = %PROCESSOR_REVISION%
::echo ProgramData = %ProgramData%
::echo ProgramFiles = %ProgramFiles%
::echo ProgramFiles(x86) = %ProgramFiles(x86)%
::echo ProgramW6432 = %ProgramW6432%
::echo PROMPT = %PROMPT%
::echo PSModulePath = %PSModulePath%
::echo PUBLIC = %PUBLIC%
::echo SESSIONNAME = %SESSIONNAME%
::echo SystemDrive = %SystemDrive%
::echo SystemRoot = %SystemRoot%
::echo TEMP = %TEMP%
::echo USERDNSDOMAIN = %USERDNSDOMAIN%
::echo USERDOMAIN = %USERDOMAIN%
::echo USERNAME = %USERNAME%
::echo userpath = %userpath%
::echo USERPROFILE = %USERPROFILE%
::echo VSEDEFLOGDIR = %VSEDEFLOGDIR%
::echo windir = %windir%
