#pragma once
#ifndef DKApp_H
#define DKApp_H
#include "DK.h"

///////////
class DKApp
{
public:
	DKApp();
	static void Init();
	static void Load(){};
	static void Loop();
	static void DoFrame();
	static void Exit();
	static int GetFramerate();
	static void SetFramerate(int fps);
	static bool active;
	static bool loaded;
	static bool paused;
	static int argc;
	static char** argv;

	static double now;
	static double lastFrame;
	static double lastSecond;
	static double _fps;
	

//#ifdef USE_Boost
	template<class T>
	//////////////////////////////////////////////////////////////////////////
	static void AddLoopFunc(const DKString& type, void (T::*func)(), T* _this)
	{
		if(same(type, "EVENT")){
			event_funcs.push_back(boost::bind(func, _this));
		}
		else if(same(type, "UPDATE")){
			update_funcs.push_back(boost::bind(func, _this));
		}
		else if (same(type, "RENDER")){
			render_funcs.push_back(boost::bind(func, _this));
		}
		else{
			DKLog("AddLoopFunc(): type "+type+" invalid.\n", DKERROR);
		}
	}

	template<class T>
	///////////////////////////////////////////////////////////////////////////////
	static void AddLoopFuncFirst(const DKString& type, void (T::*func)(), T* _this)
	{
		if (same(type, "EVENT")){
			event_funcs.insert(event_funcs.begin(), boost::bind(func, _this));
		}
		else if (same(type, "UPDATE")){
			update_funcs.insert(update_funcs.begin(), boost::bind(func, _this));
		}
		else if (same(type, "RENDER")){
			render_funcs.insert(render_funcs.begin(), boost::bind(func, _this));
		}
		else{
			DKLog("AddLoopFunc(): type " + type + " invalid.\n", DKERROR);
		}
	}

	template<class T>
	///////////////////////////////////////////////////////
	static void RemoveLoopFunc(void (T::*func)(), T* _this)
	{
		for(unsigned int i=0; i<event_funcs.size(); ++i){
			if(event_funcs[i].contains(boost::bind(func, _this))){
				event_funcs.erase(event_funcs.begin() +i );
			}
		}
		for(unsigned int i=0; i<update_funcs.size(); ++i){
			if(update_funcs[i].contains(boost::bind(func, _this))){
				update_funcs.erase(update_funcs.begin() +i );
			}
		}
		for(unsigned int i=0; i<render_funcs.size(); ++i){
			if(render_funcs[i].contains(boost::bind(func, _this))){
				render_funcs.erase(render_funcs.begin() +i );
			}
		}
	}

	static std::vector<boost::function<void()> > event_funcs;
	static std::vector<boost::function<void()> > update_funcs;
	static std::vector<boost::function<void()> > render_funcs;
//#endif
	
#ifdef WIN32
	static HINSTANCE hInstance; //posibbly move to DKWindows
	static bool WINAPI ConsoleHandler(DWORD type);
#endif

};

//////////
#ifdef IOS
@interface iphoneViewerAppDelegate : NSObject <UIApplicationDelegate, UIAccelerometerDelegate>{
	UIAccelerationValue        accel[3];
}

@property (nonatomic, retain) UIWindow *_window;

- (void)updateScene;

@end
#endif //ISO

#endif //DKApp_H
