# CMake generated Testfile for 
# Source directory: C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/modules/videostab
# Build directory: C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/win32/modules/videostab
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
if("${CTEST_CONFIGURATION_TYPE}" MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
  add_test(opencv_test_videostab "C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/win32/bin/Debug/opencv_test_videostabd.exe" "--gtest_output=xml:opencv_test_videostab.xml")
  set_tests_properties(opencv_test_videostab PROPERTIES  LABELS "Main;opencv_videostab;Accuracy" WORKING_DIRECTORY "C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/win32/test-reports/accuracy" _BACKTRACE_TRIPLES "C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/cmake/OpenCVUtils.cmake;1344;add_test;C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/cmake/OpenCVModule.cmake;1235;ocv_add_test_from_target;C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/cmake/OpenCVModule.cmake;1046;ocv_add_accuracy_tests;C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/modules/videostab/CMakeLists.txt;11;ocv_define_module;C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/modules/videostab/CMakeLists.txt;0;")
elseif("${CTEST_CONFIGURATION_TYPE}" MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
  add_test(opencv_test_videostab "C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/win32/bin/Release/opencv_test_videostab.exe" "--gtest_output=xml:opencv_test_videostab.xml")
  set_tests_properties(opencv_test_videostab PROPERTIES  LABELS "Main;opencv_videostab;Accuracy" WORKING_DIRECTORY "C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/win32/test-reports/accuracy" _BACKTRACE_TRIPLES "C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/cmake/OpenCVUtils.cmake;1344;add_test;C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/cmake/OpenCVModule.cmake;1235;ocv_add_test_from_target;C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/cmake/OpenCVModule.cmake;1046;ocv_add_accuracy_tests;C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/modules/videostab/CMakeLists.txt;11;ocv_define_module;C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/modules/videostab/CMakeLists.txt;0;")
else()
  add_test(opencv_test_videostab NOT_AVAILABLE)
endif()
