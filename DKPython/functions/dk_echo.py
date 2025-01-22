import sys 
sys.path.append(".")
from DK import *
from dk_color import *

################################################################################
# dk_echo(message)
#
#     Print a message to the console
#
#     @message    - The message to print
#
def dk_echo(*args):
#   dk_debugFunc 0 1

    if len(args) == 0 or args[0] is None:
        print("")
        return

    _message_= args[0]
        
    #if msg starts and ends with quotes, remove the first and last characters
    #%if_NDE% if "" == %_message_:~0,1%%_message_:~-1% set "msg=%_message_:~1,-1%"
    #%if_DE% if "" == %_message_:~0,1%%_message_:~-1% set "msg=!_message_:~1,-1!"
        
    print(_message_)
######################################################################






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
def DKTEST():
    #dk_debugFunc 0

#    ESC=""
#    clr=ESC+"[0m"
#    red=ESC+"[31m"
#    blue=ESC+"[34m"
#    white=ESC+"[37m"

    print("This is a normal echo commmand")
    dk_echo()
    dk_echo()
    dk_echo("This is a dk_echo line")
    dk_echo(red+"This is "+white+"dk_echo "+blue+"with color "+clr)

########################################################################
#DKTEST()
