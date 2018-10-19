//see: digitalknob/3rdParty/libvncserver-master/client_examples/SDLvncviewer.c

#include "DK/stdafx.h"
#include "DKVncClient.h"
#include "DK/DKFile.h"
#include "DKWindow/DKWindow.h"
#include "SDL.h"
#include <signal.h>


struct { int sdl; int rfb; } buttonMapping[]={
	{1, rfbButton1Mask},
	{2, rfbButton2Mask},
	{3, rfbButton3Mask},
	{4, rfbButton4Mask},
	{5, rfbButton5Mask},
	{0,0}
};

int DKVncClient::enableResizable = 0, DKVncClient::viewOnly, DKVncClient::buttonMask;
int DKVncClient::realWidth, DKVncClient::realHeight, DKVncClient::bytesPerPixel, DKVncClient::rowStride;
int DKVncClient::rightShiftKeyDown, DKVncClient::leftShiftKeyDown;
DKSDLWindow* DKVncClient::dkSdlWindow;
const char* DKVncClient::pass;
int DKVncClient::message_wait = 1;
SDL_Texture* DKVncClient::tex = NULL;
rfbClient* DKVncClient::cl;
bool DKVncClient::seperate_loop = false;

long DKVncClient::last_mouse_move = 0;

////////////////////////
bool DKVncClient::Init()
{
	DKLog("DKVncClient::Init()\n", DKDEBUG);

	DKString server_ip;
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[VNC_SERVER]", server_ip);
	if(server_ip.empty()){ server_ip = "127.0.0.1"; }
	DKString server_port;
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[VNC_PORT]", server_port);
	if(server_port.empty()){ server_port = "5900"; }
	DKString server_password;
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[VNC_PASSWORD]", server_password);
	if(!server_password.empty()){
		pass = server_password.c_str();
	}
	DKString encoding;
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[VNC_ENCODING]", encoding);
	DKString vnc_bgrttt;
	bool bgrttt = false;
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[VNC_BGR233]", vnc_bgrttt);
	if(!vnc_bgrttt.empty()){
		bgrttt = toBool(vnc_bgrttt);
	}
	DKString vnc_message_wait;
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[VNC_MESSAGE_WAIT]", vnc_message_wait);
	if(!vnc_message_wait.empty()){
		message_wait = toInt(vnc_message_wait);
	}
	DKString vnc_compression;
	int compression = 0;
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[VNC_COMPRESSION]", vnc_compression);
	if(!vnc_compression.empty()){
		compression = toInt(vnc_compression);
	}
	DKString vnc_quality;
	int quality = 1;
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[VNC_QUALITY]", vnc_quality);
	if(!vnc_quality.empty()){
		quality = toInt(vnc_quality);
	}
	DKString vnc_jpeg;
	bool jpeg = true;
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[VNC_JPEG]", vnc_jpeg);
	if(!vnc_jpeg.empty()){
		jpeg = toBool(vnc_jpeg);
	}
	DKString vnc_cursor;
	bool cursor = true;
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[VNC_CURSOR]", vnc_cursor);
	if(!vnc_cursor.empty()){
		cursor = toBool(vnc_cursor);
	}
	
	dkSdlWindow = DKSDLWindow::Instance("DKSDLWindow0");

	SDL_SetEventFilter(NULL, NULL);

	atexit(SDL_Quit);
	signal(SIGINT, exit);

	//cl = rfbGetClient(5,3,2); // 16-bit
	cl = rfbGetClient(8,3,4); // 32-bit?

	//Display extra info
	DKLog("canUseCoRRE = "+toString(cl->canUseCoRRE)+"\n");
	DKLog("canUseHextile = "+toString(cl->canUseHextile)+"\n");

	//cl->appData.shareDesktop = true;
	//cl->appData.viewOnly = false;
	cl->appData.encodingsString = encoding.c_str();
	cl->appData.useBGR233 = bgrttt;
	//cl->appData.nColours = 256;
	//cl->appData.forceOwnCmap = false;
	//cl->appData.forceTrueColour = false;
	//cl->appData.requestedDepth = 32;
	cl->appData.compressLevel = compression;
	cl->appData.qualityLevel = quality;
	cl->appData.enableJPEG = jpeg;
	cl->appData.useRemoteCursor = cursor;
	//cl->appData.palmVNC = false;
	cl->appData.scaleSetting = 200;
	
	cl->canHandleNewFBSize = TRUE;
	//cl->MallocFrameBuffer = DKVncClient::resize;
	if(seperate_loop){
		cl->GotFrameBufferUpdate = DKVncClient::update;
	}
	cl->HandleKeyboardLedState = DKVncClient::kbd_leds;
	cl->HandleTextChat = DKVncClient::text_chat;
	cl->GotXCutText = DKVncClient::got_selection;
	cl->listenPort = LISTEN_PORT_OFFSET;
	cl->listen6Port = LISTEN_PORT_OFFSET;
	cl->serverHost = (char*)server_ip.c_str();
	cl->serverPort = toInt(server_port);
	if(!server_password.empty()){
		cl->GetPassword = DKVncClient::password;
	}
	//cl->format.redShift = 16;
    //cl->format.greenShift = 0;
    //cl->format.blueShift = 8;
	
	/*
	DKLog("Connecting to "+server_ip+". . .\n");
	//if(!rfbInitClient(cl, &DKApp::argc, DKApp::argv)){
	//	cl = NULL;
	//	cleanup(cl);
	//	return;
	//}

	if(!rfbInitConnection(cl)){
		cl = NULL;
		cleanup(cl);
		return false;
	}
	*/
	//Connect("address", "password");
	
	//tex = SDL_CreateTexture(dkSdlWindow->renderer, SDL_PIXELFORMAT_ABGR8888, SDL_TEXTUREACCESS_STREAMING, cl->width, cl->height);
	//tex = SDL_CreateTexture(dkSdlWindow->renderer, SDL_PIXELFORMAT_ARGB1555, SDL_TEXTUREACCESS_TARGET, cl->width, cl->height);

	//SDL_Surface* sdl = SDL_GetWindowSurface(dkSdlWindow->window);
	//rfbClientSetClientData(cl, SDL_Init, sdl);

	//ValidateAspectRatio(cl);
	//resize(cl);

	if(seperate_loop){
		SDL_Event e;
		DKApp::active = true;
		while(DKApp::active){
			while(SDL_PollEvent(&e)){
				handle(&e);
			}
			//while(WaitForMessage(cl, message_wait)){
				HandleRFBServerMessage(cl);
			//}
		}
	}
	else{
		DKSDLWindow::AddEventFunc(&DKVncClient::handle, this);
		DKSDLWindow::AddDrawFunc(&DKVncClient::draw, this);
	}
	
	if(!Connect(server_ip, server_password)){
		DKLog("DKVncClient::Init(): Connect() failed\n", DKWARN);
		return false; 
	}
	return true;
}

