//see: digitalknob/3rdParty/libvncserver-master/client_examples/SDLvncviewer.c
//FIXME: convert to SDL2 compatable 

#include "DK/stdafx.h"
#include "DKVncClient.h"

#include "SDL.h"
#include <signal.h>
//#include "scrap.h"

/*
#ifdef SDL_ASYNCBLIT
int sdlFlags = SDL_HWSURFACE | SDL_ASYNCBLIT | SDL_HWACCEL;
#else
int sdlFlags = SDL_HWSURFACE | SDL_HWACCEL;
#endif
*/

struct { int sdl; int rfb; } buttonMapping[]={
	{1, rfbButton1Mask},
	{2, rfbButton2Mask},
	{3, rfbButton3Mask},
	{4, rfbButton4Mask},
	{5, rfbButton5Mask},
	{0,0}
};

int DKVncClient::enableResizable = 1, DKVncClient::viewOnly, DKVncClient::listenLoop, DKVncClient::buttonMask;
int DKVncClient::realWidth, DKVncClient::realHeight, DKVncClient::bytesPerPixel, DKVncClient::rowStride;
//char* DKVncClient::sdlPixels;
int DKVncClient::rightAltKeyDown, DKVncClient::leftAltKeyDown;
DKSDLWindow* DKVncClient::dkSdlWindow;

////////////////////////
void DKVncClient::Init()
{
	DKLog("DKVncClient::Init()\n", DKINFO);

	dkSdlWindow = DKSDLWindow::Instance("DKSDLWindow0");
	int width = 1280;
	int height = 1024;
	dkSdlWindow->SetWidth(&width, NULL);
	dkSdlWindow->SetHeight(&height, NULL);

	int i, j;
	SDL_Event e;

#ifdef LOG_TO_FILE
	rfbClientLog=rfbClientErr=log_to_file;
#endif
	for(i = 1, j = 1; i < DKApp::argc; i++)
		if (!strcmp(DKApp::argv[i], "-viewonly"))
			viewOnly = 1;
		else if (!strcmp(DKApp::argv[i], "-resizable"))
			enableResizable = 1;
		else if (!strcmp(DKApp::argv[i], "-no-resizable"))
			enableResizable = 0;
		else if (!strcmp(DKApp::argv[i], "-listen")) {
			listenLoop = 1;
			DKApp::argv[i] = "-listennofork";
			++j;
		}
		else {
			if (i != j)
				DKApp::argv[j] = DKApp::argv[i];
			j++;
		}
		DKApp::argc = j;

		//SDL_Init(SDL_INIT_VIDEO | SDL_INIT_NOPARACHUTE);
		//SDL_EnableUNICODE(1);
		//SDL_EnableKeyRepeat(SDL_DEFAULT_REPEAT_DELAY, SDL_DEFAULT_REPEAT_INTERVAL);
		atexit(SDL_Quit);
		signal(SIGINT, exit);

		do{
			// 16-bit: cl = rfbGetClient(5,3,2);
			cl = rfbGetClient(8,3,4);
			cl->MallocFrameBuffer = DKVncClient::resize;
			cl->canHandleNewFBSize = TRUE;
			cl->GotFrameBufferUpdate = DKVncClient::update;
			cl->HandleKeyboardLedState = DKVncClient::kbd_leds;
			cl->HandleTextChat = DKVncClient::text_chat;
			cl->GotXCutText = DKVncClient::got_selection;
			cl->listenPort = LISTEN_PORT_OFFSET;
			cl->listen6Port = LISTEN_PORT_OFFSET;
			if(!rfbInitClient(cl, &DKApp::argc, DKApp::argv)){
				cl = NULL; // rfbInitClient has already freed the client struct
				cleanup(cl);
				break;
			}

			//init_scrap();

			while(1){
				if(SDL_PollEvent(&e)){
					//handleSDLEvent() return 0 if user requested window close.
					//In this case, handleSDLEvent() will have called cleanup().
					if(!handleSDLEvent(cl, &e)){
						break;
					}
				}
				else{
					i=WaitForMessage(cl,500);
					if(i<0){
						cleanup(cl);
						break;
					}
					if(i){
						if(!HandleRFBServerMessage(cl)){
							cleanup(cl);
							break;
						}
					}
				}
			}
		}
		while(listenLoop);
}

///////////////////////
void DKVncClient::End()
{
	DKLog("DKVncClient::End()\n", DKINFO);
}

