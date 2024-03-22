# NOTE: HelloWorld requires no DK libs
dk_command(echo hello BASH)
dk_command(command -v bash OUTPUT_VARIABLE BASH_FILE BASH)
message("BASH_FILE ${BASH_FILE}")