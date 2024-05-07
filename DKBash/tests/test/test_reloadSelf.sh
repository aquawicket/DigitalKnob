#!/bin/sh

###### Load Function files ######
#. ../functions/DK

#rm -r -f "${DIGITALKNOB_DIR}/${DKSCRIPT_NAME}"

DKSCRIPT_PATH="$(cd $(dirname $(realpath $0)); pwd)/$(basename $0)"
echo "DKSCRIPT_PATH = ${DKSCRIPT_PATH}"

DKSCRIPT_DIR="$(dirname "${DKSCRIPT_PATH}")"
echo "DKSCRIPT_DIR = ${DKSCRIPT_DIR}"

DKSCRIPT_NAME="$(basename "${DKSCRIPT_PATH}")"
echo "DKSCRIPT_NAME = ${DKSCRIPT_NAME}"

DKPARENT_DIR="$(dirname "${DKSCRIPT_DIR}")"
echo "DKPARENT_DIR = ${DKPARENT_DIR}"

cp -r "${DKSCRIPT_PATH}" "${DKPARENT_DIR}/${DKSCRIPT_NAME}"
		

exec $SHELL