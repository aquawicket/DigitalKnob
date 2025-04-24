/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2025 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

#pragma once
#ifndef dk_app_h
#define dk_app_h

#include "DK.h"
#include <stdbool.h>

extern const char* BUILD_DATE;
extern const char* BUILD_TIME;

//class dk_app{
//public:

/**
*	@function dk_app(argc, argv) - This is the entry point for digitalknob
*
*	@param argc ::  Non-negative value representing the number of arguments passed to the program from the environment in which the program is run.
*	@param argv ::	Pointer to the first element of an array of argc + 1 pointers, of which the last one is null and the previous ones, if any, 
*					point to null-terminated multibyte strings that represent the arguments passed to the program from the execution environment. 
*					If argv[0] is not a null pointer (or, equivalently, if argc > 0), it points to a string that represents the name used to invoke the program, 
*					or to an empty string.
*	@returns    ::	void
*	https://en.cppreference.com/w/cpp/language/main_function
*/
	int dk_app_dk_app(int argc, char** argv);
	static void dk_app_Init();
	static void dk_app_Load(){};
	static void dk_app_Loop();
#if EMSCRIPTEN
	static EM_BOOL EM_DoFrame(double time, void* userData);
#endif
	static void dk_app_DoFrame();
	static void dk_app_CallLoops();
	
	//TODO: https://en.cppreference.com/w/cpp/utility/program/exit
	static void dk_app_Exit();

	bool   dk_app_active;
	bool   dk_app_paused;
	int    dk_app_argc;
	char** dk_app_argv;

	/*
	template<class T>
	static void AppendLoopFunc(void (T::*func)(), T* instance){
		loop_funcs.push_back(std::bind(func, instance));
	}
	*/
	
	/*
	template<class T>
	static void PrependLoopFunc(void (T::*func)(), T* instance){
		loop_funcs.insert(loop_funcs.begin(), std::bind(func, instance));
	}
	
	template<class T>
	static void InsertLoopFunc(void (T::*func)(), T* instance, int position){
		loop_funcs.insert(loop_funcs.begin() + position, std::bind(func, instance));
	}
	*/

	/*
	template<class T>
	static void RemoveLoopFunc(void (T::*func)(), T* instance){
		DKDEBUGFUNC(func, instance);
		for(unsigned int i=0; i<loop_funcs.size(); ++i){
			//if (loop_funcs[i].contains(std::bind(func, instance)))
			//	loop_funcs.erase(loop_funcs.begin() +i );
		}
	}
	*/
	
	//static std::vector<std::function<void()> > loop_funcs;
//};

#endif //dk_app_h
