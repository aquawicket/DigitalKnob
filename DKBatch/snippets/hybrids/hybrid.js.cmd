0</* ::###################### BATCH #######################
@echo off
:main
	cscript.exe /nologo /E:jscript "%~f0" "%~nx0" main arg1 arg2 arg3
	pause
exit /b %errorlevel%
::####################### END BATCH ###################### */0;



//###################### Jscript #########################
var argc = WScript.Arguments.length;
var argv = [];
for (var i = 0; i < argc; i++){ argv.push(WScript.Arguments.Item(i)) }
main(argc, argv);

function main(argc, argv) {
	WScript.Echo("Javascript: main("+argc+", "+argv+")");
	WScript.Quit(13);
}
//###################### END JSCRIPT #####################
