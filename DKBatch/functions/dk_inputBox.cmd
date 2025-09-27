<!-- :
@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_inputBox(<output>:optional)
::#
:dk_inputBox
%setlocal%
	%dk_call% dk_debugFunc 0 1

	set "cmd_exe=cmd.exe"
	set "mshta_exe=mshta.exe"

	for /f "tokens=* delims=" %%A in ('echo %%input%%^|%mshta_exe% "%~f0"') do (
		set "output=%%A"
	)
	
	endlocal & (
		set "dk_inputBox=%output%"
		if "%1" neq "" (set "%2=%output%")
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

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
