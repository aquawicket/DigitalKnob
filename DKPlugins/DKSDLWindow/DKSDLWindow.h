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

	void* GetX(void*);
	void* GetY(void*);
	void* GetWidth(void*);
	void* GetHeight(void*);
	void* SetX(void* x);
	void* SetY(void* y);
	void* SetWidth(void* w);
	void* SetHeight(void* h);
	void* GetScreenWidth(void*);
	void* GetScreenHeight(void*);
	void* IsFullscreen(void*);
	void* Fullscreen(void*);
	void* Windowed(void*);
	void* Restore(void*);
	void* Minimize(void*);
	void* Hide(void*);
	void* Show(void*);
	void* GetMouseX(void*);
	void* GetMouseY(void*);
	void* GetHwnd(void*);

	bool SetIcon(const DKString& file);
	static int EventFilter(void* userdata, SDL_Event* event);
	bool handle(SDL_Event* event);
	void Process();
	static std::map<int,int> sdlKeyCode;
	static std::map<int,int> sdlCharCode;
	static std::map<int,int> sdlShiftCharCode;
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
