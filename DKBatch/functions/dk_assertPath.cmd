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
rem # dk_assertPath(path)
rem #
rem # Throw assertion if argument is NOT a valid, existing file or directory
rem #
:dk_assertPath
	if NOT defined dk_assertPath_FORWARD_SLASHES (set "dk_assertPath_FORWARD_SLASHES=1")
	if NOT defined dk_assertPath_CASE_SENSITIVE (set "dk_assertPath_CASE_SENSITIVE=1")
	rem if NOT defined dk_assertPath_DEBUG (set "dk_assertPath_DEBUG=0")
%setlocal%
rem	(set _value_=%*)
rem	(set _varname_=%_value_%)
rem	(set _varname_=%_varname_:(=%)
rem	(set _varname_=%_varname_:)=%)
rem	(set _varname_=%_varname_:"=%)
rem	(set _varname_=%_varname_: =%)
rem	if defined %_varname_% (set _value_="!%_varname_:"=%!") else (set "_varname_=path")
rem	set _value_="%_value_:"=%"

    echo %1| find.exe """%~1""" >nul 2>nul || (
        if NOT DEFINED %1 (
                %dk_call% dk_error "%red% path variables require quotes %clr%" & %return%
            )
        )
    )

	if defined %1 (
        set "_varname_=%~1"
        set "_value_=!%~1!"
    ) else (
        set "_varname_=noname"
        set "_value_=%~1"
    )

    for %%G in ("%_value_:"=%") do set "_real_=%%~G"
    
	if "%dk_assertPath_FORWARD_SLASHES%" equ "1" (
         if "%_value_%" neq "%_value_:\=/%" (
            %dk_call% dk_error "%red% %_varname_%-%_value_% invalid use of backslashes %clr%" & %return%
        )
        set "_real_=%_real_:\=/%"
	)
    
    rem ### character mismatch
    if /i "%_value_%" neq "%_real_%" (
			%dk_call% dk_error "%red% '%_value_%':'%_real_%' mismatched characters %clr%" & %return%
	)
		
	rem ### Test case sensitive ###
	if "%dk_assertPath_CASE_SENSITIVE%" equ "1" (
		if "%_value_%" neq "%_real_%" (
			%dk_call% dk_error "%red% '%_value_%':'%_real_%' Case sensitive mismatch %clr%" & %return%
		)
	)

	rem ### Test path exists ###
	if NOT EXIST "%_value_%" (
        %dk_call% dk_error "ASSERTION: dk_assertPath %_varname_%:'%_value_%' NOT found" & %return%
    )

	if "%dk_assertPath_DEBUG%" equ "1" (%dk_call% dk_debug "dk_assertPath %_varname_% = '%_value_%'")
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	rem ###### THESE SHOULD ALL BE FOUND ######
  
	rem ### Quoted ###
	%dk_call% dk_assertPath "%SystemDrive%/"							
	rem # existing path w/ foward slashes
	%dk_call% dk_assertPath "%SystemDrive%/Program Files"				
	rem # existing path w/ trailing forwardslash
	%dk_call% dk_assertPath "%SystemDrive%/Program Files/"			
	rem # existing lower case path
    %dk_call% dk_assertPath "%SystemDrive%/program files"			&rem Case mismatch
	rem # existing UPPER CASE path
	%dk_call% dk_assertPath "%SystemDrive%/PROGRAM FILES"			&rem Case mismatch
	rem # windows path
	%dk_call% dk_assertPath "%SystemDrive%\Program Files"			&rem Delimiter mismatch
	rem # existing path w/ trailing backslash
	%dk_call% dk_assertPath "%SystemDrive%\Program Files\"			&rem Delimiter mismatch
	rem # existing path w/ mixed slashes
	%dk_call% dk_assertPath "%SystemDrive%/Program Files"			&rem Delimiter mismatch
	rem # existing path w/ double forwardslashes
	%dk_call% dk_assertPath "%SystemDrive%//Program Files/"			&rem Delimiter mismatch
	rem # existing path w/ double backslashes
	%dk_call% dk_assertPath "%SystemDrive%\\Program Files\"			&rem Delimiter mismatch

	rem ### Quoted w/ special characters  i.e. ( and )
	rem # foward slashes w/ special characters
    %dk_call% dk_assertPath "%SystemDrive%/Program Files (x86)"
	rem # trailing forwardslash w/ special characters
	%dk_call% dk_assertPath "%SystemDrive%/Program Files (x86)/"
	rem # lower case w/ special characters
    %dk_call% dk_assertPath "%SystemDrive%/program files (x86)"		&rem Case mismatch
	rem # UPPER CASE w/ special characters
    %dk_call% dk_assertPath "%SystemDrive%/PROGRAM FILES (X86)"		&rem Case mismatch
	rem # windows path w/ special characters
    %dk_call% dk_assertPath "%SystemDrive%\Program Files (x86)"		&rem Delimiter mismatch
	rem # trailing backslash w/ special characters
	%dk_call% dk_assertPath "%SystemDrive%\Program Files (x86)\"	&rem Delimiter mismatch
	rem # existing path w/ mixed slashes
	%dk_call% dk_assertPath "%SystemDrive%/Program Files (x86)"		&rem Delimiter mismatch
	rem # existing path w/ double forwardslashes
	%dk_call% dk_assertPath "%SystemDrive%//Program Files (x86)/"	&rem Delimiter mismatch
	rem # existing path w/ double backslashes
	%dk_call% dk_assertPath "%SystemDrive%\\Program Files (x86)\"	&rem Delimiter mismatch

	rem ### Unquotes ###
	rem # foward slashes
	%dk_call% dk_assertPath %SystemDrive%/Program Files				
	rem # trailing forwardslash
	%dk_call% dk_assertPath %SystemDrive%/Program Files/				
	rem # lower case
	%dk_call% dk_assertPath %SystemDrive%/program files				&rem Case mismatch
	rem # UPPER CASE
	%dk_call% dk_assertPath %SystemDrive%/PROGRAM FILES				&rem Case mismatch
	rem # windows path
	%dk_call% dk_assertPath %SystemDrive%\Program Files				&rem Delimiter mismatch
	rem # trailing backslash
	%dk_call% dk_assertPath %SystemDrive%\Program Files\			&rem Delimiter mismatch
	rem # existing path w/ mixed slashes
	%dk_call% dk_assertPath %SystemDrive%/Program Files				&rem Delimiter mismatch
	rem # existing path w/ double forwardslashes
	%dk_call% dk_assertPath %SystemDrive%//Program Files/			&rem Delimiter mismatch
	rem # existing path w/ double backslashes
	%dk_call% dk_assertPath %SystemDrive%\\Program Files\			&rem Delimiter mismatch

	rem ### as variable ###
	set "myPath=%SystemDrive%/Program Files"
	rem # As a variable name
	%dk_call% dk_assertPath myPath										
	rem # As a variable name quoted
	%dk_call% dk_assertPath "myPath"									
	rem # as Variable quoted
	%dk_call% dk_assertPath "%myPath%"									
	rem # As a variable using !_! quoted
	%dk_call% dk_assertPath "!myPath!"																

	rem ### as variable w/ special characters  i.e. ( and ) ###
	set "myPath=%SystemDrive%/Program Files (x86)"
	rem # As a variable name
    %dk_call% dk_assertPath myPath										
	rem # As a quoted variable name
    %dk_call% dk_assertPath "myPath"									
	rem # as a ariable using %'s quoted
    %dk_call% dk_assertPath "%myPath%"									
	rem # As a variable using !'s quoted
    %dk_call% dk_assertPath "!myPath!"									
								

	rem ### Unquotes w/ special characters  i.e. ( and )
	rem # foward slashes
rem	%dk_call% dk_assertPath %SystemDrive%/Program Files (x86)		
	rem # trailing forwardslash
    %dk_call% dk_assertPath %SystemDrive%/Program Files (x86)/	    
	rem # lower case
rem	%dk_call% dk_assertPath %SystemDrive%/program files (x86)		
	rem # UPPER CASE
rem	%dk_call% dk_assertPath %SystemDrive%/PROGRAM FILES (X86)		
	rem # windows path
rem	%dk_call% dk_assertPath %SystemDrive%\Program Files (x86)		
	rem # trailing backslash
rem	%dk_call% dk_assertPath %SystemDrive%\Program Files (x86)\	  
	
	rem ### quotes w/ special characters  i.e. ( and )
	rem # foward slashes
	%dk_call% dk_assertPath "%SystemDrive%/Program Files (x86)"		
	rem # trailing forwardslash
	%dk_call% dk_assertPath "%SystemDrive%/Program Files (x86)/"	    
	rem # lower case
	%dk_call% dk_assertPath "%SystemDrive%/program files (x86)"		
	rem # UPPER CASE
	%dk_call% dk_assertPath "%SystemDrive%/PROGRAM FILES (X86)"		
	rem # windows path
	%dk_call% dk_assertPath "%SystemDrive%\Program Files (x86)"		
	rem # trailing backslash
	%dk_call% dk_assertPath "%SystemDrive%\Program Files (x86)\"	  

	rem ###### THESE SHOULD ALL BE (NOT FOUND) ######
	rem # nonexistent path
	%dk_call% dk_assertPath "%SystemDrive%/NonExistent (x86)"			&rem ASSERT
	rem # nonexistent lower case path
	%dk_call% dk_assertPath "%SystemDrive%/NonExistent (x86)"			&rem ASSERT
	rem # nonexistent UPPER CASE path
	%dk_call% dk_assertPath "%SystemDrive%/NonExistent (x86)"			&rem ASSERT
	rem # nonexistent windows path
    %dk_call% dk_assertPath "%SystemDrive%\NonExistent (x86)"			&rem ASSERT
	rem # nonexistent No quotes path
	%dk_call% dk_assertPath %SystemDrive%/NonExistent (x86) 		

%endfunction%
