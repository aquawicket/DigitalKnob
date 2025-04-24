<!-- :
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


:: PasswordSubmitter.bat
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

<HTML>
<HEAD>
  <TITLE>HTA Demo</TITLE>
    <HTA:APPLICATION ID="oHTA"
     APPLICATIONNAME="myApp"
     BORDER="thin"
     BORDERSTYLE="normal"
     CAPTION="yes"
     ICON=""
     MAXIMIZEBUTTON="yes"
     MINIMIZEBUTTON="yes"
     SHOWINTASKBAR="no"
     SINGLEINSTANCE="no"
     SYSMENU="yes"
     VERSION="1.0"/>

  <SCRIPT>

  /* This function also retrieves the value of the commandLine property,
     which cannot be set as an attribute.  */
   
  function window.onload()
  {
	/* window.resizeTo(300,150); */
     sTempStr = "applicationName  = " + oHTA.applicationName + "\n" + 
                "border           = " + oHTA.border          + "\n" +
                "borderStyle      = " + oHTA.borderStyle     + "\n" + 
                "caption          = " + oHTA.caption         + "\n" +
                "commandLine      = " + oHTA.commandLine     + "\n" +
                "icon             = " + oHTA.icon            + "\n" +
                "maximizeButton   = " + oHTA.maximizeButton  + "\n" +
                "minimizeButton   = " + oHTA.minimizeButton  + "\n" + 
                "showInTaskBar    = " + oHTA.showInTaskbar   + "\n" +
                "singleInstance   = " + oHTA.singleInstance  + "\n" +  
                "sysMenu          = " + oHTA.sysMenu         + "\n" + 
                "version          = " + oHTA.version         + "\n"; 
          
     oPre.innerText = sTempStr;       
  }
  </SCRIPT>
</HEAD>
<BODY SCROLL="no">
  <PRE ID=oPre>  </PRE>
</BODY>
</HTML>
