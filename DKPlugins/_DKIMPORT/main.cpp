#if HAVE_DKSDLWindow
#if !IOS && !ANDROID
	#define SDL_MAIN_HANDLED
#else
	#include "SDL_main.h"
#endif
#endif
#include "DK/DKApp.h"

int main(int argc, char** argv)
{
#if HAVE_DKSDLWindow
#if !IOS
	SDL_SetMainReady();
#endif
#endif
	DKApp dkapp(argc, argv);
	DKApp::Init();
	DKApp::Loop();
	return 0;
}
