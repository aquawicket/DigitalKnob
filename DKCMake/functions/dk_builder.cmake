include_guard()	
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

dk_validate(HOST_TRIPLE		"dk_HOST_TRIPLE()")
dk_validate(TARGET_TRIPLE 	"dk_TARGET_TRIPLE()")
dk_validate(CONFIG_PATH   	"dk_MULTI_CONFIG()")


###############################################################################
# dk_builder()
#
#
#function(dk_builder)
#	dk_debugFunc("\${ARGV}")
#	
#endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#function(DKTEST)
#	dk_debugFunc("\${ARGV}")
#	
#	dk_builder()
#endfunction()
