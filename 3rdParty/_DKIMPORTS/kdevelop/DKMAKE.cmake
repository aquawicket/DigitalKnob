# https://github.com/KDE/kdevelop
# https://www.kdevelop.org/

if(NOT LINUX_HOST)
	return()
endif()



DKSET(KDEVELOP_VERSION 5.6.1)
DKSET(KDEVELOP_NAME kdevelop-${KDEVELOP_VERSION})
DKSET(KDEVELOP_DL https://download.kde.org/stable/kdevelop/5.6.1/bin/linux/KDevelop-5.6.1-x86_64.AppImage)
DKSET(KDEVELOP ${3RDPARTY}/${KDEVELOP_NAME})
DKINSTALL(${KDEVELOP_DL} kdevelop ${KDEVELOP})



LINUX_DKSETPATH(${KDEVELOP})
LINUX_DKQCOMMAND(chmod +x KDevelop.AppImage)
LINUX_DKQCOMMAND(./KDevelop.AppImage)

