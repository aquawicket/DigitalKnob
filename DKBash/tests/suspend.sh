#!/bin/bash -eu
script(){ #a mock for your script
    while :; do
        echo working
        sleep 1
    done
}

set -m #use job control
script & #run it in the background in a separate process group
read -sd ' ' #silently read until a space is read
kill -STOP -$! #stop the background process group
sleep 20 #wait 2 seconds (change it to 20 for your case)
kill -CONT -$! #resume the background process group
fg #put it in the forground so it's killable with Ctrl+C