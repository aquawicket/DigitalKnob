debug = True
import sys 
sys.path.append(".")

import DK
import os 


print(os.environ.get('COMSPEC', 'default_value'))

ENABLE_dk_log=1

##################################################################################
# dk_log(message)
#
#	Print a debug message to the console
#
#	@msg	- The message to print
#
def dk_log(message):
    #dk_debugFunc()
    #if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
    
    if ENABLE_dk_log != 1:
        return

    
    
    
    
    
    
###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######   
def DKTEST():
    DKTEST()
