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

set "ARGV0=%~0"
echo ARGV0 = '%ARGV0%'
set "ARGV=%*"
echo ARGV = '%ARGV%'
set "ARGV1=%~1"
echo ARGV1 = '%ARGV1%'
for %%G in ("%ARGV1%") do (
	set "ARGV1_f=%%~fG"
	echo ARGV1_f = '!ARGV1_f!'
	set "ARGV1_d=%%~dG"
	echo ARGV1_d = '!ARGV1_d!'
	set "ARGV1_p=%%~pG"
	echo ARGV1_p = '!ARGV1_p!'
	set "ARGV1_n=%%~nG"
	echo ARGV1_n = '!ARGV1_n!'
	set "ARGV1_x=%%~xG"
	echo ARGV1_x = '!ARGV1_x!'
	set "ARGV1_z=%%~zG"
	echo ARGV1_z = '!ARGV1_z!'
	set "ARGV1_a=%%~aG"
	echo ARGV1_a = '!ARGV1_a!'
	set "ARGV1_t=%%~tG"
	echo ARGV1_t = '!ARGV1_t!'
	set "ARGV1_$PATH=%%~$PATH:G"
	echo ARGV1_$PATH = '!ARGV1_$PATH!'
)
echo PATH = %PATH%

rem ### call :extension
rem # .asm .bash .bat .c .cmake .cmd .cpp .cs .hta .htm .html .java .js .mhtml .php .pl .ps1 .py .sh .vbs
call :%ARGV1_x%


::if NOT DEFINED %ARGV1_x% (echo ERROR: %ARGV1_x%:'!%ARGV1_x%!' UNDEFINED & exit /b 1)

rem ### call :Execute
call :Execute




rem ############ .asm ############
:.asm
	if not defined todo.exe (set "todo.exe=%SystemRoot:\=/%/System32/todo.exe")
	if not defined .asm (set ".asm="!todo.exe:/=\!"")
exit /b %errorlevel%


rem ############ .bash ############
:.bash
	if not defined bash.exe (set "bash.exe=%USERPROFILE:\=/%/Digital Knob/DKTools/git-portable-2.46.2-64-bit/bin/bash.exe")
	if not defined .bash (set ".bash="!bash.exe:/=\!"")
exit /b %errorlevel%


rem ############ .bat ############
:.bat
	if not defined cmd.exe (set "cmd.exe=%ComSpec%")
	if not defined .bat (set ".bat="!cmd.exe:/=\!" /c")
exit /b %errorlevel%


rem ############ .c ############
:.c
	if not defined todo.exe (set "todo.exe=%SystemRoot:\=/%/System32/todo.exe")
	if not defined .c (set ".c="!todo.exe:/=\!"")
exit /b %errorlevel%


rem ############ .cmake ############
:.cmake
	set "DKSCRIPT_PATH=%ARGV1:\=/%"
	if not defined .cmake (set .cmake=%dk_call% cmake.exe -P)
	set ARGV=%ARGV:/=\%
exit /b %errorlevel%


rem ############ .cmd ############
:.cmd
	if not defined cmd.exe (set "cmd.exe=%ComSpec%")
	if not defined .cmd (set ".cmd="!cmd.exe:/=\!"")
exit /b %errorlevel%


rem ############ .cpp ############
:.cpp
	if not defined cpp.exe (set "cpp.exe=%SystemRoot:\=/%/System32/cpp.exe")
	if not defined .cpp (set ".cpp="!cs.exe:/=\!"")
exit /b %errorlevel%


rem ############ .cs ############
:.cs
	for /r "%SystemRoot:\=/%/Microsoft.NET/Framework/" %%# in ("*csc.exe") do (set "csc.exe=%%#")
	if not exist "!csc.exe!" (echo ERROR: csc.exe:'!csc.exe!' NOT FOUND & exit /b 1)

	set "DKCSharp_FILE=%ARGV%"
	if NOT defined DKCSharp_FILE (echo ERROR: DKCSharp_FILE is invalid & exit /b 1)
 	
	:: get the app name
	for %%Z in ("%DKCSharp_FILE%") do (set "APP=%%~nZ")
    
	::###### Compile Code ######
	echo compiling ...
	if EXIST "%APP%.exe" (del %APP%.exe)
	%csc.exe:/=\%" /nologo /out:"%APP%.exe" "%USERPROFILE%\Digital Knob\Development\DKCSharp\functions\DK.cs"
    
	if NOT EXIST "%APP%.exe" (
		echo ERROR: compilation of "%DKCSharp_FILE%" failed.
		exit /b 1
	)

	set "ARGV="%APP%.exe"
exit /b %errorlevel%


rem ############ .hta ############
:.hta
	if not defined .hta (
		if not exist "%mshta.exe%" (%dk_call% dk_findFile "mshta.exe")
		if exist "!mshta.exe!" (set ".hta="!mshta.exe:/=\!"")
	)
exit /b %errorlevel%


