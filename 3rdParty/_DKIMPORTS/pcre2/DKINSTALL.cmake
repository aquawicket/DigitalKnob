#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ pcre2 ############
# https://github.com/PCRE2Project/pcre2.git

dk_load(dk_builder)

### IMPORT ###
dk_import(https://github.com/PCRE2Project/pcre2/archive/7c215fa.zip)



#TODO