//////////////////////////////////////////////
rfbBool DKVncClient::resize(rfbClient* client) 
{
	DKLog("DKVncClient::resize()\n", DKINFO);

	int width = client->width;
	int height = client->height;
	int depth = client->format.bitsPerPixel;

	//if(enableResizable){
	//	sdlFlags |= SDL_RESIZABLE;
	//}

	client->updateRect.x = client->updateRect.y = 0;
	client->updateRect.w = width; client->updateRect.h = height;
	rfbBool okay = 1;//SDL_VideoModeOK(width, height, depth, sdlFlags);
	//if(!okay)
		//for(depth=24;!okay && depth>4;depth/=2)
			//okay = SDL_VideoModeOK(width,height,depth,sdlFlags);
	if(okay){
		//SDL_Surface* sdl = SDL_SetVideoMode(width, height, depth, sdlFlags);
		SDL_Surface* sdl = SDL_GetWindowSurface(dkSdlWindow->sdlwin);
		rfbClientSetClientData(client, SDL_Init, sdl);
		client->width = sdl->pitch / (depth / 8);
		if(sdl->pixels){
			free(client->frameBuffer);
			sdl->pixels = NULL;
		}
		client->frameBuffer = (uint8_t*)sdl->pixels;
		client->format.bitsPerPixel = depth;
		client->format.redShift = sdl->format->Rshift;
		client->format.greenShift = sdl->format->Gshift;
		client->format.blueShift = sdl->format->Bshift;
		client->format.redMax = sdl->format->Rmask>>client->format.redShift;
		client->format.greenMax = sdl->format->Gmask>>client->format.greenShift;
		client->format.blueMax = sdl->format->Bmask>>client->format.blueShift;
		SetFormatAndEncodings(client);
	}
	else{
		SDL_Surface* sdl = (SDL_Surface*)rfbClientGetClientData(client, SDL_Init);
		rfbClientLog("Could not set resolution %dx%d!\n", client->width,client->height);
		if(sdl) {
			client->width=sdl->pitch / (depth / 8);
			client->height=sdl->h;
		} 
		else{
			client->width=0;
			client->height=0;
		}
		return FALSE;
	}
	//SDL_WM_SetCaption(client->desktopName, "SDL");

	return TRUE;
}

///////////////////////////////////////////////////////////////
void DKVncClient::update(rfbClient* cl,int x,int y,int w,int h) 
{
	//DKLog("DKVncClient::update\n", DKINFO);

	SDL_Surface* sdl = SDL_GetWindowSurface(dkSdlWindow->sdlwin);
	if(sdl->pixels){
		resizeRectangleToReal(cl, x, y, w, h);
		w = ((x + w) * realWidth - 1) / cl->width + 1;
		h = ((y + h) * realHeight - 1) / cl->height + 1;
		x = x * realWidth / cl->width;
		y = y * realHeight / cl->height;
		w -= x;
		h -= y;
	}
	//SDL_UpdateRect(rfbClientGetClientData(cl, SDL_Init), x, y, w, h);
	SDL_Texture *tex = SDL_CreateTexture(dkSdlWindow->sdlren, SDL_PIXELFORMAT_RGBA8888, SDL_TEXTUREACCESS_TARGET, w, h);
	
	//Now render to the texture
	SDL_SetRenderTarget(dkSdlWindow->sdlren, tex);
	SDL_RenderClear(dkSdlWindow->sdlren);

	//copy data here
	SDL_RenderCopy(dkSdlWindow->sdlren, (SDL_Texture*)rfbClientGetClientData(cl, SDL_Init), NULL, NULL);
	SDL_SetRenderTarget(dkSdlWindow->sdlren, NULL);

	//Now render the texture target to our screen, but upside down
	SDL_RenderClear(dkSdlWindow->sdlren);
	SDL_RenderCopyEx(dkSdlWindow->sdlren, tex, NULL, NULL, 0, NULL, SDL_FLIP_NONE);
	SDL_RenderPresent(dkSdlWindow->sdlren);

	//Cleanup
	SDL_DestroyTexture(tex);
}

/////////////////////////////////////////////////////////////
void DKVncClient::kbd_leds(rfbClient* cl, int value, int pad)
{
	DKLog("DKVncClient::kbd_leds()\n", DKINFO);

	// note: pad is for future expansion 0=unused
	fprintf(stderr,"Led State= 0x%02X\n", value);
	fflush(stderr);
}

/////////////////////////////////////////////////////////////////
void DKVncClient::text_chat(rfbClient* cl, int value, char *text) 
{
	DKLog("DKVncClient::text_chat()\n", DKINFO);

	switch(value) {
	case rfbTextChatOpen:
		fprintf(stderr,"TextChat: We should open a textchat window!\n");
		TextChatOpen(cl);
		break;
	case rfbTextChatClose:
		fprintf(stderr,"TextChat: We should close our window!\n");
		break;
	case rfbTextChatFinished:
		fprintf(stderr,"TextChat: We should close our window!\n");
		break;
	default:
		fprintf(stderr,"TextChat: Received \"%s\"\n", text);
		break;
	}
	fflush(stderr);
}

