# dk_include_guard()

##################################################################################
# dk_get_dkpaths()
#
#
dk_get_dkpaths() {
	dk_debug "dk_get_dkpaths($@)"
	
	# [[ $0 != $BASH_SOURCE ]] && echo "Script is being sourced" || echo "Script is being run"
	
	#export SCRIPT=$0
	#echo "SCRIPT = $SCRIPT"
	#export SCRIPT_PATH=$(realpath "$0")
	#echo "SCRIPT_PATH = $SCRIPT_PATH"
	#export SCRIPT_DIR=$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )
	#echo "SCRIPT_DIR = $SCRIPT_DIR"
	#export SCRIPT_NAME=$(basename "$0")
	#echo "SCRIPT_NAME = $SCRIPT_NAME"

	#echo "BASH_SOURCE = $BASH_SOURCE"
	#export BASH_SOURCE_PATH=$(realpath "$BASH_SOURCE")
	#echo "BASH_SOURCE_PATH = $BASH_SOURCE_PATH"
	#export BASH_SOURCE_DIR=$( cd -- "$(dirname "$BASH_SOURCE")" >/dev/null 2>&1 ; pwd -P )
	#echo "BASH_SOURCE_DIR = $BASH_SOURCE_DIR"
	#export BASH_SOURCE_NAME=$(basename "$BASH_SOURCE")
	#echo "BASH_SOURCE_NAME = $BASH_SOURCE_NAME"

	DKBRANCH_DIR=$PWD
	while [ "$(dirname $DKBRANCH_DIR)" != "/" ]; do
		if [ "$(basename $(dirname $DKBRANCH_DIR))" == "digitalknob" ]; then
			break
		fi
		DKBRANCH_DIR=$(dirname $DKBRANCH_DIR)
	done
	if [ "$(dirname $DKBRANCH_DIR)" == "/" ]; then
		echo "ERROR: could not find DKBRANCH directory"
		exit 1
	fi
	
	# digitalknob
	export DIGITALKNOB_DIR=$(dirname $DKBRANCH_DIR)
	export DIGITALKNOB=$(basename $DIGITALKNOB_DIR)
		# digitalknob/branch
		export DKBRANCH_DIR=$DKBRANCH_DIR
		export DKBRANCH=$(basename $DKBRANCH_DIR)
			# digitalknob/branch/3rdParty
			export DK3RDPARTY_DIR=${DKBRANCH_DIR}/3rdParty
			export DK3RDPARTY=$(basename $DK3RDPARTY_DIR)
				# digitalknob/branch/3rdParty/_DKIMPORTS
				export DKIMPORTS_DIR=${DK3RDPARTY_DIR}/_DKIMPORTS
				export DKIMPORTS=$(basename $DKIMPORTS_DIR)
			# digitalknob/branch/DKApps	
			export DKAPPS_DIR=${DKBRANCH_DIR}/DKApps
			export DKAPPS=$(basename $DKAPPS_DIR)
			# digitalknob/branch/DKBash
			export DKBASH_DIR=${DKBRANCH_DIR}/DKBash
			export DKBASH=$(basename $DKBASH_DIR)
			# digitalknob/branch/DKBatch
			export DKBATCH_DIR=${DKBRANCH_DIR}/DKBatch
			export DKBATCH=$(basename $DKBATCH_DIR)
			# digitalknob/branch/DKCMake
			export DKCMAKE_DIR=${DKBRANCH_DIR}/DKCMake
			export DKCMAKE=$(basename $DKCMAKE_DIR)
			# digitalknob/branch/DKDocs
			export DKDOCS_DIR=${DKBRANCH_DIR}/DKDocs
			export DKDOCS=$(basename $DKDOCS_DIR)
			# digitalknob/branch/DKPlugins
			export DKPLUGINS_DIR=${DKBRANCH_DIR}/DKPlugins
			export DKPLUGINS=$(basename $DKPLUGINS_DIR)
		# digitalknob/DKTools
		export DKTOOLS_DIR=${DIGITALKNOB_DIR}/DKTools
		export DKTOOLS=$(basename $DKTOOLS_DIR)
		# digitalknob/download
		export DKDOWNLOAD_DIR=${DIGITALKNOB_DIR}/download
		export DKDOWNLOAD=$(basename $DKDOWNLOAD_DIR)
	
	echo "DIGITALKNOB_DIR: ${DIGITALKNOB_DIR}"
	echo "DIGITALKNOB: ${DIGITALKNOB}"
	echo "DKBRANCH_DIR: ${DKBRANCH_DIR}"
	echo "DKBRANCH: ${DKBRANCH}"
	echo "DK3RDPARTY_DIR: ${DK3RDPARTY_DIR}"
	echo "DK3RDPARTY: ${DK3RDPARTY}"
	echo "DKIMPORTS_DIR: ${DKIMPORTS_DIR}"
	echo "DKIMPORTS: ${DKIMPORTS}"
	echo "DKAPPS_DIR: ${DKAPPS_DIR}"
	echo "DKAPPS: ${DKAPPS}"
	echo "DKBASH_DIR: ${DKBASH_DIR}"
	echo "DKBASH: ${DKBASH}"
	echo "DKBATCH_DIR: ${DKBATCH_DIR}"
	echo "DKBATCH: ${DKBATCH}"
	echo "DKCMAKE_DIR: ${DKCMAKE_DIR}"
	echo "DKCMAKE: ${DKCMAKE}"
	echo "DKDOCS_DIR: ${DKDOCS_DIR}"
	echo "DKDOCS: ${DKDOCS}"
	echo "DKPLUGINS_DIR: ${DKPLUGINS_DIR}"
	echo "DKPLUGINS: ${DKPLUGINS}"
	echo "DKTOOLS_DIR: ${DKTOOLS_DIR}"
	echo "DKTOOLS: ${DKTOOLS}"
	echo "DKDOWNLOAD_DIR: ${DKDOWNLOAD_DIR}"
	echo "DKDOWNLOAD: ${DKDOWNLOAD}"
}