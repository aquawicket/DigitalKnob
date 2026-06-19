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


rem ##################################################################################
rem # dk_ascii()
rem #
rem # https://www.ascii-code.com/
rem # https://en.wikipedia.org/wiki/ASCII
rem # https://home.unicode.org
rem # https://en.wikipedia.org/wiki/Code_page_437
rem #
:Valid_Variable_Chars
setlocal DisableDelayedExpansion
setlocal EnableDelayedExpansion
   
rem NUL
rem SOH
rem STX
rem ETX
rem EQT
rem ENQ
rem ACK
rem BEL
rem BS
call :testvar A A
call :testvar B B
call :testvar C C
call :testvar D D
call :testvar E E
pause
%endfunction%


:testvar
	set %~1=%~2 && echo %~1 = '!%~1!'
%endfunction%






exit /b 0

rem	set "=ETX"
rem	set "=EQT"
rem	set "=ENQ"
rem	set "=ACK"
rem	set "=BEL"
rem	set "=BS"
rem	set "	=TAB"
rem	set "
rem =LF"
rem	set "=VT"
rem	set "=FF"
rem	set "
rem	=CR"
rem	set "=SO"
rem	set "=SI"
rem	set "=DLE"
rem	set "=DC1"
rem	set "=DC2"
rem	set "=DC3"
rem	set "=DC4"
rem	set "=NAK"
rem	set "=SYN"
rem	set "=ETB"
rem	set "=CAN"
rem	set "=EM"
rem	set "=SUB"
rem	set "=ESC"
rem	set "=FS"
rem	set "=GS"
rem	set "=RS"
rem	set "=US"
rem  set " =SP"
rem  set "!=Exclamation"
rem  set ""=Double quotes"
rem  set "#=Number sign"
rem  set "$=Dollar"
rem  set "%=Percent sign"
rem  set "&=Ampersand"
rem  set "'=Single quote"
rem  set "(=Open parenthesis"
rem  set ")=Close parenthesis"
rem  set "*=Asterisk"
rem  set "^+=Plus"
rem  set ",=Comma"
rem  set "-=minus"
rem  set ".=Period"
rem  set "/=divide"
rem  set "0=Zero"
rem  set "1=One"
rem  set "2=Two"
rem  set "3=Three"
rem  set "4=Four"
rem  set "5=Five"
rem  set "6=Six"
rem  set "7=Seven"
rem  set "8=Eight"
rem  set "9=Nine"
rem  set ":=Colon"
rem  set ";=Semicolon"
rem  set "<=Less than"
rem  set "=Equals"
rem  set ">=Greater than"
rem  set "?=Question mark"
rem  set "@=At sign"
rem  set "A=Uppercase A"
rem  set "B=Uppercase B"
rem  set "C=Uppercase C"
rem  set "D=Uppercase D"
rem  set "E=Uppercase E"
rem  set "F=Uppercase F"
rem  set "G=Uppercase G"
rem  set "H=Uppercase H"
rem  set "I=Uppercase I"
rem  set "J=Uppercase J"
rem  set "K=Uppercase K"
rem  set "L=Uppercase L"
rem  set "M=Uppercase M"
rem  set "N=Uppercase N"
rem  set "O=Uppercase O"
rem  set "P=Uppercase P"
rem  set "Q=Uppercase Q"
rem  set "R=Uppercase R"
rem  set "S=Uppercase S"
rem  set "T=Uppercase T"
rem  set "U=Uppercase U"
rem  set "V=Uppercase V"
rem  set "W=Uppercase W"
rem  set "X=Uppercase X"
rem  set "Y=Uppercase Y"
rem  set "Z=Uppercase Z"
rem  set "[=Opening bracket"
rem  set "\=Backslash"
rem  set "]=Closing bracket"
rem  set "^=Caret"
rem  set "_=Underscore"
rem  set "=Grave accent"
rem  set "a=Lowercase a"
rem  set "b=Lowercase b"
rem  set "c=Lowercase c"
rem  set "d=Lowercase d"
rem  set "e=Lowercase e"
rem  set "f=Lowercase f"
rem  set "g=Lowercase g"
rem  set "h=Lowercase h"
rem  set "i=Lowercase i"
rem  set "j=Lowercase j"
rem  set "k=Lowercase k"
rem  set "l=Lowercase l"
rem  set "m=Lowercase m"
rem  set "n=Lowercase n"
rem  set "o=Lowercase o"
rem  set "p=Lowercase p"
rem  set "q=Lowercase q"
rem  set "r=Lowercase r"
rem  set "s=Lowercase s"
rem  set "t=Lowercase t"
rem  set "u=Lowercase u"
rem  set "v=Lowercase v"
rem  set "w=Lowercase w"
rem  set "x=Lowercase x"
rem  set "y=Lowercase y"
rem  set "z=Lowercase z"
rem  set "{=Opening brace"
rem  set "|=Vertical bar"
rem  set "}=Closing brace"
rem  set "~=Equal"
rem  set "=DEL"