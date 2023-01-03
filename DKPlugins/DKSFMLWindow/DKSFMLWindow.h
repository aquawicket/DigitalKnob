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
* The above copyright noticeand this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

#pragma once
#ifndef DKSFMLWindow_H
#define DKSFMLWindow_H

//WARNING_DISABLE
#ifdef USE_GDK
#	include <gtk/gtk.h>
#endif
#include <SFML/Window.hpp>
//WARNING_ENABLE

#include "DK/DK.h"


class DKSFMLWindow : public DKObjectT<DKSFMLWindow>
{
public:
	bool Init();
	bool End();

	bool TestInt(const void* input, void* output);
	bool TestString(const void* input, void* output);
	bool TestReturnInt(const void* input, void* output);
	bool TestReturnString(const void* input, void* output);

	bool Fullscreen(const void* input, void* output);
	bool GetClipboard(const void* input, void* output);
	bool GetHandle(const void* input, void* output);
	bool GetHeight(const void* input, void* output);
	bool GetMouseX(const void* input, void* output);
	bool GetMouseY(const void* input, void* output);
	bool GetWidth(const void* input, void* output);
	bool GetX(const void* input, void* output);
	bool GetY(const void* input, void* output);
	bool Hide(const void* input, void* output);
	bool IsFullscreen(const void* input, void* output);
	bool IsVisible(const void* input, void* output);
	bool MessageBox(const void* input, void* output);
	bool Minimize(const void* input, void* output);
	bool Restore(const void* input, void* output);
	bool SetClipboard(const void* input, void* output);
	bool SetHeight(const void* input, void* output);
	bool SetIcon(const void* input, void* output);
	bool SetWidth(const void* input, void* output);
	bool SetX(const void* input, void* output);
	bool SetY(const void* input, void* output);
	bool Show(const void* input, void* output);
	bool Windowed(const void* input, void* output);

	bool handle(sf::Event& e);
	void Process();

#if WIN
	WINDOWPLACEMENT g_wpPrev = { sizeof(g_wpPrev) };
#endif

	sf::Window window;

	//static std::vector<boost::function<bool(sf::Event& e)> > event_funcs;
	static std::vector<std::function<bool(sf::Event& e)> > event_funcs;
	//static std::vector<boost::function<void()> > draw_funcs;
	static std::vector<std::function<void()> > draw_funcs;

	template<class T>
	static void AddEventFunc(bool (T::*func)(sf::Event& e), T* _this){
		//event_funcs.push_back(boost::bind(func, _this, boost::placeholders::_1));
		event_funcs.push_back(std::bind(func, _this, std::placeholders::_1));
	}

	template<class T>
	static void AddDrawFunc(void (T::*func)(), T* _this){
		//draw_funcs.push_back(boost::bind(func, _this));
		draw_funcs.push_back(std::bind(func, _this));
	}

	template<class T>
	static void AddDrawFuncFirst(void (T::*func)(), T* _this){
		//draw_funcs.insert(draw_funcs.begin(), boost::bind(func, _this));
		draw_funcs.insert(draw_funcs.begin(), std::bind(func, _this));
	}
};

REGISTER_OBJECT(DKSFMLWindow, true)

#endif //DKSFMLWindow_H
