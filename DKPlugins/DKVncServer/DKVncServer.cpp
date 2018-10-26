#include "DK/stdafx.h"
#include "DK/DKFile.h"
#include "DKVncServer.h"

#ifdef WIN32
#define sleep Sleep
#include <WS2tcpip.h>
#endif

#ifdef LINUX
#include <unistd.h>
#include <X11/Xlib.h>
#include <X11/Xutil.h>
Display* DKVncServer::disp;
Window DKVncServer::root;
XImage* DKVncServer::image;
#endif

#ifdef MAC
CGImageRef DKVncServer::image_ref;
CGDataProviderRef DKVncServer::provider;
CFDataRef DKVncServer::dataref;
#endif

#ifdef __IRIX__
#include <netdb.h>
#endif

#include <rfb/keysym.h>
#include "radon.h"

static rfbScreenInfoPtr rfbScreen;
static int bpp = 4;

/*
rfbPixelFormat pixfmt = {
	32,    //U8  bitsPerPixel;
	32,    //U8  depth;
	0,     //U8  bigEndianFlag;
	1,     //U8  trueColourFlag;
	255,   //U16 redMax;
	255,   //U16 greenMax;
	255,   //U16 blueMax;
	16,    //U8  redShift;
	8,     //U8  greenShift;
	0,     //U8  blueShift;
	0,     //U8  pad 1;
	0	   //U8  pad 2
};
*/
const rfbPixelFormat vnc8bitFormat =
{ 8, 8, 0, 1, 7, 7, 3, 0, 3, 6, 0, 0 };
const rfbPixelFormat vnc16bitFormat =
{ 16, 16, 0, 1, 63, 31, 31, 0, 6, 11, 0, 0 };
const rfbPixelFormat vnc24bitFormat =
{ 32, 24, 0, 1, 255, 255, 255, 16, 8, 0, 0, 0 };

/////////////////////////
typedef struct ClientData
{
	//int key = 0;
	int buttonMask = 0;
	DKString ipaddress;
} ClientData;

std::vector<ClientLog> DKVncServer::clientLog;
DKString DKVncServer::capture;


////////////////////////
bool DKVncServer::Init()
{
	DKDEBUGFUNC();
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[VNC_CAPTURE]", capture);
	if(capture.empty()){ capture = "GDI"; } //DIRECT X

	static DKString password;
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[VNC_PASSWORD]", password);
	if(password.empty()){
		DKWARN("WARNING! No password set in settings file!\n");
	}

	int desktopWidth;
	int desktopHeight;
	DKUtil::GetScreenWidth(desktopWidth);
	DKUtil::GetScreenHeight(desktopHeight);

/*
#ifdef MAC
	image_ref = CGDisplayCreateImage(CGMainDisplayID());
	provider = CGImageGetDataProvider(image_ref);
	dataref = CGDataProviderCopyData(provider);
#endif
*/
#ifdef LINUX
	disp = XOpenDisplay(NULL);
	root = XDefaultRootWindow(disp);
#endif

	rfbScreen = rfbGetScreen(&DKApp::argc, DKApp::argv, desktopWidth, desktopHeight, 8, 3, bpp);
	if(!rfbScreen){
		DKERROR("DKVncServer::Init(): rfbScreen is invalid\n");
		return false;
	}
	rfbScreen->desktopName = "DKVncServer";
	rfbScreen->frameBuffer = (char*)malloc(desktopHeight * desktopWidth * bpp);
	rfbScreen->alwaysShared = TRUE;
	rfbScreen->ptrAddEvent = mouseevent;
	rfbScreen->kbdAddEvent = keyevent;
	rfbScreen->newClientHook = newclient;
	rfbScreen->httpDir = (char*)DKFile::local_assets.c_str(); //+"DKVncServer";
	rfbScreen->httpEnableProxyConnect = TRUE;
	rfbScreen->serverFormat = vnc24bitFormat;

	if(!password.empty()){
		static const char* pass = password.c_str(); 
		static const char* passwords[2]={pass, 0};
		rfbScreen->authPasswdData = (void*)passwords;
		rfbScreen->passwordCheck = rfbCheckPasswordByList2;
	}

	rfbInitServer(rfbScreen);  
	DKApp::AppendLoopFunc(&DKVncServer::Loop, this);
	return true;
}

