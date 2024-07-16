<!-- :
@echo off
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
		<TITLE>HTA Demo</TITLE>
		<HTA:APPLICATION ID="htaInput"
			APPLICATIONNAME="htaInput"
			BORDER="thin"
			BORDERSTYLE="normal"
			CAPTION="yes"
			ICON=""
			MAXIMIZEBUTTON="yes"
			MINIMIZEBUTTON="yes"
			NAVIGABLE="yes"
			SCROLL="no"
			SHOWINTASKBAR="no"
			SINGLEINSTANCE="yes"
			SYSMENU="yes"
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
		stop
    </script>
</body>
</html> 
