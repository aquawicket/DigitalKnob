//if(!dk_valid("DK"))		{ dk_source(DKJAVASCRIPT_DIR+"/functions/DK.js", function(){});			}
if(!dk_valid("dk_color"))	{ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_color.js", function(){}); 	}


//############ dk_log SETTINGS ############
if(!dk_valid("dk_log_ENABLE"))				{ var dk_log_ENABLE = 1; 					}

//### DEFAULT ###
if(!dk_valid("DEFAULT"))					{ var DEFAULT="DEFAULT"; 					}
if(!dk_valid("dk_log_DEFAULT_ENABLE"))		{ var dk_log_DEFAULT_ENABLE=1; 				}
if(!dk_valid("dk_log_DEFAULT_COLOR"))		{ var dk_log_DEFAULT_COLOR=white; 			}
if(!dk_valid("dk_log_DEFAULT_TAG"))			{ var dk_log_DEFAULT_TAG=""; 				}
if(!dk_valid("dk_log_DEFAULT_TRACE"))		{ var dk_log_DEFAULT_TRACE=0;				}
if(!dk_valid("dk_log_DEFAULT_LINE"))		{ var dk_log_DEFAULT_LINE=0; 				}
if(!dk_valid("dk_log_DEFAULT_SOUND"))		{ var dk_log_DEFAULT_SOUND=0;				}
if(!dk_valid("dk_log_DEFAULT_TIMEOUT"))		{ var dk_log_DEFAULT_TIMEOUT=0; 			}
if(!dk_valid("dk_log_DEFAULT_PAUSE"))		{ var dk_log_DEFAULT_PAUSE=0; 				}
if(!dk_valid("dk_log_DEFAULT_HALT"))		{ var dk_log_DEFAULT_HALT=0; 				}

//### VERBOSE ###
if(!dk_valid("VERBOSE"))					{ var VERBOSE="VERBOSE"; 					}
if(!dk_valid("dk_log_VERBOSE_ENABLE"))		{ var dk_log_VERBOSE_ENABLE=1;				}
if(!dk_valid("dk_log_VERBOSE_COLOR"))		{ var dk_log_VERBOSE_COLOR=magenta; 		}
if(!dk_valid("dk_log_VERBOSE_TAG"))			{ var dk_log_VERBOSE_TAG="VERBOSE: "; 		}
if(!dk_valid("dk_log_VERBOSE_TRACE"))		{ var dk_log_VERBOSE_TRACE=0;				}
if(!dk_valid("dk_log_VERBOSE_LINE"))		{ var dk_log_VERBOSE_LINE=0; 				}
if(!dk_valid("dk_log_VERBOSE_SOUND"))		{ var dk_log_VERBOSE_SOUND=0;				}
if(!dk_valid("dk_log_VERBOSE_TIMEOUT"))		{ var dk_log_VERBOSE_TIMEOUT=0; 			}
if(!dk_valid("dk_log_VERBOSE_PAUSE"))		{ var dk_log_VERBOSE_PAUSE=0; 				}
if(!dk_valid("dk_log_VERBOSE_HALT"))		{ var dk_log_VERBOSE_HALT=0; 				}

//### DEBUG ###
if(!dk_valid("DEBUG"))						{ var DEBUG="DEBUG"; 						}
if(!dk_valid("dk_log_DEBUG_ENABLE"))		{ var dk_log_DEBUG_ENABLE=1;				}
if(!dk_valid("dk_log_DEBUG_COLOR"))			{ var dk_log_DEBUG_COLOR=lblue; 			}
if(!dk_valid("dk_log_DEBUG_TAG"))			{ var dk_log_DEBUG_TAG="DEBUG: "; 			}
if(!dk_valid("dk_log_DEBUG_TRACE"))			{ var dk_log_DEBUG_TRACE=0;					}
if(!dk_valid("dk_log_DEBUG_LINE"))			{ var dk_log_DEBUG_LINE=0; 					}
if(!dk_valid("dk_log_DEBUG_SOUND"))			{ var dk_log_DEBUG_SOUND=0;					}
if(!dk_valid("dk_log_DEBUG_TIMEOUT"))		{ var dk_log_DEBUG_TIMEOUT=0; 				}
if(!dk_valid("dk_log_DEBUG_PAUSE"))			{ var dk_log_DEBUG_PAUSE=0; 				}
if(!dk_valid("dk_log_DEBUG_HALT"))			{ var dk_log_DEBUG_HALT=0; 					}

//### INFO ###
if(!dk_valid("INFO"))						{ var INFO="INFO"; 							}
if(!dk_valid("dk_log_INFO_ENABLE"))			{ var dk_log_INFO_ENABLE=1;					}
if(!dk_valid("dk_log_INFO_COLOR"))			{ var dk_log_INFO_COLOR=white;				}
if(!dk_valid("dk_log_INFO_TAG"))			{ var dk_log_INFO_TAG="INFO: ";				}
if(!dk_valid("dk_log_INFO_TRACE"))			{ var dk_log_INFO_TRACE=0;					}
if(!dk_valid("dk_log_INFO_LINE"))			{ var dk_log_INFO_LINE=0; 					}
if(!dk_valid("dk_log_INFO_SOUND"))			{ var dk_log_INFO_SOUND=0;					}
if(!dk_valid("dk_log_INFO_TIMEOUT"))		{ var dk_log_INFO_TIMEOUT=0; 				}
if(!dk_valid("dk_log_INFO_PAUSE"))			{ var dk_log_INFO_PAUSE=0; 					}
if(!dk_valid("dk_log_INFO_HALT"))			{ var dk_log_INFO_HALT=0; 					}

//### SUCCESS ###
if(!dk_valid("SUCCESS"))					{ var SUCCESS="SUCCESS"; 					}
if(!dk_valid("dk_log_SUCCESS_ENABLE"))		{ var dk_log_SUCCESS_ENABLE=1;				}
if(!dk_valid("dk_log_SUCCESS_COLOR"))		{ var dk_log_SUCCESS_COLOR=green;			}
if(!dk_valid("dk_log_SUCCESS_TAG"))			{ var dk_log_SUCCESS_TAG="SUCCESS: ";		}
if(!dk_valid("dk_log_SUCCESS_TRACE"))		{ var dk_log_SUCCESS_TRACE=0;				}
if(!dk_valid("dk_log_SUCCESS_LINE"))		{ var dk_log_SUCCESS_LINE=0; 				}
if(!dk_valid("dk_log_SUCCESS_SOUND"))		{ var dk_log_SUCCESS_SOUND=0;				}
if(!dk_valid("dk_log_SUCCESS_TIMEOUT"))		{ var dk_log_SUCCESS_TIMEOUT=0; 			}
if(!dk_valid("dk_log_SUCCESS_PAUSE"))		{ var dk_log_SUCCESS_PAUSE=0; 				}
if(!dk_valid("dk_log_SUCCESS_HALT"))		{ var dk_log_SUCCESS_HALT=0; 				}

//### TODO ###
if(!dk_valid("TODO"))						{ var TODO="TODO"; 							}
if(!dk_valid("dk_log_TODO_ENABLE"))			{ var dk_log_TODO_ENABLE=1;					}
if(!dk_valid("dk_log_TODO_COLOR"))			{ var dk_log_TODO_COLOR=blue;				}
if(!dk_valid("dk_log_TODO_TAG"))			{ var dk_log_TODO_TAG="TODO: ";				}
if(!dk_valid("dk_log_TODO_TRACE"))			{ var dk_log_TODO_TRACE=0;					}
if(!dk_valid("dk_log_TODO_LINE"))			{ var dk_log_TODO_LINE=0; 					}
if(!dk_valid("dk_log_TODO_SOUND"))			{ var dk_log_TODO_SOUND=0;					}
if(!dk_valid("dk_log_TODO_TIMEOUT"))		{ var dk_log_TODO_TIMEOUT=1; 				}
if(!dk_valid("dk_log_TODO_PAUSE"))			{ var dk_log_TODO_PAUSE=0; 					}
if(!dk_valid("dk_log_TODO_HALT"))			{ var dk_log_TODO_HALT=0; 					}

//### NOTICE ###
if(!dk_valid("NOTICE"))						{ var NOTICE="NOTICE"; 						}
if(!dk_valid("dk_log_NOTICE_ENABLE"))		{ var dk_log_NOTICE_ENABLE=1;				}
if(!dk_valid("dk_log_NOTICE_COLOR"))		{ var dk_log_NOTICE_COLOR=lyellow;			}
if(!dk_valid("dk_log_NOTICE_TAG"))			{ var dk_log_NOTICE_TAG="NOTICE: ";			}
if(!dk_valid("dk_log_NOTICE_TRACE"))		{ var dk_log_NOTICE_TRACE=0;				}
if(!dk_valid("dk_log_NOTICE_LINE"))			{ var dk_log_NOTICE_LINE=0; 				}
if(!dk_valid("dk_log_NOTICE_SOUND"))		{ var dk_log_NOTICE_SOUND=0;				}
if(!dk_valid("dk_log_NOTICE_TIMEOUT"))		{ var dk_log_NOTICE_TIMEOUT=1; 				}
if(!dk_valid("dk_log_NOTICE_PAUSE"))		{ var dk_log_NOTICE_PAUSE=0; 				}
if(!dk_valid("dk_log_NOTICE_HALT"))			{ var dk_log_NOTICE_HALT=0; 				}

//### FIXME ###
if(!dk_valid("FIXME"))						{ var FIXME="FIXME"; 						}
if(!dk_valid("dk_log_FIXME_ENABLE"))		{ var dk_log_FIXME_ENABLE=1;				}
if(!dk_valid("dk_log_FIXME_COLOR"))			{ var dk_log_FIXME_COLOR=lyellow;			}
if(!dk_valid("dk_log_FIXME_TAG"))			{ var dk_log_FIXME_TAG="FIXME: ";			}
if(!dk_valid("dk_log_FIXME_TRACE"))			{ var dk_log_FIXME_TRACE=0;					}
if(!dk_valid("dk_log_FIXME_LINE"))			{ var dk_log_FIXME_LINE=0; 					}
if(!dk_valid("dk_log_FIXME_SOUND"))			{ var dk_log_FIXME_SOUND=0;					}
if(!dk_valid("dk_log_FIXME_TIMEOUT"))		{ var dk_log_FIXME_TIMEOUT=3; 				}
if(!dk_valid("dk_log_FIXME_PAUSE"))			{ var dk_log_FIXME_PAUSE=0; 				}
if(!dk_valid("dk_log_FIXME_HALT"))			{ var dk_log_FIXME_HALT=0; 					}

//### WARNING ###
if(!dk_valid("WARNING"))					{ var WARNING="WARNING"; 					}
if(!dk_valid("dk_log_WARNING_ENABLE"))		{ var dk_log_WARNING_ENABLE=1;				}
if(!dk_valid("dk_log_WARNING_COLOR"))		{ var dk_log_WARNING_COLOR=yellow;			}
if(!dk_valid("dk_log_WARNING_TAG"))			{ var dk_log_WARNING_TAG="WARNING: ";		}
if(!dk_valid("dk_log_WARNING_TRACE"))		{ var dk_log_WARNING_TRACE=1;				}
if(!dk_valid("dk_log_WARNING_LINE"))		{ var dk_log_WARNING_LINE=0; 				}
if(!dk_valid("dk_log_WARNING_SOUND"))		{ var dk_log_WARNING_SOUND=0;				}
if(!dk_valid("dk_log_WARNING_TIMEOUT"))		{ var dk_log_WARNING_TIMEOUT=0; 			}
if(!dk_valid("dk_log_WARNING_PAUSE"))		{ var dk_log_WARNING_PAUSE=0; 				}
if(!dk_valid("dk_log_WARNING_HALT"))		{ var dk_log_WARNING_HALT=0; 				}

//### DEPRECATED ###
if(!dk_valid("DEPRECATED"))					{ var DEPRECATED="DEPRECATED"; 				}
if(!dk_valid("dk_log_DEPRECATED_ENABLE"))	{ var dk_log_DEPRECATED_ENABLE=1;			}
if(!dk_valid("dk_log_DEPRECATED_COLOR"))	{ var dk_log_DEPRECATED_COLOR=yellow;		}
if(!dk_valid("dk_log_DEPRECATED_TAG"))		{ var dk_log_DEPRECATED_TAG="DEPRECATED: ";	}
if(!dk_valid("dk_log_DEPRECATED_TRACE"))	{ var dk_log_DEPRECATED_TRACE=0;			}
if(!dk_valid("dk_log_DEPRECATED_LINE"))		{ var dk_log_DEPRECATED_LINE=0; 			}
if(!dk_valid("dk_log_DEPRECATED_SOUND"))	{ var dk_log_DEPRECATED_SOUND=0;			}
if(!dk_valid("dk_log_DEPRECATED_TIMEOUT"))	{ var dk_log_DEPRECATED_TIMEOUT=3; 			}
if(!dk_valid("dk_log_DEPRECATED_PAUSE"))	{ var dk_log_DEPRECATED_PAUSE=0; 			}
if(!dk_valid("dk_log_DEPRECATED_HALT"))		{ var dk_log_DEPRECATED_HALT=0; 			}

//### ERROR ###
if(!dk_valid("ERROR"))						{ var ERROR="ERROR"; 						}
if(!dk_valid("dk_log_ERROR_ENABLE"))		{ var dk_log_ERROR_ENABLE=1;				}
if(!dk_valid("dk_log_ERROR_COLOR"))			{ var dk_log_ERROR_COLOR=lred;				}
if(!dk_valid("dk_log_ERROR_TAG"))			{ var dk_log_ERROR_TAG="ERROR: ";			}
if(!dk_valid("dk_log_ERROR_TRACE"))			{ var dk_log_ERROR_TRACE=0;					}
if(!dk_valid("dk_log_ERROR_LINE"))			{ var dk_log_ERROR_LINE=0; 					}
if(!dk_valid("dk_log_ERROR_SOUND"))			{ var dk_log_ERROR_SOUND=0;					}
if(!dk_valid("dk_log_ERROR_TIMEOUT"))		{ var dk_log_ERROR_TIMEOUT=1; 				}
if(!dk_valid("dk_log_ERROR_PAUSE"))			{ var dk_log_ERROR_PAUSE=0; 				}
if(!dk_valid("dk_log_ERROR_HALT"))			{ var dk_log_ERROR_HALT=0; 					}

//### FATAL ###
if(!dk_valid("FATAL"))						{ var FATAL="FATAL"; 						}
if(!dk_valid("dk_log_FATAL_ENABLE"))		{ var dk_log_FATAL_ENABLE=1;				}
if(!dk_valid("dk_log_FATAL_COLOR"))			{ var dk_log_FATAL_COLOR=red;				}
if(!dk_valid("dk_log_FATAL_TAG"))			{ var dk_log_FATAL_TAG="FATAL: ";			}
if(!dk_valid("dk_log_FATAL_TRACE"))			{ var dk_log_FATAL_TRACE=1;					}
if(!dk_valid("dk_log_FATAL_LINE"))			{ var dk_log_FATAL_LINE=0; 					}
if(!dk_valid("dk_log_FATAL_SOUND"))			{ var dk_log_FATAL_SOUND=1;					}
if(!dk_valid("dk_log_FATAL_TIMEOUT"))		{ var dk_log_FATAL_TIMEOUT=1; 				}
if(!dk_valid("dk_log_FATAL_PAUSE"))			{ var dk_log_FATAL_PAUSE=0; 				}
if(!dk_valid("dk_log_FATAL_HALT"))			{ var dk_log_FATAL_HALT=1; 					}


//##################################################################################
//# dk_log(message)
//# dk_log(level, message)
//#
//#    Print a log message to the console
//#
//#    @level   - The message level
//#    @message - The message to print
//#
dk_log = function dk_log_f(){
	//dk_debugFunc(1 2);
	
	if(dk_log_ENABLE !== 1){ return; }
	
	if(typeof arguments[1] === "undefined"){
		_level_="DEFAULT";
		_message_=arguments[0];
	} 
	else {
		_level_=arguments[0];
		_message_=arguments[1];	
	}
	
	if(eval('dk_log_'+_level_+'_ENABLE') !== 1){ return; }

	//###### ECHO MESSAGE ######
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
	
	//###### TIMEOUT ######
	if(eval('dk_log_'+_level_+'_TIMEOUT') === 1){ 
		console.log(eval('dk_log_'+_level_+'_COLOR')+"*** TIMEOUT_ON_"+_level_+" ***"+clr);
		// TODO
	}
	
	//###### PAUSE ######
	if(eval('dk_log_'+_level_+'_PAUSE') === 1){ 
		console.log(eval('dk_log_'+_level_+'_COLOR')+"*** PAUSE_ON_"+_level_+" ***"+clr);
		dk_pause();
	}
	
	//###### HALT ######
	if(eval('dk_log_'+_level_+'_HALT') === 1){ 
		console.log(eval('dk_log_'+_level_+'_COLOR')+"*** HALT_ON_"+_level_+" ***"+clr);
		dk_exit(13);
		dk_echo(clr);
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
