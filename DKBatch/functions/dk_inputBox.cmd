<!-- :
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*


::################################################################################
::# dk_inputBox(rtn_var)
::#
:dk_inputBox
    %dk_call% dk_debugFunc 0 1
 ::setlocal
    for /f "tokens=* delims=" %%p in ('cmd /c mshta.exe "%~f0"') do (
        set "rtn_var=%%p"
    )
    endlocal & set "%~1=%rtn_var%"
	echo %rtn_var%
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    %dk_call% dk_debugFunc 0
 setlocal
 
    %dk_call% dk_inputBox rtn_var
    %dk_call% dk_printVar rtn_var
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
