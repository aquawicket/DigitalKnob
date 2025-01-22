import sys 
sys.path.append(".")
import DK

from dk_log import *

##################################################################################
# dk_todo(<message>)
#
#    Print a todo message to the console
#
#    @message - The message to print
#
def dk_todo(*args):
#    dk_call dk_debugFunc 1

    dk_log(TODO, args[0])





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
def DKTEST():
#    dk_call dk_debugFunc 0

    dk_todo("test dk_todo message")
