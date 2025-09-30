#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################

#dk_load("$ENV{DKCMAKE_DIR}/DKVariables.cmake") # For Global settings and variables

#########################################################################
# dk_configure(Source_Dir, args...)
#
#	@Install_Path - The path to the configure file to use, CMakeLists.txt for cmake, configure for Unix, Etc.
#				  If no Install_Path is specified, ${${CURRENT_PLUGIN}} will be used
#
function(dk_configure)
	dk_debugFunc(0 99)
	dk_debug("dk_configure(${ARGV})")

	###### Source_Dir ######
	if(ARGV)
		set(Source_Dir "${ARGV0}")
	elseif(${CURRENT_PLUGIN})
		set(Source_Dir "${${CURRENT_PLUGIN}}")
	endif()
	dk_assertPath("${Source_Dir}")
	if(NOT "${Source_Dir}" STREQUAL "${${CURRENT_PLUGIN}}")
		dk_notice("dk_build(): Source_Dir:${Source_Dir} != ${CURRENT_PLUGIN}:${${CURRENT_PLUGIN}}")
	endif()
	dk_debug("Source_Dir = ${Source_Dir}")

	### Config_Dir ###
	dk_validate(${CURRENT_PLUGIN}_Config_Dir "dk_Target_Config()")
	set(Config_Dir "${${CURRENT_PLUGIN}_Config_Dir}")
	dk_debug("Config_Dir = ${Config_Dir}")
	
	### Build_Dir ###
	dk_validate(${CURRENT_PLUGIN}_Build_Dir "dk_Target_Config()")
	set(Build_Dir "${${CURRENT_PLUGIN}_Build_Dir}")
	dk_debug("Build_Dir = ${Build_Dir}")
	
	#dk_printPrefixVars(${CURRENT_PLUGIN})
	
	###### dk_allButFirstArgs ######
	if(ARGV)
		dk_call(dk_allButFirstArgs ${ARGV})
	endif()
	
	#if(NOT REBUILDALL)
		#dk_debug("${CURRENT_PLUGIN}_LIBS = ${${CURRENT_PLUGIN}_LIBS}")
		foreach(lib ${${CURRENT_PLUGIN}_LIBS})
			if(NOT DEFINED missing_libs)
				set(missing_libs 0)
			endif()
			if(NOT EXISTS "${lib}")
				set(missing_libs 1)
			endif()
		endforeach()
		if("${missing_libs}" EQUAL "0")
			dk_notice("${CURRENT_PLUGIN} libs already built. skipping...")
			return()
		endif()
	#endif()
	
	#if(REBUILDALL)
		dk_call(dk_clearCmakeCache "${Config_Dir}")
	#endif()

	# Path checks needs to be case sensitive. 
	# For example, openssl has Configure in it's root directory. On windows, if(EXISTS ${Install_Path}/configure) will return true.
	# This will cause problems on unix and any casesensitive platforms, so we use dk_pathExists because it is case sensitive.
	dk_call(dk_pathExists "${Source_Dir}/CMakeLists.txt" 	CMakeLists.txt)
	dk_pathExists("${Source_Dir}/configure"      			configure)
	dk_pathExists("${Source_Dir}/configure.ac"   			configure.ac)

	
	############ Configure with CMAKE ############
	# Configure with CMake		(multi_config / single_config)
	#
	if(CMakeLists.txt)
		dk_info("###### Configuring ${CURRENT_PLUGIN} with CMake ######")	
		dk_validate(DKCMAKE_DIR		"dk_DKBRANCH_DIR()") 
		dk_validate(CMAKE_GENERATOR	"dk_load(${DKCMAKE_DIR}/DKBuildFlags.cmake)")
		dk_validate(cmake_exe		"dk_depend(cmake)")
		
		#### create thr Cmake configure command ###
		dk_validate(DKCMAKE_BUILD	"dk_load(${DKCMAKE_DIR}/DKBuildFlags.cmake)")
		set(command_list ${DKCMAKE_BUILD} ${dk_allButFirstArgs} "-S" "${Source_Dir}" "-B" "${Config_Dir}")		
		dk_mergeFlags("${command_list}" command_list)		
	
		#### Execute the Cmake configure command ####
		dk_set(dk_exec_PRINT_COMMAND 1)
		dk_exec(${command_list})	
		dk_replaceAll("${command_list}" ";" "\" \n\"" command_string)
		dk_fileWrite("${Config_Dir}/DKBUILD.log" "\"${command_string}\"\n\n")
		
		#### restore any altered flags ####
		dk_set(DKCMAKE_BUILD ${cmake_exe} -G ${CMAKE_GENERATOR} ${DKCMAKE_FLAGS})
		
		
	############ Configure with ../../configure ############
	#
	elseif(configure OR configure.ac)
		#### cd into build directory
		set(OLDPWD "${PWD}")
		if(NOT EXISTS "${Build_Dir}")
			dk_mkdir("${Build_Dir}")
		endif()		
		dk_chdir("${Build_Dir}")
		
		# Configure with Autotools	(single_config)
		dk_echo("###### Configuring ${CURRENT_PLUGIN} with ../../configure ######")
			
		dk_fileAppend("${Build_Dir}/DKBUILD.log" "../../configure ${DKCONFIGURE_FLAGS} ${dk_allButFirstArgs}\n")
		if(EXISTS "${${CURRRENT_PLUGIN}}/configure")
			if(Windows_Host AND (MSYSTEM OR Android OR Emscripten))
				dk_validate(bash_exe "dk_depend(bash)")
				dk_exec(${bash_exe} -c "../../configure ${DKCONFIGURE_FLAGS} ${dk_allButFirstArgs}")
				dk_fileAppend("${Build_Dir}/DKBUILD.log" "${dk_exec}\n\n\n")
			else()
				dk_exec(../../configure ${DKCONFIGURE_FLAGS} ${dk_allButFirstArgs})
				dk_fileAppend("${Build_Dir}/DKBUILD.log" "${dk_exec}\n\n\n")
			endif()
		else()
			dk_warning("No configure file found. It may need to be generated with autotools")
		endif()
			
		#### restore any altered flags ####
		if(Emscripten)
			dk_set(DKCONFIGURE_BUILD ${EMCONFIGURE} ../../configure ${DKCONFIGURE_FLAGS})
		else()
			dk_set(DKCONFIGURE_BUILD ../../configure ${DKCONFIGURE_FLAGS})
		endif()
		
		#### return to previous working directory
		dk_chdir("${OLDPWD}")
		
	############ configure with provided commands #############
	# No Specific configure type. Just pass the arguments to dk_exec to run	
	#
	else()
		#### cd into build directory
		set(OLDPWD "${PWD}")
		if(NOT EXISTS "${Build_Dir}")
			dk_mkdir("${Build_Dir}")
		endif()	
		dk_chdir("${Build_Dir}")
		
		dk_notice("###### configure type not detected for ${CURRENT_PLUGIN}. Running provided commands unaltered ######")
		dk_fileAppend("${Build_Dir}/DKBUILD.log" "${dk_allButFirstArgs}\n")
			
		#f(Windows_Host AND (MSYSTEM OR Android OR Emscripten))
		#	dk_exec(${dk_allButFirstArgs} BASH_ENV OUTPUT_VARIABLE echo_output) # ERROR_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)
		#	dk_fileAppend("${Build_Dir}/DKBUILD.log" "${echo_output}\n\n\n")
		#else()
		if(dk_allButFirstArgs)
			dk_exec(${dk_allButFirstArgs}) # ERROR_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)
			dk_fileAppend("${Build_Dir}/DKBUILD.log" "${dk_exec}\n\n\n")
			dk_unset(dk_allButFirstArgs)
		endif()
		
		#### return to previous working directory
		dk_chdir("${OLDPWD}")
	endif()
	
	
	
	
	#### restore any altered flags ####
	dk_set(DKCMAKE_BUILD ${cmake_exe} -G ${CMAKE_GENERATOR} ${DKCMAKE_FLAGS})  
	if(Emscripten)
		dk_set(DKCONFIGURE_BUILD ${EMCONFIGURE} ../../configure ${DKCONFIGURE_FLAGS})
	else()
		dk_set(DKCONFIGURE_BUILD ../../configure ${DKCONFIGURE_FLAGS})
	endif()
	
