<# ::###################### BATCH #######################
@echo off
:main
	echo(     BATCH: main(%*)
	powershell -c "iex ((Get-Content '%~f0') -join [Environment]::Newline); iex 'main A'"
	call :func2 C
exit /b %errorlevel%
::####################### END BATCH #####################>

###################### POWRSHELL ########################
function main {
	echo "PowerShell: main($args)"
	func2 "B";
	exit 13
}
#################### END POWRSHELL ######################

<# ::###################### BATCH #######################
@echo off
:func2
	echo(     BATCH: func2(%*)
	powershell -c "iex ((Get-Content '%~f0') -join [Environment]::Newline); iex 'func2 D'"
exit /b %errorlevel%
::####################### END BATCH #####################>

###################### POWRSHELL ########################
function func2 {
	echo "PowerShell: func2($args)"
	exit 13
}
#################### END POWRSHELL ######################