///////////////////////
bool DKVncServer::End()
{
	DKDEBUGFUNC();
	return true;
}

///////////////////////////////////////////////////////////////
enum rfbNewClientAction DKVncServer::newclient(rfbClientPtr cl)
{
	DKDEBUGFUNC(cl);
	cl->clientData = (void*)calloc(sizeof(ClientData), 1);
	cl->clientGoneHook = clientgone;

	//Get client ip address
	struct sockaddr_in addr;
	socklen_t len = sizeof(addr);
	unsigned int ip;
	getpeername(cl->sock, (struct sockaddr*)&addr, &len);
	ip = ntohl(addr.sin_addr.s_addr);
	ClientData* cd = (ClientData*)cl->clientData;
	cd->ipaddress = toString((ip>>24)&0xff)+"."+toString((ip>>16)&0xff)+"."+toString((ip>>8)&0xff)+"."+toString(ip&0xff);
	DKINFO("Client ip address: "+cd->ipaddress+"\n");

	for(unsigned int i=0; i<clientLog.size(); i++){
		if(same(cd->ipaddress, clientLog[i].ipaddress)){
			if(clientLog[i].failed_attempts > 2){
				DKWARN(cd->ipaddress+" is banned from this server\n");
				return RFB_CLIENT_REFUSE;
			}
		}
	}

	return RFB_CLIENT_ACCEPT;
}

/////////////////////////////////////////////
void DKVncServer::clientgone(rfbClientPtr cl)
{
	DKDEBUGFUNC(cl);
	free(cl->clientData);
	cl->clientData = NULL;
}

////////////////////////
void DKVncServer::Loop()
{
	//DKDEBUGFUNC();
	if(rfbProcessEvents(rfbScreen, 1)){
		DrawBuffer();
	}
}

////////////////////////////////////////////////////////////////////////////////////////////
rfbBool DKVncServer::rfbCheckPasswordByList2(rfbClientPtr cl, const char* response, int len)
{
	DKDEBUGFUNC(cl, response, len);
	char **passwds;
	int i=0;

	//search for ipaddress in clientLog or add new 
	ClientData* cd = (ClientData*)cl->clientData;
	int current_client = -1;
	for(unsigned int i=0; i<clientLog.size(); i++){
		if(same(cd->ipaddress, clientLog[i].ipaddress)){
			current_client = i;
			continue;
		}
	}
	if(current_client == -1){
		ClientLog cl;
		cl.ipaddress = cd->ipaddress;
		clientLog.push_back(cl);
		current_client = clientLog.size()-1;
	}

	for(passwds=(char**)cl->screen->authPasswdData; *passwds; passwds++,i++){
		uint8_t auth_tmp[CHALLENGESIZE];
		memcpy((char *)auth_tmp, (char *)cl->authChallenge, CHALLENGESIZE);
		rfbEncryptBytes(auth_tmp, *passwds);
		if(memcmp(auth_tmp, response, len) == 0){
			if(i >= cl->screen->authPasswdFirstViewOnly)
				cl->viewOnly=TRUE;
			clientLog[current_client].failed_attempts = 0;
			return(TRUE);
		}
	}
	
	rfbErr("authProcessClientMessage: authentication failed from %s\n", cl->host);
	clientLog[current_client].failed_attempts++;
	return(FALSE);
}

