<!-- :
@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)


::################################################################################
::# dk_inputBox(<output>:optional)
::#
:dk_inputBox
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 0 1

	for /f "tokens=* delims=" %%p in ('cmd /c mshta.exe "%~f0"') do (
		set "dk_inputBox=%%p"
	)
	if "%~1"=="" (
		endlocal & (
			set "dk_inputBox=%dk_inputBox%"
			if "%1" neq "" set "%2=%dk_inputBox%"
		)
	) else (
		endlocal & (
			set "dk_inputBox=%dk_inputBox%"
			if "%1" neq "" set "%2=%dk_inputBox%"
		)
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_inputBox
	%dk_call% dk_printVar dk_inputBox
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
		<input type="text" id="input" value="" style="width:100%">
		<button onclick='submit()'>Submit</button>
		<button onclick='cancel()'>Cancel</button>
		<script language='javascript' >
			window.resizeTo(500,150);
			function load(e){
				var textbox = document.getElementById('input');
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
