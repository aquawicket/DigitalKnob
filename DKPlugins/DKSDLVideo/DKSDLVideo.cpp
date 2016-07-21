#include "stdafx.h"
#include "DKSDLVideo.h"
#include "DKFile.h"
#include "DKSDLWindow.h"


////////////////////
void DKSDLVideo::Init()
{
	stream = NULL;
	streamObj = NULL;
	DKClass::RegisterFunc("DKSDLVideo::Play", &DKSDLVideo::Play, this);
}

///////////////////
void DKSDLVideo::End()
{
	if (stream)
		WV_closeStream(stream);

	/* close the streaming object */
	if (streamObj)
		WV_freeStreamRendererObj(streamObj);

	/* close the waave engine */
	WV_waaveClose();
}

//////////////////////////////////
void* DKSDLVideo::Play(void* data)
{
	DKString path = *static_cast<DKString*>(data);
	if (!DKFile::VerifyPath(path)) { return 0; }

	WV_waaveInit(WAAVE_INIT_AUDIO | WAAVE_INIT_VIDEO);
	stream = WV_getStream(path.c_str());

	int streamType = WV_getStreamType(stream);

	if (streamType == WV_STREAM_TYPE_VIDEO || streamType == WV_STREAM_TYPE_AUDIOVIDEO) {
		SDL_RenderClear(DKSDLWindow::Get("")->sdlren);
		streamObj = WV_getStreamRendererObj(DKSDLWindow::Get("")->sdlren, NULL, NULL);
		WV_setStreamingMethod(stream, streamObj);
	}

	WV_loadStream(stream);

	/* reset window size for video */
	if (streamObj) {
		int winWidth = streamObj->srcWidth;
		int winHeight = streamObj->srcHeight;
		SDL_SetWindowSize(DKSDLWindow::Get("")->sdlwin, winWidth, winHeight);
		WV_resetStreamRendererOutput(streamObj, DKSDLWindow::Get("")->sdlren, NULL); //!! update the object !!
	}

	WV_playStream(stream);
	//DKLog("DKSDLVideo::Play(): not implemented yet. \n", DKERROR);
	return NULL;
}

