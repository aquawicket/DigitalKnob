#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ${CMAKE_SOURCE_DIR}/../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ DKCSSStyleDeclaration ############
# [IDL] https://drafts.csswg.org/cssom/#the-cssstyledeclaration-interface
dk_depend(DKInterface)




############ DKCSSStyleDeclaration ############
dk_set(CURRENT_PLUGIN "DKCSSStyleDeclaration")
dk_generateCmake(DKCSSStyleDeclaration)
dk_assets(DKCSSStyleDeclaration)

dk_set(DKCSSStyleDeclaration "C:/Users/Administrator/digitalknob/Development/DKCpp/plugins/DKCSSStyleDeclaration")
dk_configure(${DKCSSStyleDeclaration})
dk_build(${DKCSSStyleDeclaration})
