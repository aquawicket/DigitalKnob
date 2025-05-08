#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


##################################################################################
# dk_onEvent()
#
#
#!/bin/bash

exitfn () {
  trap '' SIGINT            # Restore signal handling for SIGINT.
  echo; echo 'Aarghh!!'  # Growl at user,
  exit                   #   then exit script.
}

trap "exitfn" INT        # Set SIGINT trap to call function.

read -p "What? "         # Ask user for input,
echo "You said: ${REPLY}"  #   then echo back.

trap '' SIGINT              # Restore signal handling.
exec ${0}