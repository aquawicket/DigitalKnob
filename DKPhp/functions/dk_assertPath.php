<?php

#$dk_assertPath_FORWARD_SLASHES=1;
#$dk_assertPath_CASE_SENSITIVE=1;
################################################################################
# dk_assertPath(path)
#
function dk_assertPath() {
	#dk_debugFunc(0, 99);
	include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/dk_success.php");
	include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/dk_error.php");
	
	if(!isset($argv)){
		$argv = func_get_args();
	}
	$path = "$argv[0]";
	if(substr("$path", -1) == "/" && substr("$path", -2) != ":/"){
		$path = substr("$path", 0, -1);
	}

	#### Test path exists ###
	if(file_exists("$path")){
		if($path == str_replace("\\", "/", realpath("$path"))){
			#dk_success("$argv[0]");
			return 0;
		}
	}
	
	if(file_exists("$$path")){
		if($$path == str_replace("\\", "/", realpath("$$path"))){
			#dk_success("$argv[0]");
			return 0;
		}
	}
	#dk_error("$argv[0]");

	dk_error("ASSERTION: dk_assertPath('$argv[0]'): not found\n");
	return -1;
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(!function_exists('DKTEST')){ function DKTEST() {
	#dk_debugFunc 0

	####### THESE SHOULD ALL BE FOUND ######
	#### Quoted ###
	dk_assertPath("C:/");										#OK
	# existing path w/ foward slashes
	dk_assertPath("C:/Program Files/Common Files");				#OK
	# existing path w/ trailing forwardslash
	dk_assertPath("C:/Program Files/Common Files/");			#OK
	# existing lower case path
	dk_assertPath("c:/program files/common files");				#Case mismatch
	# existing UPPER CASE path
	dk_assertPath("C:/PROGRAM FILES/COMMON FILES");				#Case mismatch
	# windows path
	dk_assertPath("C:\Program Files\Common Files");				#Delimiter mismatch
	# existing path w/ trailing backslash
	dk_assertPath("C:\\Program Files\\Common Files\\");			#Delimiter mismatch
	# existing path w/ mixed slashes
	dk_assertPath("C:/Program Files\Common Files");				#Delimiter mismatch
	# existing path w/ double forwardslashes
	dk_assertPath("C://Program Files//Common Files");			#Delimiter mismatch
	# existing path w/ double backslashes
	dk_assertPath("C:\\Program Files\\Common Files");			#Delimiter mismatch

	#### Quoted w/ special characters  i.e. ( and )
	# foward slashes w/ special characters
	dk_assertPath("C:/Program Files (x86)/Common Files");		#OK
	# trailing forwardslash w/ special characters
	dk_assertPath("C:/Program Files (x86)/Common Files/");		#OK
	# lower case w/ special characters
	dk_assertPath("c:/program files (x86)/common files");		#Case mismatch
	# UPPER CASE w/ special characters
	dk_assertPath("C:/PROGRAM FILES (X86)/COMMON FILES");		#Case mismatch
	# windows path w/ special characters
	dk_assertPath("C:\Program Files (x86)\Common Files");		#Delimiter mismatch
	# trailing backslash w/ special characters
	dk_assertPath("C:\\Program Files (x86)\\Common Files\\");	#Delimiter mismatch
	# existing path w/ mixed slashes
	dk_assertPath("C:/Program Files (x86)\Common Files");		#Delimiter mismatch
	# existing path w/ double forwardslashes
	dk_assertPath("C://Program Files (x86)//Common Files");		#Delimiter mismatch
	# existing path w/ double backslashes
	dk_assertPath("C:\\Program Files (x86)\\Common Files");		#Delimiter mismatch

	#### Unquoted ###
	/*
	# foward slashes
	dk_assertPath(C:/Program Files/Common Files);				#OK
	# trailing forwardslash
	dk_assertPath(C:/Program Files/Common Files/);				#OK
	# lower case
	dk_assertPath(c:/program files/common files);				#Case mismatch
	# UPPER CASE
	dk_assertPath(C:/PROGRAM FILES/COMMON FILES);				#Case mismatch
	# windows path
	dk_assertPath(C:\Program Files\Common Files);				#Delimiter mismatch
	# trailing backslash
	dk_assertPath(C:\Program Files\Common Files\);				#Delimiter mismatch
	# existing path w/ mixed slashes
	dk_assertPath(C:/Program Files\Common Files);				#Delimiter mismatch
	# existing path w/ double forwardslashes
	dk_assertPath(C://Program Files//Common Files);				#Delimiter mismatch
	# existing path w/ double backslashes
	dk_assertPath(C:\\Program Files\\Common Files);				#Delimiter mismatch
	*/
	
	#### as variable ###
	$myPath="C:/Program Files/Common Files";
	# As a variable name
	#dk_assertPath(myPath);										#undefined constant
	# As a variable name quoted
#	dk_assertPath("myPath");									#OK
	# As a variable using quoted
	dk_assertPath("$myPath");									#OK
	# As a variable without quotes
	dk_assertPath($myPath);										#OK


	### as variable w/ special characters  i.e. ( and ) ###
	$myPath="C:/Program Files (x86)/Common Files";
	# As a variable name
	#dk_assertPath(myPath);										#undefined constant
	# As a quoted variable name
#	dk_assertPath("myPath");									#OK
	# as a ariable using %'s quoted
	dk_assertPath("$myPath");									#OK
	# As a variable without quotes
	dk_assertPath($myPath);										#CMD ERROR

	### Unquotes w/ special characters  i.e. ( and )
	/*
	# foward slashes
	dk_assertPath(C:/Program Files (x86)/Common Files);			#CMD ERROR
	# trailing forwardslash
	dk_assertPath(C:/Program Files (x86)/Common Files/);		#CMD ERROR
	# lower case
	dk_assertPath(c:/program files (x86)/common files);			#CMD ERROR
	# UPPER CASE
	dk_assertPath(C:/PROGRAM FILES (X86)/COMMON FILES);			#CMD ERROR
	# windows path
	dk_assertPath(C:\Program Files (x86)\Common Files);			#CMD ERROR
	# trailing backslash
	dk_assertPath(C:\Program Files (x86)\Common Files\);		#CMD ERROR
	*/
	
	###### THESE SHOULD ALL BE (NOT FOUND) ######
	# nonexistent path
	dk_assertPath("C:/NonExistent (x86)/Common Files");			#ASSERT
	# nonexistent lower case path
	dk_assertPath("c:/NonExistent (x86)/common files");			#ASSERT
	# nonexistent UPPER CASE path
	dk_assertPath("C:/NonExistent (x86)/COMMON FILES");			#ASSERT
	# nonexistent windows path
	dk_assertPath("C:\\NonExistent (x86)\\Common Files");		#ASSERT
	# nonexistent No quotes path
	#dk_assertPath(C:/NonExistent (x86)/Common Files);			#CMD ERROR
}}


include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/DK.php");
?>