# https://github.com/dotnet/ILMerge
# https://www.nuget.org/packages/ilmerge
#
# https://www.nuget.org/api/v2/package/ilmerge/3.0.41


### VERSION ###
DKSET(ILMERGE_VERSION 3.0.41)
DKSET(ILMERGE_NAME ilmerge-${ILMERGE_VERSION})
DKSET(ILMERGE_DL https://www.nuget.org/api/v2/package/ilmerge/${ILMERGE_VERSION})
DKSET(ILMERGE ${3RDPARTY}/${ILMERGE_NAME})


### INSTALL ###
DKINSTALL(${ILMERGE_DL} ilmerge ${ILMERGE})
