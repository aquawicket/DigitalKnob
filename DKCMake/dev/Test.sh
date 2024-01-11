clear

CMAKE=$(which cmake)
echo CMAKE = $CMAKE
DKCMAKE=/c/Users/Administrator/digitalknob/Development/DKCMake
echo DKCMAKE = $DKCMAKE


$CMAKE -DDKCMAKE=$DKCMAKE -P $DKCMAKE/dev/Test.cmake

exec $SHELL #keep terminal open