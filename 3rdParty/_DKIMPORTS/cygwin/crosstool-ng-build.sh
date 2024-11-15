#!/bin/bash

# Clone source repository
git clone --depth 1 --config core.autocrlf=input https://github.com/crosstool-ng/crosstool-ng.git
cd crosstool-ng

# Reset all CRLFs to LFs
# (In case core.autocrlf is globally configured to "true" and the repository has been cloned with CRLF endings.
#  This should not be necessary when git supports the --config flag.)
# git rm . -r
# git config core.autocrlf input
# git reset --hard HEAD

# Configure crosstool
./bootstrap
./configure

# Build crosstool
make
make install


reg ADD "HKLM\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Kernel" /v obcaseinsensitive /t REG_DWORD /d 0 /f


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