/////////////////////////////////////////////////////////////////////////
void DKVncClient::got_selection(rfbClient *cl, const char *text, int len)
{
	DKLog("DKVncClient::got_selection()\n", DKINFO);

	//put_scrap(T('T', 'E', 'X', 'T'), len, text);
}

////////////////////////////////////////
void DKVncClient::cleanup(rfbClient* cl)
{
	DKLog("DKVncClient::cleanup()\n", DKINFO);

	//just in case we're running in listenLoop:
	//close viewer window by restarting SDL video subsystem
	SDL_QuitSubSystem(SDL_INIT_VIDEO);
	SDL_InitSubSystem(SDL_INIT_VIDEO);
	if(cl)
		rfbClientCleanup(cl);
}

////////////////////////////////////////////////////////////////
rfbBool DKVncClient::handleSDLEvent(rfbClient *cl, SDL_Event *e)
{
	DKLog("DKVncClient::handleSDLEvent()\n", DKINFO);

	switch(e->type) {
/*
#if SDL_MAJOR_VERSION > 1 || SDL_MINOR_VERSION >= 2
	case SDL_VIDEOEXPOSE:
		SendFramebufferUpdateRequest(cl, 0, 0,
			cl->width, cl->height, FALSE);
		break;
#endif
*/
	case SDL_MOUSEBUTTONUP:
	case SDL_MOUSEBUTTONDOWN:
	case SDL_MOUSEMOTION:
	{
		int x, y, state, i;
		if (viewOnly)
			break;

		if (e->type == SDL_MOUSEMOTION) {
			x = e->motion.x;
			y = e->motion.y;
			state = e->motion.state;
		}
		else {
			x = e->button.x;
			y = e->button.y;
			state = e->button.button;
			for (i = 0; buttonMapping[i].sdl; i++)
				if (state == buttonMapping[i].sdl) {
					state = buttonMapping[i].rfb;
					if (e->type == SDL_MOUSEBUTTONDOWN)
						buttonMask |= state;
					else
						buttonMask &= ~state;
					break;
				}
		}
		SDL_Surface* sdl = SDL_GetWindowSurface(dkSdlWindow->sdlwin);
		if(sdl->pixels) {
			x = x * cl->width / realWidth;
			y = y * cl->height / realHeight;
		}
		SendPointerEvent(cl, x, y, buttonMask);
		buttonMask &= ~(rfbButton4Mask | rfbButton5Mask);
		break;
	}
	case SDL_KEYUP:
	case SDL_KEYDOWN:
		if (viewOnly)
			break;
		//SendKeyEvent(cl, SDL_key2rfbKeySym(&e->key), e->type == SDL_KEYDOWN ? TRUE : FALSE);
		if (e->key.keysym.sym == SDLK_RALT)
			rightAltKeyDown = e->type == SDL_KEYDOWN;
		if (e->key.keysym.sym == SDLK_LALT)
			leftAltKeyDown = e->type == SDL_KEYDOWN;
		break;
	case SDL_QUIT:
		if(listenLoop)
		{
			cleanup(cl);
			return FALSE;
		}
		else
		{
			rfbClientCleanup(cl);
			exit(0);
		}
	/*
	case SDL_ACTIVEEVENT:
		if (!e->active.gain && rightAltKeyDown) {
			SendKeyEvent(cl, XK_Alt_R, FALSE);
			rightAltKeyDown = FALSE;
			rfbClientLog("released right Alt key\n");
		}
		if (!e->active.gain && leftAltKeyDown) {
			SendKeyEvent(cl, XK_Alt_L, FALSE);
			leftAltKeyDown = FALSE;
			rfbClientLog("released left Alt key\n");
		}

		if (e->active.gain && lost_scrap()) {
			static char *data = NULL;
			static int len = 0;
			get_scrap(T('T', 'E', 'X', 'T'), &len, &data);
			if (len)
				SendClientCutText(cl, data, len);
		}
		break;
	*/
	case SDL_SYSWMEVENT:
		//clipboard_filter(e);
		break;
	case SDL_WINDOWEVENT_RESIZED || SDL_WINDOWEVENT_SIZE_CHANGED:
		setRealDimension(cl, e->window.data1, e->window.data2);
		break;
	default:
		rfbClientLog("ignore SDL event: 0x%x\n", e->type);
	}
	return TRUE;
}

