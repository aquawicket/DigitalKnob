# https://github.com/KDE/kdevelop
# https://www.kdevelop.org/

if(NOT LINUX_HOST)
	return()
endif()


### IMPORT ###
dk_import(https://download.kde.org/stable/kdevelop/5.6.1/bin/linux/KDevelop-5.6.1-x86_64.AppImage)


### INSTALL ###
#LINUX_dk_setPath(${KDEVELOP})
LINUX_dk_queueCommand(chmod 777 ${KDEVELOP}/KDevelop-5.6.1-x86_64.AppImage)
LINUX_dk_queueCommand(${KDEVELOP}/KDevelop-5.6.1-x86_64.AppImage)
