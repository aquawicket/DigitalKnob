//#if HAVE_sdl2
#if !IOS && !ANDROID
	#define SDL_MAIN_HANDLED
#else
	#include "SDL_main.h"
#endif
//#endif
#include "DK/DKApp.h"

int main(int argc, char** argv)
{
#if !IOS
	SDL_SetMainReady();
#endif
	DKApp dkapp(argc, argv);
	DKApp::Init();
	DKApp::Loop();
	return 0;
}
