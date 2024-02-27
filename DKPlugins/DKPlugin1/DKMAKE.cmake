dk_depend(DK)
dk_dll(DKPlugin1)
dk_assets(DKPlugin1)

IF(WIN_X86)
	dk_copy(${DKPLUGINS}/DKPlugin1/win_x86/Release/DKPlugin1.dll ${DKPROJECT}/assets/DKPlugin1 OVERWRITE)
ENDIF()

IF(WIN_64)
	dk_copy(${DKPLUGINS}/DKPlugin1/win_x86_64/Release/DKPlugin1.dll ${DKPROJECT}/assets/DKPlugin1 OVERWRITE)
ENDIF()
