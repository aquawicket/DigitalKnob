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
rem # dk_multiSelect(input)
rem #
:dk_multiSelect
%setlocal%

	set "options=%~1"
	%dk_call% dk_validate DKHTA_FUNCTIONS_DIR %dk_call% dk_DKBRANCH_DIR
	set "dk_multiSelect_hta=%DKHTA_FUNCTIONS_DIR%/dk_multiSelect.hta"
	rem set "dk_multiSelect_hta=%~f0"
	
	%dk_call% dk_validate mshta.exe %dk_call% dk_findFile mshta.exe
	rem ######## Pass Batch variable to HTA
	for /f "tokens=* delims=" %%a in ('echo %%options%%^|"%mshta.exe%" "%dk_multiSelect_hta%"') do (
		rem ########## Pass Hta variable back to Batch
		set "dk_multiSelect=%%a"
	)
	
	:return
	endlocal & (
		set "dk_multiSelect=%dk_multiSelect%"
		if "%~2" neq "" (
			set "%~2=%dk_multiSelect%"
		) else (
			rem echo.%dk_inputBox%
		)
	)
%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_multiSelect "Item 1,Item 2,Item 3"
    %dk_call% dk_debug "dk_multiSelect = %dk_multiSelect%"
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
			var input = new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(0);
			var str = input.ReadLine();
			var arry = str.split(",")
			for(var i = 0; i < arry.length; i++) {
				addSelection(arry[i]);
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
			if(typeof e.options[e.selectedIndex] === "object"){
				var text = e.options[e.selectedIndex].text;
				var fso= new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(1);
				close(fso.Write(text));
			}
        }
        function cancel() {
            close();
        }
    </script>
</body>
</html>
