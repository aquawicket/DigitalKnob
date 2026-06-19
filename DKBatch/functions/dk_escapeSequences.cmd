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

rem ASCII Table - https://www.ascii-code.com
rem ANSI Escape Sequences - https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797
rem Escape Characters - https://www.robvanderwoude.com/escapechars.php
rem ##################################################################################
rem # dk_escapeSequences()
rem #
rem #
:dk_escapeSequences
%setlocal%

rem  set ASCII_length=0
    rem ASCII control characters (character code 0-31)
    rem                  SYMBOL  DEC     OCT     HEX     HTML    Description
rem  call:ASCII_ADD      NUL     0       000     0x00    #00     "Null character"
rem  call:ASCII_ADD      SOH     1       001     0x01    #01     "Start of Heading"
rem  call:ASCII_ADD      STX     2       002     0x02    #02     "Start of Text"
rem  call:ASCII_ADD      ETX     3       003     0x03    #03     "End of Text"
rem  call:ASCII_ADD      EOT     4       004     0x04    #04     "End of Transmission"
rem  call:ASCII_ADD      ENQ     5       005     0x05    #05     "Enquiry"
rem  call:ASCII_ADD      ACK     6       006     0x06    #06     "Acknowledge"
rem  call:ASCII_ADD      BEL     7       007     0x07    #07     "Bell, Alert"
rem  call:ASCII_ADD      BS      8       010     0x08    #08     "Backspace"
rem  call:ASCII_ADD      HT      9       011     0x09    #09     "Horizontal Tab"
rem  call:ASCII_ADD      LF      10      012     0x0a    #10     "Line Feed"
rem  call:ASCII_ADD      VT      11      013     0x0b    #11     "Vertical Tabulation"
rem  call:ASCII_ADD      FF      12      014     0x0c    #12     "Form Feed"
rem  call:ASCII_ADD      CR      13      015     0x0d    #13     "Carriage Return"
rem  call:ASCII_ADD      SO      14      016     0x0e    #14     "Shift Out"
rem  call:ASCII_ADD      SI      15      017     0x0f    #15     "Shift In"
rem  call:ASCII_ADD      DLE     16      020     0x10    #16     "Data Link Escape"
rem  call:ASCII_ADD      DC1     17      021     0x11    #17     "Device Control One (XON)"
rem  call:ASCII_ADD      DC2     18      022     0x12    #18     "Device Control Two"
rem  call:ASCII_ADD      DC3     19      023     0x13    #19     "Device Control Three (XOFF)"
rem  call:ASCII_ADD      DC4     20      024     0x14    #20     "Device Control Four"
rem  call:ASCII_ADD      NAK     21      025     0x15    #21     "Negative Acknowledge"
rem  call:ASCII_ADD      SYN     22      026     0x16    #22     "Synchronous Idle"
rem  call:ASCII_ADD      ETB     23      027     0x17    #23     "End of Transmission Block"
rem  call:ASCII_ADD      CAN     24      030     0x18    #24     "Cancel"
rem  call:ASCII_ADD      EM      25      031     0x19    #25     "End of medium"
rem  call:ASCII_ADD      SUB     26      032     0x1a    #26     "Substitute"
rem  call:ASCII_ADD      ESC     27      033     0x1b    #27     "Escape"
rem  call:ASCII_ADD      FS      28      034     0x1c    #28     "File Separator"
rem  call:ASCII_ADD      GS      29      035     0x1d    #29     "Group Separator"
rem  call:ASCII_ADD      RS      30      036     0x1e    #30     "Record Separator"
rem  call:ASCII_ADD      US      31      037     0x1f    #31     "Unit Separator"

    rem :ASCII_length_Loop
    rem if defined ASCII[%ASCII_length%] (
    rem  set /a ASCII_length+=1
    rem  goto ASCII_length_Loop
    rem )
   
