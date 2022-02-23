CMAKE_MINIMUM_REQUIRED(VERSION 3.10)
CMAKE_POLICY(SET CMP0007 NEW)
include(../Functions.cmake)
include(../string.cmake)

message(STATUS " ")
message(STATUS "###############################")
message(STATUS "#########  Test.cmake  ########")
message(STATUS "###############################")
message(STATUS " ")


#dk_printAllVariables()
#DKIMPORT2(https://github.com/aquawicket/DigitalKnob.zip)

message(STATUS "With the string.cmake class, we overwrite the set() function to intercept and \"stringify\" variables. That will add _function style macros to the variable name so we can access the function much like javascript. Instead of string.function() we use string_function(). CMake functions lack returning values directly, So, we use the last parameter as he return variable.\n")

message(STATUS "EXAMPLE:  set(MyString \"the text within the string\")\n")
set(MyString "the text within the string")

message(STATUS "string.cmake will automatically listen for the set() function and use it to stringify that variable, and add string _functions to it.")
message(STATUS "For example, now we can use the string includes() function like this...\n")
message(STATUS "MyString_includes(\"within\" 15 result)")
MyString_includes("within" 3 result)
message(STATUS "result = \${result}\n")
DKDEBUG("OUTPUT: result = ${result}\n")
message(STATUS "This style puts CMake closer to javascript style, which looks like this.. result = MyString.include('within', 15)")
message(STATUS "The only major differences are the dot .  is replaced with an underscore _  And instead of the function returning a value directly,")
message(STATUS "we set the return variable as the last parameter. Then we can easily check it's value right after the function completes")