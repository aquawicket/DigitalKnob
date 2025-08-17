#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)								&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export CMD_EXE=$(command -v 'cmd.exe')								&& echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '\r')		&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})									&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export BASH_EXE=$(command -v bash)									&& echo "BASH_EXE = ${BASH_EXE}"
	[ -e "${DK_SH}" ]					|| export DK_SH="$(dirname $0)/DK.sh"									&& echo "DK_SH = ${DK_SH}"
	[ -e "${DK_SH}" ]					|| export DK_SH=$(find "${HOME}" -name "DK.sh")							&& echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]				&& exec "${BASH_EXE}" "${DK_SH}" "$0" $*									|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


#########################################################################
# dk_import() LIBRARY APP
#
#	This is a flexable super function for importing just about anything into DigitalKnob
#	The idea is to provide a url or path and dk_import will do the rest. 
#
#	@url	- The online path of the .git or file to import
#
#	github GIT:	https://github.com/orginization/library.git		dkimportGit(url) #branch/tag #PATCH
#	github DL:	https://github.com/orginization/library			dkimportGit(url) #branch/tag #PATCH
#	lib url DL:	https://website.com/library.zip					dkimportDownload(url) #PATCH
#	exe url DL:	https://website.com/executable.exe 				dkimportDownload(url) #PATCH
#
#	TODO: https://cmake.org/cmake/help/latest/module/FetchContent.html 
#
dk_import() {
	dk_debugFunc 0 99
	
	Import_Path="${CURRENT_IMPORT}";
	dk_call dk_assertPath "${Import_Path}/dkconfig.txt";
	dk_call dk_getFileParams "${Import_Path}/dkconfig.txt";
	dk_call dk_validate Host_Tuple "dk_call dk_Host_Tuple";
	dk_call dk_basename ${Import_Path} Import_Name;
	
	dk_call dk_getParameterValue APP "$@";
	if [ -n "${APP}" ]; then
		dk_call dk_validate DKTOOLS_DIR "dk_call dk_DKTOOLS_DIR";
		INSTALL_ROOT="INSTALL_ROOT ${DKTOOLS_DIR}";
	fi
	dk_call dk_assertVar ${Import_Name}_${Host_Tuple}_Import;
	PLUGIN_IMPORT="${Import_Name}_${Host_Tuple}_Import";
	dk_call dk_importVariables "${!PLUGIN_IMPORT}" ${INSTALL_ROOT-};
	source <(printf "%s" "${PLUGIN_EXPORT}");
	
	dk_call dk_download "${PLUGIN[Url]}";
	
	dk_call dk_getExtension "${PLUGIN[Url]}" "${PLUGIN[Url.Extension]}"
	[ "${PLUGIN[Url.Extension]}" = ".7z" ] 		&& FileType="Archive";
	[ "${PLUGIN[Url.Extension]}" = ".bz" ]		&& FileType="Archive";	
	[ "${PLUGIN[Url.Extension]}" = ".bz2" ]		&& FileType="Archive";
	[ "${PLUGIN[Url.Extension]}" = ".gz" ]		&& FileType="Archive";
	[ "${PLUGIN[Url.Extension]}" = ".rar" ]		&& FileType="Archive";
	[ "${PLUGIN[Url.Extension]}" = ".sfx.exe" ]	&& FileType="Archive";
	[ "${PLUGIN[Url.Extension]}" = ".tar" ]		&& FileType="Archive";
	[ "${PLUGIN[Url.Extension]}" = ".tar.gz" ]	&& FileType="Archive";
	[ "${PLUGIN[Url.Extension]}" = ".tgz" ]		&& FileType="Archive";
	[ "${PLUGIN[Url.Extension]}" = ".xz" ]		&& FileType="Archive";
	[ "${PLUGIN[Url.Extension]}" = ".zip" ]		&& FileType="Archive";
	
	[ "${FileType}" = "Archive" ] && dk_call dk_smartExtract "${dk_download}" "${PLUGIN[Install.Path]}";
}















###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	#dk_debugFunc 0
	
	dk_call dk_depend "git"
	
	#dk_call dk_import "https://github.com/madler/zlib/archive/d4768283.zip"
	#dk_call dk_import https://www.dependencywalker.com/depends22_x64.zip
}