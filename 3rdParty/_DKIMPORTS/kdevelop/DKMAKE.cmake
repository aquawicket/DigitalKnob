# https://github.com/KDE/kdevelop
# https://www.kdevelop.org/

if(NOT LINUX_HOST)
	return()
endif()



dk_set(KDEVELOP_VERSION 5.6.1)
dk_set(KDEVELOP_NAME kdevelop-${KDEVELOP_VERSION})
dk_set(KDEVELOP_DL https://download.kde.org/stable/kdevelop/5.6.1/bin/linux/KDevelop-5.6.1-x86_64.AppImage)
dk_set(KDEVELOP ${3RDPARTY}/${KDEVELOP_NAME})
#dk_import(${KDEVELOP_DL} ${KDEVELOP})
dk_import(${KDEVELOP_DL} ${KDEVELOP})



LINUX_dk_setPath(${KDEVELOP})
LINUX_dk_queueCommand(chmod +x KDevelop.AppImage)
LINUX_dk_queueCommand(./KDevelop.AppImage)

