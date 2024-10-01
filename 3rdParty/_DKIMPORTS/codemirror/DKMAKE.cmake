#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://github.com/codemirror/CodeMirror
# https://github.com/codemirror/CodeMirror.git
# https://github.com/codemirror/CodeMirror/archive/17634c2205d987366dedbb763fbf7b4d4ecf1326.zip
# https://codemirror.net/codemirror.zip

dk_import(https://github.com/codemirror/codemirror5/archive/998f328b6b01217f6ef9e958ce3a128daddc592e.zip)
#dk_import(https://github.com/codemirror/codemirror5/archive/refs/heads/master.zip)

