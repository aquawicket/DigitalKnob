import sys 
sys.path.append(".")
from dk_echo import *

try: ENABLE_dk_log
except NameError: ENABLE_dk_log=1

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
DEFAULT_ENABLE=1
DEFAULT_COLOR=white
DEFAULT_TAG=""
# DEFAULT_PAUSE=1
# DEFAULT_TIMEOUT=1
# DEFAULT_TRACE=1
# DEFAULT_LINE=1
# DEFAULT_HALT=1

### VERBOSE
VERBOSE="VERBOSE"
VERBOSE_ENABLE=1
VERBOSE_COLOR=magenta
VERBOSE_TAG="VERBOSE: "
#VERBOSE_PAUSE=1"
#VERBOSE_TIMEOUT=1"
#VERBOSE_TRACE=1"
#VERBOSE_LINE=1"
#VERBOSE_HALT=1"

### DEBUG
DEBUG="DEBUG"
DEBUG_ENABLE=1
DEBUG_COLOR=lblue
DEBUG_TAG="DEBUG: "
# DEBUG_PAUSE=1
# DEBUG_TIMEOUT=1
# DEBUG_TRACE=1
# DEBUG_LINE=1
# DEBUG_HALT=1

### INFO
INFO="INFO"
INFO_ENABLE=1
INFO_COLOR=white
INFO_TAG="INFO: "
# INFO_PAUSE=1
# INFO_TIMEOUT=1
# INFO_TRACE=1
# INFO_LINE=1
# INFO_HALT=1

### SUCCESS
SUCCESS="SUCCESS"
SUCCESS_ENABLE=1
SUCCESS_COLOR=green
SUCCESS_TAG="SUCCESS: "
# SUCCESS_PAUSE=1
# SUCCESS_TIMEOUT=1
# SUCCESS_TRACE=1
# SUCCESS_LINE=1
# SUCCESS_HALT=1

### TODO
TODO="TODO"
TODO_ENABLE=1
TODO_COLOR=blue
TODO_TAG="TODO: "
#TODO_PAUSE      set "TODO_PAUSE=1
TODO_TIMEOUT=1
#TODO_TRACE      set "TODO_TRACE=1
#TODO_LINE       set "TODO_LINE=1
#TODO_HALT       set "TODO_HALT=1

### NOTICE
NOTICE="NOTICE"
NOTICE_ENABLE=1
NOTICE_COLOR=lyellow
NOTICE_TAG="NOTICE: "
# NOTICE_PAUSE=1
# NOTICE_TIMEOUT=1
# NOTICE_TRACE=1
# NOTICE_LINE=1
# NOTICE_HALT=1

### FIXME
FIXME="FIXME"
FIXME_ENABLE=1
FIXME_COLOR=lyellow
FIXME_TAG="FIXME: "
FIXME_PAUSE=1
FIXME_TIMEOUT=1
# FIXME_TRACE=1
# FIXME_LINE=1
# FIXME_HALT=1

### WARNING
WARNING="WARNING"
WARNING_ENABLE=1
WARNING_COLOR=yellow
WARNING_TAG="WARNING: "
# WARNING_PAUSE=1
# WARNING_TIMEOUT=1
WARNING_TRACE=1
# WARNING_LINE=1
# WARNING_HALT=1

### ERROR
ERROR="ERROR"
ERROR_ENABLE=1
ERROR_COLOR=lred
ERROR_TAG="ERROR: "
# ERROR_PAUSE=1"
ERROR_TIMEOUT=1
ERROR_TRACE=1
# ERROR_LINE=1
# ERROR_HALT=1

### FATAL
FATAL="FATAL"
FATAL_ENABLE=1
FATAL_COLOR=red
FATAL_TAG="FATAL: "
# FATAL_PAUSE=1
# FATAL_TIMEOUT=1
FATAL_TRACE=1
# FATAL_LINE=1
FATAL_SOUND=1
FATAL_HALT=1



##################################################################################
# dk_log(message)
#
#	Print a debug message to the console
#
#	@msg	- The message to print
#
def dk_log(*args):
#    dk_debugFunc 1 2

    if ENABLE_dk_log != 1:  
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

DKTEST()




