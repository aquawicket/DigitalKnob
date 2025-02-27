@echo off
::### https://stackoverflow.com/a/9910946


::	%	%%	 
::	^	^^	May not always be required in doublequoted strings, but it won't hurt
::	&	^&
::	<	^<
::	>	^>
::	|	^|
::	'	^'	Required only in the FOR /F "subject" (i.e. between the parenthesis), unless backq is used
::	`	^`	Required only in the FOR /F "subject" (i.e. between the parenthesis), if backq is used
::	,	^,	Required only in the FOR /F "subject" (i.e. between the parenthesis), even in doublequoted strings
::	;	^;
::	=	^=
::	(	^(
::	)	^)
::	!	^^!	Required only when delayed variable expansion is active
::	"	""	Required only inside the search pattern of FIND
::	\	\\	Required only inside the regex pattern of FINDSTR
::	[	\[
::	]	\]
::	"	\"
::	.	\.
::	*	\*
::	?	\?


setlocal DisableDelayedExpansion
rem set /p "complex=Complex Input "
::set "complex=xx! & "!^&"ab^^ " ^^^^cd%%"
set "complex= ^ & < > | ' ` , ; = ( ) ! \ / [ ] . * ? "

setlocal EnableDelayedExpansion
call :prepareForCallBatch complex PreparedParam
echo  Sending complex string: '!PreparedParam!'

call :printVariable PreparedParam

pause
exit /b





:: Prepare special characters &|<>"^ for a batch call
:prepareForCallBatch
set "temp=!%~1!"

::set "temp=!temp:%=%%!"
::set "temp=!temp:^=^^!"
::set "temp=!temp:&=^&!"
::set "temp=!temp:|=^|!"
::set "temp=!temp:<=^<!"
::set "temp=!temp:>=^>!"
set "temp=!temp:"=""!"
::set "temp=!temp:"=!"
set "temp=!temp:"=^^"!"
set "%~2=!temp!"
exit /b


:printVariable
setlocal

echo Received complex string: '!%~1!'

exit /b