#pragma once //Is this obsolete?
#ifndef DKApp_H
#define DKApp_H

#include "DK/DK.h"

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

	static bool active;
	static bool loaded;
	static bool paused;
	static int argc;
	static char** argv;

	template<class T>
	///////////////////////////////////////////////////////
	static void AppendLoopFunc(void (T::*func)(), T* _this)
	{
		loop_funcs.push_back(boost::bind(func, _this));
	}
	
	/*
	template<class T>
	////////////////////////////////////////////////////////
	static void PrependLoopFunc(void (T::*func)(), T* _this)
	{
		loop_funcs.insert(loop_funcs.begin(), boost::bind(func, _this));
	}
	
	template<class T>
	/////////////////////////////////////////////////////////////////////
	static void InsertLoopFunc(void (T::*func)(), T* _this, int position)
	{
		loop_funcs.insert(loop_funcs.begin() + position, boost::bind(func, _this));
	}
	*/

	template<class T>
	///////////////////////////////////////////////////////
	static void RemoveLoopFunc(void (T::*func)(), T* _this)
	{
		for(unsigned int i=0; i<loop_funcs.size(); ++i){
			if(loop_funcs[i].contains(boost::bind(func, _this))){
				loop_funcs.erase(loop_funcs.begin() +i );
			}
		}
	}

	static std::vector<boost::function<void()> > loop_funcs;
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
