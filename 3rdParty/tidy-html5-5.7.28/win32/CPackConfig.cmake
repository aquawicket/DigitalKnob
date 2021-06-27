# This file will be configured to contain variables for CPack. These variables
# should be set in the CMake list file of the project before CPack module is
# included. The list of available CPACK_xxx variables and their associated
# documentation may be obtained using
#  cpack --help-variable-list
#
# Some variables are common to all generators (e.g. CPACK_PACKAGE_NAME)
# and some are specific to a generator
# (e.g. CPACK_NSIS_EXTRA_INSTALL_COMMANDS). The generator specific variables
# usually begin with CPACK_<GENNAME>_xxxx.


set(CPACK_BUILD_SOURCE_DIRS "C:/Users/aquawicket/digitalknob/DK/3rdParty/tidy-html5-5.7.28;C:/Users/aquawicket/digitalknob/DK/3rdParty/tidy-html5-5.7.28/win32")
set(CPACK_CMAKE_GENERATOR "Visual Studio 16 2019")
set(CPACK_COMPONENT_UNSPECIFIED_HIDDEN "TRUE")
set(CPACK_COMPONENT_UNSPECIFIED_REQUIRED "TRUE")
set(CPACK_DEBIAN_PACKAGE_HOMEPAGE "http://www.html-tidy.org")
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "maintainer@htacg.org")
set(CPACK_DEBIAN_PACKAGE_SECTION "Libraries")
set(CPACK_DEFAULT_PACKAGE_DESCRIPTION_FILE "C:/Program Files (x86)/CMake/share/cmake-3.19/Templates/CPack.GenericDescription.txt")
set(CPACK_DEFAULT_PACKAGE_DESCRIPTION_SUMMARY "tidy built using CMake")
set(CPACK_GENERATOR "NSIS;WIX;ZIP")
set(CPACK_INSTALL_CMAKE_PROJECTS "C:/Users/aquawicket/digitalknob/DK/3rdParty/tidy-html5-5.7.28/win32;tidy;ALL;/")
set(CPACK_INSTALL_PREFIX "C:/Program Files (x86)/tidy")
set(CPACK_MODULE_PATH "")
set(CPACK_NSIS_DISPLAY_NAME "tidy 5.7.28")
set(CPACK_NSIS_INSTALLER_ICON_CODE "")
set(CPACK_NSIS_INSTALLER_MUI_ICON_CODE "")
set(CPACK_NSIS_INSTALL_ROOT "$PROGRAMFILES")
set(CPACK_NSIS_PACKAGE_NAME "tidy 5.7.28")
set(CPACK_NSIS_UNINSTALL_NAME "Uninstall")
set(CPACK_OUTPUT_CONFIG_FILE "C:/Users/aquawicket/digitalknob/DK/3rdParty/tidy-html5-5.7.28/win32/CPackConfig.cmake")
set(CPACK_PACKAGE_CONTACT "maintainer@htacg.org")
set(CPACK_PACKAGE_DEFAULT_LOCATION "/")
set(CPACK_PACKAGE_DESCRIPTION_FILE "C:/Users/aquawicket/digitalknob/DK/3rdParty/tidy-html5-5.7.28/README/README.html")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "tidy - HTML syntax checker")
set(CPACK_PACKAGE_FILE_NAME "tidy-5.7.28-win32")
set(CPACK_PACKAGE_INSTALL_DIRECTORY "tidy 5.7.28")
set(CPACK_PACKAGE_INSTALL_REGISTRY_KEY "tidy 5.7.28")
set(CPACK_PACKAGE_NAME "tidy")
set(CPACK_PACKAGE_RELOCATABLE "true")
set(CPACK_PACKAGE_VENDOR "HTML Tidy Advocacy Community Group")
set(CPACK_PACKAGE_VERSION "5.7.28")
set(CPACK_PACKAGE_VERSION_MAJOR "5")
set(CPACK_PACKAGE_VERSION_MINOR "7")
set(CPACK_PACKAGE_VERSION_PATCH "28")
set(CPACK_RESOURCE_FILE_LICENSE "C:/Users/aquawicket/digitalknob/DK/3rdParty/tidy-html5-5.7.28/README/LICENSE.txt")
set(CPACK_RESOURCE_FILE_README "C:/Users/aquawicket/digitalknob/DK/3rdParty/tidy-html5-5.7.28/README/README.html")
set(CPACK_RESOURCE_FILE_WELCOME "C:/Users/aquawicket/digitalknob/DK/3rdParty/tidy-html5-5.7.28/README/README.html")
set(CPACK_RPM_EXCLUDE_FROM_AUTO_FILELIST_ADDITION "/usr/share/man;/usr/share/man/man1")
set(CPACK_SET_DESTDIR "OFF")
set(CPACK_SOURCE_GENERATOR "ZIP")
set(CPACK_SOURCE_IGNORE_FILES "C:/Users/aquawicket/digitalknob/DK/3rdParty/tidy-html5-5.7.28/test/;C:/Users/aquawicket/digitalknob/DK/3rdParty/tidy-html5-5.7.28/build/;C:/Users/aquawicket/digitalknob/DK/3rdParty/tidy-html5-5.7.28/.git/")
set(CPACK_SOURCE_OUTPUT_CONFIG_FILE "C:/Users/aquawicket/digitalknob/DK/3rdParty/tidy-html5-5.7.28/win32/CPackSourceConfig.cmake")
set(CPACK_SYSTEM_NAME "win32")
set(CPACK_TOPLEVEL_TAG "win32")
set(CPACK_WIX_SIZEOF_VOID_P "4")
set(CPACK_WIX_UPGRADE_GUID "D809598A-B513-4752-B268-0BAC403B00E4")

if(NOT CPACK_PROPERTIES_FILE)
  set(CPACK_PROPERTIES_FILE "C:/Users/aquawicket/digitalknob/DK/3rdParty/tidy-html5-5.7.28/win32/CPackProperties.cmake")
endif()

if(EXISTS ${CPACK_PROPERTIES_FILE})
  include(${CPACK_PROPERTIES_FILE})
endif()
