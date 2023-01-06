/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright noticeand this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/
#pragma once
#ifndef DKScreenRecorder_H
#define DKScreenRecorder_H

#include "DK/DK.h"

//DirectX Capture
#if WIN32
//WARNING_DISABLE
#	include <Wincodec.h>             // we use WIC for saving images
#	include <d3d9.h>                 // DirectX 9 header
//WARNING_ENABLE
#	pragma comment(lib, "d3d9.lib")  // link to DirectX 9 library
#	define WIDEN2(x) L ## x
#	define WIDEN(x) WIDEN2(x)
#	define __WFILE__ WIDEN(__FILE__)
#	define HRCHECK(__expr) {hr=(__expr);if(FAILED(hr)){wprintf(L"FAILURE 0x%08X (%i)\n\tline: %u file: '%s'\n\texpr: '" WIDEN(#__expr) L"'\n",hr, hr, __LINE__,__WFILE__);}}
#	define RELEASE(__p) {if(__p!=nullptr){__p->Release();__p=nullptr;}}
#endif

//WARNING_DISABLE
#include "include/opencv2/opencv.hpp"
//#include "modules/imgproc/include/opencv2/imgproc/imgproc.hpp"
#include "opencv2/imgproc/imgproc.hpp""
//#include "opencv2/videoio.hpp"
#include "opencv2/videoio/videoio.hpp"
#if MAC
#	import "CoreGraphics/CoreGraphics.h"
#endif

#if LINUX
#	include <unistd.h>
#	include <X11/Xlib.h>
#	include <X11/Xutil.h>
#endif
//WARNING_ENABLE

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

#if MAC
	static CGImageRef image_ref;
	static CGDataProviderRef provider;
	static CFDataRef dataref;
#endif
#if LINUX
	static Display* disp;
	static Window root;
	static XImage* image;
#endif
};


REGISTER_OBJECT(DKScreenRecorder, true);

#endif //DKScreenRecorder_H
