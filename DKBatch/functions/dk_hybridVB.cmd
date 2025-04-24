<!-- : Begin batch script
@echo off
cscript //nologo "%~f0?.wsf"
pause
exit /b

----- Begin wsf script --->
<job><script language="VBScript">
  WScript.Echo "VBScript output called by batch"
</script></job>