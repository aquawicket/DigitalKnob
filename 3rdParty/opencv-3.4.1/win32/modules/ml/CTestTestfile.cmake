# CMake generated Testfile for 
# Source directory: C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/modules/ml
# Build directory: C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/win32/modules/ml
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
if("${CTEST_CONFIGURATION_TYPE}" MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
  add_test(opencv_test_ml "C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/win32/bin/Debug/opencv_test_mld.exe" "--gtest_output=xml:opencv_test_ml.xml")
  set_tests_properties(opencv_test_ml PROPERTIES  LABELS "Main;opencv_ml;Accuracy" WORKING_DIRECTORY "C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/win32/test-reports/accuracy" _BACKTRACE_TRIPLES "C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/cmake/OpenCVUtils.cmake;1344;add_test;C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/cmake/OpenCVModule.cmake;1235;ocv_add_test_from_target;C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/cmake/OpenCVModule.cmake;1046;ocv_add_accuracy_tests;C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/modules/ml/CMakeLists.txt;2;ocv_define_module;C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/modules/ml/CMakeLists.txt;0;")
elseif("${CTEST_CONFIGURATION_TYPE}" MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
  add_test(opencv_test_ml "C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/win32/bin/Release/opencv_test_ml.exe" "--gtest_output=xml:opencv_test_ml.xml")
  set_tests_properties(opencv_test_ml PROPERTIES  LABELS "Main;opencv_ml;Accuracy" WORKING_DIRECTORY "C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/win32/test-reports/accuracy" _BACKTRACE_TRIPLES "C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/cmake/OpenCVUtils.cmake;1344;add_test;C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/cmake/OpenCVModule.cmake;1235;ocv_add_test_from_target;C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/cmake/OpenCVModule.cmake;1046;ocv_add_accuracy_tests;C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/modules/ml/CMakeLists.txt;2;ocv_define_module;C:/Users/aquawicket/digitalknob/DK/3rdParty/opencv-3.4.1/modules/ml/CMakeLists.txt;0;")
else()
  add_test(opencv_test_ml NOT_AVAILABLE)
endif()
