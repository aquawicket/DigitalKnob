/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
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
#ifndef DKApp_H
#define DKApp_H

#include "DK/DK.h"

class DKApp{
public:

/**
*	@function DKApp(argc, argv) :: This is the entry point for digitalknob
*
*	@param argc ::  Non-negative value representing the number of arguments passed to the program from the environment in which the program is run.
*	@param argv ::	Pointer to the first element of an array of argc + 1 pointers, of which the last one is null and the previous ones, if any, 
*					point to null-terminated multibyte strings that represent the arguments passed to the program from the execution environment. 
*					If argv[0] is not a null pointer (or, equivalently, if argc > 0), it points to a string that represents the name used to invoke the program, 
*					or to an empty string.
*	@returns    ::	void
*	https://en.cppreference.com/w/cpp/language/main_function
*/
	DKApp(int argc, char** argv);
	static void Init();
	static void Load(){};
	static void Loop();
#if EMSCRIPTEN
	static EM_BOOL EM_DoFrame(double time, void* userData);
#endif
	static void DoFrame();
	static void CallLoops();
	
	//TODO: https://en.cppreference.com/w/cpp/utility/program/exit
	static void Exit();

	static bool   active;
	static bool   paused;
	static int    argc;
	static char** argv;

	template<class T>
	static void AppendLoopFunc(void (T::*func)(), T* instance){
		loop_funcs.push_back(std::bind(func, instance));
	}
	
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

	template<class T>
	static void RemoveLoopFunc(void (T::*func)(), T* instance){
		DKDEBUGFUNC(func, instance);
		for(unsigned int i=0; i<loop_funcs.size(); ++i){
			//if (loop_funcs[i].contains(std::bind(func, instance)))
			//	loop_funcs.erase(loop_funcs.begin() +i );
		}
	}

	static std::vector<std::function<void()> > loop_funcs;
};

#endif //DKApp_H
