#pragma once
#ifndef DKApp_H
#define DKApp_H

#include "DK/DK.h"


///////////
class DKApp
{
public:
	DKApp(int argc, char** argv);
	static void Init();
	static void Load(){};
	static void Loop();
	static void DoFrame();
	static void CallLoops();
	static void Exit();

	static bool   active;
	static bool   paused;
	static int    argc;
	static char** argv;

	template<class T>
	//////////////////////////////////////////////////////////
	static void AppendLoopFunc(void (T::*func)(), T* instance)
	{
		//loop_funcs.push_back(boost::bind(func, instance));
		loop_funcs.push_back(std::bind(func, instance));
	}
	
	/*
	template<class T>
	///////////////////////////////////////////////////////////
	static void PrependLoopFunc(void (T::*func)(), T* instance)
	{
		//loop_funcs.insert(loop_funcs.begin(), boost::bind(func, instance));
		loop_funcs.insert(loop_funcs.begin(), std::bind(func, instance));
	}
	
	template<class T>
	////////////////////////////////////////////////////////////////////////
	static void InsertLoopFunc(void (T::*func)(), T* instance, int position)
	{
		//loop_funcs.insert(loop_funcs.begin() + position, boost::bind(func, instance));
		loop_funcs.insert(loop_funcs.begin() + position, std::bind(func, instance));
	}
	*/

	template<class T>
	//////////////////////////////////////////////////////////
	static void RemoveLoopFunc(void (T::*func)(), T* instance)
	{
		for(unsigned int i=0; i<loop_funcs.size(); ++i){
			//if(loop_funcs[i].contains(boost::bind(func, instance))){
			if (loop_funcs[i].contains(std::bind(func, instance))) {
				loop_funcs.erase(loop_funcs.begin() +i );
			}
		}
	}

	//static std::vector<boost::function<void()> > loop_funcs;
	static std::vector<std::function<void()> > loop_funcs;
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
