dk_depend(DK)
dk_dll(DKPlugin2)
dk_assets(DKPlugin2)

if(WIN_X86)
	dk_copy(${DKPLUGINS_DIR}/DKPlugin2/win_x86/Release/DKPlugin2.dll ${DK_PROJECT_DIR}/assets/Development/DKPlugin2 OVERWRITE)
endif()

if(WIN_X86_64)
	dk_copy(${DKPLUGINS_DIR}/DKPlugin2/win_x86_64/Release/DKPlugin2.dll ${DK_PROJECT_DIR}/assets/Development/DKPlugin2 OVERWRITE)
endif()
