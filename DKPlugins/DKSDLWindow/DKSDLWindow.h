#pragma once
#ifndef DKSDLWindow_H
#define DKSDLWindow_H
#include "DK.h"
#include "SDL.h"

/////////////////////////////////////////////////
class DKSDLWindow : public DKObjectT<DKSDLWindow>
{
public:
	virtual void Init();
	virtual void End();

	void* Fullscreen(void*);
	void* GetHeight(void*);
	void* GetHwnd(void*);
	void* GetMouseX(void*);
	void* GetMouseY(void*);
	void* GetScreenHeight(void*);
	void* GetScreenWidth(void*);
	void* GetWidth(void*);
	void* GetX(void*);
	void* GetY(void*);
	void* Hide(void*);
	void* IsFullscreen(void*);
	void* IsVisible(void*);
	void* Minimize(void*);
	void* Restore(void*);
	void* SetHeight(void* h);
	void* SetWidth(void* w);
	void* SetX(void* x);
	void* SetY(void* y);
	void* Show(void*);
	void* Windowed(void*);

	bool SetIcon(const DKString& file);
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
