<!-- :
@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%../../DKBatch/functions/")
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

	%dk_call% dk_mkdir "%DKIMPORTS_DIR%/%name%"
	
	%dk_call% dk_toUpper "%name%"
	%dk_call% dk_printVar dk_toUpper
	
	:: dkconfig.txt
	echo %dk_toUpper%_IMPORT=%link% > 					"%DKIMPORTS_DIR%/%name%/dkconfig.txt"

	:: DKINSTALL.cmake
	echo #!/usr/bin/cmake -P >																		"%DKIMPORTS_DIR%/%name%/DKINSTALL.cmake"
	echo if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}") >>											"%DKIMPORTS_DIR%/%name%/DKINSTALL.cmake"
	echo	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/") >>						"%DKIMPORTS_DIR%/%name%/DKINSTALL.cmake"
	echo endif() >>																					"%DKIMPORTS_DIR%/%name%/DKINSTALL.cmake"
	echo include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake") >>											"%DKIMPORTS_DIR%/%name%/DKINSTALL.cmake"
	echo: >>																						"%DKIMPORTS_DIR%/%name%/DKINSTALL.cmake"
	echo: >>																						"%DKIMPORTS_DIR%/%name%/DKINSTALL.cmake"
	echo ###### %name% ###### >>																	"%DKIMPORTS_DIR%/%name%/DKINSTALL.cmake"
	echo # %link% >>																				"%DKIMPORTS_DIR%/%name%/DKINSTALL.cmake"
	::echo: >>																						"%DKIMPORTS_DIR%/%name%/DKINSTALL.cmake"
	::echo ### DEPENDS ### >>																		"%DKIMPORTS_DIR%/%name%/DKINSTALL.cmake"
	::echo #dk_depend(depend_name) >> 																"%DKIMPORTS_DIR%/%name%/DKINSTALL.cmake"
	echo: >>																						"%DKIMPORTS_DIR%/%name%/DKINSTALL.cmake"
	echo ### INSTALL ### >>																			"%DKIMPORTS_DIR%/%name%/DKINSTALL.cmake"
	echo dk_validate		(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()") >>							"%DKIMPORTS_DIR%/%name%/DKINSTALL.cmake"
	echo dk_getFileParam	("$ENV{DKIMPORTS_DIR}/%name%/dkconfig.txt" %dk_toUpper%_IMPORT) >>		"%DKIMPORTS_DIR%/%name%/DKINSTALL.cmake"
	echo dk_import		(${%dk_toUpper%_IMPORT} NAME %name%) >>											"%DKIMPORTS_DIR%/%name%/DKINSTALL.cmake"

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
