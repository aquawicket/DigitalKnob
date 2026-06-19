<!-- :
@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ################################################################################
rem # dk_inputBox(<title> <value> <output>:optional)
rem #
:dk_inputBox
%setlocal%

	set "title=%~1"
	set "value=%~2"

	%dk_call% dk_validate DKHTA_FUNCTIONS_DIR %dk_call% dk_DKBRANCH_DIR
	set "dk_inputBox_hta=%DKHTA_FUNCTIONS_DIR%/dk_inputBox.hta"
	rem set "dk_inputBox_hta=%~f0"

	set "dk_inputBox="
	%dk_call% dk_validate mshta.exe %dk_call% dk_findFile mshta.exe

	for /f "tokens=* delims=" %%A in ('echo.%*^|"%mshta.exe%" "%dk_inputBox_hta%"') do (
		set "dk_inputBox=%%~A"
	)
	
rem	set "dk_exec_ECHO_OUTPUT=1"
rem	set "dk_exec_ECHO_ERROR=1"
rem	set "dk_exec_PRINT_CALL=1" 			&rem dk_exec_call
rem	set "dk_exec_PRINT_COMMAND=1" 		&rem dk_exec_command
rem	set "dk_exec_PRINT_EXITCODES=1"		&rem dk_exec_exitcodes
rem	set "dk_exec_PRINT_EXITCODE=1"		&rem dk_exec_exitcode
rem	set "dk_exec_PRINT_STDERR=1"		&rem dk_exec_stderr[]
rem	set "dk_exec_PRINT_STDOUT=1"		&rem dk_exec_stdout[]
rem	set "dk_exec_PRINT_OUTPUT=1"		&rem dk_exec
rem	%dk_call% dk_exec %mshta.exe% "%dk_inputBox_hta%"
rem	set "dk_inputBox=%dk_exec%"
rem	echo dk_inputBox = %dk_inputBox%
	
	
	:return
	endlocal & (
		set "dk_inputBox=%dk_inputBox%"
		if "%~3" neq "" (
			set "%~3=%dk_inputBox%"
		) else (
			rem echo.%dk_inputBox%
		)
	)
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_inputBox "Custom Title" "initial value"
	%dk_call% dk_echo "dk_inputBox = %dk_inputBox%"
	
	%dk_call% dk_inputBox
	%dk_call% dk_echo "dk_inputBox = %dk_inputBox%"
%endfunction%























-->

<!-- https://learn.microsoft.com/en-us/previous-versions/ms536495(v=vs.85) -->
<html>
	<head>
		<TITLE>dk_inputBox</TITLE>
		<HTA:APPLICATION ID="dk_inputBox"
			APPLICATIONNAME="dk_inputBox"
			BORDER="thin"
			BORDERSTYLE="normal"
			CAPTION="yes"
			ICON=""
			MAXIMIZEBUTTON="no"
			MINIMIZEBUTTON="no"
			NAVIGABLE="no"
			SCROLL="no"
			SHOWINTASKBAR="no"
			SINGLEINSTANCE="yes"
			SYSMENU="no"
			VERSION="1.0"/>
	</head>
	<body onLoad='load(event)' onkeypress='keyPress(event)'>
	
		<!--######### Pass batch variable to HTA ########################################-->
		<script language='javascript'>
		
			// https://stackoverflow.com/a/18647776
			function splitArgs(myString){
				//The parenthesis in the regex creates a captured group within the quotes
				var myRegexp = /[^\s"]+|"([^"]*)"/gi;
				var myArray = [];
				do {
					//Each call to exec returns the next regex match as an array
					var match = myRegexp.exec(myString);
					if (match != null){
						//Index 1 in the array is the captured group if it exists
						//Index 0 is the matched text, which we use if no captured group exists
						myArray.push(match[1] ? match[1] : match[0]);
					}
				} while (match != null);
				return myArray;
			}
			
			window.resizeTo(400,200);
			var input = new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(0);
			var argv=input.ReadLine();
			//var argv=argv.split(" ");
			var argv=splitArgs(argv);
			if(typeof argv[0] !== "undefined"){ document.title = argv[0]; }
			var value=argv[1];
		</script>	
		<!--#############################################################################-->
		
		<input type="text" id="input" value="" style="width:100%">
		<button onclick='submit()'>Submit</button>
		<button onclick='cancel()'>Cancel</button>
		<script language='javascript' >
			window.resizeTo(500,150);
			function load(e){
				var textbox = document.getElementById('input');
				if(typeof value !== "undefined"){ textbox.value = value; }
				textbox.select();
			}
			function keyPress(e){
				if (e.keyCode == 13) {
					submit();
				}
			}
			function submit() {
				var pass=document.getElementById('input').value;
				var fso= new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(1);
				close(fso.Write(pass));
			}
			function cancel() {
				close();
			}
		</script>
	</body>
</html>
