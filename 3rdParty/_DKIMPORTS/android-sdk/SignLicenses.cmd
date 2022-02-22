%dkbatch%

call "C:/Users/%USERNAME%/digitalknob/DK/3rdParty/_DKIMPORTS/jdk8/registerJDK.cmd"

set "SDKMANAGER=C:\Users\%USERNAME%\digitalknob\DK\3rdParty\android-sdk\tools\bin\sdkmanager.bat
%SDKMANAGER% --licenses

call "C:/Users/%USERNAME%/digitalknob/DK/3rdParty/_DKIMPORTS/jdk/registerJDK.cmd" 
 
%DKEND% 
