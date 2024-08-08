/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2024 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/
#pragma once
#ifndef DKOSGVideo_H
#define DKOSGVideo_H
#include "DK/DK.h"

//WARNING_DISABLE
#if HAVE_osgDB
	#include <osgDB/Registry>
#endif
//WARNING_ENABLE


class DKOSGVideo : public DKObjectT<DKOSGVideo>
{
public:
	bool Init();
	bool End();
	static void loaddlls();
	//static void unloaddlls();
	void Play(const DKString& file);
};

REGISTER_OBJECT(DKOSGVideo, true)

#define DKVIDEO_LOAD_DLLS() \
    class DK_VIDEO_LOAD{ \
    public: \
        DK_VIDEO_LOAD() \
        { \
            DKOSGVideo::loaddlls(); \
		} \
    }; \
static DK_VIDEO_LOAD global_DK_VIDEO_LOAD;
 
//#if HAVE_osgdb_ffmpeg
#ifndef ANDROID
	//#include "DKOSGVideo.h"
	DKVIDEO_LOAD_DLLS()
	USE_OSGPLUGIN(ffmpeg)
#endif
//#endif

#endif //DKOSGVideo_H
