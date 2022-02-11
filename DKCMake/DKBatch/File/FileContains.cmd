%dkbatch%

>nul findstr /c:"%~2" "%~1" && ( set "%0=1" ) || ( set "%0=0" )
