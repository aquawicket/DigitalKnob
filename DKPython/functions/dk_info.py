import sys 
sys.path.append(".")
from DK import *

from dk_log import *

##################################################################################
# dk_info(<message>)
#
#    Print a info message to the console
#
#    @message - The message to print
#
def dk_info(*args):
#    dk_call dk_debugFunc 1

    dk_log(INFO, args[0])





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
def DKTEST():
#    dk_call dk_debugFunc 0

    dk_info("test dk_info message")
