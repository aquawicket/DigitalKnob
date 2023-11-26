# https://github.com/w3c/reffy.git

dk_depend(nodejs)

dk_import(https://github.com/w3c/reffy.git BRANCH main)

# https://github.com/w3c/reffy#readme
dk_set(REFFY_CRAWL_IDL OFF)
if(${REFFY_CRAWL_IDL})
	dk_command(${NPM_EXE} install -g reffy)
	dk_command(${NPM_EXE} update -g reffy)
	dk_set(REFFY_EXE ${NODEJS}/reffy.cmd)
	dk_command(${REFFY_EXE} --spec fetch --module idl > fetch.idl)
	dk_command(${REFFY_EXE} --spec html --module idl > html.idl)
	dk_command(${REFFY_EXE} --module idl > all.idl)
endif()
