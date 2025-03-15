import sys 
sys.path.append(".")
from DK import *

from dk_echo import *
try: dk_log_ENABLE
except NameError: dk_log_ENABLE=1

# 0 VERBOSE    dk_verbose
# 1 DEBUG      dk_debug
# 2 INFO       dk_info
# 3 SUCCESS    dk_success
# 4 TODO       dk_todo
# 5 NOTICE     dk_notice
# 6 FIXME      dk_fixme
# 7 WARNING    dk_warning
# 8 ERROR      dk_error
# 9 FATAL      dk_fatal
    
### DEFAULT
DEFAULT="DEFAULT"
dk_log_DEFAULT_ENABLE=1
dk_log_DEFAULT_COLOR=white
dk_log_DEFAULT_TAG=""
# dk_log_DEFAULT_PAUSE=1
# dk_log_DEFAULT_TIMEOUT=1
# dk_log_DEFAULT_TRACE=1
# dk_log_DEFAULT_LINE=1
# dk_log_DEFAULT_HALT=1

### VERBOSE
VERBOSE="VERBOSE"
dk_log_VERBOSE_ENABLE=1
dk_log_VERBOSE_COLOR=magenta
dk_log_VERBOSE_TAG="VERBOSE: "
#dk_log_VERBOSE_PAUSE=1"
#dk_log_VERBOSE_TIMEOUT=1"
#dk_log_VERBOSE_TRACE=1"
#dk_log_VERBOSE_LINE=1"
#dk_log_VERBOSE_HALT=1"

### DEBUG
DEBUG="DEBUG"
dk_log_DEBUG_ENABLE=1
dk_log_DEBUG_COLOR=lblue
dk_log_DEBUG_TAG="DEBUG: "
# dk_log_DEBUG_PAUSE=1
# dk_log_DEBUG_TIMEOUT=1
# dk_log_DEBUG_TRACE=1
# dk_log_DEBUG_LINE=1
# dk_log_DEBUG_HALT=1

### INFO
INFO="INFO"
dk_log_INFO_ENABLE=1
dk_log_INFO_COLOR=white
dk_log_INFO_TAG="INFO: "
# dk_log_INFO_PAUSE=1
# dk_log_INFO_TIMEOUT=1
# dk_log_INFO_TRACE=1
# dk_log_INFO_LINE=1
# dk_log_INFO_HALT=1

### SUCCESS
SUCCESS="SUCCESS"
dk_log_SUCCESS_ENABLE=1
dk_log_SUCCESS_COLOR=green
dk_log_SUCCESS_TAG="SUCCESS: "
# dk_log_SUCCESS_PAUSE=1
# dk_log_SUCCESS_TIMEOUT=1
# dk_log_SUCCESS_TRACE=1
# dk_log_SUCCESS_LINE=1
# dk_log_SUCCESS_HALT=1

### TODO
TODO="TODO"
dk_log_TODO_ENABLE=1
dk_log_TODO_COLOR=blue
dk_log_TODO_TAG="TODO: "
#dk_log_TODO_PAUSE      set "dk_log_TODO_PAUSE=1
dk_log_TODO_TIMEOUT=1
#dk_log_TODO_TRACE      set "dk_log_TODO_TRACE=1
#dk_log_TODO_LINE       set "dk_log_TODO_LINE=1
#dk_log_TODO_HALT       set "dk_log_TODO_HALT=1

### NOTICE
NOTICE="NOTICE"
dk_log_NOTICE_ENABLE=1
dk_log_NOTICE_COLOR=lyellow
dk_log_NOTICE_TAG="NOTICE: "
# dk_log_NOTICE_PAUSE=1
# dk_log_NOTICE_TIMEOUT=1
# dk_log_NOTICE_TRACE=1
# dk_log_NOTICE_LINE=1
# dk_log_NOTICE_HALT=1

### FIXME
FIXME="FIXME"
dk_log_FIXME_ENABLE=1
dk_log_FIXME_COLOR=lyellow
dk_log_FIXME_TAG="FIXME: "
dk_log_FIXME_PAUSE=1
dk_log_FIXME_TIMEOUT=1
# dk_log_FIXME_TRACE=1
# dk_log_FIXME_LINE=1
# dk_log_FIXME_HALT=1

### WARNING
WARNING="WARNING"
dk_log_WARNING_ENABLE=1
dk_log_WARNING_COLOR=yellow
dk_log_WARNING_TAG="WARNING: "
# dk_log_WARNING_PAUSE=1
# dk_log_WARNING_TIMEOUT=1
dk_log_WARNING_TRACE=1
# dk_log_WARNING_LINE=1
# dk_log_WARNING_HALT=1

