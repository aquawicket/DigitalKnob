#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################



echo "DKTEST ${0} (${*})"
#echo "DKTEST = $DKTEST"
#echo "0 = ${0}"
#echo "BASH_SOURCE[0] = ${BASH_SOURCE[0]}"
#echo "BASH_SOURCE[1] = ${BASH_SOURCE[1]}"


#################################################################
# Trickle down condition checker
# Outcomes:   ALL FALSE or At least 1 True
#
# A=0; B=1
# C=1; D=1
# E=0; F=1
# if (( [ "$A" = "$B" ] && echo "a is TRUE") || (echo "a is FALSE"
#	    [ "$C" = "$D" ] && echo "b is TRUE") || (echo "b is FALSE"
#	    [ "$E" = "$F" ] && echo "d is TRUE")); then
#	   echo "AT LEAST 1 TRUE"
# else
#	   echo "ALL FALSE"
# fi
#################################################################

#################################################################
# Trickle down condition checker
# Outcomes:   ALL FALSE or At least 1 True
#
# A=0; B=1
# C=1; D=1
# E=0; F=1
# if (( [ "$A" = "$B" ] && echo "a is TRUE") || (echo "a is FALSE"
#	    [ "$C" = "$D" ] && echo "b is TRUE") || (echo "b is FALSE"
#	    [ "$E" = "$F" ] && echo "d is TRUE")); then
#	   echo "AT LEAST 1 TRUE"
# else
#	   echo "ALL FALSE"
# fi
#################################################################


#[ "$ENABLE_DKTEST" -ne "1" ] && exit 0

# No comments
#
if ( [ "$DKTEST" = "" ]                  ||
     [ "$DKTEST" = "${0}" ]              ||
     [ "$DKTEST" = "${BASH_SOURCE[0]}" ] ||
     [ "$DKTEST" = "${BASH_SOURCE[1]}" ] ||
     [ "$DKTEST" = "${BASH_SOURCE[2]}" ] ); then
	 echo "############################################################################"
     echo "###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	 echo "############################################################################"
     return 0
else
	 exit 0
fi

# Coments
#
#if ( ( [ "$DKTEST" = "" ]                   &&  echo "DKTEST is TRUE:${DKTEST}" )   || ( echo "  0 is FALSE:${DKTEST}"
#       [ "$DKTEST" = "${0}" ]               &&  echo "     0 is TRUE:${DKTEST}" )   || ( echo "  0 is FALSE:${DKTEST}"
#       [ "$DKTEST" = "${BASH_SOURCE[0]}" ]  &&  echo "   bs0 is TRUE:${DKTEST}" )   || ( echo "bs0 is FALSE:${DKTEST}"
#       [ "$DKTEST" = "${BASH_SOURCE[1]}" ]  &&  echo "   bs1 is TRUE:${DKTEST}" )   || ( echo "bs1 is FALSE:${DKTEST}"
#       [ "$DKTEST" = "${BASH_SOURCE[2]}" ]  &&  echo "   bs2 is TRUE:${DKTEST}" ) ); then
#      echo "########## DKTEST ${DKTEST} #################"
#      return 0
#else
#	  exit 0
#fi

# Commentable
# if ( ( [ "$DKTEST" = "" ] &&  
#            echo "DKTEST is TRUE:${DKTEST}" 
#			            ) || ( 
#			echo "0 is FALSE:${DKTEST}"
#       [ "$DKTEST" = "${0}" ] &&  
#	        echo "0 is TRUE:${DKTEST}" 
#			            ) || ( 
#			echo "0 is FALSE:${DKTEST}"
#      [ "$DKTEST" = "${BASH_SOURCE[0]}" ] &&  
#	        echo "bs0 is TRUE:${DKTEST}" 
#			            ) || ( 
#			echo "bs0 is FALSE:${DKTEST}"
#       [ "$DKTEST" = "${BASH_SOURCE[1]}" ] &&  
#	        echo "bs1 is TRUE:${DKTEST}" 
#		             	) || ( 
#			echo "bs1 is FALSE:${DKTEST}"
#       [ "$DKTEST" = "${BASH_SOURCE[2]}" ] ) ); then
#			echo "bs2 is TRUE:${DKTEST}"
#      echo "########## DKTEST ${DKTEST} #################"
#      return 0
#else
#	  exit 0
#fi