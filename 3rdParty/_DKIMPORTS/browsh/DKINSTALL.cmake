#/usr/bin/cmake -P 
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}") 
set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/") 
endif() 
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake") 
 
 
###### browsh ###### 
# https://github.com/browsh-org/browsh/releases/download/v1.8.0/browsh_1.8.0_windows_amd64.exe 
 
### INSTALL ### 
dk_validate		(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()") 
dk_getAllFileParams("$ENV{DKIMPORTS_DIR}/browsh/dkconfig.txt")

dk_validate(dk_host_triple "dk_host_triple()")
if(WIN_HOST)
	set(BROWSH_IMPORT "${BROWSH_WIN_X86_64_IMPORT}")
endif()
dk_import		(${BROWSH_IMPORT} NAME browsh) 
