CMAKE_EXE=$(which cmake)
#echo CMAKE_EXE = $CMAKE_EXE
DKCMAKE_DIR=/c/Users/aquawicket/digitalknob/Development/DKCMake
#echo DKCMAKE_DIR = $DKCMAKE_DIR


$CMAKE_EXE -P $DKCMAKE_DIR/dev/Test.cmake

#exec $SHELL #keep terminal open