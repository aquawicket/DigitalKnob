/*
 * This source file is part of RmlUi, the HTML/CSS Interface Middleware
 *
 * For the latest information, see http://github.com/mikke89/RmlUi
 *
 * Copyright (c) 2008-2010 Nuno Silva
 * Copyright (c) 2019 The RmlUi Team, and contributors
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

#include "Framerate.h"
#include <SDL.h>
#include <cstring>

//Frame limiter
int Framerate::_fps = 100;
long Framerate::lastSecond = 0;
long Framerate::now = 0;
long Framerate::lastFrame = 0;
int Framerate::ticksPerFrame = 1000 / _fps;

//FPS Counter
long Framerate::frametimes[FRAME_VALUES]; // An array to store frame times:
long Framerate::frametimelast = 0; // Last calculated Framerate::GetTicks()
long Framerate::framecount = 0; // total frames rendered
float Framerate::framespersecond = 0;


long Framerate::GetTicks() 
{
	return SDL_GetTicks();
}

int Framerate::GetFramerate()
{
	return _fps;
}

void Framerate::SetFramerate(const int& fps)
{
	_fps = fps;
	if (_fps == 0) {
		ticksPerFrame = 0;
		return;
	}
	ticksPerFrame = 1000 / _fps;
}

void Framerate::StartFramerate() 
{
	Framerate::now = Framerate::GetTicks();
	Framerate::lastFrame = Framerate::GetTicks();
	Framerate::lastSecond = Framerate::GetTicks();
}

void Framerate::LimitFramerate(const int& fps)
{
	if (!Framerate::now) 
	{ 
		Framerate::StartFramerate(); 
	}
	Framerate::now = Framerate::GetTicks();
	long delta = Framerate::now - Framerate::lastFrame;
	if (delta < Framerate::ticksPerFrame) 
	{
		long sleep = Framerate::ticksPerFrame - delta;
		SDL_Delay(sleep);
	}
	if(fps != _fps)
	{
		Framerate::SetFramerate(fps);
	}
	Framerate::lastFrame = Framerate::GetTicks();
	Framerate::UpdateFps();
}

unsigned long Framerate::GetFrames()
{
	return framecount;
}

void Framerate::StartFps() 
{
	memset(frametimes, 0, sizeof(frametimes)); // Set all frame times to 0ms
	frametimelast = Framerate::GetTicks();
}

void Framerate::UpdateFps() 
{
	if (!frametimelast) { Framerate::StartFps(); }
	long frametimesindex;
	long getticks;
	long count;
	long i;
	// frametimesindex is the position in the array. It ranges from 0 to FRAME_VALUES.
	// This value rotates back to 0 after it hits FRAME_VALUES.
	frametimesindex = framecount % FRAME_VALUES;
	getticks = Framerate::GetTicks();// store the current time
	frametimes[frametimesindex] = getticks - frametimelast; // save the frame time value
	frametimelast = getticks; // save the last frame time for the next UpdateFps()
	framecount++; // increment the frame count
	if (framecount < FRAME_VALUES)
	{
		count = framecount;
	}
	else
	{
		count = FRAME_VALUES;
	}
	framespersecond = 0;
	for (i = 0; i < count; i++)
	{
		framespersecond += frametimes[i];
	}
	framespersecond /= count;
	framespersecond = 1000.f / framespersecond;
}

unsigned int Framerate::GetFps() 
{
	return (unsigned int)framespersecond;
}
