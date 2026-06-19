/* 2>nul || @echo off && goto :main */

0</* ::###################### BATCH #######################
@echo off
:main
	echo.     BATCH: main(%*)
	cscript.exe /nologo /E:jscript "%~f0" "%~nx0" main A
	powershell -c "iex ((Get-Content '%~f0') -join [Environment]::Newline); iex 'main A'"
	pause
exit /b %errorlevel%
::####################### END BATCH ###################### */0;
*/

//###################### Jscript #########################
var argc = WScript.Arguments.length;
var argv = [];
for (var i = 0; i < argc; i++){ argv.push(WScript.Arguments.Item(i)) }
main(argc, argv);

function main(argc, argv) {
	WScript.echo."Javascript: main("+argc+", "+argv+")");
	WScript.Quit(13);
}
//###################### END JSCRIPT #####################
/*

###################### POWRSHELL ########################
function main {
	echo "PowerShell: main($args)"
	func2 "B";
	exit 13
}
#################### END POWRSHELL ###################### 
*/


