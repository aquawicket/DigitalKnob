<!-- :
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*


::################################################################################
::# dk_multiSelect(rtn_var)
::#
:dk_multiSelect
    call dk_debugFunc 0 1
 ::setlocal
    for /f "tokens=* delims=" %%p in ('cmd /c mshta.exe "%~f0"') do (
        set "rtn_var=%%p"
    )
    endlocal & set "%~1=%rtn_var%"
	echo %rtn_var%
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_multiSelect rtn_var
    %dk_call% dk_printVar rtn_var
%endfunction%



### https://learn.microsoft.com/en-us/previous-versions/ms536495(v=vs.85) ### -->
<html>
    <head>
        <TITLE>dk_multiSelect</TITLE>
        <HTA:APPLICATION 
			ID="dk_multiSelect"
            APPLICATIONNAME="dk_multiSelect"
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
            SYSMENU="yes"
            VERSION="1.0"/>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    </head> 
	
<body onLoad='load(event)' onkeypress='keyPress(event)'>
	<div class="wrapper" style="width:100%">
	<select size="15" name="" id="input" class="form-control" style="Width:100%;top:0px">
        <option value="">One</option>
        <option value="">Two</option>
        <option value="">Three</option>
        <option value="">Four</option>
        <option value="">Five</option>
        <option value="">Six</option>
        <option value="">Seven</option>
        <option value="">Eight</option>
        <option value="">Nine</option>
        <option value="">Ten</option>
    </select></div>
    <button onclick='submit()'>Submit</button>
    <button onclick='cancel()'>Cancel</button>
    <script language='javascript' >
        window.resizeTo(200,400);
        function load(e){
			// load
		}
		function keyPress(e){
            if (e.keyCode == 13) {
                submit();
            }
        }
        function submit() {
			var e = document.getElementById("input");
			var value = e.value;
			var text = e.options[e.selectedIndex].text;
            var fso= new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(1);
            close(fso.Write(text));
        }
        function cancel() {
            close();
        }
    </script>
</body>
</html> 
