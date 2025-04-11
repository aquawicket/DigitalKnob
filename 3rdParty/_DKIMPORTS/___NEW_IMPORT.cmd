<!-- :
@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=../../DKBatch/functions/")
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::############################################################################
::# ___NEW_IMPORT()
::#
::#
:___NEW_IMPORT
setlocal
	%dk_call% dk_debugFunc 0

	for /f "tokens=* delims=" %%A in ('cmd /c mshta.exe "%~f0"') do (
		set "str=%%A"
	)
	
	%dk_call% String/dk_split "%str%"
	set "link=%dk_split[0]%"
	set "name=%dk_split[1]%"
	
	%dk_call% dk_echo "link = %link%"
	%dk_call% dk_echo "name = %name%"
	
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	if exist "%DKIMPORTS_DIR%/%name%" (
		%dk_call% dk_notice "%DKIMPORTS_DIR%/%name% already exists"
		%return%
	)

	%dk_call% dk_makeDirectory "%DKIMPORTS_DIR%/%name%"
::	echo @echo off > 								"%dk_inputBox%.cmd"
::	echo if not defined DK.cmd (call "%%DKBATCH_FUNCTIONS_DIR_%%DK.cmd" %%~0 %%*) >> "%dk_inputBox%.cmd"
::	echo: >> 										"%dk_inputBox%.cmd"
::	echo ::############################################################################ >> "%dk_inputBox%.cmd"
::	echo ::# %dk_inputBox%() >> 					"%dk_inputBox%.cmd"
::	echo ::# >> 									"%dk_inputBox%.cmd"
::	echo ::# >> 									"%dk_inputBox%.cmd"
::	echo :%dk_inputBox% >> 							"%dk_inputBox%.cmd"
::	echo setlocal enableDelayedExpansion >> 		"%dk_inputBox%.cmd"
::	echo 	%%dk_call%% dk_debugFunc 0 >> 			"%dk_inputBox%.cmd"
::	echo: >>										"%dk_inputBox%.cmd"
::	echo 	::insert function code here:: >>		"%dk_inputBox%.cmd"
::	echo: >>										"%dk_inputBox%.cmd"
::	echo %%endfunction%% >> 						"%dk_inputBox%.cmd"
::	echo: >> 										"%dk_inputBox%.cmd"
::	echo: >> 										"%dk_inputBox%.cmd"
::	echo: >> 										"%dk_inputBox%.cmd"
::	echo: >> 										"%dk_inputBox%.cmd"
::	echo: >> 										"%dk_inputBox%.cmd"
::	echo: >> 										"%dk_inputBox%.cmd"
::	echo: >> 										"%dk_inputBox%.cmd"
::	echo: >> 										"%dk_inputBox%.cmd"
::	echo: >> 										"%dk_inputBox%.cmd"
::	echo: >> 										"%dk_inputBox%.cmd"
::	echo: >> 										"%dk_inputBox%.cmd"
::	echo ::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### >> "%dk_inputBox%.cmd"
::	echo :DKTEST >> 								"%dk_inputBox%.cmd"
::	echo setlocal enableDelayedExpansion >> 		"%dk_inputBox%.cmd"
::	echo 	%%dk_call%% dk_debugFunc 0 >> 			"%dk_inputBox%.cmd"
::	echo: >> 										"%dk_inputBox%.cmd" 
::	echo 	%%dk_call%% %dk_inputBox% >>			"%dk_inputBox%.cmd"
::	echo %%endfunction%% >> 						"%dk_inputBox%.cmd"
::	echo: >> 										"%dk_inputBox%.cmd"
::	
::	:edit_textfile
::	%dk_call% dk_validate NOTEPADPP_EXE "%dk_call% dk_NOTEPADPP_EXE"
::	"%NOTEPADPP_EXE%" "%dk_inputBox%.cmd"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% ___NEW_IMPORT
%endfunction%


### https://learn.microsoft.com/en-us/previous-versions/ms536495(v=vs.85) ### -->
<html>
	<head>
		<TITLE>__NEW_IMPORT</TITLE>
		<HTA:APPLICATION ID="__NEW_IMPORT"
			APPLICATIONNAME="__NEW_IMPORT"
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
		LINK: <input type="text" id="link" value="" style="width:80%">
		NAME: <input type="text" id="name" value="" style="width:80%">
		<button onclick='submit()'>Submit</button>
		<button onclick='cancel()'>Cancel</button>
		<script language='javascript' >
			window.resizeTo(500,150);
			function load(e){
				var link = document.getElementById('link');
				var name = document.getElementById('name');
				link.select(); 
			}
			function keyPress(e){
				if (e.keyCode == 13) {
					submit();
				}
			}
			function submit() {
				var link=document.getElementById('link').value;
				var name=document.getElementById('name').value;
				output = link+";"+name;
				
				var stdout = new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(1);
				close(stdout.Write(output));
			}
			function cancel() {
				close();
			}
		</script>
	</body>
</html> 
