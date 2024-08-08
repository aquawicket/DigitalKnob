include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://github.com/Aloshi/dukglue.git


dk_depend(duktape)


#dk_import(https://github.com/Aloshi/dukglue.git PATCH)
dk_import(https://github.com/Aloshi/dukglue/archive/refs/heads/master.zip)


dk_include(${DUKGLUE}/include)
