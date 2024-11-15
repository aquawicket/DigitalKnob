#!/bin/bash

# Directories
# Do not use a cygwin path string for WINDOWS_DIR as it will not work
WINDOWS_DIR=C:/compile-cs
LINUX_DIR=/usr/compile

# Create case sensitive file system
mkdir $WINDOWS_DIR
mkdir $LINUX_DIR

# Mount new filesystem
mount $WINDOWS_DIR $LINUX_DIR -o binary,posix=1

cd $LINUX_DIR
mkdir src

ct-ng menuconfig