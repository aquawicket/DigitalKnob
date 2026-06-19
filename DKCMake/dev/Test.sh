cmake_exe=$(which cmake)
#echo cmake_exe = $cmake_exe
DKCMAKE_DIR=/c/Users/aquawicket/DigitalKnob/Development/DKCMake
#echo DKCMAKE_DIR = $DKCMAKE_DIR


$cmake_exe -P $DKCMAKE_DIR/dev/Test.cmake

#exec $SHELL #keep terminal open