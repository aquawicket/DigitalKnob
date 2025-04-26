//if(!dk_valid("DK"))		{ dk_source(DKJAVASCRIPT_DIR+"/functions/DK.js", function(){});			}
if(!dk_valid("dk_color"))	{ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_color.js", function(){}); 	}


//############ dk_log SETTINGS ############
if(!dk_valid("dk_log_ENABLE"))			{ var dk_log_ENABLE = 1; }

//### DEFAULT ###
if(!dk_valid("DEFAULT"))				{ var DEFAULT="DEFAULT"; 			}
if(!dk_valid("dk_log_DEFAULT_ENABLE"))	{ var dk_log_DEFAULT_ENABLE=1; 		}
if(!dk_valid("dk_log_DEFAULT_COLOR"))	{ var dk_log_DEFAULT_COLOR=white; 	}
if(!dk_valid("dk_log_DEFAULT_TAG"))		{ var dk_log_DEFAULT_TAG=""; 		}
if(!dk_valid("dk_log_DEFAULT_TRACE"))	{ var dk_log_DEFAULT_TRACE=0;		}
if(!dk_valid("dk_log_DEFAULT_LINE"))	{ var dk_log_DEFAULT_LINE=0; 		}
if(!dk_valid("dk_log_DEFAULT_SOUND"))	{ var dk_log_DEFAULT_SOUND=0;		}
if(!dk_valid("dk_log_DEFAULT_TIMEOUT"))	{ var dk_log_DEFAULT_TIMEOUT=0; 	}
if(!dk_valid("dk_log_DEFAULT_PAUSE"))	{ var dk_log_DEFAULT_PAUSE=0; 		}
if(!dk_valid("dk_log_DEFAULT_HALT"))	{ var dk_log_DEFAULT_HALT=0; 		}

//### VERBOSE ###
if(!dk_valid("VERBOSE"))				{ var VERBOSE="VERBOSE"; 			}
var dk_log_VERBOSE_ENABLE=1;
var dk_log_VERBOSE_COLOR=magenta;
var dk_log_VERBOSE_TAG="VERBOSE: ";
var dk_log_VERBOSE_TRACE=0;
var dk_log_VERBOSE_LINE=0;
var dk_log_VERBOSE_SOUND=0;
var dk_log_VERBOSE_TIMEOUT=0;
var dk_log_VERBOSE_PAUSE=0;
var dk_log_VERBOSE_HALT=0;

//### DEBUG ###
if(!dk_valid("DEBUG"))					{ var DEBUG="DEBUG"; 				}
var dk_log_DEBUG_ENABLE=1;
var dk_log_DEBUG_COLOR=lblue;
var dk_log_DEBUG_TAG="DEBUG: ";
var dk_log_DEBUG_TRACE=0;
var dk_log_DEBUG_LINE=0;
var dk_log_DEBUG_SOUND=0;
var dk_log_DEBUG_TIMEOUT=0;
var dk_log_DEBUG_PAUSE=0;
var dk_log_DEBUG_HALT=0;

//### INFO ###
if(!dk_valid("INFO"))					{ var INFO="INFO"; 					}
var dk_log_INFO_ENABLE=1;
var dk_log_INFO_COLOR=white;
var dk_log_INFO_TAG="INFO: ";
var dk_log_INFO_TRACE=0;
var dk_log_INFO_LINE=0;
var dk_log_INFO_SOUND=0;
var dk_log_INFO_TIMEOUT=0;
var dk_log_INFO_PAUSE=0;
var dk_log_INFO_HALT=0;

//### SUCCESS ###
if(!dk_valid("SUCCESS"))				{ var SUCCESS="SUCCESS"; 			}
var dk_log_SUCCESS_ENABLE=1;
var dk_log_SUCCESS_COLOR=green;
var dk_log_SUCCESS_TAG="SUCCESS: ";
var dk_log_SUCCESS_TRACE=0;
var dk_log_SUCCESS_LINE=0;
var dk_log_SUCCESS_SOUND=0;
var dk_log_SUCCESS_TIMEOUT=0;
var dk_log_SUCCESS_PAUSE=0;
var dk_log_SUCCESS_HALT=0;

//### TODO ###
if(!dk_valid("TODO"))					{ var TODO="TODO"; 					}
var dk_log_TODO_ENABLE=1;
var dk_log_TODO_COLOR=blue;
var dk_log_TODO_TAG="TODO: ";
var dk_log_TODO_TRACE=0;
var dk_log_TODO_LINE=0;
var dk_log_TODO_SOUND=0;
var dk_log_TODO_TIMEOUT=1;
var dk_log_TODO_PAUSE=0;
var dk_log_TODO_HALT=0;

//### NOTICE ###
if(!dk_valid("NOTICE"))					{ var NOTICE="NOTICE"; 				}
var dk_log_NOTICE_ENABLE=1;
var dk_log_NOTICE_COLOR=lyellow;
var dk_log_NOTICE_TAG="NOTICE: ";
var dk_log_NOTICE_TRACE=0;
var dk_log_NOTICE_LINE=0;
var dk_log_NOTICE_SOUND=0;
var dk_log_NOTICE_TIMEOUT=0;
var dk_log_NOTICE_PAUSE=0;
var dk_log_NOTICE_HALT=0;

//### FIXME ###
if(!dk_valid("FIXME"))					{ var FIXME="FIXME"; 				}
var dk_log_FIXME_ENABLE=1;
var dk_log_FIXME_COLOR=lyellow;
var dk_log_FIXME_TAG="FIXME: ";
var dk_log_FIXME_TRACE=0;
var dk_log_FIXME_LINE=0;
var dk_log_FIXME_SOUND=0;
var dk_log_FIXME_TIMEOUT=3;
var dk_log_FIXME_PAUSE=0;
var dk_log_FIXME_HALT=0;

//### WARNING ###
if(!dk_valid("WARNING"))				{ var WARNING="WARNING"; 			}
var dk_log_WARNING_ENABLE=1;
var dk_log_WARNING_COLOR=yellow;
var dk_log_WARNING_TAG="WARNING: ";
var dk_log_WARNING_TRACE=1;
var dk_log_WARNING_LINE=0;
var dk_log_WARNING_SOUND=0;
var dk_log_WARNING_TIMEOUT=0;
var dk_log_WARNING_PAUSE=0;
var dk_log_WARNING_HALT=0;

//### DEPRECATED ###
if(!dk_valid("DEPRECATED"))				{ var DEPRECATED="DEPRECATED"; 		}
var dk_log_DEPRECATED_ENABLE=1;
var dk_log_DEPRECATED_COLOR=yellow;
var dk_log_DEPRECATED_TAG="DEPRECATED: ";
var dk_log_DEPRECATED_TRACE=0;
var dk_log_DEPRECATED_LINE=0;
var dk_log_DEPRECATED_SOUND=0;
var dk_log_DEPRECATED_TIMEOUT=3;
var dk_log_DEPRECATED_PAUSE=0;
var dk_log_DEPRECATED_HALT=0;

//### ERROR ###
if(!dk_valid("ERROR"))					{ var ERROR="ERROR"; 				}
var dk_log_ERROR_ENABLE=1;
var dk_log_ERROR_COLOR=lred;
var dk_log_ERROR_TAG="ERROR: ";
var dk_log_ERROR_TRACE=0;
var dk_log_ERROR_LINE=0;
var dk_log_ERROR_SOUND=0;
var dk_log_ERROR_TIMEOUT=1;
var dk_log_ERROR_PAUSE=0;
var dk_log_ERROR_HALT=0;

//### FATAL ###
if(!dk_valid("FATAL"))					{ var FATAL="FATAL"; 				}
var dk_log_FATAL_ENABLE=1;
var dk_log_FATAL_COLOR=red;
var dk_log_FATAL_TAG="FATAL: ";
var dk_log_FATAL_TRACE=1;
var dk_log_FATAL_LINE=0;
var dk_log_FATAL_SOUND=1;
var dk_log_FATAL_TIMEOUT=0;
var dk_log_FATAL_PAUSE=0;
var dk_log_FATAL_HALT=1;


//##################################################################################
//# dk_log(level, message)
//#
//#    Print a log message to the console
//#
//#    @level   - The message level
//#    @message - The message to print
//#
dk_log = function dk_log_f(){
	//dk_debugFunc(1 2);
	
	//if(dk_log_ENABLE !== 1){return} 
	if(typeof arguments[1] === "undefined"){
		_level_="DEFAULT";
		_message_=arguments[0];
	} 
	else {
		_level_=arguments[0];
		_message_=arguments[1];	
	}
	
	if(eval('dk_log_'+_level_+'_ENABLE') !== 1){ return; }

	//###### ECHO MASSAGE ######
	console.log(eval('dk_log_'+_level_+'_COLOR')+eval('dk_log_'+_level_+'_TAG')+_message_+clr);
	
	//###### TRACE ######
	if(eval('dk_log_'+_level_+'_TRACE') === 1){ 
		console.log(eval('dk_log_'+_level_+'_COLOR')+"*** TRACE_ON_"+_level_+" ***"+clr);
		// TODO
	}
	
	//###### LINE ######
	if(eval('dk_log_'+_level_+'_LINE') === 1){ 
		console.log(eval('dk_log_'+_level_+'_COLOR')+"*** LINE_ON_"+_level_+" ***"+clr);
		// TODO
	}
	
	//###### SOUND ######
	if(eval('dk_log_'+_level_+'_SOUND') === 1){ 
		console.log(eval('dk_log_'+_level_+'_COLOR')+"*** SOUND_ON_"+_level_+" ***"+clr);
		// TODO
	}
	
	//###### PAUSE ######
	if(eval('dk_log_'+_level_+'_PAUSE') === 1){ 
		console.log(eval('dk_log_'+_level_+'_COLOR')+"*** PAUSE_ON_"+_level_+" ***"+clr);
		dk_pause();
	}
	
	//###### TIMEOUT ######
	if(eval('dk_log_'+_level_+'_TIMEOUT') === 1){ 
		console.log(eval('dk_log_'+_level_+'_COLOR')+"*** TIMEOUT_ON_"+_level_+" ***"+clr);
		// TODO
	}
	
	//###### HALT ######
	if(eval('dk_log_'+_level_+'_HALT') === 1){ 
		console.log(eval('dk_log_'+_level_+'_COLOR')+"*** HALT_ON_"+_level_+" ***"+clr);
		// TODO
	}
}


//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);

    dk_log(VERBOSE,		"test dk_log VERBOSE message");
    dk_log(DEBUG,		"test dk_log DEBUG message");
	dk_log(				"test dk_log message");
    dk_log(INFO,		"test dk_log INFO message");
    dk_log(SUCCESS,		"test dk_log SUCCESS message");
    dk_log(TODO,		"test dk_log TODO message");
    dk_log(NOTICE,		"test dk_log NOTICE message");
    dk_log(FIXME,		"test dk_log FIXME message");
    dk_log(WARNING,		"test dk_log WARNING message");
	dk_log(DEPRECATED,	"test dk_log DEPRECATED message");
    dk_log(ERROR,		"test dk_log ERROR message");
    dk_log(FATAL,		"test dk_log FATAL message");
}
