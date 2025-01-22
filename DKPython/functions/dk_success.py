import sys 
sys.path.append(".")
import DK

from dk_log import *

##################################################################################
# dk_success(<message>)
#
#    Print a success message to the console
#
#    @message - The message to print
#
def dk_success(*args):
#    dk_call dk_debugFunc 1

    dk_log(SUCCESS, args[0])





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
def DKTEST():
#    dk_call dk_debugFunc 0

    dk_success("test dk_success message")
