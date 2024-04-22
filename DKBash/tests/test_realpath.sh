#!/bin/bash

reelpath() {
    [ $1 = /* ] && echo "$1" || echo "$PWD/${1#./}"
}

echo ""
RP=$(reelpath "$0")
echo "RP = $RP"

exec $SHELL