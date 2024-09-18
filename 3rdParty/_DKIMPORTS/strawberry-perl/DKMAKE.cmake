include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://strawberryperl.com/


dk_validate(HOST_TRIPLE   		"dk_HOST_TRIPLE()")
dk_validate(TARGET_TRIPLE 		"dk_TARGET_TRIPLE()")
dk_validate(DKBUILD_TYPE		"dk_BUILD_TYPE()")
dk_validate(CONFIG_PATH   		"dk_MULTI_CONFIG()")


dk_import(https://github.com/StrawberryPerl/Perl-Dist-Strawberry/releases/download/SP_54001_64bit_UCRT/strawberry-perl-5.40.0.1-64bit-portable.zip)

# TODO