///////////////////////
bool DKVncClient::End()
{
	DKLog("DKVncClient::End()\n", DKDEBUG);
	SDL_DestroyTexture(tex);
	cl = NULL;
	cleanup(cl);
	return true;
}


//////////////////////////////////////////////////
bool DKVncClient::TestInt(int& input, int& output)
{
	if(DKClass::HasFunc("DKSDLWindow::TestInt")){
		return DKClass::CallFunc("DKSDLWindow::TestInt", &input, &output);
	}
	if(DKClass::HasFunc("DKSFMLWindow::TestInt")){
		return DKClass::CallFunc("DKSFMLWindow::TestInt", &input, &output);
	}
	DKLog("DKWindow::TestInt(): No function available \n", DKERROR);
	return false;
}

///////////////////////////////////////////////////////////////
bool DKVncClient::TestString(DKString& input, DKString& output)
{
	if(DKClass::HasFunc("DKSDLWindow::TestString")){
		return DKClass::CallFunc("DKSDLWindow::TestString", &input, &output);
	}
	if(DKClass::HasFunc("DKSFMLWindow::TestString")){
		return DKClass::CallFunc("DKSFMLWindow::TestString", &input, &output);
	}
	DKLog("DKWindow::TestString(): No function available \n", DKERROR);
	return false;
}