rem  %dk_call% dk_echo
rem  echo        SYMBOL  DEC OCT HEX HTML    Description
rem  for /L %%i IN (0,1,%ASCII_length%) DO (
rem      call:ASCII_SHOW %%i
rem  )
rem  %dk_call% dk_echo


    rem %dk_call% dk_hexToVariable NUL 0x00
    rem %dk_call% dk_hexToVariable SOH 0x01
    rem %dk_call% dk_hexToVariable STX 0x02
    rem %dk_call% dk_hexToVariable ETX 0x03
    rem %dk_call% dk_hexToVariable EOT 0x04
    rem %dk_call% dk_hexToVariable ENQ 0x05
    rem %dk_call% dk_hexToVariable ACK 0x06
    rem %dk_call% dk_hexToVariable BEL 0x07
    rem %dk_call% dk_hexToVariable BS  0x08
    rem %dk_call% dk_hexToVariable TAB 0x09
    rem %dk_call% dk_hexToVariable LF  0x0a
    rem %dk_call% dk_hexToVariable VT  0x0b
    rem %dk_call% dk_hexToVariable FF  0x0c
    rem %dk_call% dk_hexToVariable CR  0x0d
    rem %dk_call% dk_hexToVariable SO  0x0e
    rem %dk_call% dk_hexToVariable SI  0x0f
    rem %dk_call% dk_hexToVariable DLE 0x10
    rem %dk_call% dk_hexToVariable DC1 0x11
    rem %dk_call% dk_hexToVariable DC2 0x12
    rem %dk_call% dk_hexToVariable DC3 0x13
    rem %dk_call% dk_hexToVariable DC4 0x14
    rem %dk_call% dk_hexToVariable NAK 0x15
    rem %dk_call% dk_hexToVariable SYN 0x16
    rem %dk_call% dk_hexToVariable ETB 0x17
    rem %dk_call% dk_hexToVariable CAN 0x18
    rem %dk_call% dk_hexToVariable EM  0x19
    rem %dk_call% dk_hexToVariable SUB 0x1a
    %dk_call% dk_hexToVariable ESC 0x1b
    rem %dk_call% dk_hexToVariable FS  0x1c
    rem %dk_call% dk_hexToVariable GS  0x1d
    rem %dk_call% dk_hexToVariable RS  0x1e
    rem %dk_call% dk_hexToVariable US  0x1f

    rem %dk_call% dk_decimalToVariable NUL 0
    rem %dk_call% dk_decimalToVariable SOH 1
    rem %dk_call% dk_decimalToVariable STX 2
    rem %dk_call% dk_decimalToVariable ETX 3
    rem %dk_call% dk_decimalToVariable EOT 4
    rem %dk_call% dk_decimalToVariable ENQ 5
    rem %dk_call% dk_decimalToVariable ACK 6
    rem %dk_call% dk_decimalToVariable BEL 7
    rem %dk_call% dk_decimalToVariable BS  8
    rem %dk_call% dk_decimalToVariable TAB 9
    rem %dk_call% dk_decimalToVariable LF  10
    rem %dk_call% dk_decimalToVariable VT  11
    rem %dk_call% dk_decimalToVariable FF  12
    rem %dk_call% dk_decimalToVariable CR  13
    rem %dk_call% dk_decimalToVariable SO  14
    rem %dk_call% dk_decimalToVariable SI  15
    rem %dk_call% dk_decimalToVariable DLE 16
    rem %dk_call% dk_decimalToVariable DC1 17
    rem %dk_call% dk_decimalToVariable DC2 18
    rem %dk_call% dk_decimalToVariable DC3 19
    rem %dk_call% dk_decimalToVariable DC4 20
    rem %dk_call% dk_decimalToVariable NAK 21
    rem %dk_call% dk_decimalToVariable SYN 22
    rem %dk_call% dk_decimalToVariable ETB 23
    rem %dk_call% dk_decimalToVariable CAN 24
    rem %dk_call% dk_decimalToVariable EM  25
    rem %dk_call% dk_decimalToVariable SUB 26
    rem %dk_call% dk_decimalToVariable ESC 27
    rem %dk_call% dk_decimalToVariable FS  28
    rem %dk_call% dk_decimalToVariable GS  29
    rem %dk_call% dk_decimalToVariable RS  30
    rem %dk_call% dk_decimalToVariable US  31

	rem ####### General ASCII Codes ######
	set "BEL=?"		&rem Terminal bell
	set "BS=?"  	&rem Backspace
	set "HT=?"		&rem Horizontal TAB
	set "LF=?"		&rem Linefeed (newline)
	set "VT=?"		&rem Vertical TAB
	set "FF=?"		&rem Formfeed (also: New page NP)
	set "CR=?"		&rem Carriage return
	set "ESC=?"		&rem Escape character
	set "DEL=?"		&rem Delete character
    
	set "clear=%ESC%[2J"				&rem 	erase entire screen
%endfunction%

:ASCII_ADD
%setlocal%

    if "%~1" equ "" %dk_call% dk_error "%__FUNCTION__%(): argument 1 is invalid"
    if "%~2" equ "" %dk_call% dk_error "%__FUNCTION__%(): argument 2 is invalid"
    if "%~3" equ "" %dk_call% dk_error "%__FUNCTION__%(): argument 3 is invalid"
    if "%~4" equ "" %dk_call% dk_error "%__FUNCTION__%(): argument 4 is invalid"
    if "%~5" equ "" %dk_call% dk_error "%__FUNCTION__%(): argument 5 is invalid"
    if "%~6" equ "" %dk_call% dk_error "%__FUNCTION__%(): argument 6 is invalid"
    if "%~7" neq "" %dk_call% dk_error "%__FUNCTION__%(): too many arguments"
   
    rem %dk_call% dk_debug "ASCII_ADD (%*"
    rem %dk_call% dk_debug "echo %~1  %~2     %~3     %~4     %~5     %~6"
    set ID=%~2
    set ASCII[%ID%].SYMBOL=%~1
    set ASCII[%ID%].DEC=%~2
    set ASCII[%ID%].OCT=%~3
    set ASCII[%ID%].HEX=%~4
    set ASCII[%ID%].HTML=%~5
    set ASCII[%ID%].INFO=%6
   
    set /a ASCII_length+=1
%endfunction%

:ASCII_SHOW
%setlocal%

    %dk_call% dk_info "%%ASCII[%~1].DEC%%   %%ASCII[%~1].SYMBOL%%   %%ASCII[%~1].DEC%%  %%ASCII[%~1].OCT%%  %%ASCII[%~1].HEX%%  %%ASCII[%~1].HTML%% %%ASCII[%~1].INFO%%"
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_escapeSequences
%endfunction%
