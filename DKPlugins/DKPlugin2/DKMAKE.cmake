dk_depend(DK)
dk_dll(DKPlugin2)
dk_assets(DKPlugin2)

IF(WIN_X86)
	dk_copy(${DKPLUGINS}/DKPlugin2/win_x86/Release/DKPlugin2.dll ${DKPROJECT}/assets/Development/DKPlugin2 OVERWRITE)
ENDIF()

IF(WIN_X86_64)
	dk_copy(${DKPLUGINS}/DKPlugin2/win_x86_64/Release/DKPlugin2.dll ${DKPROJECT}/assets/Development/DKPlugin2 OVERWRITE)
ENDIF()