rem ############ .htm ############
:.htm
	if not defined .html (
		%dk_call% dk_validate DKTOOLS_DIR  %dk_call% dk_DKTOOLS_DIR
		if not exist "%opera.exe%" (%dk_call% dk_findFile "opera.exe" "!DKTOOLS_DIR!")
		if exist !opera.exe! (set ".html="!opera.exe:/=\!"")
	)
exit /b %errorlevel%


rem ############ .html ############
:.html
	if not defined .html (
		%dk_call% dk_validate DKTOOLS_DIR  %dk_call% dk_DKTOOLS_DIR
		if not exist "%opera.exe%" (%dk_call% dk_findFile "opera.exe" "!DKTOOLS_DIR!")
		if exist !opera.exe! (set ".html="!opera.exe:/=\!"")
	)	
exit /b %errorlevel%


rem ############ .java ############
:.java
	if not defined .java (
		if not exist "%java.exe%" (%dk_call% dk_findFile "java.exe")
		if exist "!java.exe! (set ".java="!java.exe:/=\!"")
	)
exit /b %errorlevel%


rem ############ .js ############
:.js
:.jse
	if not defined .js (
		if not exist "!cscript.exe!" (%dk_call% dk_findFile "cscript.exe" "%SystemRoot%")
		if not exist "!wscript.exe!" (%dk_call% dk_findFile "wscript.exe" "%SystemRoot%")
		if exist "!cscript.exe!" (
			set ".js="!cscript.exe:/=\!" //D //E:JScript //X //NoLogo "%USERPROFILE%\Digital Knob\Development\DKJavascript\functions\DK.js""
		) else if exist "!wscript.exe!" (
			set ".js="!wscript.exe:/=\!" //D //E:JScript //X //NoLogo "%USERPROFILE%\Digital Knob\Development\DKJavascript\functions\DK.js""
		)
		set "ARGV=!ARGV:\=/!"
	)
exit /b %errorlevel%


rem ############ .mhtml ############
:.mhtml
  if not defined chrome.exe (set "chrome.exe=%ProgramFiles:\=/%/chrome/chrome.exe")
  if not defined .mhtml (set ".mhtml="!chrome.exe:/=\!"")
exit /b %errorlevel%


rem ############ .php ############
:.php
  %dk_call% dk_validate php_exe   %dk_call% dk_depend php-src
  if not defined .php (set ".php="!php_exe:/=\!"")
exit /b %errorlevel%


rem ############ .pl ############
:.pl
  if not defined perl.exe (set "perl.exe=perl.exe")
  if not defined .pl (set ".pl="!perl.exe:/=\!"")
exit /b %errorlevel%


rem ############ .ps1 ############
:.ps1
  if not exist "%powershell_exe%" (set "powershell_exe=%USERPROFILE:\=/%/Digital Knob/DKTools/pwsh-powershell-7.2.19-win-x64/pwsh.exe")
rem  if not exist "%powershell_exe%" (set "powershell_exe=powershell.exe")
  if not defined .ps1 (set ".ps1="!powershell_exe:/=\!"")
exit /b %errorlevel%


rem ############ .py ############
:.py
  if not defined python_exe (
      rem %dk_call% dk_validate python3 %dk_call% dk_depend python3
      call "%USERPROFILE%\Digital Knob\Development\3rdParty\_DKIMPORTS\python3\DKINSTALL.cmd"
  )
  echo python3 = !python3!
  echo python_exe = !python_exe!
  if not defined .py (set ".py="!python_exe:/=\!"")
exit /b %errorlevel%


rem ############ .sh ############
:.sh
  if not defined sh.exe (set "sh.exe=%USERPROFILE:\=/%/Digital Knob/DKTools/git-portable-2.46.2-64-bit/bin/sh.exe")
  if not defined .sh (set ".sh="!sh.exe:/=\!"")
exit /b %errorlevel%


rem ############ .vbs ############
:.vbs
:.vbe
	if not defined .vbs (
		if not exist "!cscript.exe!" (%dk_call% dk_findFile "cscript.exe" "%SystemRoot%")
		if not exist "!wscript.exe!" (%dk_call% dk_findFile "wscript.exe" "%SystemRoot%")
		if exist "!cscript.exe!" (set ".vbs="!cscript.exe:/=\!" //D //E:VBScript //X //NoLogo")
		if exist "!wscript.exe!" (set ".vbs="!wscript.exe:/=\!" //D //E:VBScript //X //NoLogo")
		set "ARGV=!ARGV:\=/!"
	)
exit /b %errorlevel%


rem ############ .wfs ############
:.wfs
	rem TODO
exit /b %errorlevel%


rem ############ Execute File ############
:Execute
	echo.
	echo ##########################################
	title %ARGV1_n%
	rem # NOTE: (start "" /b /wait) is required for terminal colors to work
	!%ARGV1_x%! %ARGV% && (
		echo. & echo RETURN:true:!errorlevel! 
	) || (
		echo. & echo RETURN:false:!errorlevel!
	)
	echo ##########################################
	pause
exit /b %errorlevel%
	