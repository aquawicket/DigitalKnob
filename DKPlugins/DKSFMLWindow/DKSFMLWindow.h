#pragma once
#ifndef DKSFMLWindow_H
#define DKSFMLWindow_H

#include <SFML/Window.hpp>
#include "DK/DK.h"

///////////////////////////////////////////////////
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

#ifdef WIN32
	WINDOWPLACEMENT g_wpPrev = { sizeof(g_wpPrev) };
#endif

	sf::Window window;

	static std::vector<boost::function<bool(sf::Event& e)> > event_funcs;
	static std::vector<boost::function<void()> > draw_funcs;

	template<class T>
	/////////////////////////////////////////////////////////////////////
	static void AddEventFunc(bool (T::*func)(sf::Event& e), T* _this)
	{
		event_funcs.push_back(boost::bind(func, _this, boost::placeholders::_1));
	}

	template<class T>
	////////////////////////////////////////////////////
	static void AddDrawFunc(void (T::*func)(), T* _this)
	{
		draw_funcs.push_back(boost::bind(func, _this));
	}

	template<class T>
	/////////////////////////////////////////////////////////
	static void AddDrawFuncFirst(void (T::*func)(), T* _this)
	{
		draw_funcs.insert(draw_funcs.begin(), boost::bind(func, _this));
	}
};

REGISTER_OBJECT(DKSFMLWindow, true)

#endif //DKSFMLWindow_H
