@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


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

set setVar=setlocal disableDelayedExpansion ^& call setVariable
::set }=^& setlocal enableDelayedExpansion

set PRINT_DE_STATUS=if "^!DE^!" equ "" (echo [32mdelayed expansion = ON[0m) else (echo [31mdelayed expansion = OFF[0m)


:main
setlocal enableDelayedExpansion
	::setlocal disableDelayedExpansion
	::call setVariable complex "^ & < > | ' ` , ; = ( ) ! \ / [ ] . * ? %"
	setlocal disableDelayedExpansion & call setVariable complex "'" "`" "(" ")" "!" "\" "/" "[" "]" "." "^" "," ";" "=" "?" "|" "<" ">" "&" "*" & setlocal enableDelayedExpansion
	::setlocal disableDelayedExpansion & call setVariable complex "' ` ( ) ! \ / [ ] . ^ , ; = ? | < > & *" & setlocal enableDelayedExpansion
	::setlocal disableDelayedExpansion & call setVariable complex "abc" "123" "x y z"  & setlocal enableDelayedExpansion
	::%setVar% complex "^ & < > | ' ` , ; = ( ) ! \ / [ ] . * ? % " %}%
	
	:: delayed expansion is lost here, use of "%var%" requires quotes
	::echo main: complex = '!complex!'
	
	:: with delayed expansion regained, no quotes are required for !var!
	::echo main: complex = '!complex!'
	
	call printVariable complex
	
%endfunction%





