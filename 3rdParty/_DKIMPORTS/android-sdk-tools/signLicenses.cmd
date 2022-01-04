@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )


set "DIGITALKNOB=C:\Users\%USERNAME%\digitalknob"
set "SDKMANAGER=%DIGITALKNOB%\DK\3rdParty\android-sdk\tools\bin\sdkmanager.bat"


"%SDKMANAGER%" --licenses
