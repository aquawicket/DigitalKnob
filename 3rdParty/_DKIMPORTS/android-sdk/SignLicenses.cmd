%dkbatch%

call EndProcess java.exe
call EndProcess adb.exe

call "C:/Users/%USERNAME%/digitalknob/DK/3rdParty/_DKIMPORTS/openjdk-8u41/registerJDK.cmd"

::set "SDKMANAGER=C:\Users\%USERNAME%\digitalknob\DK\3rdParty\android-sdk\tools\bin\sdkmanager.bat
set "SDKMANAGER=C:\Users\%USERNAME%\digitalknob\DK\3rdParty\android-sdk\cmdline-tools\latest\bin\sdkmanager.bat
%SDKMANAGER% --licenses
::echo y | %SDKMANAGER% --licenses

call "C:/Users/%USERNAME%/digitalknob/DK/3rdParty/_DKIMPORTS/jdk/registerJDK.cmd" 
 
%DKEND% 