////////////////////////////////////////////
bool DKVncClient::TestReturnInt(int& output)
{
	if(DKClass::HasFunc("DKSDLWindow::TestReturnInt")){
		return DKClass::CallFunc("DKSDLWindow::TestReturnInt", NULL, &output);
	}
	if(DKClass::HasFunc("DKSFMLWindow::TestReturnInt")){
		return DKClass::CallFunc("DKSFMLWindow::TestReturnInt", NULL, &output);
	}
	DKLog("DKWindow::TestReturnInt(): No function available \n", DKERROR);
	return false;
}

////////////////////////////////////////////////////
bool DKVncClient::TestReturnString(DKString& output)
{
	if(DKClass::HasFunc("DKSDLWindow::TestReturnString")){
		return DKClass::CallFunc("DKSDLWindow::TestReturnString", NULL, &output);
	}
	if(DKClass::HasFunc("DKSFMLWindow::TestReturnString")){
		return DKClass::CallFunc("DKSFMLWindow::TestReturnString", NULL, &output);
	}
	DKLog("DKWindow::TestReturnString(): No function available \n", DKERROR);
	return false;
}

////////////////////////////////////////////////////////////////////////////
bool DKVncClient::Connect(const DKString& address, const DKString& password)
{
	DKLog("DKVncClient::Connect("+address+","+password+")\n", DKDEBUG);

	cl->serverHost = (char*)address.c_str();
	pass = password.c_str();
	cl->GetPassword = DKVncClient::password; //Tell vnc to grab the password on connect.
	if(!rfbInitConnection(cl)){
		DKLog("DKVncClient::Connect(): rfbInitConnection() failed\n", DKWARN);
		return false; 
	}
	tex = SDL_CreateTexture(dkSdlWindow->renderer, SDL_PIXELFORMAT_ABGR8888, SDL_TEXTUREACCESS_STREAMING, cl->width, cl->height);
	if(!tex){
		DKLog("DKVncClient::Connect(): tex invalid\n", DKWARN);
		return false; 
	}
	if(!ValidateAspectRatio(cl)){
		DKLog("DKVncClient::Connect(): ValidateAspectRatio() failed\n", DKWARN);
		return false; 
	}
	return true;
}

/////////////////////////////////////////////////////////
rfbBool DKVncClient::rfbInitConnection(rfbClient* client)
{
	/* Unless we accepted an incoming connection, make a TCP connection to the given VNC server */
	if(!client->listenSpecified){
		if(!client->serverHost || !ConnectToRFBServer(client,client->serverHost,client->serverPort)){
			DKLog("DKVncClient::rfbInitConnection(): ConnectToRFBServer() failed\n", DKWARN);
			return FALSE;
		}
	}
	
	/* Initialise the VNC connection, including reading the password */
	if(!InitialiseRFBConnection(client)){
		DKLog("DKVncClient::rfbInitConnection(): InitialiseRFBConnection() failed\n", DKWARN);
		return FALSE;
	}
	
	if(!SetFormatAndEncodings(client)){
		DKLog("DKVncClient::rfbInitConnection(): SetFormatAndEncodings() failed\n", DKWARN);
		return FALSE;
	}
	
	client->width=client->si.framebufferWidth;
	client->height=client->si.framebufferHeight;
	client->MallocFrameBuffer(client);
	
	if(client->updateRect.x < 0){
		client->updateRect.x = client->updateRect.y = 0;
		client->updateRect.w = client->width;
		client->updateRect.h = client->height;
	}
	
	if(client->appData.scaleSetting>1){
		if(!SendScaleSetting(client, client->appData.scaleSetting)){
			DKLog("DKVncClient::rfbInitConnection(): SendScaleSetting() failed\n", DKWARN);
			return FALSE; 
		} 
		if(!SendFramebufferUpdateRequest(client,
			client->updateRect.x / client->appData.scaleSetting,
			client->updateRect.y / client->appData.scaleSetting,
			client->updateRect.w / client->appData.scaleSetting,
			client->updateRect.h / client->appData.scaleSetting,
			FALSE)){
				DKLog("DKVncClient::rfbInitConnection(): SendFramebufferUpdateRequest() failed\n", DKWARN);
				return FALSE;
		}
	}
	else{
		if(!SendFramebufferUpdateRequest(client,
			client->updateRect.x, client->updateRect.y,
			client->updateRect.w, client->updateRect.h,
			FALSE)){
			DKLog("DKVncClient::rfbInitConnection(): SendFramebufferUpdateRequest() failed\n", DKWARN);
			return FALSE;
		}
	}
	return TRUE;
}

