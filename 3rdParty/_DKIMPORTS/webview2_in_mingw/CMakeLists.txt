cmake_minimum_required(VERSION 3.10)

project(webview2) 

include_directories(
	"${CMAKE_CURRENT_SOURCE_DIR}/Src"
	"${CMAKE_CURRENT_SOURCE_DIR}/WebView/include")
	
file(GLOB webview2_SRC 
	${CMAKE_CURRENT_SOURCE_DIR}/Src/*.h
	${CMAKE_CURRENT_SOURCE_DIR}/Src/*.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/WebView/include/*/h)
	
add_executable(webview2 ${webview2_SRC})