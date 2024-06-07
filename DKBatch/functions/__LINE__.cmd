@echo off
call DK





::##################################################################################
::# __LINE__(frame)
::#
:__LINE__() {
	if not defined %1 (set "_FRAME_=0") else (set "_FRAME_=%1")
	::set /A _FRAME_+=1

::	call dk_return "%BATCH_LINENO[%_FRAME_%]%"
goto:eof



:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	
	echo "$(__LINE__)"
	
	::prepareLineNumbers
>nul 2>nul (
  call jrepl "(\x25#=\x25)\d*(\x25=#\x25)" "$1+ln+$2" /j /f "%~f0" /o "%~f0.new"
  fc /b "%~f0" "%~f0.new" && del "%~f0.new" || move /y "%~f0.new" "%~f0"
)


echo line %#=%31%=#%

echo line %#=%33%=#%


for %%G in ( 1 2 3) DO (
   echo Within loop iteration %%G: line %#=%37%=#%
   echo Within loop iteration %%G: line %#=%38%=#%
)

exit /b

