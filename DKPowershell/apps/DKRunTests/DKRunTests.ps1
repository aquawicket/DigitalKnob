if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1 } else { . '${PSScriptRoot}/DK.ps1' }
if(!$RUNTEST_ps1){ $RUNTEST_ps1 = 1; } else{ return; } #include guard


#####################################
function Global:RUNTEST() {
	Write-Host "RUNTEST()";
#	if ! [ "#${disabled/;${1};//}#" = "#${disabled}#" ]; then
#		echo "${yellow} ######### ${1} is disabled ######### ${clr}";
#		return;
#	fi
#	echo "######## ${DKBASH_FUNCTIONS_DIR_}${1} #######";
#	[ ! -e "${DKBASH_FUNCTIONS_DIR_}${1}" ] && return -1
#	dk_call dk_fileContains "${DKBASH_FUNCTIONS_DIR_}${1}" "DKTEST(" || return -1
#	
#	CURRENT_TEST_FILE="${1}";
#	echo "">> 								$(dirname $0)/log.txt
#	echo "######### ${1} #########">> 		$(dirname $0)/log.txt
#	#title TESTING "### %~nx1 ###"
#	echo "";
#	echo "${bg_magenta}${white}###### DKTEST MODE ###### ${1} ###### DKTEST MODE ######${clr}";
#	echo "";
#	. "${DKBASH_FUNCTIONS_DIR_}${1}";
#	DKTEST && (
#		echo "        ### passed status:$?">> 		$(dirname $0)/log.txt
#	) || (
#		echo "        ### FAILED status:$?">> 		$(dirname $0)/log.txt
#	)
#	echo "";
#	echo "${bg_magenta}${white}######## END TEST ####### ${1} ######## END TEST #######${clr}";
#	echo "";
}

#####################################
function Global:DKRunTests() {
	Write-Host "DKRunTests()";
#	DISABLE __ARGC__.sh;
#	DISABLE __ARG__.sh;
#	DISABLE __ARGV__.sh;
#	
#	dk_call dk_validate DKBASH_FUNCTIONS_DIR_ "dk_call dk_DKBRANCH_DIR";
#	dk_call dk_getFiles ${DKBASH_FUNCTIONS_DIR_} _files_;
#	
#	### Clear log.txt
#	echo "" > $(dirname $0)/log.txt
#	
#	#set "dk_log_ERROR_CALLBACK=call %~f0 :CALLBACK"
#	#set "dk_log_FATAL_CALLBACK=call %~f0 :CALLBACK"
#	
#	#set "READY=1"
#	for ((i=0; i<${#_files_[@]}; i++)); do
#		echo "RUNTEST ${_files_[$i]}";
#		RUNTEST "${_files_[$i]}";
#	done
}

#####################################
function Global:DISABLE() {
	Write-Host "DISABLE()";
#	export disabled="${disabled-};${1};"
}



#####################################
function Global:CALLBACK() {
	Write-Host "CALLBACK()";
#	echo "CALLBACK()"
}

#####################################
#function Global:DK TEST() {
#	echo "DK TEST()"
#	read -p '';
#}

