@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0





::##################################################################################
::# __LINE__(frame)
::#
:__LINE__
 setlocal
	::call dk_debugFunc
	
	if not defined %1 (set "_FRAME_=0") else (set "_FRAME_=%1")
	::set /A _FRAME_+=1
::	call dk_return "%BATCH_LINENO[%_FRAME_%]%"
 endlocal
goto:eof


::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
:DKTEST
 setlocal
	::call dk_debugFunc
	
	::prepareLineNumbers
	>nul 2>nul (
	  call jrepl "(\x25#=\x25)\d*(\x25=#\x25)" "$1+ln+$2" /j /f "%~f0" /o "%~f0.new"
	  fc /b "%~f0" "%~f0.new" && del "%~f0.new" || move /y "%~f0.new" "%~f0"
	)

	echo line %#=%%=#%

	echo line %#=%%=#%

	for %%G in ( 1 2 3) DO (
	   echo Within loop iteration %%G: line %#=%%=#%
	   echo Within loop iteration %%G: line %#=%%=#%
	)
 endlocal
goto:eof
