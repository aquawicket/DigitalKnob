#!/bin/sh
echo ""
echo "$0($*)"

DKSCRIPT_PATH="$(cd $(dirname $(realpath $0)); pwd)/$(basename $0)"
echo "DKSCRIPT_PATH = ${DKSCRIPT_PATH}"
	
DKSCRIPT_DIR="$(dirname "${DKSCRIPT_PATH}")"
echo "DKSCRIPT_DIR = ${DKSCRIPT_DIR}"

DKSCRIPT_NAME="$(basename "${DKSCRIPT_PATH}")"
echo "DKSCRIPT_NAME = ${DKSCRIPT_NAME}"

DKPARENT_DIR="$(dirname "${DKSCRIPT_DIR}")"
echo "DKPARENT_DIR = ${DKPARENT_DIR}"
	
	
	

if [ "$1" == "rename" ];then 
	echo "RENAME"
	sleep 3
	
	echo "mv ${DKSCRIPT_DIR}/test ${DKSCRIPT_DIR}/test_renamed"
	mv "${DKSCRIPT_DIR}/test" "${DKSCRIPT_DIR}/test_renamed"
	
else
	echo "MAIN"
	
	echo "cp -r ${DKSCRIPT_PATH} ${DKPARENT_DIR}/${DKSCRIPT_NAME}"
	cp -r "${DKSCRIPT_PATH}" "${DKPARENT_DIR}/${DKSCRIPT_NAME}"
	#. "${DKPARENT_DIR}/${DKSCRIPT_NAME}" rename
	exec "${DKPARENT_DIR}/${DKSCRIPT_NAME}" rename
	exit
fi
exec $SHELL