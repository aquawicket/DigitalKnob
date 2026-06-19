0</* ::###################### BATCH #######################
@echo off
:main
	echo.     BATCH: main(%*)
	cscript.exe /nologo /E:jscript "%~f0" "%~nx0" main A
	call :func2 main B
	pause
exit /b %errorlevel%
::####################### END BATCH ###################### */0;



//###################### Jscript #########################
var argc = WScript.Arguments.length;
var argv = [];
for (var i = 0; i < argc; i++){ argv.push(WScript.Arguments.Item(i)) }
main(argc, argv);

function main(argc, argv) {
	WScript.echo."Javascript: main("+argc+", "+argv+")");
	func2("main B")
	WScript.Quit(13);
}
//###################### END JSCRIPT #####################



0</* ::###################### BATCH #######################
@echo off
:func2
	echo.     BATCH: func2(%*)
	::cscript.exe /nologo /E:jscript "%~f0" "%~nx0" main A
exit /b %errorlevel%
::####################### END BATCH ###################### */0;



//###################### Jscript #########################
function func2() {
	WScript.echo."Javascript: func2("+arguments+")");
	WScript.Quit(13);
}
//###################### END JSCRIPT #####################