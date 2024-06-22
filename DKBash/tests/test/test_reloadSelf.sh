#!/bin/sh
echo ""
echo "$0($*)"

DKSCRIPT_PATH="$(cd $(dirname $(realpath $0)); pwd)/$(basename $0)"
#DKSCRIPT_PATH="$(cd "$(dirname "$0")"; pwd -P)/$(basename $0)"
echo "DKSCRIPT_PATH = ${DKSCRIPT_PATH}"
	
DKSCRIPT_DIR="$(dirname "${DKSCRIPT_PATH}")"
echo "DKSCRIPT_DIR = ${DKSCRIPT_DIR}"

DKSCRIPT_NAME="$(basename "${DKSCRIPT_PATH}")"
echo "DKSCRIPT_NAME = ${DKSCRIPT_NAME}"

DKPARENT_DIR="$(dirname "${DKSCRIPT_DIR}")"
echo "DKPARENT_DIR = ${DKPARENT_DIR}"
	
	
	
if [ "$1" == "finished" ];then 
	echo "FINISHED"
	
	sleep 10
	read -rp 'Press enter to continue...' key
	
else
	echo "MAIN"
	
	echo "cp -r ${DKSCRIPT_PATH} ${DKPARENT_DIR}/${DKSCRIPT_NAME}"
	cp -rp "${DKSCRIPT_PATH}" "${DKPARENT_DIR}/${DKSCRIPT_NAME}"
	rm -r -f "${DKSCRIPT_DIR}" 2>/dev/null
	echo done
	cp -rp "${DKPARENT_DIR}/${DKSCRIPT_NAME}" "${DKSCRIPT_DIR}/renamed.sh"
	cp -rp "${DKPARENT_DIR}/${DKSCRIPT_NAME}" "${DKSCRIPT_DIR}/${DKSCRIPT_NAME}"
	exec "${DKSCRIPT_DIR}/renamed.sh" finished
	exec $SHELL
fi
