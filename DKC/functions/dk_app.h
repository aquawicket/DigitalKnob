/*
* This source file is part of DigitalKnob, the cross-platform C/C++/Javascript/Html/Css Solution
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
#include "dk_exit.h"
#include "dk_printTimestamp.h"
#include "dk_usleep.h"
#include "frame_timer.h"
#include "dk_keyboardEvent.h"


extern const char* BUILD_DATE;
extern const char* BUILD_TIME;

/*
#include <sys/time.h>
bool GetTicks(double* ticks){
	struct timespec ts;
	clock_gettime(CLOCK_MONOTONIC, &ts);
	*ticks = ((ts.tv_sec * 1000.0) + (ts.tv_nsec / 1000000.0));
	return true;
};

double a=0;
double b=0;
double work_time=0;
double delta_ms=0;
double sleep_time=0;
void LimitFramerate2(){
 // Maintain designated frequency of 5 Hz (200 ms per frame)
        GetTicks(&a);
        work_time = a - b;

        if(work_time < 200.0){
            delta_ms = 200.0 - work_time;
            dk_usleep(delta_ms * 1000.0);
        }

        GetTicks(&b);
        sleep_time = b - a;

        // Your code here

        printf("now:%f work_time:%f sleep_time:%f\n", b, work_time,  sleep_time);
}
//class dk_app{
//public:
*/
/**
*	@function dk_app(argc, argv) - This is the entry point for DigitalKnob
*
*	@param argc ::  Non-negative value representing the number of arguments passed to the program from the environment in which the program is run.
*	@param argv ::	Pointer to the first element of an array of argc + 1 pointers, of which the last one is null and the previous ones, if any, 
*					point to null-terminated multibyte strings that represent the arguments passed to the program from the execution environment. 
*					If argv[0] is not a null pointer (or, equivalently, if argc > 0), it points to a string that represents the name used to invoke the program, 
*					or to an empty string.
*	@returns    ::	void
*	https://en.cppreference.com/w/cpp/language/main_function
*/

	bool   dk_app_active;
	bool   dk_app_paused;
	int    dk_app_argc;
	char** dk_app_argv;
	
	//TODO: https://en.cppreference.com/w/cpp/utility/program/exit
	////////////////////
	void dk_app_Exit() {
		dk_app_active = false;
		dk_exit(13);
	};
	
	/////////////////////////
	void dk_app_CallLoops() {
		/*
		for(unsigned int i = 0; i < loop_funcs.size(); ++i){
			//if(active)
				loop_funcs[i]();
		}
		*/
		//dk_printTimestamp();
		
	};
	
	//////////////////////////////////////////////////
	bool dk_app_DoFrame(double time, void* userData) {
		if(dk_app_paused){ 
			//DKUtil_Sleep(100);
			return true;
		}

		//###### Frame Limiter and FPS ######
		frame_timer();
		
		//###### Keyboard Events ######
		char key;
		dk_keyboardEvent(&key);	
		if(key == 27){
			dk_exit(key);
		}
		
		dk_app_CallLoops(); //Call loop functions
		return true;
	};

	////////////////////
	void dk_app_Loop() {
		while(dk_app_active){
			#if EMSCRIPTEN
				emscripten_request_animation_frame_loop(dk_app_DoFrame, 0);
			#else
				dk_app_DoFrame(0, 0);
			#endif
		}
	};
	
	////////////////////
	void dk_app_Init() {
		dk_echo("Press Ctrl+C to end the program\n");
		dk_app_active = true;
	};
	
	////////////////////////////////////////////
	int dk_app(int _argc, char** _argv) {
		DK();
		dk_app_argc = _argc;
		dk_app_argv = _argv;
		
		dk_app_Init();
		dk_app_Loop();
		return 0;
	};
	
	
	
	
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
