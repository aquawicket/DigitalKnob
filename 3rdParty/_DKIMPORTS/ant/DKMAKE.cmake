# https://github.com/apache/ant

if(NOT WIN_HOST)
	return()
endif()


#DKIMPORT(https://github.com/apache/ant)
DKIMPORT(https://github.com/apache/ant/archive/0db467a379916a3d1fcf6956a0fedaf94cc25be3.zip)
#DKSET(ANT_VERSION 1.9.16)
#DKSET(ANT_NAME apache-ant-${ANT_VERSION})
#DKSET(ANT_DL https://mirror.cogentco.com/pub/apache/ant/binaries/apache-ant-1.9.15-bin.zip)
#DKSET(ANT ${3RDPARTY}/${ANT_NAME})
#DKINSTALL(${ANT_DL} apache-ant ${ANT})


DKSETENV("ANT_HOME" ${ANT})
DKSETENV("VS_AntHome" ${ANT})
