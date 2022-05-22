# https://github.com/dotnet/ILMerge
# https://www.nuget.org/packages/ilmerge



DKGITCLONE(https://github.com/dotnet/ILMerge.git)

#DKIMPORT(https://github.com/dotnet/ILMerge/archive/9ec1b3f29f6f11b8fc2ddcca4c055dae7b10d9e3.zip)

#DKSET(ILMERGE_VERSION 3.0.41)
#DKSET(ILMERGE_NAME ilmerge-${ILMERGE_VERSION})
#DKSET(ILMERGE_DL https://www.nuget.org/api/v2/package/ilmerge/3.0.41)
#DKSET(ILMERGE ${3RDPARTY}/${ILMERGE_NAME})
#DKINSTALL(${ILMERGE_DL} ilmerge ${ILMERGE})
