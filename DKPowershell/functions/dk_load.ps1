#@echo off
#call DK
#if defined include_guard_dk_load ( goto:eof ) else set include_guard_dk_load=1

#####################################################################
## dk_load()
##
##
function dk_load($func) {
	#if not exist "%DKBATCH_DIR%\functions\dk_debugFunc.cmd" call dk_download "%DKHTTP%/dk_debugFunc.cmd" "%DKBATCH_DIR%\functions\dk_debugFunc.cmd"
	#dk_debugFunc
	
	
	#if not exist "$DKPOWERSHELL_DIR\functions\dk_download.cmd" powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP%/dk_download.cmd', '%DKBATCH_DIR%\functions\dk_download.cmd')"
	#if not exist "$DKPOWERSHELL_DIR\functions\%~1.cmd" dk_download "%DKHTTP%/%~1.cmd" "%DKBATCH_DIR%\functions\%~1.cmd"
	echo "dk_load($func): Import-Module $DKPOWERSHELL_DIR\functions\$func.ps1"

	Import-Module -Global $DKPOWERSHELL_DIR\functions\$func.ps1



#	call %*
	
#	local fn=
#	[ -z $1 ] && return 0 #true
#	
#	if [ -f "$1" ]; then
#		fpath=$1
#		fn=$(basename ${fpath})
#	    fn="${fn%.*}"
#	else
#		fn=$1
#		fpath=$DKBASH_DIR/functions/$fn.sh
#	fi
#	
#	# Convert to unix line endings if CRLF found
#	#if file_exists $fpath; then
#		if [[ $(file -b - < $fpath) =~ CRLF ]]; then
#			echo Converting file to Unix line endings
#			sed -i -e 's/\r$//' $fpath
#		fi
#	#fi
#	
#	if [ -f $fpath ]; then
#		declare ${fn}=$fpath
#  else
#        echo "$fpath: file not found"
#    fi
#	
#	if [[ $dk_load_list =~ "$fn" ]]; then
#		# if allready in list, do nothing
#       echo "$fn: already in the list" 	
#        return 0
#    else
#		dk_load_list="${dk_load_list};$fn" # Add to list
#
#		funcs=($(grep -o "[Dd][Kk]_.[A-Za-z0-9_\t]*" ${!fn}))
#		targets=($(printf "%s\n" "${funcs[@]}" | sort -u));
#        for value in "${targets[@]}"
#        do
#			#echo "${fn}: $value"
#            if [[ $dk_load_list =~ "$value" ]]; then
#                #echo "${fn}: skipping $value.    already in load_list"
#				continue
#            elif [[ ${fn} == $value ]]; then
#			   #echo "${fn}: skipping $value.    already matches fn"
#			   continue
#            elif [[ $(command -v $value) != "" ]]; then
#			   #echo "${fn}: skipping $value.    command already recognized"
#			   continue
#            else
#               #echo "$fn: dk_load( $value )"
#               dk_load $value
#            fi
#        done
#		
#		if [ -f "${!fn}" ]; then
#			#echo "{@}: ${@}"
#			#echo "{fn}: ${!fn}"
#			if ! [ $@ == ${!fn} ]; then
#				#echo "source $fn"
#				echo "$fn: include(${!fn})"
#				source "${!fn}"
#			fi
#			return 0
#		fi
#    fi
}

#call dk_load "%*"