<!-- :
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################

setlocal EnableDelayedExpansion

if "%~1" equ "/?" (
	echo Creates an input value window and output
	echo   the result to console or assign it to variable
	echo   if variable name is passed
	(echo()
	echo Usage:
	(echo()
	echo %~0nx [storeInputTo]
)
for /f "tokens=* delims=" %%p in ('mshta.exe "%~f0"') do (
    set "input=%%p"
)


if "%~1" equ "" (
	echo %input%
	endlocal
) else (
	endlocal & (
		set "%~1=%input%"
	)
)
exit /b
-->


<!-- https://learn.microsoft.com/en-us/previous-versions/ms536495(v=vs.85) -->
<html>
	<head>
		<TITLE>DKInputBox</TITLE>
		<HTA:APPLICATION ID="DKInputBox"
			APPLICATIONNAME="DKInputBox"
			BORDER="none"
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
<body onkeypress='keyPress(event)'>
	<input type="text" id="input" value="">
    <hr>
    <button onclick='pipePass()'>Submit</button>
	
    <script language='javascript' >
		window.resizeTo(500,150);
		function keyPress(e){
			if (e.keyCode == 13) {
				pipePass();
			}
		}
        function pipePass() {
            var pass=document.getElementById('input').value;
            var fso= new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(1);
            close(fso.Write(pass));
        }
		document.getElementById("input").focus
    </script>
</body>
</html>
