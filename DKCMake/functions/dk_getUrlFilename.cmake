#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


####################################################################
# dk_getUrlFilename(<url> <ret:optional>)
#
function(dk_getUrlFilename)
	dk_debugFunc(1 2)

	set(url "${ARGV0}")
	dk_basename("${url}" dk_getUrlFilename)
	

	
	############ curl options ############	 
	# 	-Z, --time-cond 				only download if server file newer than local
	#	-R, --remote-time 				preserve the downloaded files time-stamp
	#	-L, --location	 				follow redirects
	#	-s, --silent					Do not show progress meter or error messages. 
	#	-S, --show-error				When used with --silent, it makes curl show an error message if it fails.
	#	-o, --output <file>				Write output to the given file instead of stdout.
	#	-I, --head						Fetch the headers only.
	#	-H, --header <header/@file>		Extra header to include in information sent.
	#	-f, --fail						Fail with error code 22 and with no response body output
	# 	-w, --write-out <format>		Display information on stdout after a completed transfer.
	#			filename_effective		The ultimate filename that curl writes out to.
	#			http_code				The numerical response code that was found in the last retrieved HTTP(S) or FTP(s) transfer.
	#	-O, --remote-name				Write output to a local file named like the remote file we get.
	#	-J, --remote-header-name		Tell the --remote-name option to use the server-specified Content-Disposition filename.
	#       --remove-on-error 			Remove the output file if an error occurs.
	#	    --output-dir				Directory to download the file to
	#		--create-dirs				
	
	dk_validate(curl.exe "dk_depend(curl.exe)")
	dk_realpath("${curl.exe}" curl.exe)
	dk_assertPath("${curl.exe}")
	#dk_pathToNative("${curl.exe}" curl.exe)
	
	#dk_set(dk_exec_ECHO_OUTPUT		1)													 
	#dk_set(dk_exec_ECHO_ERROR		1)
	#dk_set(dk_exec_ECHO				STDOUT) 	# STDERR, STDOUT, NONE
	#dk_set(dk_exec_ERROR_IS_FATAL	NONE)		# ANY, LAST, NONE
	#dk_set(dk_exec_ENCODING			ANSI)		# NONE, AUTO, ANSI, OEM, UTF-8, UTF8
	#dk_set(dk_exec_PRINT_CALL		1) 			# dk_exec_call
	#dk_set(dk_exec_PRINT_COMMAND	1) 			# dk_exec_command
	#dk_set(dk_exec_PRINT_EXITCODES	1)			# dk_exec_exitcodes
	#dk_set(dk_exec_PRINT_EXITCODE 	1)			# dk_exec_exitcode
	#dk_set(dk_exec_PRINT_STDERR 	1)			# dk_exec_stderr[]
	#dk_set(dk_exec_PRINT_STDOUT		1)			# dk_exec_stdout[]
	#dk_set(dk_exec_PRINT_OUTPUT 	1)			# dk_exec

	dk_exec("${curl.exe}" --silent --head --location "${url}")
	#execute_process(COMMAND "${curl.exe}" --silent --head --location "${url}" OUTPUT_VARIABLE dk_exec)
	#dk_set(dk_exec_ECHO_OUTPUT 1)	
	string(REPLACE ";" "#semicolon#" dk_exec_stdout "${dk_exec_stdout}")
	string(REPLACE "\n" ";" dk_exec_stdout "${dk_exec_stdout}")
	foreach(item IN LISTS dk_exec_stdout)
		#dk_debug("item = ${item}")
		string(TOLOWER "${item}" lower)
		if(lower MATCHES "content-disposition")
			#dk_debug("lower MATCHES content-disposition")
			#string(REPLACE "#semicolon#" ";" ContDisp ${item})
			string(REPLACE " " ";" ContDisp "${item}")
			message("ContDisp = ${ContDisp}")
			foreach(tag IN LISTS ContDisp)
				#dk_debug("tag = ${tag}")
				string(STRIP ${tag} tag)
				if(tag MATCHES ^filename)
					#dk_debug("tag MATCHES ^filename")
					if(NOT DEFINED filename)
						string(REPLACE "filename=" "" filename ${tag})
						if(NOT "${filename}" STREQUAL "")
							set(dk_getUrlFilename ${filename})
							#dk_debug("### dk_getUrlFilename = ${dk_getUrlFilename} ###")
						endif()
					endif()
					break()
				endif()
			endforeach()
		endif()
	endforeach()
	string(REPLACE "\"" "" dk_getUrlFilename "${dk_getUrlFilename}")

	###### return ######
	set(dk_getUrlFilename "${dk_getUrlFilename}" PARENT_SCOPE)
	if(${ARGC} GREATER 1)
		set(${ARGV1} "${dk_getUrlFilename}" PARENT_SCOPE)
	else()
		#message("${dk_getUrlFilename}")
	endif()
	
	dk_debug("dk_getUrlFilename = '${dk_getUrlFilename}'")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)

	dk_debugFunc(0)

	#set(url "https://go.microsoft.com/fwlink/?linkid=2124701")
	set(url "https://msedge.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/c55f85b8-c7f2-4d7e-849d-cd4bfe16b28a/MicrosoftEdgeWebView2RuntimeInstallerX64.exe")
	dk_getUrlFilename("${url}")
	message("${url} = '${dk_getUrlFilename}'")
	
	set(url "https://go.microsoft.com/fwlink/?linkid=2186537")
	dk_getUrlFilename("${url}")
	message("${url} = '${dk_getUrlFilename}'")
	
	set(url "https://dotnet.microsoft.com/en-us/download/dotnet-framework/thank-you/net35-sp1-offline-installer")
	dk_getUrlFilename("${url}")
	message("${url} = '${dk_getUrlFilename}'")
	
	set(url "https://aka.ms/vs/16/release/VC_redist.x86.exe")
	dk_getUrlFilename("${url}")
	message("${url} = '${dk_getUrlFilename}'")
	
	set(url "https://github.com/madler/zlib/archive/5a82f71e.zip")
	dk_getUrlFilename("${url}")
	message("${url} = '${dk_getUrlFilename}'")
	
	set(url "https://github.com/git-for-windows/git/releases/download/v2.46.2.windows.1/PortableGit-2.46.2-64-bit.7z.exe")
	dk_getUrlFilename("${url}")
	message("${url} = '${dk_getUrlFilename}'")
	
	set(url "https://repo.msys2.org/distrib/x86_64/msys2-base-x86_64-20241208.tar.xz")
	dk_getUrlFilename("${url}")
	message("${url} = '${dk_getUrlFilename}'")
	
	set(url "https://dl.google.com/android/repository/android-ndk-r23c-windows.zip")
	dk_getUrlFilename("${url}")
	message("${url} = '${dk_getUrlFilename}'")
endfunction()
