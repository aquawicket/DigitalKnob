#!/bin/sh
. ../functions/DK.sh

dk_getFirstPath firstPath
echo "firstPath = $firstPath"

dk_load dk_validateBranch
dk_validate DKBRANCH_DIR "dk_validateBranch"
echo "DKBRANCH_DIR = $DKBRANCH_DIR"

#echo dk_createSymlink ${DKBRANCH_DIR}/DKBuilder.sh ${firstPath}/DKBuilder
[ -e "${firstPath}/DKBuilder" ] || dk_createSymlink ${DKBRANCH_DIR}/DKBuilder.sh ${firstPath}/DKBuilder 


dk_pause

