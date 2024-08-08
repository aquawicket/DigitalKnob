# CMake for duktape
cmake_minimum_required(VERSION 3.10)

project(duktape)

include_directories(${CMAKE_SOURCE_DIR}/src)
file(GLOB duktape_SRC ${CMAKE_SOURCE_DIR}/src/*.c)
add_library(duktape STATIC ${duktape_SRC})

#### BUILD EXAMPLES ###
#set(BUILD_DUKTAPE_EXAMPLES ON)
#if(BUILD_DUKTAPE_EXAMPLES AND WIN32)
	# alloc-hybrid
	#include_directories(${CMAKE_SOURCE_DIR}/examples/alloc-hybrid)
	#file(GLOB alloc-hybrid_SRC ${CMAKE_SOURCE_DIR}/examples/alloc-hybrid/*.c)
	#add_executable(alloc-hybrid WIN32 ${duktape_SRC} ${alloc-hybrid_SRC})
	#set_target_properties(alloc-hybrid PROPERTIES LINK_FLAGS /SUBSYSTEM:CONSOLE)
	
	# alloc-logging
	#include_directories(${CMAKE_SOURCE_DIR}/examples/alloc-logging)
	#file(GLOB alloc-logging_SRC ${CMAKE_SOURCE_DIR}/examples/alloc-logging/*.c)
	#add_executable(alloc-logging WIN32 ${duktape_SRC} ${alloc-logging_SRC})
	#set_target_properties(alloc-logging PROPERTIES LINK_FLAGS /SUBSYSTEM:CONSOLE)
	
	# alloc-torture
	#include_directories(${CMAKE_SOURCE_DIR}/examples/alloc-torture)
	#file(GLOB alloc-torture_SRC ${CMAKE_SOURCE_DIR}/examples/alloc-torture/*.c)
	#add_executable(alloc-torture WIN32 ${duktape_SRC} ${alloc-torture_SRC})
	#set_target_properties(alloc-torture PROPERTIES LINK_FLAGS /SUBSYSTEM:CONSOLE)
	
	# cmdline
	#include_directories(${CMAKE_SOURCE_DIR}/examples/cmdline)
	#file(GLOB cmdline_SRC ${CMAKE_SOURCE_DIR}/examples/cmdline/*.c)
	#add_executable(cmdline WIN32 ${duktape_SRC} ${cmdline_SRC})
	#set_target_properties(cmdline PROPERTIES LINK_FLAGS /SUBSYSTEM:CONSOLE)
	
	# codepage-conv
	#include_directories(${CMAKE_SOURCE_DIR}/examples/codepage-conv)
	#file(GLOB codepage-conv_SRC ${CMAKE_SOURCE_DIR}/examples/codepage-conv/*.c)
	#add_executable(codepage-conv WIN32 ${duktape_SRC} ${codepage-conv_SRC})
	#set_target_properties(codepage-conv PROPERTIES LINK_FLAGS /SUBSYSTEM:CONSOLE)
	
	# coffee
	# TODO
	
	# cpp-exceptions
	#include_directories(${CMAKE_SOURCE_DIR}/examples/cpp-exceptions)
	#file(GLOB cpp-exceptions_SRC ${CMAKE_SOURCE_DIR}/examples/cpp-exceptions/*.c)
	#add_executable(cpp-exceptions WIN32 ${duktape_SRC} ${cpp-exceptions_SRC})
	#set_target_properties(cpp-exceptions PROPERTIES LINK_FLAGS /SUBSYSTEM:CONSOLE)
	
	# debug-trans-dvalue
	#include_directories(${CMAKE_SOURCE_DIR}/examples/debug-trans-dvalue)
	#file(GLOB debug-trans-dvalue_SRC ${CMAKE_SOURCE_DIR}/examples/debug-trans-dvalue/*.c)
	#add_executable(debug-trans-dvalue WIN32 ${duktape_SRC} ${debug-trans-dvalue_SRC})
	#set_target_properties(debug-trans-dvalue PROPERTIES LINK_FLAGS /SUBSYSTEM:CONSOLE)

	# debug-trans-socket
	#add_definitions(-DDUK_CMDLINE_DEBUGGER_SUPPORT)
	#include_directories(${CMAKE_SOURCE_DIR}/examples/debug-trans-socket)
	#add_executable(debug-trans-socket WIN32 ${duktape_SRC}
	#	${CMAKE_SOURCE_DIR}/examples/cmdline/duk_cmdline.c
	#	${CMAKE_SOURCE_DIR}/examples/debug-trans-socket/duk_trans_socket_windows.c)
	#set_target_properties(debug-trans-socket PROPERTIES LINK_FLAGS /SUBSYSTEM:CONSOLE)
	
	# dummy-date-provider
	#include_directories(${CMAKE_SOURCE_DIR}/examples/dummy-date-provider)
	#file(GLOB dummy-date-provider_SRC ${CMAKE_SOURCE_DIR}/examples/dummy-date-provider/*.c)
	#add_executable(dummy-date-provider WIN32 ${duktape_SRC} ${dummy-date-provider_SRC})
	#set_target_properties(dummy-date-provider PROPERTIES LINK_FLAGS /SUBSYSTEM:CONSOLE)
	
	# eval
	#include_directories(${CMAKE_SOURCE_DIR}/examples/eval)
	#file(GLOB eval_SRC ${CMAKE_SOURCE_DIR}/examples/eval/*.c)
	#add_executable(eval WIN32 ${duktape_SRC} ${eval_SRC})
	#set_target_properties(eval PROPERTIES LINK_FLAGS /SUBSYSTEM:CONSOLE)
	
	# eventloop
	#include_directories(${CMAKE_SOURCE_DIR}/examples/eventloop)
	#file(GLOB eventloop_SRC ${CMAKE_SOURCE_DIR}/examples/eventloop/*.c)
	#add_executable(eventloop WIN32 ${duktape_SRC} ${eventloop_SRC})
	#set_target_properties(eventloop PROPERTIES LINK_FLAGS /SUBSYSTEM:CONSOLE)
	
	# guide
	#include_directories(${CMAKE_SOURCE_DIR}/examples/guide)
	#file(GLOB guide_SRC ${CMAKE_SOURCE_DIR}/examples/guide/*.c)
	#add_executable(guide WIN32 ${duktape_SRC} ${guide_SRC})
	#set_target_properties(guide PROPERTIES LINK_FLAGS /SUBSYSTEM:CONSOLE)
	
	# hello
	#include_directories(${CMAKE_SOURCE_DIR}/examples/hello)
	#file(GLOB hello_SRC ${CMAKE_SOURCE_DIR}/examples/hello/*.c)
	#add_executable(hello WIN32 ${duktape_SRC} ${hello_SRC})
	#set_target_properties(hello PROPERTIES LINK_FLAGS /SUBSYSTEM:CONSOLE)
	
	# jxpretty
	#include_directories(${CMAKE_SOURCE_DIR}/examples/jxpretty)
	#file(GLOB jxpretty_SRC ${CMAKE_SOURCE_DIR}/examples/jxpretty/*.c)
	#add_executable(jxpretty WIN32 ${duktape_SRC} ${jxpretty_SRC})
	#set_target_properties(jxpretty PROPERTIES LINK_FLAGS /SUBSYSTEM:CONSOLE)
	
	# sandbox
	#include_directories(${CMAKE_SOURCE_DIR}/examples/sandbox)
	#file(GLOB sandbox_SRC ${CMAKE_SOURCE_DIR}/examples/sandbox/*.c)
	#add_executable(sandbox WIN32 ${duktape_SRC} ${sandbox_SRC})
	#set_target_properties(sandbox PROPERTIES LINK_FLAGS /SUBSYSTEM:CONSOLE)
#endif()