######### TODO - revamp the variable system ##################################	
#	
#	 Old Variable            New Variable                    Value
#	
#	  ${PLUGIN}		  	  ${CURRENT_PLUGIN}					:LIBEXPAT
#	${${PLUGIN}}		${${CURRENT_PLUGIN}}				:LIBEXPAT 				= C:/Users/Administrator/DigitalKnob/Development/3rdParty/libexpat-b70c8f5
#						${${CURRENT_PLUGIN}_Install_Name}	:LIBEXPAT_Install_Name	= libexpat-b70c8f5
#     ${Plugin}   		${${CURRENT_PLUGIN}_Import_Name}  	:LIBEXPAT_Import_Name 	= libexpat
#     ${Plugin_Path}	${${CURRENT_PLUGIN}_Import_Path}    :LIBEXPAT_Import_Path 	= C:/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/libexpat
#						CMAKE_INSTALL_PREFIX 										= C:/Users/Administrator/DigitalKnob/DKBIN

	#dk_set(${CURRENT_PLUGIN}_Import_Path "${Plugin_Path}")
	#dk_debug("${CURRENT_PLUGIN}_Import_Path = ${${CURRENT_PLUGIN}_Import_Path}")
	#dk_debug("${CURRENT_PLUGIN}_Import_Name = ${${CURRENT_PLUGIN}_Import_Name}")
	#dk_debug("CMAKE_INSTALL_PREFIX = ${CMAKE_INSTALL_PREFIX}")
	
	# ADD THE 3rdParty library TO THE APP SOLUTION
