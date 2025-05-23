#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

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