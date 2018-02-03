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

	bool TestInt(void* input, void* output);
	bool TestString(void* input, void* output);
	bool TestReturnInt(void* input, void* output);
	bool TestReturnString(void* input, void* output);

	bool Fullscreen(void* input, void* output);
	bool GetClipboard(void* input, void* output);
	bool GetHeight(void* input, void* output);
	bool GetHwnd(void* input, void* output);
	bool GetMouseX(void* input, void* output);
	bool GetMouseY(void* input, void* output);
	bool GetScreenHeight(void* input, void* output);
	bool GetScreenWidth(void* input, void* output);
	bool GetWidth(void* input, void* output);
	bool GetX(void* input, void* output);
	bool GetY(void* input, void* output);
	bool Hide(void* input, void* output);
	bool IsFullscreen(void* input, void* output);
	bool IsVisible(void* input, void* output);
	bool MessageBox(void* input, void* output);
	bool Minimize(void* input, void* output);
	bool Restore(void* input, void* output);
	bool SetClipboard(void* input, void* output);
	bool SetHeight(void* input, void* output);
	bool SetIcon(const DKString& file);
	bool SetWidth(void* input, void* output);
	bool SetX(void* input, void* output);
	bool SetY(void* input, void* output);
	bool Show(void* input, void* output);
	bool Windowed(void* input, void* output);
	
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
