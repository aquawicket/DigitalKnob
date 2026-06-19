#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DKINIT_sh-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin;
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)								&& echo "cygpath: HOME = ${HOME}";
	(command -v 'cmd.exe' 1>/dev/null)	&& export cmd_exe=$(command -v 'cmd.exe')								&& echo "cmd_exe = ${cmd_exe}";
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($cmd_exe /c echo %USERPROFILE% | tr -d '\r')	&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}";
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})								&& echo "wslpath: HOME = ${HOME}";
	(command -v 'bash' 1>/dev/null)		&& export bash_exe=$(command -v bash)									&& echo "bash_exe = ${bash_exe}";
	[ -e "${DK_SH}" ]					|| export DK_SH="$(dirname $0)/DK.sh"									&& echo "DK_SH = ${DK_SH}";
	[ -e "${DK_SH}" ]					|| export DK_SH=$(find "${HOME}" -name "DK.sh")							&& echo "DK_SH = ${DK_SH}";
	[ -e "${bash_exe}" ]				&& exec "${bash_exe}" "${DK_SH}" "$0" $*								|| exec "${DK_SH}" "$0" $*;
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
	
	[ -z "${CURRENT_IMPORT-}" ] && CURRENT_IMPORT="${DKSCRIPT_DIR}";
	Import_Path="${CURRENT_IMPORT}";
	dk_call dk_fileVariables "${Import_Path}/dkconfig.txt";
	dk_call dk_validate Host_Tuple "dk_call dk_Host_Tuple";
	dk_call dk_basename ${Import_Path} Import_Name;
	
	dk_call dk_getParameterValue APP "$@";
#	[ "${APP-}" = "1" ] && ${Import_Name}_Type="APP";
#	
#	_Import_Name_Type_="${Import_Name}_Type";
#	Import_Name_Type="${!_Import_Name_Type_}";	
#	if [ "${!_Import_Name_Type_}" = "APP" ]; then 
#		dk_call dk_validate DKTOOLS_DIR "dk_call dk_DKTOOLS_DIR";
#		INSTALL_ROOT="INSTALL_ROOT ${DKTOOLS_DIR}";
#	else
#		dk_call dk_validate DK3RDPARTY_DIR "dk_call dk_DK3RDPARTY_DIR"
#		INSTALL_ROOT="INSTALL_ROOT ${DK3RDPARTY_DIR}";
#	fi
#	
#	Import_Name_Host_Tuple_Import="${Import_Name}_${Host_Tuple}_Import";
#	Import_Name_Import="${Import_Name}_Import";
#	if [ -n "${!Import_Name_Host_Tuple_Import}" ]; then
#		dk_call dk_importVariables "${!Import_Name_Host_Tuple_Import}" ${INSTALL_ROOT};
#	elif [ -n "${!Import_Name_Import}" ]; then
#		dk_call dk_assertVar "${Import_Name_Import}";
#		dk_call dk_importVariables "${!Import_Name_Import}" ${INSTALL_ROOT};
#	else
#		dk_call dk_error "${Import_Path}/dkconfig.txt does not contain ${Import_Name}_${Host_Tuple}_Import OR ${Import_Name}_Import";
#		return $?;
#	fi
#	
#	Import_Name_Install_Name="${Import_Name}_Install_Name";
#	dk_call dk_isNonEmptyDirectory "${!Import_Name_Install_Name}" && {
#		echo "!%Import_Name%_Install_Name! already installed";
#		return $?;
#	} || ${clearerror}
#	
#	dk_call dk_download "${!Import_Name_Url}";
#	
#	dk_call dk_getExtension "${!Import_Name_Url}" ${Import_Name}_Url_Extension;
#	Import_Name_Url_Extension="${Import_Name}_Url_Extension";
#	[ "${!Import_Name_Url_Extension}" = ".7z" ] 		&& ${Import_Name}_Url_FileType="Archive";
#	[ "${!Import_Name_Url_Extension}" = ".bz" ]			&& ${Import_Name}_Url_FileType="Archive";
#	[ "${!Import_Name_Url_Extension}" = ".bz2" ]		&& ${Import_Name}_Url_FileType="Archive";
#	[ "${!Import_Name_Url_Extension}" = ".exe" ]		&& ${Import_Name}_Url_FileType="Executable";
#	[ "${!Import_Name_Url_Extension}" = ".git" ]		&& ${Import_Name}_Url_FileType="Git";
#	[ "${!Import_Name_Url_Extension}" = ".gz" ]			&& ${Import_Name}_Url_FileType="Archive";
#	[ "${!Import_Name_Url_Extension}" = ".rar" ]		&& ${Import_Name}_Url_FileType="Archive";
#	[ "${!Import_Name_Url_Extension}" = ".sfx.exe" ] 	&& ${Import_Name}_Url_FileType="Archive";
#	[ "${!Import_Name_Url_Extension}" = ".tar" ]		&& ${Import_Name}_Url_FileType="Archive";
#	[ "${!Import_Name_Url_Extension}" = ".tar.gz" ] 	&& ${Import_Name}_Url_FileType="Archive";
#	[ "${!Import_Name_Url_Extension}" = ".tar.xz" ]		&& ${Import_Name}_Url_FileType="Archive";
#	[ "${!Import_Name_Url_Extension}" = ".tgz" ]		&& ${Import_Name}_Url_FileType="Archive";
#	[ "${!Import_Name_Url_Extension}" = ".xz" ]			&& ${Import_Name}_Url_FileType="Archive";
#	[ "${!Import_Name_Url_Extension}" = ".zip" ]		&& ${Import_Name}_Url_FileType="Archive";
#	[ "${!Import_Name_Url_Extension}" = "" ]			&& ${Import_Name}_Url_FileType="Unknown";
#	
#	### Import from Archive
#	if [ "${!Import_Name_Url_FileType}" = "Archive" ]; then
#		dk_call dk_smartExtract "${dk_download}" "${!Import_Name_Install_Path}";
#	fi
#	
#	### Copy from Unknown
#	if [ "${!Import_Name_Url_FileType}" = "Unknown" ]; then
#		dk_call dk_copy "${dk_download}" "${!Import_Name_Install_Path}/${!Import_Name_Url_Basename}";
#	fi
#	
	
	if [ -n "${APP}" ]; then
		dk_call dk_validate DKTOOLS_DIR "dk_call dk_DKTOOLS_DIR";
		INSTALL_ROOT="INSTALL_ROOT ${DKTOOLS_DIR}";
	fi

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
	dk_debugFunc 0;
	
	dk_call dk_depend "git";
	
}