//////////////////////////////
void DKVncServer::DrawBuffer()
{  
	//DKDEBUGFUNC();
#ifdef WIN32
	//Capture Desktop with DirectX
	if(capture == "DIRECTX"){
		//DKLog("DIRECTX\n",DKINFO);
		//https://stackoverflow.com/questions/30021274/capture-screen-using-directx

		HRESULT hr = S_OK;
		IDirect3D9 *d3d = nullptr;
		IDirect3DDevice9 *device = nullptr;
		IDirect3DSurface9 *surface = nullptr;
		D3DPRESENT_PARAMETERS parameters = { 0 };
		D3DDISPLAYMODE mode;
		D3DLOCKED_RECT rc;
		UINT pitch;
		UINT adapter = D3DADAPTER_DEFAULT;

		// init D3D and get screen size
		d3d = Direct3DCreate9(D3D_SDK_VERSION);
		if(!d3d){
			DKERROR("DKVncServer::DrawBuffer(): Direct3DCreate9() failed\n");
			return;
		}
		HRCHECK(d3d->GetAdapterDisplayMode(adapter, &mode));

		parameters.Windowed = TRUE;
		parameters.BackBufferCount = 1;
		parameters.BackBufferHeight = mode.Height;
		parameters.BackBufferWidth = mode.Width;
		parameters.SwapEffect = D3DSWAPEFFECT_DISCARD;
		parameters.hDeviceWindow = NULL;

		// create device & capture surface
		//HRCHECK(d3d->CreateDevice(adapter, D3DDEVTYPE_HAL, NULL, D3DCREATE_SOFTWARE_VERTEXPROCESSING, &parameters, &device));
		HRCHECK(d3d->CreateDevice(adapter, D3DDEVTYPE_REF, NULL, D3DCREATE_SOFTWARE_VERTEXPROCESSING, &parameters, &device));
		HRCHECK(device->CreateOffscreenPlainSurface(mode.Width, mode.Height, D3DFMT_A8R8G8B8, D3DPOOL_SYSTEMMEM, &surface, nullptr));

		// compute the required buffer size
		HRCHECK(surface->LockRect(&rc, NULL, 0));
		pitch = rc.Pitch;
		HRCHECK(surface->UnlockRect());
		HRCHECK(device->GetFrontBufferData(0, surface));

		// copy it into our buffers
		HRCHECK(surface->LockRect(&rc, NULL, 0));
		CopyMemory(rfbScreen->frameBuffer, rc.pBits, mode.Height * mode.Width * bpp);
		HRCHECK(surface->UnlockRect());

		rfbMarkRectAsModified(rfbScreen, 0, 0, rfbScreen->width, rfbScreen->height);

		RELEASE(surface);
		RELEASE(device);
		RELEASE(d3d);
	}
	//Capture Desktop with GDI
	if(capture == "GDI"){
		//https://pastebin.com/r3CZpWDs
		HWND desktop = GetDesktopWindow();
		BITMAPINFO info = {0};
		info.bmiHeader.biSize = sizeof(info.bmiHeader);
		info.bmiHeader.biWidth = rfbScreen->width;
		info.bmiHeader.biHeight = rfbScreen->height* -1;
		info.bmiHeader.biPlanes = 1;
		info.bmiHeader.biBitCount = 32;
		info.bmiHeader.biCompression = BI_RGB;
		BYTE* pbBitmap;

		HDC src_dc = GetDC(desktop);
		HDC buffer_dc = CreateCompatibleDC(src_dc);
		HBITMAP dest_dc = CreateDIBSection(buffer_dc, &info, DIB_RGB_COLORS, (void**)&pbBitmap, NULL, 0);
		BITMAP bmp;
		SelectObject(buffer_dc, dest_dc);
		GetObject(dest_dc, sizeof(BITMAP), &bmp);
		int res = BitBlt(buffer_dc, 0, 0, rfbScreen->width, rfbScreen->height, src_dc, 0, 0, SRCCOPY);
		int go = GetObject(dest_dc, sizeof(BITMAP), &bmp);
		//Invert
		size_t n = rfbScreen->width * rfbScreen->height * bpp;
		int* buffer = (int*)malloc(n);
		int* dest = (int*)rfbScreen->frameBuffer;
		int* src = ((int*)bmp.bmBits);
		while(src != ((int*)bmp.bmBits) + (rfbScreen->width * rfbScreen->height - 1)){
			char* c_dest = (char*)dest;
			char* c_src = (char*)src;
			c_dest[0] = c_src[0];
			c_dest[1] = c_src[1];
			c_dest[2] = c_src[2];
			c_dest[3] = 0;
			src++;
			dest++;
		}

		rfbMarkRectAsModified(rfbScreen, 0, 0, rfbScreen->width, rfbScreen->height);
		ReleaseDC(desktop, src_dc);
		DeleteDC(src_dc);
		DeleteDC(buffer_dc);
		DeleteObject(dest_dc);
		delete buffer;
	}
#endif

#ifdef MAC
	image_ref = CGDisplayCreateImage(CGMainDisplayID());
	provider = CGImageGetDataProvider(image_ref);
	dataref = CGDataProviderCopyData(provider);
	size_t width, height;
    width = CGImageGetWidth(image_ref);
	height = CGImageGetHeight(image_ref); 
	size_t bpp = CGImageGetBitsPerPixel(image_ref) / 8;
	memcpy(rfbScreen->frameBuffer, CFDataGetBytePtr(dataref), width * height * bpp);
	rfbMarkRectAsModified(rfbScreen, 0 ,0, rfbScreen->width, rfbScreen->height);
	//CFRelease(dataref); 
	//CGImageRelease(image_ref); 
#endif

#ifdef LINUX
	image = XGetImage(disp, root, 0, 0, rfbScreen->width, rfbScreen->height, AllPlanes, ZPixmap);
	int w,h;
	for(h=0;h<rfbScreen->height;++h) {
		for(w=0;w<rfbScreen->width;++w) {
			unsigned long xpixel = XGetPixel(image, w, h);
			unsigned int red   = (xpixel & 0x00ff0000) >> 16;
			unsigned int green = (xpixel & 0x0000ff00) >> 8;
			unsigned int blue  = (xpixel & 0x000000ff);

			rfbScreen->frameBuffer[(h*rfbScreen->width+w)*bpp+0]=blue;
			rfbScreen->frameBuffer[(h*rfbScreen->width+w)*bpp+1]=green;
			rfbScreen->frameBuffer[(h*rfbScreen->width+w)*bpp+2]=red;
		}
		rfbScreen->frameBuffer[h*rfbScreen->width*bpp+0]=0xff;
		rfbScreen->frameBuffer[h*rfbScreen->width*bpp+1]=0xff;
		rfbScreen->frameBuffer[h*rfbScreen->width*bpp+2]=0xff;
		rfbScreen->frameBuffer[h*rfbScreen->width*bpp+3]=0xff;
	}

	rfbMarkRectAsModified(rfbScreen,0,0,rfbScreen->width,rfbScreen->height);
	//XDestroyImage(image);
	//image = NULL;
#endif
	
	/*
	//Paint framebuffer solid white
	int w, h;
	for(h=0;h<rfbScreen->height;++h) {
		for(w=0;w<rfbScreen->width;++w) {
			rfbScreen->frameBuffer[(h*rfbScreen->width+w)*bpp+0]=0xff;
			rfbScreen->frameBuffer[(h*rfbScreen->width+w)*bpp+1]=0xff;
			rfbScreen->frameBuffer[(h*rfbScreen->width+w)*bpp+2]=0xff;
		}
		rfbScreen->frameBuffer[h*rfbScreen->width*bpp+0]=0xff;
		rfbScreen->frameBuffer[h*rfbScreen->width*bpp+1]=0xff;
		rfbScreen->frameBuffer[h*rfbScreen->width*bpp+2]=0xff;
		rfbScreen->frameBuffer[h*rfbScreen->width*bpp+3]=0xff;
	}
	rfbMarkRectAsModified(rfbScreen, 0, 0, rfbScreen->width, rfbScreen->height);
	*/

	//rfbFillRect(rfbScreen, 0, 0, rfbScreen->width, rfbScreen->height, 0xffffff);
	//rfbDrawString(rfbScreen, &radonFont, 10, 10, "DKVncServer", 0xffffff);
}