### ERROR
ERROR="ERROR"
dk_log_ERROR_ENABLE=1
dk_log_ERROR_COLOR=lred
dk_log_ERROR_TAG="ERROR: "
# dk_log_ERROR_PAUSE=1"
dk_log_ERROR_TIMEOUT=1
dk_log_ERROR_TRACE=1
# dk_log_ERROR_LINE=1
# dk_log_ERROR_HALT=1

### FATAL
FATAL="FATAL"
dk_log_FATAL_ENABLE=1
dk_log_FATAL_COLOR=red
dk_log_FATAL_TAG="FATAL: "
# dk_log_FATAL_PAUSE=1
# dk_log_FATAL_TIMEOUT=1
dk_log_FATAL_TRACE=1
# dk_log_FATAL_LINE=1
dk_log_FATAL_SOUND=1
dk_log_FATAL_HALT=1



##################################################################################
# dk_log(message)
#
#	Print a debug message to the console
#
#	@msg	- The message to print
#
def dk_log(*args):
#    dk_debugFunc 1 2

    if dk_log_ENABLE != 1:  
        return 
   
    if len(args) == 1 or args[1] == None:
        _level_=DEFAULT
        _message_=args[0]
    
    if len(args) > 1:
        _level_=args[0]
        _message_=args[1]
    
    if globals()[f"{_level_}_ENABLE"] != 1:
        return
      
#   ::if "" == %_message_:~0,1%%_message_:~-1% dk_set _message_ %_message_:~1,-1%    &:: if _message_ starts and ends with quotes, remove them
    
    dk_echo(globals()[f"{_level_}_COLOR"] + globals()[f"{_level_}_TAG"] + _message_ + clr)
#   if "!%_level_%_TRACE!"=="1" dk_echo "!%_level_%_COLOR!*** TRACE_ON_%_level_% ***%clr%"  && dk_stacktrace#
#	if "!%_level_%_SOUND!"=="1" dk_echo "!%_level_%_COLOR!*** SOUND_ON_%_level_% ***%clr%"  && (
#			Array::dk_push errorBeeps "440,500"
#			Array::dk_push errorBeeps "440,500"
#			Array::dk_push errorBeeps "440,500" 
#			Array::dk_push errorBeeps "349,350" 
#			Array::dk_push errorBeeps "523,150" 
#			Array::dk_push errorBeeps "440,500" 
#			Array::dk_push errorBeeps "349,350" 
#			Array::dk_push errorBeeps "523,150" 
#			Array::dk_push errorBeeps "440,1000"
#			Array::dk_push errorBeeps "659,500" 
#			Array::dk_push errorBeeps "659,500" 
#			Array::dk_push errorBeeps "659,500" 
#			Array::dk_push errorBeeps "698,350" 
#			Array::dk_push errorBeeps "523,150" 
#			Array::dk_push errorBeeps "415,500" 
#			Array::dk_push errorBeeps "349,350" 
#			Array::dk_push errorBeeps "523,150" 
#			Array::dk_push errorBeeps "440,1000"
#			dk_beeps errorBeeps
#		)
#       if "!%_level_%_LINE!"=="1"  	dk_echo "!%_level_%_COLOR!*** LINE_ON_%_level_% ***%crl%"   	&& dk_showFileLine "%_callerpath%" "%_message_%"
#		if "!%_level_%_PAUSE!"=="1" 	dk_echo "!%_level_%_COLOR!*** PAUSE_ON_%_level_% ***%clr%"  	&& dk_pause
#		if "!%_level_%_TIMEOUT!"=="1" 	dk_echo "!%_level_%_COLOR!*** TIMEOUT_ON_%_level_% ***%clr%"  && dk_timeout
#       if "!%_level_%_HALT!"=="1"  	dk_echo "!%_level_%_COLOR!*** HALT_ON_%_level_% ***%clr%"   	&& dk_exit 13
############################################################################



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
def DKTEST():
#	dk_debugFunc 0
 
    dk_log("test dk_log message")
    
    dk_log(VERBOSE, "test dk_log VERBOSE message")
    dk_log(DEBUG,   "test dk_log DEBUG message")
    dk_log(INFO,    "test dk_log INFO message")
    dk_log(SUCCESS, "test dk_log SUCCESS message")
    dk_log(TODO,    "test dk_log TODO message")
    dk_log(NOTICE,  "test dk_log NOTICE message")
    dk_log(FIXME,   "test dk_log FIXME message")
    dk_log(WARNING, "test dk_log WARNING message")
    dk_log(ERROR,   "test dk_log ERROR message")
    dk_log(FATAL,   "test dk_log FATAL message")
##########################################################################

#DKTEST()




