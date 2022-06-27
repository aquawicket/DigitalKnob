if(NOT WIN_HOST)
	return()
endif()

# http://findandreplace.sourceforge.net/
#
# https://sourceforge.net/projects/findandreplace/files/latest/download
# https://sourceforge.net/projects/findandreplace/files/findandreplace/2.0.3/FAR-2.0.3-win.zip/download
# https://sourceforge.net/projects/findandreplace/files/findandreplace/2.0.3/FAR-2.0.3-osx.zip/download
# https://sourceforge.net/projects/findandreplace/files/findandreplace/2.0.3/FAR-2.0.3-x.tar.gz/download
# https://sourceforge.net/projects/findandreplace/files/findandreplace/2.0.3/FAR-2.0.3-sources.tar.gz/download


### VERSION ###
dk_set(FAR_VERSION 2.0.3)
dk_set(FAR_NAME FAR-${FAR_VERSION}-win)
dk_set(FAR_DL https://sourceforge.net/projects/findandreplace/files/findandreplace/${FAR_VERSION}/${FAR_NAME}.zip)
dk_set(FAR ${3RDPARTY}/${FAR_NAME})


### INSTALL ###
#dk_install(${FAR_DL} ${FAR})
dk_import(${FAR_DL} ${FAR})
