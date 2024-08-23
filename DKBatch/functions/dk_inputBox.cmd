<!-- :
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"


::################################################################################
::# dk_inputBox(rtn_var)
::#
:dk_inputBox
	call dk_debugFunc 1
	
	setlocal
	for /f "tokens=* delims=" %%p in ('mshta.exe "%~f0"') do (
		set "input=%%p"
	)
	
	endlocal & set "%~1=%input%"
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_inputBox input
	%dk_call% dk_echo "input = %input%"
goto:eof

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
<body onkeypress='keyPress(event)'>
	<input type="text" id="input" value="" style="width:100%">
    <button onclick='submit()'>Submit</button>
	<button onclick='cancel()'>Cancel</button>
    <script language='javascript' >
		window.resizeTo(500,150);
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
		document.getElementById("input").focus
    </script>
</body>
</html> 
