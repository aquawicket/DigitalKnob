import sys 
sys.path.append(".")
import DK

from dk_log import *

##################################################################################
# dk_error(<message>)
#
#    Print a error message to the console
#
#    @message - The message to print
#
def dk_error(*args):
#    dk_call dk_debugFunc 1

    dk_log(ERROR, args[0])





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
def DKTEST():
#    dk_call dk_debugFunc 0

    dk_error("test dk_error message")
