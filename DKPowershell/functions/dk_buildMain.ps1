if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_buildMain_ps1){ $dk_buildMain_ps1 = 1; } else{ return; } #include guard

####################################################################
# dk_buildMain()
#
#
function Global:dk_buildMain() {
	dk_debugFunc 0;

	trap {
		"Error found: $_"
		dk_call dk_stacktrace
	}

# 	dk_call dk _validateSudo
	
#	if dk _defined WSLENV; then 
#		dk_call dk_info "WSLENV is on"
#		dk_call dk_info "calling sudo chown -R ${LOGNAME} ${HOME} to allow windows write access to \\\wsl.localhost\DISTRO\home\\${LOGNAME}"
#		sudo chown -R "${LOGNAME}" "${HOME}"
#	fi

	#dk_call dk_printVar SHLVL
	#dk_call dk_printVar MSYSTEM
	#dk_call dk_printVar DKSCRIPT_PATH
	#dk_call dk_printVar DKSCRIPT_DIR
	#dk_call dk_printVar DKSCRIPT_NAME
	
	### Get the Host_Tuple and other HOST variables
	dk_call dk_Host_Tuple
	dk_call dk_DIGITALKNOB_DIR
	dk_call dk_installGit
	dk_call dk_DKBRANCH_DIR
	
	if(!(Test-Path "$(dk_call dk_DKDESKTOP_DIR)/DigitalKnob.lnk")){
		dk_call dk_createShortcut "$(dk_call dk_DIGITALKNOB_DIR)" "$(dk_call dk_DKDESKTOP_DIR)/DigitalKnob.lnk"
	}
	
	dk_call dk_quickAccessPin "$(dk_call dk_DIGITALKNOB_DIR)"
	
	if(!(Test-Path "$(dk_call dk_DKDESKTOP_DIR)/DKBuilder.ps1.lnk")){
		dk_call dk_createShortcut "$(dk_call dk_DKBRANCH_DIR)/DKPowershell/apps/DKBuilder/DKBuilder.ps1" "$(dk_call dk_DKDESKTOP_DIR)/DKBuilder.ps1.lnk"
	}
	
	if("${DKSCRIPT_DIR}" -ne "${dk_call dk_DKBRANCH_DIR}"){
		dk_call dk_warning "${DKSCRIPT_NAME} is not running from the DKBRANCH_DIR directory. Any changes will not be saved by git!"
		dk_call dk_warning "${DKSCRIPT_NAME} path = ${DKSCRIPT_DIR}"
		dk_call dk_warning "DKBRANCH_DIR path = ${env:DKBRANCH_DIR}"
	}
	
	$running=1;
	while($running){  
		if(!${UPDATE})			{ dk_call dk_pickUpdate;  	continue; }
		if(!${Target_App})		{ dk_call dk_Target_App;    continue; }
		if(!${Target_Tuple})	{ dk_call dk_Target_Tuple;  continue; }
		if(!${Target_Type})		{ dk_call dk_Target_Type;   continue; }
		
		dk_call dk_createCache;
		
		########### CMAKE Command ###################
		dk_call dk_chdir "$(dk_call dk_DKBRANCH_DIR)/DKCpp/apps/${Target_App}";
		dk_call dk_validate CMAKE_EXE "dk_call dk_depend cmake";
		dk_call ${CMAKE_EXE} -P "$(dk_call dk_DKBRANCH_DIR)/DKCpp/apps/${Target_App}/DKINSTALL.cmake";
		#dk_call dk_cmakeEval "dk_load('${dk_call dk_DKBRANCH_DIR}/DKCpp/apps/${Target_App}/DKINSTALL.cmake')";
		
		#dk_call dk_generate;	
		#dk_call dk_buildApp;
		
		dk_call dk_unset UPDATE;
		dk_call dk_unset Target_App;
		dk_call dk_unset Target_Tuple;
		dk_call dk_unset Target_Type;
	}  
}

