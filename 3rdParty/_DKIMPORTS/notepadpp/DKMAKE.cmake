include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://notepad-plus-plus.org/
# https://github.com/notepad-plus-plus.git


dk_validate(HOST "dk_getHostTriple()")
	
### BINARY DISTRIBUTIONS (PORTABLE) ###
WIN_ARM64_HOST_dk_set	(NOTEPADPP_DL https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.arm64.zip)
WIN_X86_HOST_dk_set		(NOTEPADPP_DL https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.zip)
WIN_X86_64_HOST_dk_set	(NOTEPADPP_DL https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.x64.zip)

## Get NOTEPADPP_DL_FILE, NOTEPADPP_FOLDER
if(NOT NOTEPADPP_DL)
	return()
endif()

dk_getFilename(${NOTEPADPP_DL} NOTEPADPP_DL_FILE)
dk_removeExtension(${NOTEPADPP_DL_FILE} NOTEPADPP_FOLDER)
dk_convertToCIdentifier(${NOTEPADPP_FOLDER} NOTEPADPP_FOLDER)


### IMPORT ###
dk_validate(DKTOOLS_DIR "dk_getDKPaths()")
dk_import(${NOTEPADPP_DL} PATH ${DKTOOLS_DIR}/${NOTEPADPP_FOLDER})
dk_set(NOTEPADPP_EXE "${NOTEPADPP}/notepad++.exe")
dk_getNativePath(${NOTEPADPP_EXE} NOTEPADPP_EXE_WINPATH)


### dark mode ###
dk_copy(${DKIMPORTS_DIR}/notepadpp/dark_config.xml ${NOTEPADPP}/config.xml OVERWRITE)







### addContextMenu.cmd ###
dk_set(NOTEPADPP_addContextMenu_cmd "${NOTEPADPP}/addContextMenu.cmd")
if(NOT EXISTS 	"${NOTEPADPP_addContextMenu_cmd}")
	file(WRITE 	"${NOTEPADPP_addContextMenu_cmd}"
[================================================================================================[
@echo off

echo Adding 'Edit with Notepad++' context menu to Windows 
REG ADD "HKEY_CLASSES_ROOT\*\shell\Edit with Notepad++" /v Icon /t REG_SZ /d "\"${NOTEPADPP_EXE_WINPATH}\"" /f
REG ADD "HKEY_CLASSES_ROOT\*\shell\Edit with Notepad++\command" /ve /d "\"${NOTEPADPP_EXE_WINPATH}\" \"%%1\"" /f

echo complete
]================================================================================================])
	dk_fileReplace("${NOTEPADPP_addContextMenu_cmd}" "\${NOTEPADPP_EXE_WINPATH}" "${NOTEPADPP_EXE_WINPATH}")
	dk_command(	"${NOTEPADPP_addContextMenu_cmd}")
endif()





### associateFiles.cmd ###
#
#	Computer\HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts
#	Seems to be a better place to change file associations. They take precidence over ftype and assoc commands
#
dk_set(NOTEPADPP_associateFiles_cmd "${NOTEPADPP}/associateFiles.cmd")
if(NOT EXISTS 	"${NOTEPADPP_associateFiles_cmd}")
	file(WRITE 	"${NOTEPADPP_associateFiles_cmd}"
	
[====================================================================================================[
@echo off
:: https://ss64.com/nt/ftype.html
ftype dk_txtfile=${NOTEPADPP_EXE_WINPATH} "%%1"

assoc .1=dk_txtfile
assoc .2=dk_txtfile
assoc .3=dk_txtfile
assoc .=dk_txtfile
assoc .androidproj=dk_txtfile
assoc .backup=dk_txtfile
assoc .bak=dk_txtfile
assoc .c=dk_txtfile
assoc .cmake=dk_txtfile
assoc .code-workspace=dk_txtfile
assoc .cpp=dk_txtfile
assoc .css=dk_txtfile
assoc .data=dk_txtfile
assoc .gitattributes=dk_txtfile
assoc .gitconfig=dk_txtfile
assoc .glsl=dk_txtfile
assoc .gradle=dk_txtfile
assoc .h=dk_txtfile
assoc .htm=dk_txtfile
assoc .html=dk_txtfile
assoc .java=dk_txtfile
assoc .js=dk_txtfile
assoc .json=dk_txtfile
assoc .make=dk_txtfile
assoc .marks=dk_txtfile
assoc .md=dk_txtfile
assoc .mk=dk_txtfile
assoc .php=dk_txtfile
assoc .plist=dk_txtfile
assoc .pro=dk_txtfile
assoc .properties=dk_txtfile
assoc .rc=dk_txtfile
assoc .reference=dk_txtfile
assoc .rsp=dk_txtfile
assoc .sed=dk_txtfile
assoc .sh=dk_txtfile
assoc .storyboard=dk_txtfile
assoc .targets=dk_txtfile
assoc .traineddata=dk_txtfile
assoc .ts=dk_txtfile
assoc .ts=dk_txtfile
assoc .txt=dk_txtfile
assoc .xml=dk_txtfile
]====================================================================================================])

	dk_fileReplace("${NOTEPADPP_associateFiles_cmd}" "\${NOTEPADPP_EXE_WINPATH}" "${NOTEPADPP_EXE_WINPATH}")
	dk_command(	"${NOTEPADPP_associateFiles_cmd}")
endif()
