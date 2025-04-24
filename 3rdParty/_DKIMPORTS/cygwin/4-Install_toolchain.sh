#!/bin/bash

export TOOLCHAIN_NAME="i686-unknown-linux-gnu"
export TOOLCHAIN_VERSION="9.2.0"

# Extract the tar archive
tar xzf ${TOOLCHAIN_NAME}-${TOOLCHAIN_VERSION}.tar.gz

# Populate directory
chmod -R u+w /usr/local
./${TOOLCHAIN_NAME}/bin/${TOOLCHAIN_NAME}-populate -m -s ${TOOLCHAIN_NAME} -d /usr/local/${TOOLCHAIN_NAME}

# Remove temporary directory & .config file
rm -r -f ./${TOOLCHAIN_NAME} | true
rm -f /usr/local/.config | true
