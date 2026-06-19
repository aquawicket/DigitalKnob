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


rem ############################################################################
rem # dk_setEx()
rem #
rem #
:dk_setEx
	rem setlocal enableDelayedExpansion

	setlocal disableDelayedExpansion

	rem echo 1 = %~1
	rem echo 2 = %~2

	%dk_call% dk_validate findstr.exe %dk_call% dk_findFile findstr.exe
	rem echo %findstr.exe% /C:" dk_setEx %%0 %~2 " "%~1"
	for /f "usebackq tokens=* delims=" %%G in (`%findstr.exe% /C:" dk_setEx %%0 %~2 " "%~1"`) do (
		set var=%%~G
	)
	
	rem var
	echo %%var%%  = %var%
	echo.

	exit /b 0
	
	rem varA
	set varA=%var%
	echo %%varA%% = %varA%
	rem set varA=%varA:^=^^^^%
	rem set varA=%varA:!=^^^^!%

	set prefix=%varA%
	echo %%prefix%%  = %prefix%
	
	exit /b 0
	rem set prefix=%prefix:!=#%
	rem set prefix=%prefix:"=#%
	rem set prefix=%prefix:$=#%
	rem set prefix=%prefix:%%=#%
	rem set prefix=%prefix:&=#%
	rem set prefix=%prefix:)=#%
	echo %%prefix%%  = %prefix%
	
	rem dk_setEx
	rem echo %%dk_setEx%%  = %dk_setEx%
	rem echo.

	rem echo dk_setEx = %dk_setEx%
	rem dk_setEx =  %dk_call% dk_setEx %0 SETEX_VAR "value of variable"
	
	set prefix=%dk_setEx:>=#%
	rem set prefix=%prefix:&=#%
	set prefix=%prefix:)=#%
	set prefix=%prefix:|=#%
	call set prefix=%%prefix:%~2=#%%
		
	for /f "tokens=1 delims=#" %%A in ("%prefix%") do (set prefix=%%A%~2 )
	rem echo prefix = %prefix%
		
	set dk_setEx=%dk_setEx:^=^^%
	set dk_setEx=%dk_setEx:!=^^!%
	rem set dk_setEx=%dk_setEx:""="%
	call set dk_setEx=%%dk_setEx:%prefix%=%%
	%dk_call% dk_trim %dk_setEx%
	echo dk_trim = %dk_trim%


	endlocal & (
		set dk_setEx=%dk_setEx::=^:%
	)

	

	
rem	:UnEscape
rem	echo "%_args_%" | %findstr.exe% /c:"^^" >nul && (
rem		set "_args_=%_args_:^^=^%"
rem		goto :UnEscape
rem	)
rem	
rem	endlocal & (
rem		set "%~1=%_args_%"
rem	)
%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal enableDelayedExpansion


@echo off
setlocal disableDelayedExpansion
for /f "useback delims=" %%_ in (%0) do (
  if "%%_"=="___ATAD___" set $=
  if defined $ (set var=%%_)
  if "%%_"=="___DATA___" set $=1
)

rem var
echo 61 %%var%%  = %var%
echo.

rem varA
set varA=%var%
echo 66 %%varA%% = %varA%
set varA=%varA:^=^^^^%
set varA=%varA:!=^^^^!%



rem varA
rem set varB=%var%
rem echo 66 %%varB%% = %varB%
rem set varB=%varB:^=^^%

endlocal & (
	rem varA
	
rem	set varN9=%varA:^^^^^^^^^^=^%
rem	set varN8=%varA:^^^^^^^^^=^%
rem set varN7=%varA:^^^^^^^^=^%
rem	set varN6=%varA:^^^^^^^=^%
rem	set varN5=%varA:^^^^^^=^%
rem set varN4=%varA:^^^^^=^%
rem	set varN3=%varA:^^^^=^%
rem	set varN2=%varA:^^^=^%
rem set varN1=%varA:^^=^%
	set var00=%varA:^=%
	set var01=%varA:^=^% 
	set var02=%varA:^=^^%
	set var03=%varA:^=^^^%
	set var04=%varA:^=^^^^% 
	set var05=%varA:^=^^^^^%
	set var06=%varA:^=^^^^^^%
	set var07=%varA:^=^^^^^^^%
	set var08=%varA:^=^^^^^^^^%
	set var09=%varA:^=^^^^^^^^^%
	set var10=%varA:^=^^^^^^^^^^%
	
)
echo.


rem set varB=^!var01^!
set varA=^!var01^!
set myVar=^!varA^!
rem set myVar=%varB!:^^!%
rem call set myVar=%%varB:!=^^!%%
echo %%myVar%% = %myVar:!=^^!%
echo ^^!myVar^^! = !myVar! 

pause

rem echo %%var00%% = %var00% 
echo %%var01%% = %var01% 
rem echo %%var02%% = %var02%
echo %%var03%% = %var03%
rem echo %%var04%% = %var04% 
echo %%var05%% = %var05% 
rem echo %%var06%% = %var06% 
echo %%var07%% = %var07% 
rem echo %%var08%% = %var08% 
echo %%var09%% = %var09% 
rem echo %%var10%% = %var10%


echo ^^!var00^^! = !var00!
echo ^^!var01^^! = !var01!
echo ^^!var02^^! = !var02!
echo ^^!var03^^! = !var03!
echo ^^!var04^^! = !var04!
echo ^^!var05^^! = !var05!
echo ^^!var06^^! = !var06!
echo ^^!var07^^! = !var07!
echo ^^!var08^^! = !var08!
echo ^^!var09^^! = !var09!
echo ^^!var10^^! = !var10!




rem set varB=%varB:^^=%
rem echo 102 ^^!varB^^! = !varB!
rem echo 102 ^^!varC^^! = !varC!
rem echo 102 ^^!varD^^! = !varD!
rem echo 102 ^^!varE^^! = !varE!

rem set varA=%varA:&=^&%
rem echo 96 %%varA%% = %varA:!=^^!%

pause
goto :eof



:testCommand
%setlocal%
	%~1 || pause && pause
	echo errorlevel = !errorlevel!
%endfunction%

rem %varB%
rem set varB=%varB:!=^^!%
rem echo 100 ^^!varB^^! = !varB!
rem echo 101 %%varB%% = %varB:!=^^!%
rem set varB=%varB:^^^^=^%

rem echo 104 ^^!varB^^! = !varB!

rem set varB=%varB:^=^^%
rem echo 107 %%varB%% = %varB:!=^^!%

rem set varB=%varB:!=^^!%
rem echo 110 %%varB%% = %varB%



rem ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~ 
___DATA___
  ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~ 
___ATAD___


rem #
rem #


 
	rem	                 ALL: "  ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~"
	rem                 VALID: "      # $   & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~"
	%dk_call% dk_setEx myVar1 "      # $   & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~"
	rem	             INVALID: "  ! "     %                                                      "
	%dk_call% dk_echo "%%myVar1%% = %myVar1%"
	%dk_call% dk_echo "^^!myVar1^^! = !myVar1!"
	
	rem	                 ALL: " !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~"
	rem                 VALID:
	%dk_call% dk_setEx myVar2 "   #$ &'()*+,-./:;<=>?@[\]^_`{|}~"
	rem	             INVALID: " !"  %                           "
	echo "%%myVar2%%" = "%myVar2%"
	echo   ^^!myVar2^^! = '!myVar2!'
	
%endfunction%

