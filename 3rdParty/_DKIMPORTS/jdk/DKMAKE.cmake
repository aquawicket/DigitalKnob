if(NOT ANDROID)
	return()
endif()


### INSTALL ###
IF(NOT EXISTS "C:/Program Files (x86)/Java/jre1.8.0_40/bin/java.exe")
	DKSETPATH(${DIGITALKNOB}/Download)
	## DKDOWNLOAD(www.internet.com/jdk-8u25-windows-x64.exe) ## find an online link
	ANDROID_COMMAND(${DIGITALKNOB}/Download/jdk-8u25-windows-x64.exe)
ENDIF()