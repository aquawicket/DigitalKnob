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

rem ################################################################################
::# preserveExclamation()
::#
::#
:preserveExclamation
%setlocal%
	
	echo ^^!
	echo "^!"
	rem pause
	rem %dk_call% dk_echo abc!
	rem %dk_call% dk_echo abc^!
	rem %dk_call% dk_echo abc^^!
	rem %dk_call% dk_echo abc^^^!
	rem %dk_call% dk_echo abc^^^^!
	rem %dk_call% dk_echo abc^^^^^!
	rem %dk_call% dk_echo abc^^^^^^!
	rem %dk_call% dk_echo abc^^^^^^^!
	rem %dk_call% dk_echo abc^^^^^^^^!
	rem %dk_call% dk_echo abc^^^^^^^^^!
	pause
	%dk_call% dk_echo "!!"
	%dk_call% dk_echo "^!"
	%dk_call% dk_echo "^^!"
	%dk_call% dk_echo "^^^!"
	%dk_call% dk_echo "^^^^!"
	%dk_call% dk_echo "^^^^^!"
	%dk_call% dk_echo "^^^^^^!"
	%dk_call% dk_echo "^^^^^^^!"
	%dk_call% dk_echo "^^^^^^^^!"
	%dk_call% dk_echo "^^^^^^^^^!"
	pause
	

	if "!!" equ "" (echo DelayedExpansion ON) else (echo DelayedExpansion OFF)
	rem	set "string=^!"
	rem	echo string = %string%
	rem	echo string = !string!
	rem	echo "string = %string%"
	rem	echo "string = !string!"
	echo. 
	
	echo setlocal disableDelayedExpansion
	setlocal disableDelayedExpansion
	if "!!" equ "" (echo DelayedExpansion ON) else (echo DelayedExpansion OFF)
	echo set string=!
	set string=!
	echo string = %string%
	echo string = !string!
	echo "string = %string%"
	echo "string = !string!"
	echo. 
	
	echo endlocal
	
	rem endlocal & (set string=%string%)	
	rem endlocal & (set string=%string:!=^!%)	
	rem endlocal & (set string=%string:!=^^!%)
	rem endlocal & (set string=%string:!=^^^!%)
    rem endlocal & (set string=%string:!=^^^^!%)
	rem endlocal & (set string=%string:!=^^^^^!%)
	rem endlocal & (set string=%string:!=^^^^^^!%)
	rem endlocal & (set string=%string:!=^^^^^^^!%)     &rem *
	rem endlocal & (set string=%string:!=^^^^^^^^!%)
	rem endlocal & (set string=%string:!=^^^^^^^^^!%)
	endlocal & (set string=%string:!=^^^^^^^^^^!%)		&rem *
	rem endlocal & (set string=%string:!=^^^^^^^^^^^!%)
	rem endlocal & (set string=%string:!=^^^^^^^^^^^^!%)
	rem endlocal & (set string=%string:!=^^^^^^^^^^^^^!%)
	rem endlocal & (set string=%string:!=^^^^^^^^^^^^^^!%)
	rem endlocal & (set string=%string:!=^^^^^^^^^^^^^^^!%)
	rem endlocal & (set string=%string:!=^^^^^^^^^^^^^^^^!%)
	rem endlocal & (set string=%string:!=^^^^^^^^^^^^^^^^^!%)
	if "!!" equ "" (echo DelayedExpansion ON) else (echo DelayedExpansion OFF)
  	 echo      echo    %%string%%    =  %string%
 	 echo      echo   "%%string%%"   = "%string%"
	 echo      echo   %%%%string%%%%   =  %%string%%
	 echo      echo  "%%%%string%%%%"  = "%%string%%"
	 echo      echo  %%%%%%string%%%%%%  =  %%%string%%%
	 echo      echo "%%%%%%string%%%%%%" = "%%%string%%%"
	 echo.
	 echo      echo    ^^!string^^!    =  !string!
	 echo      echo   "^!string^!"   = "!string!"
	 echo      echo   ^^!^^!string^^!^^!   =  !!string!!
	 echo      echo  "^!^!string^!^!"  = "!!string!!"
	 echo      echo  ^^!^^!^^!string^^!^^!^^!  =  !!!string!!!
	 echo      echo "^!^!^!string^!^!^!" = "!!!string!!!"
	 echo.
	 echo      echo   ^^!%%string%%^^!   = !%string%!
	 echo      echo                      = !%%string%%!
	 echo      echo                      = !%%%string%%%!
	 echo      echo                      = !%%%%string%%%%!
	 echo      echo                      = !%%%%%string%%%%%!
	 echo      echo                      = !%%%%%%string%%%%%%!
     echo.
     echo      echo   %%^^!string^^!%%      = %!string!%
	 echo      echo  %%%%^^!string^^!%%%%   = %%!string!%% 
	 echo      echo                         = %%%!string!%%%
	 echo      echo                         = %%%%!string!%%%%
	 echo      echo                         = %%%%%!string!%%%%%
	 echo      echo                         = %%%%%%!string!%%%%%%
	 echo      echo                         = %%%%%%%!string!%%%%%%%
	 echo.
	 echo      echo                         = %!%string%!%
	 echo      echo                         = !%!string!%!
call echo call echo    %%%%string%%%%    =  %string%
call echo call echo   "%%%%string%%%%"   = "%string%"
call echo call echo   %%%%%%%%string%%%%%%%%   =  %%string%%
call echo call echo  "%%%%%%%%string%%%%%%%%"  = "%%string%%"
call echo call echo  %%%%%%%%%%%%string%%%%%%%%%%%%  =  %%%string%%%
call echo call echo "%%%%%%%%%%%%string%%%%%%%%%%%%" = "%%%string%%%"
call echo call echo    ^^!string^^!    =  !string! 
call echo call echo   "^!string^!"   = "!string!" 
call echo call echo   ^^!^^!string^^!^^!   =  !!string!! 
call echo call echo  "^!^!string^!^!"  = "!!string!!" 
	::call echo 
	echo. 
	
	echo setlocal enableDelayedExpansion
	setlocal enableDelayedExpansion
	if "!!" equ "" (echo DelayedExpansion ON) else (echo DelayedExpansion OFF)
	echo string = %string%
	echo string = !string!
	echo "string = %string%"
	echo "string = !string!"
	echo. 

	echo echo %%string%% = %string%
	echo echo ^^!string^^! = !string!
	echo echo "%%string%%" = "%string%"
	echo echo "^!string^!" = "!string!"




pause
%endfunction%