////////////////////////////////////////////////////////////////////////////////
void DKVncServer::newframebuffer(rfbScreenInfoPtr screen, int width, int height)
{
	DKDEBUGFUNC(screen, width, height);
	char *oldfb, *newfb;
	oldfb = (char*)screen->frameBuffer;
	newfb = (char*)malloc(width * height * bpp);
	rfbNewFramebuffer(screen, (char*)newfb, width, height, 5, 3, bpp);
	free(oldfb);
}

///////////////////////////////////////////////////////////////////////////
void DKVncServer::mouseevent(int buttonMask, int x, int y, rfbClientPtr cl)
{
	DKDEBUGFUNC(buttonMask, x, y, cl);
	ClientData* cd = (ClientData*)cl->clientData;
	if(same(cd->ipaddress,"127.0.0.1")){ return; }
	
	DKUtil::SetMousePos(x, y);
	if(buttonMask && !cd->buttonMask){
		cd->buttonMask = buttonMask;
		if(cd->buttonMask == 1){
			DKUtil::LeftPress();
		}
		if(cd->buttonMask == 2){
			DKUtil::MiddlePress();
		}
		if(cd->buttonMask == 4){
			DKUtil::RightPress();
		}
		if(cd->buttonMask == 8){
			DKUtil::WheelUp();
		}
		if(cd->buttonMask == 16){
			DKUtil::WheelDown();
		}
	}
	if(!buttonMask && cd->buttonMask){
		if(cd->buttonMask == 1){
			DKUtil::LeftRelease();
		}
		if(cd->buttonMask == 2){
			DKUtil::MiddleRelease();
		}
		if(cd->buttonMask == 4){
			DKUtil::RightRelease();
		}
		cd->buttonMask = 0;
	}

	rfbDefaultPtrAddEvent(buttonMask, x, y, cl);
}

