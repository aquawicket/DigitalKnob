#if !IOS && !ANDROID
	#define SDL_MAIN_HANDLED
#else
	#include "SDL_main.h"
#endif
#include "App.h"

int main(int argc, char** argv)
{
#if !IOS && !ANDROID
	SDL_SetMainReady();
#endif
	DKApp dkapp(argc, argv);
	DKApp::Init();
	DKApp::Loop();
	return 0;
}
