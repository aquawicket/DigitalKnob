rem shebang

@echo off

set myVar=value
::echo myVar = '%myVar%'			&rem  w/ newline
set /p "=myVar = '%myVar%'" <nul	&rem  no newline

