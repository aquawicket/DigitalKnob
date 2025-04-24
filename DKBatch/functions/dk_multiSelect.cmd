<!-- :
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################################################################################
::# dk_multiSelect(rtn_var)
::#
:dk_multiSelect
    %dk_call% dk_debugFunc 0 99

::######## Pass batch variable into HTA
set "selections=One;Two;Three"
for /f "tokens=* delims=" %%a in ('echo %%selections%%^|mshta.exe "%~f0"') do (
    ::########## Pass Hta variable back to Batch 
	set "rtn_var=%%a"
)
endlocal & set "%~1=%rtn_var%"
echo %rtn_var%















::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0 99
 
    %dk_call% dk_multiSelect rtn_var "one, two, three"
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
		</select>
	</div>
    <button onclick='submit()'>Submit</button>
    <button onclick='cancel()'>Cancel</button>
	
    <script language='javascript' >
        window.resizeTo(200,400);
        function load(e){
			
			//######### Pass batch variable into HTA ######################################
			var input= new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(0);
			var line=input.ReadLine();
		
			addSelection(line);
			for (let i = 0; i < line.length; i++) {
				addSelection(line[i]);
			}
		}
		function addSelection(name){
			var input = document.getElementById("input");
			var option = document.createElement("option");
			option.setAttribute("value", name);
			option.innerHTML = name;
			input.appendChild(option);
		}
		function keyPress(e){
            if (e.keyCode == 13){
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
