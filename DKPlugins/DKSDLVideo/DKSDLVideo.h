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

//https://github.com/ashafiei/dranger-ffmpeg-tuto
//http://dranger.com/ffmpeg/
#pragma once
#ifndef DKSDLVideo_H
#define DKSDLVideo_H

#include "DK/DK.h"

//WARNING_DISABLE
#include "SDL.h"
extern "C" {
	#include <libavcodec/avcodec.h>
	#include <libavdevice/avdevice.h>
	#include <libavfilter/avfilter.h>
	#include <libavformat/avformat.h>
	#include <libavformat/avio.h>
	#include <libavutil/avutil.h>
	#include <libpostproc/postprocess.h>
	#include <libswresample/swresample.h>
	#include <libswscale/swscale.h>
	#include <libavutil/frame.h>
	#include <libavutil/imgutils.h>
}
//WARNING_ENABLE


class DKSDLVideo : public DKObjectT<DKSDLVideo>
{
public:
	bool Init();
	bool End();
	
	/*
	bool OpenFile_A(const DKString& file);
	bool CloseFile_A();
	void display_A(AVCodecContext* ctx, AVPacket* pkt, AVFrame* frame, SDL_Rect* rect, SDL_Texture* texture, SDL_Renderer* renderer, double fpsrend);
	void playaudio_A(AVCodecContext *ctx, AVPacket *pkt, AVFrame *frame, SDL_AudioDeviceID auddev);
	*/
	
	//bool OnEvent(SDL_Event* event);
};


REGISTER_OBJECT(DKSDLVideo, true)
#endif //DKSDLVideo_H
