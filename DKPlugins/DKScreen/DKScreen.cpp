#include "DK/stdafx.h"
#include "DKScreen/DKScreen.h"

WARNING_DISABLE
#if ANDROID
	# if HAVE_sdl
		#include "SDL.h"
	#endif
#endif
#if LINUX
	#include <X11/Xlib.h>
#endif
#if MAC
	#import "CoreGraphics/CoreGraphics.h"
#endif
WARNING_ENABLE


int DKScreen::width() { // getter
	DKDEBUGFUNC();
	#if ANDROID
		// https://stackoverflow.com/a/12134363/688352
		//#include <sys/ioctl.h>
		//#include <linux/fb.h>
		//struct fb_var_screeninfo fb_var;
		//int fd = open("/dev/graphics/fb0", O_RDONLY);
		//ioctl(fd, FBIOGET_VSCREENINFO, &fb_var);
		//close(fd);
		#if HAVE_sdl
			SDL_DisplayMode sdl_displayMode;
			SDL_GetCurrentDisplayMode(0, &sdl_displayMode);
			return sdl_displayMode.w;
		#else 
			DKERROR("sdl unavailable! \n");
			return 0;
		#endif
	#elif EMSCRIPTEN
		DKWARN("Screen.width not implemented!");
		return 0;
	#elif LINUX
		#if HAVE_libx11_dev
			Display* d = XOpenDisplay(NULL);
			Screen* s = DefaultScreenOfDisplay(d);
			return s->width;
		#else
			return DKERROR("!HAVE_libx11_dev");
		#endif
	#elif MAC
		CGRect mainMonitor = CGDisplayBounds(CGMainDisplayID());
		CGFloat monitorWidth = CGRectGetWidth(mainMonitor);
		return monitorWidth;
	#elif WIN
		RECT desktop;
		const HWND hDesktop = GetDesktopWindow();
		if(!GetWindowRect(hDesktop, &desktop))
			DKERROR("GetWindowRect() failed\n");
		return desktop.right;
	#else
		DKWARN("Screen.width not implemented!");
		return 0;
	#endif
}

int DKScreen::height() { // getter
	DKDEBUGFUNC();
	#if ANDROID
		// https://stackoverflow.com/a/12134363/688352
		//#include <sys/ioctl.h>
		//#include <linux/fb.h>
		//struct fb_var_screeninfo fb_var;
		//int fd = open("/dev/graphics/fb0", O_RDONLY);
		//ioctl(fd, FBIOGET_VSCREENINFO, &fb_var);
		//close(fd);
		#if HAVE_sdl
			SDL_DisplayMode sdl_displayMode;
			SDL_GetCurrentDisplayMode(0, &sdl_displayMode);
			return sdl_displayMode.h;
		#else
			DKERROR("sdl unavailable! \n");
			return 0;
		#endif
	#elif EMSCRIPTEN
		DKWARN("Screen.height not implemented!");
		return 0;
	#elif LINUX
		#if HAVE_libx11_dev
			Display* d = XOpenDisplay(NULL);
			Screen* s = DefaultScreenOfDisplay(d);
			return s->height;
		#else
			DKERROR("!HAVE_libx11_dev");
			return 0;
		#endif
	#elif MAC
		CGRect mainMonitor = CGDisplayBounds(CGMainDisplayID());
		CGFloat monitorHeight = CGRectGetHeight(mainMonitor);
		return monitorHeight;
	#elif WIN
		RECT desktop;
		const HWND hDesktop = GetDesktopWindow();
		if(!GetWindowRect(hDesktop, &desktop))
			DKERROR("GetWindowRect() failed\n");
		return desktop.bottom;
	#else
		DKWARN("Screen.height not implemented!");
		return 0;
	#endif
}