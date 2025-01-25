cmake_minimum_required(VERSION 3.10)

project(webview2) 

include_directories(
	"${CMAKE_CURRENT_SOURCE_DIR}/Src"
	"${CMAKE_CURRENT_SOURCE_DIR}/WebView/include")
	
file(GLOB webview2_SRC 
	${CMAKE_CURRENT_SOURCE_DIR}/Src/*.h
	${CMAKE_CURRENT_SOURCE_DIR}/Src/*.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/WebView/include/*/h)
	

#set(CMAKE_EXE_LINKER_FLAGS -L./WebView/x64 -lWebView2Loader -mwindows -static-libgcc -static-libstdc++ -Wl,-Bstatic -lstdc++ -lpthread -Wl,-Bdynamic)

	
	
add_executable(webview2 ${webview2_SRC})
set(CMAKE_EXE_LINKER_FLAGS	"${CMAKE_EXE_LINKER_FLAGS} -static -static-libgcc -static-libstdc++") 

target_link_libraries(webview2 ${LIBGCC_LIBRARY_DEBUG} 
"${CMAKE_CURRENT_SOURCE_DIR}/WebView/x64/WebView2Guid.lib" "${CMAKE_CURRENT_SOURCE_DIR}/WebView/x64/WebView2Loader.dll.lib")
