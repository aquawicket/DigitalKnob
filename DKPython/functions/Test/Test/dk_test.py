import sys 
sys.path.append(".")
sys.path.append("../")
sys.path.append("../../")
from DK import *

####################################################################
# Test/Test/dk_test()
#
def Test_Test_dk_test(*args):
#   dk_debugFunc 0 99

    print(f" ################# Test/Test/dk_test.cmd ################")
    if len(args) > 0:   print(f"                     0 = {args[0]}")
    if len(args) > 1:   print(f"                     1 = {args[1]}")
    if len(args) > 2:   print(f"                     2 = {args[2]}")
    if len(args) > 3:   print(f"                     3 = {args[3]}")
    if len(args) > 4:   print(f"                     4 = {args[4]}")
    if len(args) > 5:   print(f"                     5 = {args[5]}")
    if len(args) > 6:   print(f"                     6 = {args[6]}")
    if len(args) > 7:   print(f"                     7 = {args[7]}")
    if len(args) > 8:   print(f"                     8 = {args[8]}")
    if len(args) > 9:   print(f"                     9 = {args[9]}")
    print(f"                     * = {args}")
#    print(f"            ERRORLEVEL = {ERRORLEVEL}")
#    print(f"                   LVL = {LVL}")
#    print(f"              __TIME__ = {__TIME__}")
#    print(f"              __CMND__ = {__CMND__}")
#    print(f"              __FILE__ = {__FILE__}")
#    print(f"              __LINE__ = {__LINE__}")
#    print(f"              __FUNC__ = {__FUNC__}")
#    print(f"              __ARGC__ = {__ARGC__}")
#    print(f"              __ARGV__ = {__ARGV__}")
    print(f"         DKSCRIPT_PATH = {DKSCRIPT_PATH}")
#    print(f"          DKSCRIPT_DIR = {DKSCRIPT_DIR}")
#    print(f"         DKSCRIPT_NAME = {DKSCRIPT_NAME}")
#    print(f"          DKSCRIPT_EXT = {DKSCRIPT_EXT}")
#    print(f"         DKSCRIPT_ARGS = {DKSCRIPT_ARGS}")
#    print(f"            DKHOME_DIR = {DKHOME_DIR}")
#    print(f"           DKCACHE_DIR = {DKCACHE_DIR}")
#    print(f"         DKDESKTOP_DIR = {DKDESKTOP_DIR}")
#    print(f"           DIGITALKNOB = {DIGITALKNOB}")
#    print(f"       DIGITALKNOB_DIR = {DIGITALKNOB_DIR}")
#    print(f"        DKDOWNLOAD_DIR = {DKDOWNLOAD_DIR}")
#    print(f"           DKTOOLS_DIR = {DKTOOLS_DIR}")
#    print(f"              DKBRANCH = {DKBRANCH}")
#    print(f"          DKBRANCH_DIR = {DKBRANCH_DIR}")
#    print(f"        DK3RDPARTY_DIR = {DK3RDPARTY_DIR}")
#    print(f"            DKCPP_APPS_DIR = {DKCPP_APPS_DIR}")
#    print(f"            DKBASH_DIR = {DKBASH_DIR}")
#    print(f"  DKBASH_FUNCTIONS_DIR = {DKBASH_FUNCTIONS_DIR}")
#    print(f" DKBASH_FUNCTIONS_DIR_ = {DKBASH_FUNCTIONS_DIR_}")
    
	
	
    #	setGlobal GLOBAL_VAR "This is a global variable"
    #	setReturn RETURN_VAR "This is a return variable"
    #	::SYNTAX ERROR

    #	print(f":
    #	print(f" dk_test()
    #	::print(f" dk.gbl.GLOBAL_VAR = %dk.gbl.GLOBAL_VAR%
    #	print(f" GLOBAL_VAR = %GLOBAL_VAR%
        
    #	::print(f" dk.rtn.RETURN_VAR = %dk.rtn.RETURN_VAR%
    #	print(f" RETURN_VAR = %RETURN_VAR%
        
    #:: FIXME: we only want endlocal once
    #::endlocal & set "dk_test=return value from dk_test.cmd"

#endfunction








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
def DKTEST():
#    dk_debugFunc 0

#    dk_test("from Test/Test/DKTEST()", "to dk_test()")
#	print("")
#	print("GLOBAL_VAR = "+GLOBAL_VAR)
#	print("RETURN_VAR = "+RETURN_VAR)
	
#	Test_dk_test("from Test/Test/DKTEST()", "to Test/dk_test()")
#	print("")
#	print("GLOBAL_VAR = "+GLOBAL_VAR)
#	print("RETURN_VAR = "+RETURN_VAR)
	
	Test_Test_dk_test("from Test/Test/DKTEST()", "to Test/Test/dk_test()")
	print("")
#	print("GLOBAL_VAR = "+GLOBAL_VAR)
#	print("RETURN_VAR = "+RETURN_VAR)
#endfunction

