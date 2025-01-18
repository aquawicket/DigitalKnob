import sys 
sys.path.append(".")
import DK

################################################################################
# dk_echo(message)
#
#     Print a message to the console
#
#     @msg    - The message to print
#
def dk_echo(message):
#   dk_debugFunc 0 1

#    if "%~1" equ "" (echo: & %endfunction%)   
    _message_= message 
        
    #if msg starts and ends with quotes, remove the first and last characters
    #%if_NDE% if "" == %_message_:~0,1%%_message_:~-1% set "msg=%_message_:~1,-1%"
    #%if_DE% if "" == %_message_:~0,1%%_message_:~-1% set "msg=!_message_:~1,-1!"
        
    print(_message_)
######################################################################






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
def DKTEST():
    #dk_debugFunc 0

#    print("This is a normal echo commmand")
    dk_echo("")
    dk_echo("")
    dk_echo("This is a dk_echo line")
    dk_echo("%red%This is %white%dk_echo %blue%with color %clr%")
#	print("This is a normal echo commmand")
    dk_echo("")
    dk_echo("")
    dk_echo("This is a dk_echo line")
    dk_echo("%red%This is %white%dk_echo %blue%with color %clr%")
########################################################################
DKTEST()
