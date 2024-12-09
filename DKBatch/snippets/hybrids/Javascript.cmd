0</* :
@echo off
@cscript /nologo /E:jscript "%~f0" "%~nx0" %*
set exit_code=%ERRORLEVEL%

//###### exit_code ######
echo exit_code = %exit_code%
pause
exit /b %exit_code% & */0;

//########################################## Jscript ##################################################
var argc = WScript.Arguments.length;
var argv = [];
for (var i = 0; i < argc; i++){ argv.push(WScript.Arguments.Item(i)) }
main(argc, argv);

//######### main ##########
function main(argc, argv) {
	
	WScript.Echo("Javascript: main("+argc+", "+argv+")");
	WScript.Quit(13);
}