////////////////////////
void DKVncClient::draw()
{
	if(!cl->frameBuffer){
		//DKLog("DKVncClient::draw(): cl->frameBuffer invalid\n", DKWARN);
		return; 
	}

	//SDL_Event e;
	//while(SDL_PollEvent(&e)){
	//	handle(&e);
	//}

	if(!HandleRFBServerMessage(cl)){
		DKLog("DKVncClient::draw(): HandleRFBServerMessage() failed\n", DKWARN);
		return;
	}
	SDL_Rect r;
	r.x = 0;
	r.y = 0;
	r.w = cl->width;
	r.h = cl->height;
	if(SDL_UpdateTexture(tex, &r, cl->frameBuffer, cl->width*4) == -1){
		DKLog("DKVncClient::draw(): SDL_UpdateTexture() failed\n", DKWARN);
		return;
	}
	if(SDL_RenderCopyEx(dkSdlWindow->renderer, tex, NULL, NULL, 0, NULL, SDL_FLIP_NONE) == -1){
		DKLog("DKVncClient::draw(): SDL_RenderCopyEx() failed\n", DKWARN);
		return;
	}
}

///////////////////////////////////////////////////////////////////
void DKVncClient::update(rfbClient* cl, int x, int y, int w, int h) 
{
	//Throttle the drawing to conserve cpu
	DKUtil::GetTicks(DKUtil::now);
	int delta = DKUtil::now - DKUtil::lastFrame;
	if(delta < DKUtil::ticksPerFrame){
		//UINT32 sleep = DKApp::ticksPerFrame - delta;
		//DKUtil::Sleep(sleep);
		return;
	}
	DKUtil::GetTicks(DKUtil::lastFrame);
	//DKLog("DKVncClient::update("+toString(cl->desktopName)+","+toString(x)+","+toString(y)+","+toString(w)+","+toString(h)+")\n");
	SDL_Rect r;
	r.x = 0;
	r.y = 0;
	r.w = cl->width;
	r.h = cl->height;

	SDL_UpdateTexture(tex, &r, cl->frameBuffer, cl->width*4);

	//Now render the texture target to our screen
	SDL_SetRenderTarget(dkSdlWindow->renderer, NULL);
	SDL_RenderClear(dkSdlWindow->renderer);
	SDL_RenderCopyEx(dkSdlWindow->renderer, tex, NULL, NULL, 0, NULL, SDL_FLIP_NONE);
	SDL_RenderPresent(dkSdlWindow->renderer);
}