#	if(PROJECT_INCLUDE_3RDPARTY)
#		if(NOT CMAKE_SCRIPT_MODE_FILE)
#			if(EXISTS "${${CURRENT_PLUGIN}}/CMakeLists.txt")
#				dk_debug("adding ${${Plugin}} to the project solution")
#				add_subdirectory("${${CURRENT_PLUGIN}}" "${Config_Dir}")
#			endif()
#		endif()
#	endif(PROJECT_INCLUDE_3RDPARTY)
	
	# Install 3rd Party Libs
	if(INSTALL_DKLIBS)
		#if(${isDKPlugin} EQUAL -1)
			if(EXISTS "${Config_Dir}/cmake_install.cmake")
				dk_exec(${CMAKE_COMMAND} --install "${Config_Dir}")
			endif()
		#endif()
	endif(INSTALL_DKLIBS)
	
	
	if("${${CURRENT_PLUGIN}}" MATCHES "${DKCPP_PLUGINS_DIR}") ##### TEST ME:
		# Install header files for DKPlugin
		if(INSTALL_DKLIBS)
			dk_info("Installing ${Plugin} header files")
			file(INSTALL DIRECTORY "${${CURRENT_PLUGIN}}/" DESTINATION ${CMAKE_INSTALL_PREFIX}/include/${Plugin} FILES_MATCHING PATTERN "*.h")
			dk_deleteEmptyDirectories("${CMAKE_INSTALL_PREFIX}/include/${Plugin}")
		endif()
		
		#Add the DKPlugin to the app project
#		if(PROJECT_INCLUDE_DKPLUGINS)
#			if(NOT CMAKE_SCRIPT_MODE_FILE)
#				if(EXISTS "${${CURRENT_PLUGIN}}/CMakeLists.txt")
#					add_subdirectory("${${CURRENT_PLUGIN}}" "${Config_Dir}")
#				endif()
#			endif()
#		endif()
		
		# Install DKPlugin Libs
		if(INSTALL_DKLIBS)
			if(EXISTS "${Config_Dir}/cmake_install.cmake")
				dk_exec(${CMAKE_COMMAND} --install "${Config_Dir}")
			endif()
		endif()
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_depend(zlib)
	dk_configure(${zlib})
endfunction()