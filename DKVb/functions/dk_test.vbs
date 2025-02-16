executeGlobal CreateObject("Scripting.FileSystemObject").openTextFile("DK.vbs").readAll()


'##################################################################################
'# dk_test()
'#
public function dk_test(args)
	WScript.Echo ""
	ARGV = Join(args, ";")
	WScript.Echo "dk_test("+ARGV+")"
	WScript.Echo ""
	WScript.Echo "################# dk_test.vbs ################"
	ARGC = CStr(UBound(args)+1)
	if ARGC > 0 then 
		WScript.Echo "                    0 = "+args(0)
	end if
	if ARGC > 0 then 
		WScript.Echo "                    1 = "+args(1)
	end if
    if ARGC > 2 then 
		WScript.Echo "                    2 = "+args(2)
	end if
	if ARGC > 2 then 
		WScript.Echo "                    3 = "+args(3)
	end if
	if ARGC > 2 then 
		WScript.Echo "                    4 = "+args(4)
	end if
	if ARGC > 2 then 
		WScript.Echo "                    5 = "+args(5)
	end if
	if ARGC > 2 then 
		WScript.Echo "                    6 = "+args(6)
	end if
	if ARGC > 2 then 
		WScript.Echo "                    7 = "+args(7)
	end if
	if ARGC > 2 then 
		WScript.Echo "                    8 = "+args(8)
	end if
	if ARGC > 2 then 
		WScript.Echo "                    9 = "+args(9)
	end if
        WScript.Echo "           ERRORLEVEL = "+ERRORLEVEL
        WScript.Echo "                  LVL = "+LVL
'        WScript.Echo "                 TIME = "+TIME
        WScript.Echo "                 CMND = "+CMND
        WScript.Echo "                 FILE = "+WScript.ScriptFullName
        WScript.Echo "                 LINE = "+LINE
        WScript.Echo "                 FUNC = "+FUNC
        WScript.Echo "                 ARGC = "+ARGC
        WScript.Echo "                 ARGV = "+ARGV
        WScript.Echo "        DKSCRIPT_PATH = "+DKSCRIPT_PATH
        WScript.Echo "         DKSCRIPT_DIR = "+DKSCRIPT_DIR
        WScript.Echo "        DKSCRIPT_NAME = "+DKSCRIPT_NAME
        WScript.Echo "         DKSCRIPT_EXT = "+DKSCRIPT_EXT
        WScript.Echo "        DKSCRIPT_ARGS = "+DKSCRIPT_ARGS
        WScript.Echo "           DKHOME_DIR = "+DKHOME_DIR
        WScript.Echo "          DKCACHE_DIR = "+DKCACHE_DIR
        WScript.Echo "        DKDESKTOP_DIR = "+DKDESKTOP_DIR
        WScript.Echo "          DIGITALKNOB = "+DIGITALKNOB
        WScript.Echo "      DIGITALKNOB_DIR = "+DIGITALKNOB_DIR
        WScript.Echo "       DKDOWNLOAD_DIR = "+DKDOWNLOAD_DIR
        WScript.Echo "          DKTOOLS_DIR = "+DKTOOLS_DIR
        WScript.Echo "             DKBRANCH = "+DKBRANCH
        WScript.Echo "         DKBRANCH_DIR = "+DKBRANCH_DIR
        WScript.Echo "       DK3RDPARTY_DIR = "+DK3RDPARTY_DIR
        WScript.Echo "           DKCPP_APPS_DIR = "+DKCPP_APPS_DIR
        WScript.Echo "           DKBASH_DIR = "+DKVB_DIR
        WScript.Echo " DKBASH_FUNCTIONS_DIR = "+DKVB_FUNCTIONS_DIR
        WScript.Echo "DKBASH_FUNCTIONS_DIR_ = "+DKVB_FUNCTIONS_DIR_
    	
'	%dk_call% setGlobal GLOBAL_VAR "This is a global variable"
'	%dk_call% setReturn RETURN_VAR "This is a return variable"

	WScript.Echo "GLOBAL_VAR = %GLOBAL_VAR%"
	WScript.Echo "RETURN_VAR = %RETURN_VAR%"
end function









'###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if DKSCRIPT_FILE = "dk_test.vbs" then
	
	dk_test(Array("from :DKTEST", "to dk_test"))
'	WScript.Echo ""
'	WScript.Echo "GLOBAL_VAR = %GLOBAL_VAR%"
'	WScript.Echo "RETURN_VAR = %RETURN_VAR%"
	
'	Test::dk_test("from :DKTEST" "to Test::dk_test")
'	WScript.Echo ""
'	WScript.Echo "GLOBAL_VAR = %GLOBAL_VAR%"
'	WScript.Echo "RETURN_VAR = %RETURN_VAR%"
	
'	Test::Test::dk_test("from :DKTEST" "to Test::Test::dk_test")
'	WScript.Echo ""
'	WScript.Echo "GLOBAL_VAR = %GLOBAL_VAR%"
'	WScript.Echo "RETURN_VAR = %RETURN_VAR%"
	
	
end if