////////////////////////////////////////////////////////////////////////
void DKVncServer::keyevent(rfbBool down, rfbKeySym key, rfbClientPtr cl)
{
	DKDEBUGFUNC(down, key, cl);
	int k = key;
	switch(key){
		case 65307: k = 27; break; //ESC
		case 65470: k = 112; break; //F1
		case 65471: k = 113; break; //F2
		case 65472: k = 114; break; //F3
		case 65473: k = 115; break; //F4
		case 65474: k = 116; break; //F5
		case 65475: k = 117; break; //F6
		case 65476: k = 118; break; //F7
		case 65477: k = 119; break; //F8
		case 65478: k = 120; break; //F9
		case 65479: k = 121; break; //F10
		case 65480: k = 122; break; //F11       
		case 65481: k = 123; break; //F12       
		//case : k = 0; break; //Print Screen
		//case : k = 0; break; //Scroll Lock
		case 65299: k = 19; break; //Pause     
		case 96: k = 192; break; //`         
		case 49: k = 49; break; //1         
		case 50: k = 50; break; //2         
		case 51: k = 51; break; //3         
		case 52: k = 52; break; //4         
		case 53: k = 53; break; //5         
		case 54: k = 54; break; //6         
		case 55: k = 55; break; //7         
		case 56: k = 56; break; //8         
		case 57: k = 57; break; //9         
		case 48: k = 48; break; //0         
		case 45: k = 189; break; //-         
		case 61: k = 187; break; //=         
		case 65288: k = 8; break; //Backspace 
		case 65289: k = 9; break; //Tab       
		case 113: k = 81; break; //q         
		case 119: k = 87; break; //w         
		case 101: k = 69; break; //e         
		case 114: k = 82; break; //r         
		case 116: k = 84; break; //t         
		case 121: k = 89; break; //y         
		case 117: k = 85; break; //u         
		case 105: k = 73; break; //i         
		case 111: k = 79; break; //o         
		case 112: k = 80; break; //p         
		case 91: k = 219; break; //[         
		case 93: k = 221; break; //]         
		case 92: k = 220; break; //\         
		//case : k = 20; break; //CapsLock  
		case 97: k = 65; break; //a         
		case 115: k = 83; break; //s         
		case 100: k = 68; break; //d         
		case 102: k = 70; break; //f         
		case 103: k = 71; break; //g         
		case 104: k = 72; break; //h         
		case 106: k = 74; break; //j         
		case 107: k = 75; break; //k         
		case 108: k = 76; break; //l         
		case 59: k = 186; break; //;         
		case 39: k = 222; break; //'         
		case 65293: k = 13; break; //Enter     
		case 65505: k = 16; break; //LShift    
		case 122: k = 90; break; //z         
		case 120: k = 88; break; //x         
		case 99: k = 67; break; //c         
		case 118: k = 86; break; //v         
		case 98: k = 66; break; //b         
		case 110: k = 78; break; //n         
		case 109: k = 77; break; //m         
		case 44: k = 188; break; //,         
		case 46: k = 190; break; //.         
		case 47: k = 191; break; ///         
		//case 65505: k = 16; break; //RShift    
		case 65507: k = 17; break; //LCtrl     
		//case : k = 91; break; //LWinKey
		case 65513: k = 18; break; //LAlt      
		case 32: k = 32; break; //Space     
		case 65514: k = 18; break; //RAlt      
		//case : k = 0; break; //RWinKey   
		case 65383: k = 93; break; //Menu      
		case 65508: k = 17; break; //RCtrl     
		/*
		case 126: k = 0; break; //~         
		case 33: k = 0; break; //!         
		case 64: k = 0; break; //@         
		case 35: k = 0; break; //#         
		case 36: k = 0; break; //$         
		case 37: k = 0; break; //%         
		case 94: k = 0; break; //^         
		case 38: k = 0; break; //&         
		case 42: k = 0; break; //*         
		case 40: k = 0; break; //(         
		case 41: k = 0; break; //)         
		case 95: k = 0; break; //_         
		case 43: k = 0; break; //+         
		case 81: k = 0; break; //Q         
		case 87: k = 0; break; //W         
		case 69: k = 0; break; //E         
		case 82: k = 0; break; //R         
		case 84: k = 0; break; //T         
		case 89: k = 0; break; //Y         
		case 85: k = 0; break; //U         
		case 73: k = 0; break; //I         
		case 79: k = 0; break; //O         
		case 80: k = 0; break; //P         
		case 123: k = 0; break; //{         
		case 125: k = 0; break; //}         
		case 124: k = 0; break; //|         
		case 65: k = 0; break; //A         
		case 83: k = 0; break; //S         
		case 68: k = 0; break; //D         
		case 70: k = 0; break; //F         
		case 71: k = 0; break; //G         
		case 72: k = 0; break; //H         
		case 74: k = 0; break; //J         
		case 75: k = 0; break; //K         
		case 76: k = 0; break; //L         
		case 58: k = 0; break; //:         
		case 34: k = 0; break; //"         
		case 90: k = 0; break; //Z         
		case 88: k = 0; break; //X         
		case 67: k = 0; break; //C         
		case 86: k = 0; break; //V         
		case 66: k = 0; break; //B         
		case 78: k = 0; break; //N         
		case 77: k = 0; break; //M         
		case 60: k = 0; break; //<         
		case 62: k = 0; break; //>         
		case 63: k = 0; break; //?
		*/			
		case 65379: k = 45; break; //Insert    
		case 65360: k = 36; break; //Home      
		case 65365: k = 33; break; //PageUp    
		case 65535: k = 46; break; //Delete    
		case 65367: k = 35; break; //End       
		case 65366: k = 34; break; //PageDown  
		case 65362: k = 38; break; //Up        
		case 65361: k = 37; break; //Left      
		case 65364: k = 40; break; //Down      
		case 65363: k = 39; break; //Right     
		//case : k = 144; break; //NumLock
		case 65455: k = 111; break; ///         
		case 65450: k = 106; break; //*         
		case 65453: k = 109; break; //-         
		case 65463: k = 103; break; //7         
		case 65464: k = 104; break; //8         
		case 65465: k = 105; break; //9         
		case 65451: k = 107; break; //+         
		case 65460: k = 100; break; //4         
		case 65461: k = 101; break; //5         
		case 65462: k = 102; break; //6         
		case 65457: k = 97; break; //1         
		case 65458: k = 98; break; //2         
		case 65459 : k = 99; break; //3         
		case 65421: k = 13; break; //Enter     
		case 65456: k = 96; break; //0         
		case 65454: k = 110; break; //.         
		default: break;
	}
	
	if(down){
		DKUtil::PressKey(k);
	}
	else {
		DKUtil::ReleaseKey(k);
	}
}
