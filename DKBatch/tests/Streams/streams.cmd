::#  https://www.robvanderwoude.com/redirection.php
::# 
::#		command 	> file				Write standard output of command to file
::#		command 	1> file				Write standard output of command to file (same as previous)
::#		command 	2> file				Write standard error of command to file (OS/2 and NT)
::#		command 	> file 2>&1			Write both standard output and standard error of command to file (OS/2 and NT)
::#		command 	>> file				Append standard output of command to file
::#		command 	1>> file			Append standard output of command to file (same as previous)
::#		command 	2>> file			Append standard error of command to file (OS/2 and NT)
::#		command 	>> file 2>&1		Append both standard output and standard error of command to file (OS/2 and NT)
::#		commandA	| commandB			Redirect standard output of commandA to standard input of commandB
::#		commandA	2>&1 | commandB		Redirect standard output and standard error of commandA to standard input of commandB (OS/2 and NT)
::#		command 	< file				command gets standard input from file
::#		command 	2>&1				command's standard error is redirected to standard output (OS/2 and NT)
::#		command 	1>&2				command's standard output is redirected to standard error (OS/2 and NT)




@ECHO OFF
ECHO This text goes to Standard Output
ECHO This text goes to Standard Error 1>&2
ECHO This text goes to the Console>CON
ping 8.8.8.8 | start "" /b /wait tee stdout.txt
pause