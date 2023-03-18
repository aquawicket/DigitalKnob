# https://github.com/w3c/reffy.git

dk_depend(nodejs)

dk_import(https://github.com/w3c/reffy.git BRANCH main)

# https://github.com/w3c/reffy#readme
dk_command(${NPM_EXE} install -g reffy)
dk_command(${NPM_EXE} update -g reffy)
dk_set(REFFY_EXE ${NODEJS}/reffy.cmd)
dk_command(${REFFY_EXE} --spec fetch --module idl)
