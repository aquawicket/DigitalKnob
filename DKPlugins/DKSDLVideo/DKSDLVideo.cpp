#include "DK/stdafx.h"
#include "DKSDLVideo.h"
#include "DKFile.h"
#include "DKSDLWindow.h"


///////////////////////
void DKSDLVideo::Init()
{
	DKDebug();
	stream = NULL;
	streamObj = NULL;
	DKSDLWindow::AddEventFunc(&DKSDLVideo::handle, this);
	DKClass::RegisterFunc("DKSDLVideo::Play", &DKSDLVideo::Play, this);
}

//////////////////////
void DKSDLVideo::End()
{
	DKDebug();
	if(stream)
		WV_closeStream(stream);

	/* close the streaming object */
	if(streamObj)
		WV_freeStreamRendererObj(streamObj);

	/* close the waave engine */
	WV_waaveClose();
}



/////////////////////////////////////////
bool DKSDLVideo::Handle(SDL_Event *event)
{
	DKDebug(event);
	if(event->type == WV_REFRESH_EVENT){
		WV_refreshVideoFrame(event);
		return true;
	}
	else if (event->type == WV_EOF_EVENT){
		//closePlayer();
		DKLog("DKSDLVideo::handle(): end of file\n");
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

//////////////////////////////////////////////////////
bool DKSDLVideo::Play(const void* input, void* output)
{
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