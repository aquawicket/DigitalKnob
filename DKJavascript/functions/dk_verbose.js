// shebang
//#####################################################################################################
//file:///C:/Users/Administrator/DigitalKnob/Development/DKJavascript/functions/dk_fileContains.js
if(typeof ActiveXObject === "function"){
	if(typeof wscript_shell !== "object")	{ var wscript_shell = new ActiveXObject("WScript.Shell"); }
	if(typeof ENV !== "object")				{ var ENV = wscript_shell.Environment("Process"); }
	if(typeof ENV === "object" && typeof wscript_shell === "object" && ENV("DKINIT_js") === "") {	
		ENV("DKINIT_js") = WScript.ScriptFullName;
		wscript_shell.Run("cmd /k mshta.exe \"file:///C:/Users/Administrator/DigitalKnob/Development/DKHta/functions/DK.hta\" | for /f \"delims=\" %a in ('findstr \"^\"') do 	@echo %a", 1, 1);
		throw new Error('Program Terminated');
	}
}
//#####################################################################################################


dk_source(DKJAVASCRIPT_DIR+"/functions/dk_log.js");

//### dk_verbose() Settings ###
if(!dk_valid("VERBOSE"))				{ var VERBOSE="VERBOSE"; 				}
if(!dk_valid("dk_log_VERBOSE_ENABLE"))	{ var dk_log_VERBOSE_ENABLE=1;			}
if(!dk_valid("dk_log_VERBOSE_COLOR"))	{ var dk_log_VERBOSE_COLOR=magenta; 	}
if(!dk_valid("dk_log_VERBOSE_TAG"))		{ var dk_log_VERBOSE_TAG="VERBOSE: "; 	}
if(!dk_valid("dk_log_VERBOSE_TRACE"))	{ var dk_log_VERBOSE_TRACE=0;			}
if(!dk_valid("dk_log_VERBOSE_LINE"))	{ var dk_log_VERBOSE_LINE=0; 			}
if(!dk_valid("dk_log_VERBOSE_SOUND"))	{ var dk_log_VERBOSE_SOUND=0;			}
if(!dk_valid("dk_log_VERBOSE_TIMEOUT"))	{ var dk_log_VERBOSE_TIMEOUT=0; 		}
if(!dk_valid("dk_log_VERBOSE_PAUSE"))	{ var dk_log_VERBOSE_PAUSE=0; 			}
if(!dk_valid("dk_log_VERBOSE_HALT"))	{ var dk_log_VERBOSE_HALT=0; 			}
//################################################################################
//# dk_verbose(msg)
//#
//#     Print an verbose message to the console
//#
//#     @msg    - The message to print
//#
dk_verbose = function dk_verbose(){
	
	

	dk_log("VERBOSE", arguments[0]);
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);
	
	dk_verbose("test dk_verbose VERBOSE message");
}
