// https://medium.com/@tglaiel/how-to-make-your-game-run-at-60fps-24c61210fe75
// https://stackoverflow.com/a/1739265/688352

#pragma once
#ifndef frame_timer_h
#define frame_timer_h

#include "DK.h"
#include "dk_printTimestamp.h"
#include <stdbool.h>
#include <stdint.h>
#include <windows.h>
#include <inttypes.h>


int64_t CounterStart;
double fixed_update;
double	variable_update;
double render;
int64_t clocks_per_second;

int64_t lastTime = 0.0;
double nbFrames = 0.0;
 
void ProcessEvents(){
	
};





void game_fixed_update(double deltaTime){
	fixed_update = deltaTime;
};
void game_variable_update(double deltaTime){
	variable_update = deltaTime;
};
void game_render(double deltaTime){
	render = deltaTime;
	
};


typedef struct SDL_DisplayMode {
    uint32_t format;            /**< pixel format */
    int w;                      /**< width, in screen coordinates */
    int h;                      /**< height, in screen coordinates */
    int refresh_rate;           /**< refresh rate (or zero for unspecified) */
    void *driverdata;           /**< driver-specific data, initialize to 0 */
} SDL_DisplayMode;

// https://stackoverflow.com/a/1739265/688352
////////////////////////////////////////
int64_t SDL_GetPerformanceFrequency() { 
	LARGE_INTEGER li;
    if(!QueryPerformanceFrequency(&li)){
		dk_echo("QueryPerformanceFrequency failed!\n");
	}
    double PCFreq = li.QuadPart/1000.0;
	
	QueryPerformanceCounter(&li);
    CounterStart = li.QuadPart;
	
	return PCFreq;
};

//////////////////////////////////////////
uint64_t SDL_GetPerformanceCounter() { 
	LARGE_INTEGER li;
    QueryPerformanceCounter(&li);
    return (li.QuadPart-CounterStart)/clocks_per_second;
}

/////////////////////////////////////////////////////////////////////////
int SDL_GetCurrentDisplayMode(int displayIndex, SDL_DisplayMode * mode) { 
	return 1; 
}

////////////////////////////
void PrintFps() {
	// Measure speed
	if(lastTime == 0.0){
		lastTime = SDL_GetPerformanceCounter();
	}
    int64_t currentTime = SDL_GetPerformanceCounter();
    nbFrames++;
    if ( currentTime - lastTime >= 1000.0f ){ // If last prinf() was more than 1 sec ago
		double multiplier = 1000.0000000f;
		double msPF = (1000.0f / nbFrames);
		double FPS = nbFrames;
        printf("\r                  msPF:%f FPS:%f", msPF, FPS);
        nbFrames = 0.0f;
        lastTime += 1000.0f;
    }
};

