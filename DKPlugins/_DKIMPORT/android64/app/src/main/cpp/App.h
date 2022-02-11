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

#ifndef APP_H
#define APP_H

#ifdef RMLUI_PLATFORM_WIN32
	#include <windows.h>
#endif
#include <string.h>
#include <SDL.h>
#include <RmlUi/Core.h>
#include <RmlUi/Core/Input.h>
#include <RmlUi/Debugger/Debugger.h>
#include "FileInterface.h"
#include "SystemInterface.h"
#include "RenderInterface.h"

class App
{
public:
	static void init();
	static void loop();
	static void draw_background(SDL_Renderer* sdlRenderer, int width, int height);
	static void do_frame();
	static void exit();
	
	static SDL_Window* mSdlWindow;
	static SDL_Renderer* mSdlRenderer;
	static FileInterface* mFileInterface;
    static SystemInterface* mSystemInterface;
    static RenderInterface* mRenderInterface;
	static Rml::Context* mRmlContext;
	static Rml::String mFile;
    static Rml::String mTitle;
    static int mX;
    static int mY;
	static int mWidth;
	static int mHeight;
	static bool mActive;
};

#endif //APP_H
