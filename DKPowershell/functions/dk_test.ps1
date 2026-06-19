if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}\DK.ps1; }
if(!$dk_test_ps1){ $dk_test_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_test()
#
#
function GLOBAL:dk_test($argA, $argB, $argC) {
	dk_call dk_debugFunc 0 99
	
	$bound = ${PsBoundParameters};
	
	$n = 0;
	foreach($value in $Args){
		if(${value}){
			if(!($unbound)){ $unbound = [ordered]@{}; }
			$unbound.Add("unbound$n", "${value}");
			$n++;
		}
	}
	
	$all = [ordered]@{}
	$all += ${PsBoundParameters};
	if($unbound){ $all += ${unbound}; }
	
										  dk_call dk_echo "####################### dk_test.ps1 #################################";
										  dk_call dk_echo ""
										  dk_call dk_echo "      ####################### FUNCTIONS #######################";
	if(${function:NONEXISTENT})		    { dk_call dk_echo "                NONEXISTENT = '$(dk_call NONEXISTENT)'"                               }
	if(${function:__TIME__})			{ dk_call dk_echo "                   __TIME__ = '$(dk_call __TIME__)'"                                  }
	if(${function:__CALLER__})			{ dk_call dk_echo "                 __CALLER__ = '$(dk_call __CALLER__)'"                                }
    if(${function:__FILE__})			{ dk_call dk_echo "                   __FILE__ = '$(dk_call __FILE__)'"                                  }
    if(${function:__LINE__})			{ dk_call dk_echo "                   __LINE__ = '$(dk_call __LINE__)'"                                  }
    if(${function:__FUNCTION__})		{ dk_call dk_echo "               __FUNCTION__ = '$(dk_call __FUNCTION__ 1)'"                            }
    if(${function:__ARGC__})			{ dk_call dk_echo "                   __ARGC__ = '$(dk_call __ARGC__ 1)'"                                }
    if(${function:__ARGV__})			{ dk_call dk_echo "                   __ARGV__ = '$(dk_call __ARGV__ 1)'"                                }
	                                      dk_call dk_echo ""
										  dk_call dk_echo "      ####################### VARIABLES #######################";
	if(${NONEXISTENT})					{ dk_call dk_echo "                NONEXISTENT = '${NONEXISTENT}'"                                       }
	if(${NONEXISTENT[0]})   			{ dk_call dk_echo "             NONEXISTENT[0] = '$(NONEXISTENT[0])'"                                    }
                                          dk_call dk_echo ""
	if($($args[0]))   					{ dk_call dk_echo "           args[0]          = '$($args[0])'";                                         }
	if(${bound}.Count)   				{ dk_call dk_echo "           bound.Count      = '$(${bound}.Count)'"                                    }
	if(${bound}.Keys)       			{ dk_call dk_echo "           bound.Keys       = '$(${bound}.Keys)'"                                     }
	if(${bound}.Values)       			{ dk_call dk_echo "           bound.Values     = '$(${bound}.Values)'"                                   }
	if(${bound}.Count -gt 0)    	  	{ dk_call dk_echo "           bound[0]         =  $($(${bound}.Keys)[0]):'$($(${bound}.Values)[0])'"     }
	if(${bound}.Count -gt 1)     		{ dk_call dk_echo "           bound[1]         =  $($(${bound}.Keys)[1]):'$($(${bound}.Values)[1])'"     }
	if(${bound}.Count -gt 2)    		{ dk_call dk_echo "           bound[2]         =  $($(${bound}.Keys)[2]):'$($(${bound}.Values)[2])'"     }
	if(${bound}.Count -gt 3)     		{ dk_call dk_echo "           bound[3]         =  $($(${bound}.Keys)[3]):'$($(${bound}.Values)[3])'"     }
	if(${bound}.Count -gt 4)     		{ dk_call dk_echo "           bound[4]         =  $($(${bound}.Keys)[4]):'$($(${bound}.Values)[4])'"     }
	if(${bound}.Count -gt 5)    		{ dk_call dk_echo "           bound[5]         =  $($(${bound}.Keys)[5]):'$($(${bound}.Values)[5])'"     }
	if(${bound}.Count -gt 6)    		{ dk_call dk_echo "           bound[6]         =  $($(${bound}.Keys)[6]):'$($(${bound}.Values)[6])'"     }
	if(${bound}.Count -gt 7)     		{ dk_call dk_echo "           bound[7]         =  $($(${bound}.Keys)[7]):'$($(${bound}.Values)[7])'"     }
	if(${bound}.Count -gt 8)    		{ dk_call dk_echo "           bound[8]         =  $($(${bound}.Keys)[8]):'$($(${bound}.Values)[8])'"     }
	if(${bound}.Count -gt 9)     		{ dk_call dk_echo "           bound[9]         =  $($(${bound}.Keys)[9]):'$($(${bound}.Values)[9])'"     }
										  dk_call dk_echo ""
	if(${unbound}.Count)   				{ dk_call dk_echo "         unbound.Count      = '$(${unbound}.Count)'"                                  }
	if(${unbound}.Keys)       			{ dk_call dk_echo "         unbound.Keys       = '$(${unbound}.Keys)'"                                   }
	if(${unbound}.Values)       		{ dk_call dk_echo "         unbound.Values     = '$(${unbound}.Values)'"                                 }
	if(${unbound}.Count -gt 0)      	{ dk_call dk_echo "         unbound.Values[0]  =  $($(${unbound}.Keys)[0]):'$($(${unbound}.Values)[0])'" }
	if(${unbound}.Count -gt 1)      	{ dk_call dk_echo "         unbound.Values[1]  =  $($(${unbound}.Keys)[1]):'$($(${unbound}.Values)[1])'" }
	if(${unbound}.Count -gt 2)      	{ dk_call dk_echo "         unbound.Values[2]  =  $($(${unbound}.Keys)[2]):'$($(${unbound}.Values)[2])'" }
	if(${unbound}.Count -gt 3)      	{ dk_call dk_echo "         unbound.Values[3]  =  $($(${unbound}.Keys)[3]):'$($(${unbound}.Values)[3])'" }
	if(${unbound}.Count -gt 4)      	{ dk_call dk_echo "         unbound.Values[4]  =  $($(${unbound}.Keys)[4]):'$($(${unbound}.Values)[4])'" }
	if(${unbound}.Count -gt 5)      	{ dk_call dk_echo "         unbound.Values[5]  =  $($(${unbound}.Keys)[5]):'$($(${unbound}.Values)[5])'" }
	if(${unbound}.Count -gt 6)      	{ dk_call dk_echo "         unbound.Values[6]  =  $($(${unbound}.Keys)[6]):'$($(${unbound}.Values)[6])'" }
	if(${unbound}.Count -gt 7)      	{ dk_call dk_echo "         unbound.Values[7]  =  $($(${unbound}.Keys)[7]):'$($(${unbound}.Values)[7])'" }
	if(${unbound}.Count -gt 8)      	{ dk_call dk_echo "         unbound.Values[8]  =  $($(${unbound}.Keys)[8]):'$($(${unbound}.Values)[8])'" }
	if(${unbound}.Count -gt 9)      	{ dk_call dk_echo "         unbound.Values[9]  =  $($(${unbound}.Keys)[9]):'$($(${unbound}.Values)[9])'" }
										  dk_call dk_echo ""
	if(${all}.Count)   					{ dk_call dk_echo "             all.Count      = '$(${all}.Count)'"                                      }
	if(${all}.Keys)       				{ dk_call dk_echo "             all.Keys       = '$(${all}.Keys)'"                                       }
	if(${all}.Values)       			{ dk_call dk_echo "             all.Values     = '$(${all}.Values)'"                                     }
	if(${all}.Count -gt 0)    			{ dk_call dk_echo "             all.Values[0]  =  $($(${all}.Keys)[0]):'$($(${all}.Values)[0])'"         }
	if(${all}.Count -gt 1)      		{ dk_call dk_echo "             all.Values[1]  =  $($(${all}.Keys)[1]):'$($(${all}.Values)[1])'"         }
	if(${all}.Count -gt 2)     			{ dk_call dk_echo "             all.Values[2]  =  $($(${all}.Keys)[2]):'$($(${all}.Values)[2])'"         }
	if(${all}.Count -gt 3)				{ dk_call dk_echo "             all.Values[3]  =  $($(${all}.Keys)[3]):'$($(${all}.Values)[3])'"         }
	if(${all}.Count -gt 4)     			{ dk_call dk_echo "             all.Values[4]  =  $($(${all}.Keys)[4]):'$($(${all}.Values)[4])'"         }
	if(${all}.Count -gt 5)     			{ dk_call dk_echo "             all.Values[5]  =  $($(${all}.Keys)[5]):'$($(${all}.Values)[5])'"         }
	if(${all}.Count -gt 6)     			{ dk_call dk_echo "             all.Values[6]  =  $($(${all}.Keys)[6]):'$($(${all}.Values)[6])'"         }
	if(${all}.Count -gt 7)     			{ dk_call dk_echo "             all.Values[7]  =  $($(${all}.Keys)[7]):'$($(${all}.Values)[7])'"         }
	if(${all}.Count -gt 8)     			{ dk_call dk_echo "             all.Values[8]  =  $($(${all}.Keys)[8]):'$($(${all}.Values)[8])'"         }
	if(${all}.Count -gt 9)     			{ dk_call dk_echo "             all.Values[9]  =  $($(${all}.Keys)[9]):'$($(${all}.Values)[9])'"         }
										  dk_call dk_echo ""
	if(${DKSCRIPT_PATH})    			{ dk_call dk_echo "              DKSCRIPT_PATH = '${DKSCRIPT_PATH}'"                                     }
    if(${DKSCRIPT_DIR})    				{ dk_call dk_echo "               DKSCRIPT_DIR = '${DKSCRIPT_DIR}'"                                      }
    if(${DKSCRIPT_DIR})    				{ dk_call dk_echo "              DKSCRIPT_NAME = '${DKSCRIPT_NAME}'"                                     }
    if(${DKSCRIPT_EXT})    				{ dk_call dk_echo "               DKSCRIPT_EXT = '${DKSCRIPT_EXT}'"                                      }
    if(${DKSCRIPT_ARGS})    			{ dk_call dk_echo "              DKSCRIPT_ARGS = '${DKSCRIPT_ARGS}'"                                     }
    if(${DKHOME_DIR})    				{ dk_call dk_echo "                 DKHOME_DIR = '${DKHOME_DIR}'"                                        }
    if(${DKCACHE_DIR})    				{ dk_call dk_echo "                DKCACHE_DIR = '${DKCACHE_DIR}'"                                       }
    if(${DKDESKTOP_DIR})    			{ dk_call dk_echo "              DKDESKTOP_DIR = '${DKDESKTOP_DIR}'"                                     }
    if(${DIGITALKNOB})    				{ dk_call dk_echo "                DIGITALKNOB = '${DIGITALKNOB}'"                                       }
    if(${DIGITALKNOB_DIR})    			{ dk_call dk_echo "            DIGITALKNOB_DIR = '${DIGITALKNOB_DIR}'"                                   }
    if(${DKDOWNLOAD_DIR})    			{ dk_call dk_echo "             DKDOWNLOAD_DIR = '${DKDOWNLOAD_DIR}'"                                    }
    if(${DKTOOLS_DIR})    				{ dk_call dk_echo "                DKTOOLS_DIR = '${DKTOOLS_DIR}'"                                       }
    if(${DKBRANCH})    					{ dk_call dk_echo "                   DKBRANCH = '${DKBRANCH}'"                                          }
    if(${DKBRANCH_DIR})    				{ dk_call dk_echo "               DKBRANCH_DIR = '${DKBRANCH_DIR}'"                                      }
    if(${DK3RDPARTY_DIR})    			{ dk_call dk_echo "             DK3RDPARTY_DIR = '${DK3RDPARTY_DIR}'"                                    }
    if(${DKCPP_APPS_DIR})    			{ dk_call dk_echo "             DKCPP_APPS_DIR = '${DKCPP_APPS_DIR}'"                                    }
    if(${DKPOWERSHELL_DIR})    			{ dk_call dk_echo "                 DKBASH_DIR = '${DKPOWERSHELL_DIR}'"                                  }
    if(${DKPOWERSHELL_FUNCTIONS_DIR}) 	{ dk_call dk_echo " DKPOWERSHELL_FUNCTIONS_DIR = '${DKPOWERSHELL_FUNCTIONS_DIR}'"                        }
    if(${DKPOWERSHELL_FUNCTIONS_DIR_})	{ dk_call dk_echo "DKPOWERSHELL_FUNCTIONS_DIR_ = '${DKPOWERSHELL_FUNCTIONS_DIR_}'"                       }
    
	${global:dk_test}="Return string from dk_test.ps1";
	return ${dk_test}; 
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
    #dk_call dk_debugFunc 0;

    dk_call dk_test "123" "abc" "456" "def" "789" "g h i"
	dk_call dk_echo ""
	dk_call dk_echo "dk_test = ${dk_test}";
	
	dk_call Test/dk_test "from DKTEST()" "to Test/dk_test()"
	dk_call dk_echo ""
	dk_call dk_echo "dk_test = ${dk_test}";
	
	dk_call Test/Test/dk_test "from DKTEST()" "to Test/Test/dk_test()"
	dk_call dk_echo ""
	dk_call dk_echo "dk_test = ${dk_test}";
}
