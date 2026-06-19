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


if not defined fileAppendString_PRINT (set "fileAppendString_PRINT=0")
rem ##################################################################################
rem # dk_fileAppendString(file, "string")
rem #
rem #		Write string to file.
rem #
:dk_fileAppendString
%setlocal%

	if "%~2" equ "" (%return%)
	
	set dk_fileAppendString=%*
	for /f "tokens=1*" %%a in ("!dk_fileAppendString!") do (
		(set dk_fileAppendString="[[[%%~b]]]\nEOF")
	)

rem ### \n (newline escape)
if not defined \n (set \n=^
%=DO NOT ALTER THIS=%
)
	(set dk_fileAppendString=%dk_fileAppendString:\n=^!\n^!%)

	for /F "tokens=1* delims==" %%i in ('set dk_fileAppendString') do (
		if "%fileAppendString_PRINT%" equ "1" (echo.)
		if "%fileAppendString_PRINT%" equ "1" (echo ########################)
		for /f "tokens=* delims=" %%z IN (%%j) DO (
			rem echo line = '%%z'
			if "!prevline!" neq "" (
				if "%%~z" neq "EOF" (
				
					rem ###  Print to console w/ newline
					if "%fileAppendString_PRINT%" equ "1" (echo.!prevline:[[[=!)
					
					rem ###  Print to file w/ newline
					>>"%~1" (echo.!prevline:[[[=!)
					
				) else (
					set "prompt=!prevline:[[[=!"
					set "prompt=!prompt:]]]=!"
					if "!prompt!" neq "" (
					
						rem ###  Print to console
						if "%fileAppendString_PRINT%" equ "1" (cmd /d /k < nul)
					
						rem ###  Print to file
						cmd /d /k < nul>> "%~1"
					)
				)
			) 
			(set prevline=%%z)
		)
		if "%fileAppendString_PRINT%" equ "1" (echo.)
		if "%fileAppendString_PRINT%" equ "1" (echo ########################)
	)
%endfunction%







rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
rem setlocal disableDelayedExpansion

	%dk_call% dk_validate DKCACHE_DIR %dk_call% dk_DKCACHE_DIR
	set "file=%DKCACHE_DIR%/dk_fileAppendString_TEST_blank.txt"
	if exist "%file%" (del "%file:/=\%")
	%dk_call% dk_fileAppendString "%file%"
	
	set "file=%DKCACHE_DIR%/dk_fileAppendString_TEST_newlineA.txt"
	%dk_call% dk_fileAppendString "%file%" "line1\nline 2\nline3\nline 4\nline5\nline 6"
	
	set "file=%DKCACHE_DIR%/dk_fileAppendString_TEST_newlineB.txt"
	%dk_call% dk_fileAppendString "%file%" " line1\n  line 2\n   line3\n    line 4\n     line5\n      line 6"
	
	set "file=%DKCACHE_DIR%/dk_fileAppendString_TEST_newlineC.txt"
	%dk_call% dk_fileAppendString "%file%" "\n line1 \n  line 2  \n   line3   \n    line 4    \n     line5     \n      line 6      \n"
exit /b 0



	if exist "%file%" (del "%file:/=\%")
	%dk_call% dk_fileAppendString "%file%" "string 1 appended with dk_fileAppendString"
	type "%file:/=\%"
	
	rem ############### Special Characters ###############
	echo.
	echo ###### echo (DisableDelayedExpansion, no quotes) ######
	setlocal DisableDelayedExpansion
		rem	CHARACTERS:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ !  ^  "  &  <  >  |  %
		rem	     VALID:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ !
		echo     VALID:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ !
		rem	   INVALID:                                                      ^  "  &  <  >  |  %
		echo   INVALID:                                                     ^^ ^" ^& ^< ^> ^| %%
		rem	       ALL:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ !  ^  "  &  <  >  |  %
		echo       ALL:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ! ^^ ^" ^& ^< ^> ^| %%
		echo     TWICE:   ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ! ^^ ^" ^& ^< ^> ^| %% ( ) # $ ' * + , - . / : ; = ? @ [ \ ] _ ` { } ~ ! ^^ ^" ^& ^< ^> ^| %%
	endlocal
	
rem	                            ALL: "  ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~"
rem						    INVALID: "  ! "     %   
rem							  VALID: "      # $   & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~"
    %dk_call% dk_fileAppendString "%file%"  "      # $   & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~"
	type "%file:/=\%"
%endfunction%