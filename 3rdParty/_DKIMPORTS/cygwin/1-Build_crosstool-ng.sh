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
