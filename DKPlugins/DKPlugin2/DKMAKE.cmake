dk_depend(DK)
dk_dll(DKPlugin2)
dk_assets(DKPlugin2)

IF(WIN_32)
	dk_copy(${DKPLUGINS}/DKPlugin2/win32/Release/DKPlugin2.dll ${DKPROJECT}/assets/DK/DKPlugin2 OVERWRITE)
ENDIF()

IF(WIN_64)
	dk_copy(${DKPLUGINS}/DKPlugin2/win64/Release/DKPlugin2.dll ${DKPROJECT}/assets/DK/DKPlugin2 OVERWRITE)
ENDIF()
