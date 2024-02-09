CMAKE=$(which cmake)
#echo CMAKE = $CMAKE
DKCMAKE=/c/Users/aquawicket/digitalknob/Development/DKCMake
#echo DKCMAKE = $DKCMAKE


$CMAKE -P $DKCMAKE/dev/Test.cmake

#exec $SHELL #keep terminal open