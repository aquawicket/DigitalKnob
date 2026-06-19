:: shebang

@echo off

set myVar=value
::echo myVar = '%myVar%'			&:: w/ newline
set /p "=myVar = '%myVar%'" <nul	&:: no newline

