#!/usr/bin/env sh
. ../functions/DK.sh

dk_getFirstPath firstPath
echo "firstPath = $firstPath"


dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR"
echo "DKBRANCH_DIR = ${DKBRANCH_DIR}"

#echo dk_createSymlink ${DKBRANCH_DIR}/DKBuilder.sh ${firstPath}/DKBuilder
[ -e "${firstPath}/DKBuilder" ] || dk_createSymlink ${DKBRANCH_DIR}/DKBuilder.sh ${firstPath}/DKBuilder 


dk_pause