void display(){
	dk_printTimestamp();
	
	//dk_echo("     fixed:%f  variable:%f  render:%f", fixed_update, variable_update, render);
	dk_usleep(fixed_update * render * 1000000);
	PrintFps();
};
//################################################################################
//# frame_timer();
//#
int frame_timer() {

	//these are loaded from Settings in production code
	double update_rate = 60;
	int update_multiplicity = 1;
	bool unlock_framerate = true;

	//compute how many ticks one update should be
	clocks_per_second = SDL_GetPerformanceFrequency();
	dk_echo("clocks_per_second: %"PRId64"\n", clocks_per_second);
	double fixed_deltatime = 1.0 / update_rate;
	dk_echo("fixed_deltatime = %f\n", fixed_deltatime);
	int64_t desired_frametime = clocks_per_second / update_rate;
	dk_echo("desired_frametime: %"PRId64"\n", desired_frametime);
	
	//these are to snap deltaTime to vsync values if it's close enough
	int64_t vsync_maxerror = clocks_per_second * .0002;
	dk_echo("vsync_maxerror: %"PRId64"\n", vsync_maxerror);

	//get the refresh rate of the display (you should detect which display the window is on in production)
	int display_framerate = 60;
	dk_echo("display_framerate: %d\n", display_framerate);
	SDL_DisplayMode current_display_mode;
	if(SDL_GetCurrentDisplayMode(0, &current_display_mode)==0) {
		display_framerate = current_display_mode.refresh_rate;
	}
	int64_t snap_hz = display_framerate;
	if(snap_hz <= 0) snap_hz = 60;
	dk_echo("snap_hz: %"PRId64"\n", snap_hz);

	//these are to snap deltaTime to vsync values if it's close enough
	int64_t snap_frequencies[8] = {};
	for(int i = 0; i<8; i++) {
		snap_frequencies[i] = (clocks_per_second / snap_hz) * (i+1);
	}
	dk_echo("snap_frequencies: %"PRId64"\n", snap_frequencies);
	
	//this is for delta time averaging
	//I know you can and should use a ring buffer for this, but I didn't want to include dependencies in this sample code
	const int time_history_count = 4;
	int64_t time_averager[time_history_count] = {desired_frametime, desired_frametime, desired_frametime, desired_frametime};
	dk_echo("time_averager: %"PRId64"\n", time_averager);
	int64_t averager_residual = 0;

	//these are stored in my Application class and are not local variables in production code
	bool running = true;
	bool resync = true;
	int64_t prev_frame_time = SDL_GetPerformanceCounter();
	dk_echo("prev_frame_time: %"PRId64"\n", prev_frame_time);
	int64_t frame_accumulator = 0;

	while (running){
	  //frame timer
		int64_t current_frame_time = SDL_GetPerformanceCounter();
		int64_t delta_time = current_frame_time - prev_frame_time;
		prev_frame_time = current_frame_time;

	  //handle unexpected timer anomalies (overflow, extra slow frames, etc)
		if(delta_time > desired_frametime*8){ //ignore extra-slow frames
			delta_time = desired_frametime;
		}
		if(delta_time < 0){
			delta_time = 0;
		}


	  //vsync time snapping
	  /*
		for(int64_t snap : snap_frequencies){
			if(std::abs(delta_time - snap) < vsync_maxerror){
				delta_time = snap;
				break;
			}
		}
		*/
	
	  //delta time averaging
		for(int i = 0; i<time_history_count-1; i++){
			time_averager[i] = time_averager[i+1];
		}
		time_averager[time_history_count-1] = delta_time;
		int64_t averager_sum = 0;
		for(int i = 0; i<time_history_count; i++){
			averager_sum += time_averager[i];
		}
		delta_time = averager_sum / time_history_count;

		averager_residual += averager_sum % time_history_count;
		delta_time += averager_residual / time_history_count;
		averager_residual %= time_history_count;

	  //add to the accumulator
		frame_accumulator += delta_time;

	  //spiral of death protection
		if(frame_accumulator > desired_frametime*8){ 
			resync = true;
		}

	  //timer resync if requested
		if(resync) {
			frame_accumulator = 0;
			delta_time = desired_frametime;
			resync = false;
		}

	  // process system events
		ProcessEvents();

		if(unlock_framerate){ //UNLOCKED FRAMERATE, INTERPOLATION ENABLED
			int64_t consumedDeltaTime = delta_time;

			while(frame_accumulator >= desired_frametime){
				game_fixed_update(fixed_deltatime);
				if(consumedDeltaTime > desired_frametime){ //cap variable update's dt to not be larger than fixed update, and interleave it (so game state can always get animation frames it needs)
					game_variable_update(fixed_deltatime);
					consumedDeltaTime -= desired_frametime;
				}
				frame_accumulator -= desired_frametime;
			}

			game_variable_update((double)consumedDeltaTime / clocks_per_second);
			game_render((double)frame_accumulator / desired_frametime);
			display(); //swap buffers
			
		} else { //LOCKED FRAMERATE, NO INTERPOLATION
			while(frame_accumulator >= desired_frametime*update_multiplicity){
				for(int i = 0; i<update_multiplicity; i++){
					game_fixed_update(fixed_deltatime);
					game_variable_update(fixed_deltatime);
					frame_accumulator -= desired_frametime;
				}
			}
			
			game_render(1.0);
			display(); //swap buffers
		}
	}
	
	return 0;
};

#endif //frame_timer_h