dk_source(DKJAVASCRIPT_DIR+"/functions/dk_color.js", function(){});

var dk_log_ENABLE = 1;

//### DEFAULT ###
var DEFAULT="DEFAULT"
var DEFAULT_ENABLE=1;
var DEFAULT_COLOR=white
var DEFAULT_TAG=""
var DEFAULT_PAUSE=0
var DEFAULT_TIMEOUT=0
var DEFAULT_TRACE=0
var DEFAULT_LINE=0
var DEFAULT_HALT=0

//### VERBOSE ###
var VERBOSE="VERBOSE"
var dk_log_VERBOSE_ENABLE=1
var VERBOSE_COLOR=magenta
var VERBOSE_TAG="VERBOSE: "
var VERBOSE_PAUSE=0
var VERBOSE_TIMEOUT=0
var VERBOSE_TRACE=0
var VERBOSE_LINE=0
var VERBOSE_HALT=0

//### DEBUG ###
var DEBUG="DEBUG"
var DEBUG_ENABLE=1
var DEBUG_COLOR=lblue
var DEBUG_TAG="DEBUG: "
var DEBUG_PAUSE=0
var DEBUG_TIMEOUT=0
var DEBUG_TRACE=0
var DEBUG_LINE=0
var DEBUG_HALT=0

//### INFO ###
var INFO="INFO"
var INFO_ENABLE=1
var INFO_COLOR=white
var INFO_TAG="INFO: "
var INFO_PAUSE=0
var INFO_TIMEOUT=0
var INFO_TRACE=0
var INFO_LINE=0
var INFO_HALT=0

//### SUCCESS ###
var SUCCESS="SUCCESS"
var SUCCESS_ENABLE=1
var SUCCESS_COLOR=green
var SUCCESS_TAG="SUCCESS: "
var SUCCESS_PAUSE=0
var SUCCESS_TIMEOUT=0
var SUCCESS_TRACE=0
var SUCCESS_LINE=0
var SUCCESS_HALT=0

//### TODO ###
var TODO="TODO"
var TODO_ENABLE=1
var TODO_COLOR=blue
var TODO_TAG="TODO: "
var TODO_PAUSE=0
var TODO_TIMEOUT=1
var TODO_TRACE=0
var TODO_LINE=0
var TODO_HALT=0

//### NOTICE ###
var NOTICE="NOTICE"
var NOTICE_ENABLE=1
var NOTICE_COLOR=lyellow
var NOTICE_TAG="NOTICE: "
var NOTICE_PAUSE=0
var NOTICE_TIMEOUT=0
var NOTICE_TRACE=0
var NOTICE_LINE=0
var NOTICE_HALT=0

//### FIXME ###
var FIXME="FIXME"
var FIXME_ENABLE=1
var FIXME_COLOR=lyellow
var FIXME_TAG="FIXME: "
var FIXME_PAUSE=1
var FIXME_TIMEOUT=0
var FIXME_TRACE=0
var FIXME_LINE=0
var FIXME_HALT=0

//### WARNING ###
var WARNING="WARNING"
var WARNING_ENABLE=1
var WARNING_COLOR=yellow
var WARNING_TAG="WARNING: "
var WARNING_PAUSE=0
var WARNING_TIMEOUT=0
var WARNING_TRACE=1
var WARNING_LINE=0
var WARNING_HALT=0

//### ERROR ###
var ERROR="ERROR"
var ERROR_ENABLE=1
var ERROR_COLOR=lred
var ERROR_TAG="ERROR: "
var ERROR_PAUSE=0
var ERROR_TIMEOUT=1
var ERROR_TRACE=0
var ERROR_LINE=0
var ERROR_HALT=0

//### FATAL ###
var FATAL="FATAL"
var FATAL_ENABLE=1
var FATAL_COLOR=red
var FATAL_TAG="FATAL: "
var FATAL_PAUSE=0
var FATAL_TIMEOUT=0
var FATAL_TRACE=1
var FATAL_LINE=0
var FATAL_SOUND=1
var FATAL_HALT=1


//##################################################################################
//# dk_log(level, message)
//#
//#    Print a log message to the console
//#
//#    @level   - The message level
//#    @message - The message to print
//#
dk_log = function dk_log_f() {
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
	
	if(eval(_level_+'_ENABLE') !== 1){ return }

	console.log(eval(_level_+'_COLOR')+eval(_level_+'_TAG')+_message_+clr)
}


//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f() {
	//dk_debugFunc(0);

	dk_log("test dk_log message");
    dk_log(VERBOSE, "test dk_log VERBOSE message");
    dk_log(DEBUG,   "test dk_log DEBUG message");
    dk_log(INFO,    "test dk_log INFO message");
    dk_log(SUCCESS, "test dk_log SUCCESS message");
    dk_log(TODO,    "test dk_log TODO message");
    dk_log(NOTICE,  "test dk_log NOTICE message");
    dk_log(FIXME,   "test dk_log FIXME message");
    dk_log(WARNING, "test dk_log WARNING message");
    dk_log(ERROR,   "test dk_log ERROR message");
    dk_log(FATAL,   "test dk_log FATAL message");
}