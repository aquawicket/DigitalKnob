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

#include "DK/stdafx.h"
#include "DKSDLVideo/DKSDLVideo.h"
#include "DK/DKFile.h"
#include "DKSDLWindow/DKSDLWindow.h"


void DKSDLVideo::Init(){
	DKDebug();
	stream = NULL;
	streamObj = NULL;
	DKSDLWindow::AddEventFunc(&DKSDLVideo::handle, this);
	DKClass::RegisterFunc("DKSDLVideo::Play", &DKSDLVideo::Play, this);
}

void DKSDLVideo::End(){
	DKDebug();
	if(stream)
		WV_closeStream(stream);

	/* close the streaming object */
	if(streamObj)
		WV_freeStreamRendererObj(streamObj);

	/* close the waave engine */
	WV_waaveClose();
}

bool DKSDLVideo::Handle(SDL_Event *event){
	DKDebug(event);
	if(event->type == WV_REFRESH_EVENT){
		WV_refreshVideoFrame(event);
		return true;
	}
	else if (event->type == WV_EOF_EVENT){
		//closePlayer();
		DKINFO("DKSDLVideo::handle(): end of file\n");
		if (stream){
			WV_closeStream(stream);
		}

		if (streamObj){ //close the streaming object
			WV_freeStreamRendererObj(streamObj);
		}
		return true;
	}

	return false;
}

bool DKSDLVideo::Play(const void* input, void* output){
	DKDebug(input, output);
	DKString path = *(DKString*)input;
	if(!DKFile::VerifyPath(path)) { return false; }

	WV_waaveInit(WAAVE_INIT_AUDIO | WAAVE_INIT_VIDEO);
	stream = WV_getStream(path.c_str());

	int streamType = WV_getStreamType(stream);

	if(streamType == WV_STREAM_TYPE_VIDEO || streamType == WV_STREAM_TYPE_AUDIOVIDEO){
		//SDL_RenderClear(DKSDLWindow::Get("")->sdlren);
		streamObj = WV_getStreamRendererObj(DKSDLWindow::Get("")->sdlren, NULL, NULL);
		WV_setStreamingMethod(stream, streamObj);
	}

	WV_loadStream(stream);

	/* reset window size for video */
	if(streamObj){
		int winWidth = streamObj->srcWidth;
		int winHeight = streamObj->srcHeight;
		SDL_SetWindowSize(DKSDLWindow::Get("")->sdlwin, winWidth, winHeight);
		WV_resetStreamRendererOutput(streamObj, DKSDLWindow::Get("")->sdlren, NULL); //!! update the object !!
	}

	WV_playStream(stream);
	return true;
}
