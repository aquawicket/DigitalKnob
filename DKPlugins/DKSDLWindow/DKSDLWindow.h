#pragma once
#ifndef DKSDLWindow_H
#define DKSDLWindow_H

#include "SDL.h"
#include "DK/DK.h"

/////////////////////////////////////////////////
class DKSDLWindow : public DKObjectT<DKSDLWindow>
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
	bool GetHeight(const void* input, void* output);
	bool GetHwnd(const void* input, void* output);
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
	
	static int EventFilter(void* userdata, SDL_Event* event);
	bool handle(SDL_Event* event);
	void Process();
	static std::map<int,int> sdlKeyCode;
	static std::map<int,int> sdlCharCode;
	static std::map<int,int> sdlShiftCharCode;
	static std::map<int,int> sdlMacCode;
	void MapInputs();

	SDL_Window* sdlwin;
	SDL_Renderer* sdlren;
	//SDL_GLContext sldcontext;
	DKString gl_major_version;
	DKString gl_minor_version;
	DKString gl_version;
	DKString gl_vendor;
	DKString gl_renderer;
	//DKString gl_shading;
	DKString gl_extensions;

	DKString mTitle;
	int winX;
	int winY;
	unsigned int width;
	unsigned int height;
	int last_mouseX;
	int last_mouseY;

	static std::vector<boost::function<bool(SDL_Event *event)> > event_funcs;
	static std::vector<boost::function<void()> > draw_funcs;

	template<class T>
	/////////////////////////////////////////////////////////////////////
	static void AddEventFunc(bool (T::*func)(SDL_Event *event), T* _this)
	{
		event_funcs.push_back(boost::bind(func, _this, _1));
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

REGISTER_OBJECT(DKSDLWindow, true)

#endif //DKSDLWindow_H
