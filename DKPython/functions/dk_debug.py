import sys 
sys.path.append(".")
import DK

from dk_log import *

##################################################################################
# dk_debug(<message>)
#
#    Print a debug message to the console
#
#    @message - The message to print
#
def dk_debug(*args):
#    dk_call dk_debugFunc 1

    dk_log(DEBUG, args[0])





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
def DKTEST():
#    dk_call dk_debugFunc 0

    dk_debug("test dk_debug message")

#DKTEST()
