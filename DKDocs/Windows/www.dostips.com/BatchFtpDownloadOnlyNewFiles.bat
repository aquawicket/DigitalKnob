@Echo Off

REM -- Define File Filter, i.e. files with extension .txt
Set FindStrArgs=/E /C:".txt"

REM -- Extract Ftp Script to create List of Files
Set "FtpCommand=ls"
Call:extractFileSection "[Ftp Script 1]" "-">"%temp%\%~n0.ftp"
Rem Notepad "%temp%\%~n0.ftp"

REM -- Execute Ftp Script, collect File Names
Set "FileList="
For /F "Delims=" %%A In ('"Ftp -v -i -s:"%temp%\%~n0.ftp"|Findstr %FindStrArgs%"') Do (
    Call Set "FileList=%%FileList%% "%%A""
)

REM -- Extract Ftp Script to download files that don't exist in local folder
Set "FtpCommand=mget"
For %%A In (%FileList%) Do If Not Exist "%%~A" Call Set "FtpCommand=%%FtpCommand%% "%%~A""
Call:extractFileSection "[Ftp Script 1]" "-">"%temp%\%~n0.ftp"
Rem Notepad "%temp%\%~n0.ftp"

For %%A In (%FtpCommand%) Do Echo.%%A

REM -- Execute Ftp Script, download files
ftp -i -s:"%temp%\%~n0.ftp"
Del "%temp%\%~n0.ftp"
GOTO:EOF


:extractFileSection StartMark EndMark FileName -- extract a section of file that is defined by a start and end mark
::                  -- [IN]     StartMark - start mark, use '...:S' mark to allow variable substitution
::                  -- [IN,OPT] EndMark   - optional end mark, default is first empty line
::                  -- [IN,OPT] FileName  - optional source file, default is THIS file
:$created 20080219 :$changed 20100205 :$categories ReadFile
:$source https://www.dostips.com
SETLOCAL Disabledelayedexpansion
set "bmk=%~1"
set "emk=%~2"
set "src=%~3"
set "bExtr="
set "bSubs="
if "%src%"=="" set src=%~f0&        rem if no source file then assume THIS file
for /f "tokens=1,* delims=]" %%A in ('find /n /v "" "%src%"') do (
    if /i "%%B"=="%emk%" set "bExtr="&set "bSubs="
    if defined bExtr if defined bSubs (call echo.%%B) ELSE (echo.%%B)
    if /i "%%B"=="%bmk%"   set "bExtr=Y"
    if /i "%%B"=="%bmk%:S" set "bExtr=Y"&set "bSubs=Y"
)
EXIT /b


[Ftp Script 1]:S
!Title Connecting...
open example.com
username
password

!Title Preparing...
cd public_html/MyRemoteDirectory
lcd c:\MyLocalDirectory
binary
hash

!Title Processing... %FtpCommand%
%FtpCommand%

!Title Disconnecting...
disconnect
bye
