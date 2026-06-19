@echo off

call :dk_fileReplace "C:\Users\Administrator\DigitalKnob\Development\README.md"  DigitalKnob digitalknob


::###############################################################################
::# dk_fileReplace(filePath, find, replace)
::#
::#		parses a File line by line and replaces a substring
::#
::#	@filePath	- Path to the file to be altered.
::#	@find		- The string to search for in the file.
::#	@replace	- The string to replace the found string with
::#
:dk_fileReplace
setlocal enableextensions disabledelayedexpansion
	
	set "filePath=%~1"
	::set "find=%~2"
	::set "replace=%~3"
	
	>"%filePath%.new" (
	  for /f "delims=" %%i in ('findstr /n "^" "%filePath%"') do (
		  set "line=%%i"
		  setlocal enabledelayedexpansion
		  set "line=!line:*:=!"
		  if defined line set "line=!line:%~2=%~3!"
		  echo(!line!
		  endlocal
	  )
	)
	move /y "%filePath%.new" "%filePath%" >nul	
exit /b 0





