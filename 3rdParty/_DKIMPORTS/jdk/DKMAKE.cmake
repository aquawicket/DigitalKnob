if(NOT ANDROID)
	return()
endif()

### VERSION ###
DKSET(JDK_VERSION 16.0.2_windows-x64_bin)
DKSET(JDK_NAME jdk-${JDK_VERSION})
DKSET(JDK ${3RDPARTY}/${JDK_NAME})


### INSTALL ###
#https://softpedia-secure-download.com/dl/10e4dea0cb81ec2c67b3916aabe607ab/60fd60da/100082226/software/programming/jdk-16.0.2_windows-x64_bin.exe
DKINSTALL(https://softpedia-secure-download.com/dl/10e4dea0cb81ec2c67b3916aabe607ab/60fd60da/100082226/software/programming/${JDK_NAME}.exe jdk ${JDK_NAME})