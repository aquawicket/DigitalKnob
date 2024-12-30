#!/bin/bash

export TOOLCHAIN_NAME="i686-unknown-linux-gnu"
export TOOLCHAIN_VERSION="9.2.0"

cd /usr/compile/x-tools

# Copy configuration and create tarball
cp ../.config ${TOOLCHAIN_NAME}
tar czf ${TOOLCHAIN_NAME}-${TOOLCHAIN_VERSION}.tar.gz ${TOOLCHAIN_NAME}
