if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1 } else { . '${PSScriptRoot}/DK.ps1' }
if(!$DKRUNTEST_ps1){ $DKRUNTEST_ps1 = 1; } else{ return; } #include guard


#####################################
function Global:RUNTEST() {
	if(${disabled} -Match $args[0]){
		echo "${yellow} ######### $($args[0]) is disabled ######### ${clr}";
		return;
	}
	#echo "######## ${DKPOWERSHELL_FUNCTIONS_DIR_}$($args[0]) #######";
	if((Test-Path ${DKPOWERSHELL_FUNCTIONS_DIR_}$($args[0]))){ 
		if(!(dk_call dk_fileContains "${DKPOWERSHELL_FUNCTIONS_DIR_}$($args[0])" "function GLOBAL:DKTEST()")){
			${global:CURRENT_TEST_FILE}="$($args[0])";
			echo "">> 										${PSScriptRoot}/log.txt
			echo "######### $($args[0]) #########">> 		${PSScriptRoot}/log.txt
		#	#title TESTING "### %~nx1 ###"
			echo "";
			echo "${bg_magenta}${white}###### DKTEST MODE ###### $($args[0]) ###### DKTEST MODE ######${clr}";
			echo "";
			. "${DKPOWERSHELL_FUNCTIONS_DIR_}$($args[0])";
			DKTEST; #&& (
		#		echo "        ### passed status:$?">> 		${PSScriptRoot}/log.txt
		#	) || (
		#		echo "        ### FAILED status:$?">> 		${PSScriptRoot}/log.txt
		#	)
			echo "";
			echo "${bg_magenta}${white}######## END TEST ####### $($args[0]) ######## END TEST #######${clr}";
			echo "";
		}
	}
}

#####################################
function Global:DKRunTests() {
	Write-Host "DKRunTests()";

	DISABLE collect-wsl-logs.ps1;
	DISABLE dk_copy.ps1;
	DISABLE dk_confirm.ps1;
	DISABLE dk_download.ps1;
	DISABLE dk_dumpLogProfile.ps1;
	DISABLE dk_exit.ps1;
	DISABLE dk_extract.ps1;
	DISABLE dk_enterManually.ps1;
	DISABLE dk_generate.ps1;
	DISABLE dk_import.ps1;
	DISABLE dk_imgToIco.ps1;
	DISABLE dk_gitUpdate.ps1;
	DISABLE dk_installCmake.ps1;
	DISABLE dk_gitCommit.ps1;
	DISABLE dk_installGit.ps1;
	DISABLE dk_keyboard.ps1;
	DISABLE dk_move.ps1;
	DISABLE dk_pickUpdate.ps1;
	DISABLE dk_reload.ps1;
	DISABLE dk_smartExtract.ps1;
	DISABLE dk_resetAll.ps1;
	
	
	dk_call dk_validate DKPOWERSHELL_FUNCTIONS_DIR_ "dk_call dk_DKBRANCH_DIR";
	$_files_ = dk_call dk_getFiles ${DKPOWERSHELL_FUNCTIONS_DIR_};
	
	### Clear log.txt
	echo "" > ${PSScriptRoot}/log.txt

	#set "dk_log_ERROR_CALLBACK=call %~f0 :CALLBACK"
	#set "dk_log_FATAL_CALLBACK=call %~f0 :CALLBACK"
	
	#set "READY=1"
	for($i=0; $i -lt $_files_.count; $i++) {
		#dk_call dk_echo "${cyan}_files_[$i] = ${blue}'$($_files_[$i])'${clr}";
		RUNTEST "$($_files_[$i])";
	}
}

#####################################
function Global:DISABLE() {
	Write-Host "DISABLE($($args[0]))";

	${global:disabled}="${disabled};$($args[0]);"
}



#####################################
function Global:CALLBACK() {
	Write-Host "CALLBACK()";
#	echo "CALLBACK()"
}



