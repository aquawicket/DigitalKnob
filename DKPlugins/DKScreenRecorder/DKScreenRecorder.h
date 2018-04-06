#pragma once
#ifndef DKScreenRecorder_H
#define DKScreenRecorder_H
#include "DK/DK.h"

#ifdef LINUX
#include <unistd.h>
#include <X11/Xlib.h>
#include <X11/Xutil.h>
#endif

//DirectX Capture
#ifdef WIN32
#include <Wincodec.h>             // we use WIC for saving images
#include <d3d9.h>                 // DirectX 9 header
#pragma comment(lib, "d3d9.lib")  // link to DirectX 9 library
#define WIDEN2(x) L ## x
#define WIDEN(x) WIDEN2(x)
#define __WFILE__ WIDEN(__FILE__)
#define HRCHECK(__expr) {hr=(__expr);if(FAILED(hr)){wprintf(L"FAILURE 0x%08X (%i)\n\tline: %u file: '%s'\n\texpr: '" WIDEN(#__expr) L"'\n",hr, hr, __LINE__,__WFILE__);}}
#define RELEASE(__p) {if(__p!=nullptr){__p->Release();__p=nullptr;}}
#endif

//#include "include/opencv2/opencv.hpp"
//#include "modules/imgproc/include/opencv2/imgproc/imgproc.hpp"
#include "opencv2/videoio.hpp"

/////////////////////////////////////////////////
class DKScreenRecorder : public DKObjectT<DKScreenRecorder>
{
public:
	bool Init();
	bool End();
		
	static bool Record(const DKString& file);
	static bool Stop();
	void Loop();
	static void DrawBuffer();

	static DKString capture; //GDI, DIRECTX, OPENGL
	static char* frameBuffer;
	static int desktopWidth;
	static int desktopHeight;

	static cv::VideoWriter videoWriter;
	static cv::Mat brgMat;

#ifdef MAC
	static CGImageRef image_ref;
	static CGDataProviderRef provider;
	static CFDataRef dataref;
#endif
#ifdef LINUX
	static Display* disp;
	static Window root;
	static XImage* image;
#endif
};


REGISTER_OBJECT(DKScreenRecorder, true);

#endif //DKScreenRecorder_H

