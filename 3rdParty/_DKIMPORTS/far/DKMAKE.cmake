# http://findandreplace.sourceforge.net/
#
# https://sourceforge.net/projects/findandreplace/files/latest/download
# https://sourceforge.net/projects/findandreplace/files/findandreplace/2.0.3/FAR-2.0.3-win.zip/download
# https://sourceforge.net/projects/findandreplace/files/findandreplace/2.0.3/FAR-2.0.3-osx.zip/download
# https://sourceforge.net/projects/findandreplace/files/findandreplace/2.0.3/FAR-2.0.3-x.tar.gz/download
# https://sourceforge.net/projects/findandreplace/files/findandreplace/2.0.3/FAR-2.0.3-sources.tar.gz/download


### VERSION ###
DKSET(FAR_VERSION 2.0.3)
DKSET(FAR_NAME FAR-${FAR_VERSION}-win)
DKSET(FAR_DL https://sourceforge.net/projects/findandreplace/files/findandreplace/${FAR_VERSION}/${FAR_NAME}.zip)
DKSET(FAR ${3RDPARTY}/${FAR_NAME})


### INSTALL ###
DKINSTALL(${FAR_DL} far ${FAR})
