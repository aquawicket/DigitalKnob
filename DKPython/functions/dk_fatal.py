import sys 
sys.path.append(".")
import DK

from dk_log import *

##################################################################################
# dk_fatal(<message>)
#
#    Print a fatal message to the console
#
#    @message - The message to print
#
def dk_fatal(*args):
#    dk_call dk_debugFunc 1

    dk_log(FATAL, args[0])





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
def DKTEST():
#    dk_call dk_debugFunc 0

    dk_fatal("test dk_fatal message")
