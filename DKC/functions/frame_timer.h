// https://medium.com/@tglaiel/how-to-make-your-game-run-at-60fps-24c61210fe75
// https://stackoverflow.com/a/1739265/688352
// https://thenumb.at/cpp-course/sdl2/08/08.html
// https://github.com/libsdl-org/SDL/blob/SDL2/src/timer/windows/SDL_systimer.c
// https://stackoverflow.com/questions/38730273/how-to-limit-fps-in-a-loop-with-c?rq=3

#pragma once
#ifndef frame_timer_h
#define frame_timer_h

#include "DK.h"
#include <stdbool.h>
#include <stdint.h>
#include <windows.h>

#define cursup    "\033[A"

	
#define FPS 60


unsigned long long req_fps=0;					// Frames Per Second
unsigned long long req_mspf=0;
unsigned long long a = 0;
unsigned long long b = 0;
unsigned long long sleep_delta=0;
bool running=true;

	
//################################################################################
//# frame_timer();
//#
int frame_timer() {
	
	if(!req_fps){
		req_fps = FPS;
		a = GetTickCount();
		b = GetTickCount();
		sleep_delta=0;
	}
	//while (running) {
		
        a = GetTickCount();
        unsigned long long work_time = a - b;
        
		if(req_fps > 0){
			req_mspf = 1000.0 / req_fps;		// milliseconds per frame
			if(work_time < req_mspf) {
				unsigned long long work_delta = (req_mspf - work_time);
				dk_usleep((work_delta-15)*(1000));
			}
		}

        b = GetTickCount();
        unsigned long long sleep_time = b - a;
		
		unsigned long long mspf = (work_time + sleep_time);
		sleep_delta = (mspf - sleep_time);
		unsigned long long FPs = (1000.0f / (work_time + sleep_time));
		//unsigned long long FPs  = 1000.0f / (work_time + sleep_time);
		
		printf("\r     work_time: %f  \n", (double)work_time);
		printf("\r Requested fps: %.2f  \n", (double)req_fps);
		printf("\rRequested mspf: %.2f  \n", (double)req_mspf);
		printf("\r          mspf: %.2f  \n", (double)mspf);
		printf("\r           FPS: %f    \n", (double)FPs);
		printf(cursup);
		printf(cursup);
		printf(cursup);
		printf(cursup);
		printf(cursup);

        // Your code here
		// Do event loop
		// Do physics loop
		// Do rendering loop
		// End frame timing
	//}
	
	return 0;
};

#endif //frame_timer_h