//////////////////////////////////////////////////////////////////////////////////
void DKVncClient::resizeRectangleToReal(rfbClient *cl, int x, int y, int w, int h)
{
	DKLog("DKVncClient::resizeRectangleToReal()\n", DKINFO);

	int i0 = x * realWidth / cl->width;
	int i1 = ((x + w) * realWidth - 1) / cl->width + 1;
	int j0 = y * realHeight / cl->height;
	int j1 = ((y + h) * realHeight - 1) / cl->height + 1;
	int i, j;

	for (j = j0; j < j1; j++)
		for (i = i0; i < i1; i++) {
			int x0 = i * cl->width / realWidth;
			int x1 = ((i + 1) * cl->width - 1) / realWidth + 1;
			int y0 = j * cl->height / realHeight;
			int y1 = ((j + 1) * cl->height - 1) / realHeight + 1;
			uint32_t r = 0, g = 0, b = 0;

			for (y = y0; y < y1; y++)
				for (x = x0; x < x1; x++) {
					uint32_t v = get(cl, x, y);
#define REDSHIFT cl->format.redShift
#define REDMAX cl->format.redMax
#define GREENSHIFT cl->format.greenShift
#define GREENMAX cl->format.greenMax
#define BLUESHIFT cl->format.blueShift
#define BLUEMAX cl->format.blueMax
					r += (v >> REDSHIFT) & REDMAX;
					g += (v >> GREENSHIFT) & GREENMAX;
					b += (v >> BLUESHIFT) & BLUEMAX;
				}
			r /= (x1 - x0) * (y1 - y0);
			g /= (x1 - x0) * (y1 - y0);
			b /= (x1 - x0) * (y1 - y0);

			put(i, j, (r << REDSHIFT) | (g << GREENSHIFT) |
				(b << BLUESHIFT));
		}
}

//////////////////////////////////////////////////////
uint32_t DKVncClient::get(rfbClient *cl, int x, int y)
{
	DKLog("DKVncClient::get()\n", DKINFO);

	switch (bytesPerPixel) {
	case 1: return ((uint8_t *)cl->frameBuffer)[x + y * cl->width];
	case 2: return ((uint16_t *)cl->frameBuffer)[x + y * cl->width];
	case 4: return ((uint32_t *)cl->frameBuffer)[x + y * cl->width];
	default:
		rfbClientErr("Unknown bytes/pixel: %d", bytesPerPixel);
		exit(1);
	}
}

///////////////////////////////////////////////
void DKVncClient::put(int x, int y, uint32_t v)
{
	DKLog("DKVncClient::put()\n", DKINFO);

	SDL_Surface* sdl;
	switch (bytesPerPixel) {
	case 1: sdl = SDL_GetWindowSurface(dkSdlWindow->sdlwin); ((uint8_t *)sdl->pixels)[x + y * rowStride] = v; break;
	case 2: sdl = SDL_GetWindowSurface(dkSdlWindow->sdlwin); ((uint16_t *)sdl->pixels)[x + y * rowStride] = v; break;
	case 4: sdl = SDL_GetWindowSurface(dkSdlWindow->sdlwin); ((uint32_t *)sdl->pixels)[x + y * rowStride] = v; break;
	default:
		rfbClientErr("Unknown bytes/pixel: %d", bytesPerPixel);
		exit(1);
	}
}

///////////////////////////////////////////////////////////////////
void DKVncClient::setRealDimension(rfbClient *client, int w, int h)
{
	DKLog("DKVncClient::setRealDimension()", DKINFO);

	SDL_Surface* sdl;

	if(w < 0){
		SDL_GetWindowSize(dkSdlWindow->sdlwin, &w, &h);
	}

	if (w == realWidth && h == realHeight)
		return;

	sdl = SDL_GetWindowSurface(dkSdlWindow->sdlwin);
	if (!sdl) {
		DKLog("ERROR: "+toString(SDL_GetError())+"\n",DKERROR);
	}
	if (!sdl->pixels) {
		int size;

		sdl->pixels = (char *)client->frameBuffer;
		rowStride = client->width;

		bytesPerPixel = client->format.bitsPerPixel / 8;
		size = client->width * bytesPerPixel * client->height;
		client->frameBuffer = (uint8_t*)malloc(size);
		if (!client->frameBuffer) {
			rfbClientErr("Could not allocate %d bytes", size);
			exit(1);
		}
		memcpy(client->frameBuffer, sdl->pixels, size);
	}

	sdl = (SDL_Surface*)rfbClientGetClientData(client, SDL_Init);
	if (!sdl) {
		DKLog("ERROR: "+toString(SDL_GetError())+"\n",DKERROR);
	}
	if (sdl->w != w || sdl->h != h) {
		int depth = sdl->format->BitsPerPixel;
		//sdl = SDL_SetVideoMode(w, h, depth, sdlFlags);
		rfbClientSetClientData(client, SDL_Init, sdl);
		sdl->pixels = (char*)sdl->pixels;
		rowStride = sdl->pitch / (depth / 8);
	}

	realWidth = w;
	realHeight = h;
	update(client, 0, 0, client->width, client->height);
}