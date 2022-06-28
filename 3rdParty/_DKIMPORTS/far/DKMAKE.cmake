# http://findandreplace.sourceforge.net/
# https://sourceforge.net/projects/findandreplace/files/latest/download
# https://sourceforge.net/projects/findandreplace/files/findandreplace/2.0.3/FAR-2.0.3-win.zip/download
# https://sourceforge.net/projects/findandreplace/files/findandreplace/2.0.3/FAR-2.0.3-osx.zip/download
# https://sourceforge.net/projects/findandreplace/files/findandreplace/2.0.3/FAR-2.0.3-x.tar.gz/download
# https://sourceforge.net/projects/findandreplace/files/findandreplace/2.0.3/FAR-2.0.3-sources.tar.gz/download
if(NOT WIN_HOST)
	return()
endif()


### VERSION ###
#dk_set(FAR_VERSION 2.0.3)
#dk_set(FAR_NAME FAR-${FAR_VERSION}-win)
#dk_set(FAR_DL https://sourceforge.net/projects/findandreplace/files/findandreplace/2.0.3/FAR-2.0.3-win.zip)


dk_import(https://sourceforge.net/projects/findandreplace/files/findandreplace/2.0.3/FAR-2.0.3-win.zip ${3RDPARTY}/FAR-2.0.3-win)
