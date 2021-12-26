if(NOT LINUX_HOST)
	return()
endif()

# https://www.kdevelop.org/
#
# https://download.kde.org/stable/kdevelop/5.6.1/bin/linux/KDevelop-5.6.1-x86_64.AppImage


### VERSION ###
DKSET(KDEVELOP_VERSION 5.6.1)
DKSET(KDEVELOP_NAME kdevelop-${KDEVELOP_VERSION})
DKSET(KDEVELOP_DL https://download.kde.org/stable/kdevelop/${KDEVELOP_VERSION}/bin/linux/KDevelop-${KDEVELOP_VERSION}-x86_64.AppImage)
DKSET(KDEVELOP ${3RDPARTY}/${KDEVELOP_NAME})


### INSTALL ###
DKINSTALL(${KDEVELOP_DL} kdevelop ${KDEVELOP})
LINUX_DKSETPATH(${KDEVELOP})
LINUX_DKQCOMMAND(chmod +x KDevelop.AppImage)
LINUX_DKQCOMMAND(./KDevelop.AppImage)

