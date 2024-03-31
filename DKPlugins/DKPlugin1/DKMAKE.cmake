dk_depend(DK)
dk_dll(DKPlugin1)
dk_assets(DKPlugin1)

if(WIN_X86)
	dk_copy(${DKPLUGINS_DIR}/DKPlugin1/win_x86/Release/DKPlugin1.dll ${DK_PROJECT_DIR}/assets/DKPlugin1 OVERWRITE)
endif()

if(WIN_X86_64)
	dk_copy(${DKPLUGINS_DIR}/DKPlugin1/win_x86_64/Release/DKPlugin1.dll ${DK_PROJECT_DIR}/assets/DKPlugin1 OVERWRITE)
endif()
