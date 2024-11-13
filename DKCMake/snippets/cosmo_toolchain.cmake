set(CMAKE_SYSTEM_NAME Generic)

find_program(CMAKE_ASM_COMPILER cosmocc NO_CACHE)
find_program(CMAKE_C_COMPILER cosmocc NO_CACHE)
find_program(CMAKE_CXX_COMPILER cosmoc++ NO_CACHE)

set(CMAKE_CXX_FLAGS_INIT "-fexceptions -frtti")

find_program(CMAKE_AR cosmoar NO_CACHE)

find_program(CMAKE_RANLIB ${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-ranlib NO_CACHE)
find_program(CMAKE_LINKER ${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-ld NO_CACHE)

foreach(lang ASM C CXX)
  find_program(CMAKE_${lang}_COMPILER_AR ${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-gcc-ar NO_CACHE)
  find_program(CMAKE_${lang}_COMPILER_RANLIB ${CMAKE_HOST_SYSTEM_PROCESSOR}-linux-cosmo-gcc-ranlib NO_CACHE)
endforeach()

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

if (NOT CMAKE_C_COMPILER)
  message(FATAL_ERROR "cosmocc was not found in PATH")
endif()

set(COSMOPOLITAN 1)
set(UNIX 1)

# Cosmopolitan uses only static libraries and no RPATH
set(BUILD_SHARED_LIBS OFF)
set(CMAKE_SKIP_RPATH ON)

# The applications can run on the host platform
set(CMAKE_CROSSCOMPILING OFF)

set(CMAKE_USER_MAKE_RULES_OVERRIDE ${CMAKE_CURRENT_LIST_FILE})
set(CMAKE_ASM_OUTPUT_EXTENSION .o)
set(CMAKE_C_OUTPUT_EXTENSION .o)
set(CMAKE_CXX_OUTPUT_EXTENSION .o)
set(__just_a_refrence_to_remove_a_warning ${CMAKE_TOOLCHAIN_FILE})
