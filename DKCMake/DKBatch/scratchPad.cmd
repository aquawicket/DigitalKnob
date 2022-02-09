%DKBATCH%
::set TEST_DKVARIABLES=1

::if %TEST_DKVARIABLES% LEQ 0 ( goto :endif_TEST_DKVARIABLES ) & :if_TEST_DKVARIABLES
::(
	echo #################################
	echo ##      TESTING Variables      ##
	echo #################################
	echo creating Test_variableA
	set "Test_variableA=Some string data"
	echo Test_variableA: %Test_variableA%
	echo Test_variableA: !Test_variableA!
	echo appending Test_variableA
	set "Test_variableA=!Test_variableA! added some data to the end"
	echo Test_variableA: !Test_variableA!
	echo:
::)
::endif_TEST_DKVARIABLES
:::::::::::::::::::::::::::