//////////////////////////////////////
bool DKVncClient::handle(SDL_Event *e)
{
	//DKLog("DKVncClient::handleSDLEvent()\n", DKDEBUG);

	switch(e->type){
		case SDL_MOUSEBUTTONUP:
		case SDL_MOUSEBUTTONDOWN:
		case SDL_MOUSEMOTION:
		{
			int x, y, state;
			//if (viewOnly)
			//	break;

			if(e->type == SDL_MOUSEMOTION){
				//limit sending mouse move events to 30 frames per second
				if(!DKUtil::now){ DKUtil::InitFramerate(); }
				if(!last_mouse_move){ DKUtil::GetTicks(last_mouse_move); }
				DKUtil::GetTicks(DKUtil::now);
				int delta = DKUtil::now - last_mouse_move;
				if(delta < (1000 / 30)){  //30 fps
					return true;
				}
				DKUtil::GetTicks(last_mouse_move);

				state = e->motion.state;
				x = e->motion.x;
				y = e->motion.y;
				if(state == 3){ state = 4;}
			}
			else{
				x = e->button.x;
				y = e->button.y;
				state = e->button.button;
				if(state == 3){ state = 4;}
				if(e->type == SDL_MOUSEBUTTONUP){
					state = 0;
				}
			}

			x = x * cl->width / dkSdlWindow->width;
			y = y * cl->height / dkSdlWindow->height;
			SendPointerEvent(cl, x, y, state);
			break;
		}
		case SDL_MOUSEWHEEL:
		{
			int x, y;
			SDL_GetMouseState(&x, &y);
			x = x * cl->width / dkSdlWindow->width;
			y = y * cl->height / dkSdlWindow->height;
			if(e->wheel.y == 1){ // scroll up
				SendPointerEvent(cl, x, y, 8);
				SendPointerEvent(cl, x, y, 0);
				break;
			}
			else if(e->wheel.y == -1){ // scroll down
				SendPointerEvent(cl, x, y, 16);
				SendPointerEvent(cl, x, y, 0);
				break;
			}
		}
		case SDL_KEYUP:
		case SDL_KEYDOWN:
		{
			//if (viewOnly)
			//	break;
			/*
			if(e->key.keysym.sym == SDLK_LSHIFT && !rightShiftKeyDown){
				DKLog("left shift down\n");
				rightShiftKeyDown = TRUE;
				SendKeyEvent(cl, XK_Shift_L, TRUE);
			}
			*/
			/*
			else if(e->key.keysym.sym != SDLK_LSHIFT && rightShiftKeyDown){
				DKLog("left shift up\n");
				rightShiftKeyDown = FALSE;
				SendKeyEvent(cl, XK_Shift_L, FALSE);
			}
			*/
			//DKLog(toString(SDL_key2rfbKeySym(&e->key))+", "+toString(e->type == SDL_KEYDOWN ? "down" : "up")+"\n");
			SendKeyEvent(cl, SDL_key2rfbKeySym(&e->key), e->type == SDL_KEYDOWN ? TRUE : FALSE);
			break;
		}
		case SDL_QUIT:
		{
			DKApp::active = false;
			cleanup(cl);
			DKApp::Exit();
			return false;
		}
		/*
		case SDL_ACTIVEEVENT:
			if (!e->active.gain && rightAltKeyDown){
				SendKeyEvent(cl, XK_Alt_R, FALSE);
				rightAltKeyDown = FALSE;
				rfbClientLog("released right Alt key\n");
			}
			if (!e->active.gain && leftAltKeyDown){
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
		case SDL_WINDOWEVENT:
			//DKLog("SDL_WINDOWEVENT\n");
			switch(e->window.event){
				//case SDL_WINDOWEVENT_SIZE_CHANGED:
				case SDL_WINDOWEVENT_RESIZED:
				//case SDL_WINDOWEVENT_MINIMIZED:      
				//case SDL_WINDOWEVENT_MAXIMIZED:      
				//case SDL_WINDOWEVENT_RESTORED: 
				{
					if(dkSdlWindow->width != e->window.data1 || dkSdlWindow->height != e->window.data2){
						dkSdlWindow->width = e->window.data1;
						dkSdlWindow->height = e->window.data2;
						if(!SDL_GetWindowFlags(dkSdlWindow->window) & SDL_WINDOW_MAXIMIZED){
							ValidateAspectRatio(cl);
						}
					}
					return true;
				}
			}
			break;
		default:
		//rfbClientLog("ignored SDL event: 0x%x\n", e->type);
		return true;
	}

	return true;
}

/*
//////////////////////////////////////////////
rfbBool DKVncClient::resize(rfbClient* client) 
{
	DKLog("DKVncClient::resize()\n", DKDEBUG);
	//DKLog("client->appData.scaleSetting="+toString(client->appData.scaleSetting)+"\n");
	int width = client->width;
	int height = client->height;
	int depth = client->format.bitsPerPixel;

	//client->updateRect.x = client->updateRect.y = 0;
	//client->updateRect.w = width; client->updateRect.h = height;

	SDL_Surface* sdl = SDL_GetWindowSurface(dkSdlWindow->window);
	client->width = sdl->pitch / (depth / 8);
	client->height = sdl->h;
	tex = SDL_CreateTexture(dkSdlWindow->renderer, SDL_PIXELFORMAT_ABGR8888, SDL_TEXTUREACCESS_STREAMING, width, height);
	client->frameBuffer = (uint8_t*)sdl->pixels;
	client->format.bitsPerPixel=depth;
	SetFormatAndEncodings(client);
	DKLog("client->width="+toString(client->width)+",client->height="+toString(client->height)+"\n");
	return true;


	rfbBool okay = 1;//SDL_VideoModeOK(width, height, depth, sdlFlags);
	//if(!okay)
		//for(depth=24;!okay && depth>4;depth/=2)
			//okay = SDL_VideoModeOK(width,height,depth,sdlFlags);
	if(okay){
		//SDL_Surface* sdl = SDL_SetVideoMode(width, height, depth, sdlFlags);
		SDL_Surface* sdl = SDL_GetWindowSurface(dkSdlWindow->window);
		rfbClientSetClientData(client, SDL_Init, sdl);
		client->width = sdl->pitch / (depth / 8);
		if(!sdl->pixels){
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
*/

/////////////////////////////////////////////////////////////
void DKVncClient::kbd_leds(rfbClient* cl, int value, int pad)
{
	DKLog("DKVncClient::kbd_leds()\n", DKDEBUG);

	// note: pad is for future expansion 0=unused
	fprintf(stderr,"Led State= 0x%02X\n", value);
	fflush(stderr);
}

/////////////////////////////////////////////////////////////////
void DKVncClient::text_chat(rfbClient* cl, int value, char *text) 
{
	DKLog("DKVncClient::text_chat()\n", DKDEBUG);

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
	DKLog("DKVncClient::got_selection()\n", DKDEBUG);

	//put_scrap(T('T', 'E', 'X', 'T'), len, text);
}

////////////////////////////////////////
void DKVncClient::cleanup(rfbClient* cl)
{
	DKLog("DKVncClient::cleanup()\n", DKDEBUG);

	//just in case we're running in listenLoop:
	//close viewer window by restarting SDL video subsystem
	SDL_QuitSubSystem(SDL_INIT_VIDEO);
	SDL_InitSubSystem(SDL_INIT_VIDEO);
	if(cl)
		cl->serverHost = NULL;
}

//////////////////////////////////////////////////////////////////////////////////
void DKVncClient::resizeRectangleToReal(rfbClient *cl, int x, int y, int w, int h)
{
	DKLog("DKVncClient::resizeRectangleToReal()\n", DKDEBUG);
	
	if(!realWidth || !realHeight){
		return;
	}

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
	DKLog("DKVncClient::get()\n", DKDEBUG);

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
	DKLog("DKVncClient::put()\n", DKDEBUG);

	SDL_Surface* sdl;
	switch (bytesPerPixel) {
	case 1: sdl = SDL_GetWindowSurface(dkSdlWindow->window); ((uint8_t *)sdl->pixels)[x + y * rowStride] = v; break;
	case 2: sdl = SDL_GetWindowSurface(dkSdlWindow->window); ((uint16_t *)sdl->pixels)[x + y * rowStride] = v; break;
	case 4: sdl = SDL_GetWindowSurface(dkSdlWindow->window); ((uint32_t *)sdl->pixels)[x + y * rowStride] = v; break;
	default:
		rfbClientErr("Unknown bytes/pixel: %d", bytesPerPixel);
		exit(1);
	}
}

/*
///////////////////////////////////////////////////////////////////
void DKVncClient::setRealDimension(rfbClient *client, int w, int h)
{
	DKLog("DKVncClient::setRealDimension()", DKDEBUG);

	SDL_Surface* sdl;

	if(w < 0){
		SDL_GetWindowSize(dkSdlWindow->window, &w, &h);
	}

	if (w == realWidth && h == realHeight)
		return;

	sdl = SDL_GetWindowSurface(dkSdlWindow->window);
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
*/

//////////////////////////////////////////////////////////////
rfbKeySym DKVncClient::SDL_key2rfbKeySym(SDL_KeyboardEvent* e)
{
	rfbKeySym k = 0;
	SDL_Keycode sym = e->keysym.sym;

	switch (sym) {
	case SDLK_BACKSPACE: k = XK_BackSpace; break;
	case SDLK_TAB: k = XK_Tab; break;
	case SDLK_CLEAR: k = XK_Clear; break;
	case SDLK_RETURN: k = XK_Return; break;
	case SDLK_PAUSE: k = XK_Pause; break;
	case SDLK_ESCAPE: k = XK_Escape; break;
	case SDLK_SPACE: k = XK_space; break;
	case SDLK_DELETE: k = XK_Delete; break;
	case SDLK_KP_0: k = XK_KP_0; break;
	case SDLK_KP_1: k = XK_KP_1; break;
	case SDLK_KP_2: k = XK_KP_2; break;
	case SDLK_KP_3: k = XK_KP_3; break;
	case SDLK_KP_4: k = XK_KP_4; break;
	case SDLK_KP_5: k = XK_KP_5; break;
	case SDLK_KP_6: k = XK_KP_6; break;
	case SDLK_KP_7: k = XK_KP_7; break;
	case SDLK_KP_8: k = XK_KP_8; break;
	case SDLK_KP_9: k = XK_KP_9; break;
	case SDLK_KP_PERIOD: k = XK_KP_Decimal; break;
	case SDLK_KP_DIVIDE: k = XK_KP_Divide; break;
	case SDLK_KP_MULTIPLY: k = XK_KP_Multiply; break;
	case SDLK_KP_MINUS: k = XK_KP_Subtract; break;
	case SDLK_KP_PLUS: k = XK_KP_Add; break;
	case SDLK_KP_ENTER: k = XK_KP_Enter; break;
	case SDLK_KP_EQUALS: k = XK_KP_Equal; break;
	case SDLK_UP: k = XK_Up; break;
	case SDLK_DOWN: k = XK_Down; break;
	case SDLK_RIGHT: k = XK_Right; break;
	case SDLK_LEFT: k = XK_Left; break;
	case SDLK_INSERT: k = XK_Insert; break;
	case SDLK_HOME: k = XK_Home; break;
	case SDLK_END: k = XK_End; break;
	case SDLK_PAGEUP: k = XK_Page_Up; break;
	case SDLK_PAGEDOWN: k = XK_Page_Down; break;
	case SDLK_F1: k = XK_F1; break;
	case SDLK_F2: k = XK_F2; break;
	case SDLK_F3: k = XK_F3; break;
	case SDLK_F4: k = XK_F4; break;
	case SDLK_F5: k = XK_F5; break;
	case SDLK_F6: k = XK_F6; break;
	case SDLK_F7: k = XK_F7; break;
	case SDLK_F8: k = XK_F8; break;
	case SDLK_F9: k = XK_F9; break;
	case SDLK_F10: k = XK_F10; break;
	case SDLK_F11: k = XK_F11; break;
	case SDLK_F12: k = XK_F12; break;
	case SDLK_F13: k = XK_F13; break;
	case SDLK_F14: k = XK_F14; break;
	case SDLK_F15: k = XK_F15; break;
	case SDLK_NUMLOCKCLEAR: k = XK_Num_Lock; break;
	case SDLK_CAPSLOCK: k = XK_Caps_Lock; break;
	case SDLK_SCROLLLOCK: k = XK_Scroll_Lock; break;
	case SDLK_RSHIFT: k = XK_Shift_R; break;
	case SDLK_LSHIFT: k = XK_Shift_L; break;
	case SDLK_RCTRL: k = XK_Control_R; break;
	case SDLK_LCTRL: k = XK_Control_L; break;
	case SDLK_RALT: k = XK_Alt_R; break;
	case SDLK_LALT: k = XK_Alt_L; break;
	//case SDLK_RMETA: k = XK_Meta_R; break;
	//case SDLK_LMETA: k = XK_Meta_L; break;
	//case SDLK_LSUPER: k = XK_Super_L; break;
	//case SDLK_RSUPER: k = XK_Super_R; break;
#if 0
	case SDLK_COMPOSE: k = XK_Compose; break;
#endif
	case SDLK_MODE: k = XK_Mode_switch; break;
	case SDLK_HELP: k = XK_Help; break;
	SDLK_PRINTSCREEN: k = XK_Print; break;
	case SDLK_SYSREQ: k = XK_Sys_Req; break;
	//case SDLK_BREAK: k = XK_Break; break;
	default: break;
	}
	/* both SDL and X11 keysyms match ASCII in the range 0x01-0x7f */
	if (k == 0 && sym > 0x0 && sym < 0x100) {
		k = sym;
		if (e->keysym.mod & (KMOD_LSHIFT | KMOD_RSHIFT)) {
			if (k >= '1' && k <= '9')
				k &= ~0x10;
			else if (k >= 'a' && k <= 'f')
				k &= ~0x20;
		}
	}
	if (k == 0) {
		//if (e->keysym.unicode < 0x100)
		//	k = e->keysym.unicode;
		//else
			rfbClientLog("Unknown keysym: %d\n", sym);
	}

	return k;
}

//////////////////////////////////////////
char* DKVncClient::password(rfbClient *cl)
{
	DKLog("DKVncClient::password()\n", DKDEBUG);
	
	return (char*)pass;
}

////////////////////////////////////////////////////
bool DKVncClient::ValidateAspectRatio(rfbClient *cl)
{
	//FIXME
	return true; //BYPASS

	//DKLog("DKVncClient::ValidateAspectRatio(): cl->width="+toString(cl->width)+", cl->height="+toString(cl->height)+"\n");
	//cl->width;
	//cl->height;
	//DKWindow::SetHeight(300);

	//TODO = test this
	//SDL_SetWindowBordered(dkSdlWindow->window, SDL_FALSE);

	float delta = (float)cl->width / (float)dkSdlWindow->width;
	DKLog("DKVncClient::ValidateAspectRatio(): "+toString(cl->width)+" / "+toString(dkSdlWindow->width)+" = "+toString(delta)+"\n");

	float height = (float)cl->height / delta;
	DKLog("DKVncClient::ValidateAspectRatio(): "+toString(cl->height)+" / "+toString(delta)+" = "+toString(height)+"\n");
	DKWindow::SetHeight((int&)height);
	dkSdlWindow->height = (int)height;

	int w, h;
	SDL_GetWindowSize(dkSdlWindow->window, &w, &h);
	DKLog("DKVncClient::ValidateAspectRatio(): width="+toString(w)+" height="+toString(h)+"\n");

	//int top, left, bottom, right;
	//SDL_GetWindowBordersSize(dkSdlWindow->window, &top, &left, &bottom, &right);
	//DKLog("DKVncClient::ValidateAspectRatio(): top="+toString(top)+" left="+toString(left)+" bottom="+toString(bottom)+" right="+toString(right)+"\n");

	update(cl, 0, 0, cl->width, cl->height);

	return true;
}