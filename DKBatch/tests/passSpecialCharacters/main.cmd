@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%" (set "DKBATCH_FUNCTIONS_DIR_=../../functions/")
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

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

(set ESC=)
(set CSI=%ESC%[)
(set clr=%CSI%0m) 
(set red=%CSI%31m)
(set green=%CSI%32m) 
set DESTATE=if "^!DE^!"=="" (echo %green%delayed expansion = ON%clr%) else (echo %red%delayed expansion = OFF%clr%)


:main
setlocal enableDelayedExpansion


	::setlocal disableDelayedExpansion
	::call setVariable complex "^ & < > | ' ` , ; = ( ) ! \ / [ ] . * ? %"
	
	%setVar% complex "^ & < > | ' ` , ; = ( ) ! \ / [ ] . * ? %" & setlocal enableDelayedExpansion
	
	:: delayed expansion is lost here, use of "%var%" requires quotes 
	echo main: complex = "%complex%"
	
	echo main: complex = '!complex!'
	
	:: with delayed expansion regained, no quotes are required for !var!
	setlocal enableDelayedExpansion
	echo main: complex = '!complex!'
	
	call printVariable complex
	
	echo:
	echo:
	%DESTATE%

	setlocal disableDelayedExpansion
	call setVariableB complexB "^ & < > | ' ` , ; = ( ) ! \ / [ ] . * ? %"
	
	%DESTATE%

	echo main: complexB = "%complexB%"
	echo main: complexB = '!complexB!'
	pause
%endfunction%





