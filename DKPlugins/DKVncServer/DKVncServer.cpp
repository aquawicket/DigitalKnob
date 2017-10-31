#include "DK/stdafx.h"
#include "DK/DKFile.h"
#include "DKVncServer.h"

#ifdef WIN32
#define sleep Sleep

#else
#include <unistd.h>
#include <X11/Xlib.h>
#include <X11/Xutil.h>
#endif

#ifdef __IRIX__
#include <netdb.h>
#endif

#include <rfb/keysym.h>
#include "radon.h"
#include <WS2tcpip.h>

static rfbScreenInfoPtr rfbScreen;
static int bpp = 4;

#ifdef LINUX
static Display *disp;
static Window root;
static XImage *image;
#endif

/////////////////////////
typedef struct ClientData
{
	rfbBool oldButton;
	int oldx,oldy;
} ClientData;

DKString DKVncServer::capture;
DKString DKVncServer::ipaddress;
int DKVncServer::_buttonMask = 0;
int DKVncServer::_key = 0;

////////////////////////
void DKVncServer::Init()
{
	DKFile::GetSetting(DKFile::local_assets + "settings.txt", "[VNC_CAPTURE]", capture);
	if(capture.empty()){ capture = "GDI"; } //DIRECT X

#ifdef LINUX
	disp = XOpenDisplay(NULL);
	root = DefaultRootWindow(disp);
	XMapWindow(disp, root);
#endif

	HWND desktop = GetDesktopWindow();
	RECT size;
	int desktopWidth;
	int desktopHeight;
	if(GetWindowRect(desktop, &size)){
		desktopWidth = size.right - size.left;
		desktopHeight = size.bottom - size.top;
	}

	rfbScreen = rfbGetScreen(&DKApp::argc, DKApp::argv, desktopWidth, desktopHeight, 8, 3, bpp);
	if(!rfbScreen){
		DKLog("DKVncServer::Init(): rfbScreen is invalid", DKERROR);
		return;
	}
	rfbScreen->desktopName = "DKVncServer";
	rfbScreen->frameBuffer = (char*)malloc(desktopHeight * desktopWidth * bpp);
	rfbScreen->alwaysShared = TRUE;
	rfbScreen->ptrAddEvent = mouseevent;
	rfbScreen->kbdAddEvent = keyevent;
	rfbScreen->newClientHook = newclient;
	rfbScreen->httpDir = (char*)DKFile::local_assets.c_str(); //+"DKVncServer";
	rfbScreen->httpEnableProxyConnect = TRUE;

	rfbInitServer(rfbScreen);  
	DKApp::AppendLoopFunc(&DKVncServer::Loop, this);
	DKApp::SetFramerate(0);
}

///////////////////////
void DKVncServer::End()
{

}

////////////////////////
void DKVncServer::Loop()
{
	if(rfbProcessEvents(rfbScreen, 1)){
		DrawBuffer();
	}
}

//////////////////////////////
void DKVncServer::DrawBuffer()
{
    //Capture Desktop
#ifdef LINUX
    image = XGetImage(disp, root, 0, 0, rfbScreen->width, rfbScreen->height, AllPlanes, ZPixmap);
    
    int w,h;
    for(h=0;h<rfbScreen->height;++h) {
      for(w=0;w<rfbScreen->width;++w) {
	  unsigned long xpixel = XGetPixel(image, w, h);
	  unsigned int red   = (xpixel & 0x00ff0000) >> 16;
	  unsigned int green = (xpixel & 0x0000ff00) >> 8;
	  unsigned int blue  = (xpixel & 0x000000ff);

	  rfbScreen->frameBuffer[(h*rfbScreen->width+w)*bpp+0]=red;
	  rfbScreen->frameBuffer[(h*rfbScreen->width+w)*bpp+1]=green;
	  rfbScreen->frameBuffer[(h*rfbScreen->width+w)*bpp+2]=blue;
      }
      rfbScreen->frameBuffer[h*rfbScreen->width*bpp+0]=0xff;
      rfbScreen->frameBuffer[h*rfbScreen->width*bpp+1]=0xff;
      rfbScreen->frameBuffer[h*rfbScreen->width*bpp+2]=0xff;
      rfbScreen->frameBuffer[h*rfbScreen->width*bpp+3]=0xff;
    }
    
    rfbMarkRectAsModified(rfbScreen,0,0,rfbScreen->width,rfbScreen->height);
    XDestroyImage(image);
    image = NULL;
#endif

#ifdef WIN32
	
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
			c_dest[0] = c_src[2];
			c_dest[1] = c_src[1];
			c_dest[2] = c_src[0];
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
	else if(capture == "DIRECTX"){

		//DKLog("DIRECTX\n",DKINFO);
		//TODO
		//FIXME
		//https://stackoverflow.com/questions/30021274/capture-screen-using-directx

		HRESULT hr = S_OK;
		IDirect3D9 *d3d = nullptr;
		IDirect3DDevice9 *device = nullptr;
		IDirect3DSurface9 *surface = nullptr;
		D3DPRESENT_PARAMETERS parameters = { 0 };
		D3DDISPLAYMODE mode;
		D3DLOCKED_RECT rc;
		UINT pitch;
		SYSTEMTIME st;
		//LPBYTE *shots = nullptr;
		LPBYTE shot;
		UINT adapter = D3DADAPTER_DEFAULT;

		// init D3D and get screen size
		d3d = Direct3DCreate9(D3D_SDK_VERSION);
		HRCHECK(d3d->GetAdapterDisplayMode(adapter, &mode));

		parameters.Windowed = TRUE;
		parameters.BackBufferCount = 1;
		parameters.BackBufferHeight = mode.Height;
		parameters.BackBufferWidth = mode.Width;
		parameters.SwapEffect = D3DSWAPEFFECT_DISCARD;
		parameters.hDeviceWindow = NULL;

		// create device & capture surface
		HRCHECK(d3d->CreateDevice(adapter, D3DDEVTYPE_HAL, NULL, D3DCREATE_SOFTWARE_VERTEXPROCESSING, &parameters, &device));
		HRCHECK(device->CreateOffscreenPlainSurface(mode.Width, mode.Height, D3DFMT_A8R8G8B8, D3DPOOL_SYSTEMMEM, &surface, nullptr));

		// compute the required buffer size
		HRCHECK(surface->LockRect(&rc, NULL, 0));
		pitch = rc.Pitch;
		HRCHECK(surface->UnlockRect());

		//shot = new BYTE[mode.Height * mode.Width * bpp];

		HRCHECK(device->GetFrontBufferData(0, surface));

		// copy it into our buffers
		HRCHECK(surface->LockRect(&rc, NULL, 0));
		CopyMemory(rfbScreen->frameBuffer, rc.pBits, mode.Height * mode.Width * bpp);
		HRCHECK(surface->UnlockRect());
		
		/*
		IWICImagingFactory *factory = nullptr;
		IWICBitmapEncoder *encoder = nullptr;
		IWICBitmapFrameEncode *frame = nullptr;
		IWICBitmapFlipRotator *flip = nullptr;
		IWICStream *stream = nullptr;
		GUID pf = GUID_WICPixelFormat32bppBGR;
		BOOL coInit = CoInitialize(nullptr);

		HRCHECK(CoCreateInstance(CLSID_WICImagingFactory, nullptr, CLSCTX_INPROC_SERVER, IID_PPV_ARGS(&factory)));
		HRCHECK(factory->CreateStream(&stream));
		//std::wstring filename = toWString("test.bmp");
		//HRCHECK(stream->InitializeFromFilename(filename.c_str(), GENERIC_WRITE));
		HRCHECK(stream->InitializeFromMemory((WICInProcPointer)rfbScreen->frameBuffer, GENERIC_WRITE));
		//HRCHECK(factory->CreateEncoder(GUID_ContainerFormatPng, nullptr, &encoder));
		HRCHECK(factory->CreateEncoder(GUID_ContainerFormatBmp, nullptr, &encoder));
		//factory->CreateBitmapFlipRotator(&flip);
		//flip->Initialize((IWICBitmapSource*)encoder, WICBitmapTransformFlipVertical);
		HRCHECK(encoder->Initialize(stream, WICBitmapEncoderNoCache));
		HRCHECK(encoder->CreateNewFrame(&frame, nullptr)); // we don't use options here
		HRCHECK(frame->Initialize(nullptr)); // we dont' use any options here
		HRCHECK(frame->SetSize(rfbScreen->width, rfbScreen->height));
		HRCHECK(frame->SetPixelFormat(&pf));

		//HRCHECK(frame->WritePixels(rfbScreen->height, pitch, pitch * rfbScreen->height, shot));
		HRCHECK(frame->WritePixels(rfbScreen->height, pitch, rfbScreen->height * rfbScreen->width * bpp, shot));
		HRCHECK(frame->Commit());
		HRCHECK(encoder->Commit());
		*/

		rfbMarkRectAsModified(rfbScreen, 0, 0, rfbScreen->width, rfbScreen->height);
		
		/*
		RELEASE(stream);
		RELEASE(frame);
		RELEASE(encoder);
		RELEASE(factory);
		*/

		RELEASE(surface);
		RELEASE(device);
		RELEASE(d3d);
	}
#endif

	rfbDrawString(rfbScreen, &radonFont, 10, 10, "DKVncServer", 0xffffff);
}



/////////////////////////////////////////////
void DKVncServer::clientgone(rfbClientPtr cl)
{
	free(cl->clientData);
	cl->clientData = NULL;
}

///////////////////////////////////////////////////////////////
enum rfbNewClientAction DKVncServer::newclient(rfbClientPtr cl)
{
	//DKLog("newclient()\n", DKINFO);
	cl->clientData = (void*)calloc(sizeof(ClientData), 1);
	cl->clientGoneHook = clientgone;

	//Get client ip address
	struct sockaddr_in addr;
	socklen_t len = sizeof(addr);
	unsigned int ip;
	getpeername(cl->sock, (struct sockaddr*)&addr, &len);
	ip = ntohl(addr.sin_addr.s_addr);
	ipaddress = toString((ip>>24)&0xff)+"."+toString((ip>>16)&0xff)+"."+toString((ip>>8)&0xff)+"."+toString(ip&0xff);
	DKLog("ip = "+ipaddress+"\n", DKINFO);

	return RFB_CLIENT_ACCEPT;
}

////////////////////////////////////////////////////////////////////////////////
void DKVncServer::newframebuffer(rfbScreenInfoPtr screen, int width, int height)
{
	char *oldfb, *newfb;
	oldfb = (char*)screen->frameBuffer;
	newfb = (char*)malloc(width * height * bpp);
	rfbNewFramebuffer(screen, (char*)newfb, width, height, 8, 3, bpp);
	free(oldfb);
}

///////////////////////////////////////////////////////////////////////////
void DKVncServer::mouseevent(int buttonMask, int x, int y, rfbClientPtr cl)
{
	if(same(ipaddress,"127.0.0.1")){ return; }
	//DKLog("mouseevent(): buttonMask="+toString(buttonMask)+" x="+toString(x)+" y="+toString(y)+"\n", DKINFO);

	DKUtil::SetMousePos(x, y);
	if(buttonMask && !_buttonMask){
		
		_buttonMask = buttonMask;
		if(_buttonMask == 1){
			DKUtil::LeftPress();
		}
		if(_buttonMask == 2){
			DKUtil::MiddlePress();
		}
		if(_buttonMask == 4){
			DKUtil::RightPress();
		}
		if(_buttonMask == 8){
			DKUtil::WheelUp();
		}
		if(_buttonMask == 16){
			DKUtil::WheelDown();
		}
	}
	if(!buttonMask && _buttonMask){
		if(_buttonMask == 1){
			DKUtil::LeftRelease();
		}
		if(_buttonMask == 2){
			DKUtil::MiddleRelease();
		}
		if(_buttonMask == 4){
			DKUtil::RightRelease();
		}
		_buttonMask = 0;
	}

	rfbDefaultPtrAddEvent(buttonMask, x, y, cl);
}

////////////////////////////////////////////////////////////////////////
void DKVncServer::keyevent(rfbBool down, rfbKeySym key, rfbClientPtr cl)
{
	int k = key;
	if(down){
		DKLog("keyevent(): key="+toString((int)key)+"\n", DKINFO);

		switch(key){
			case 65307: k = 0; break; //ESC
			case 65470: k = 0; break; //F1
			case 65471: k = 0; break; //F2
			case 65472: k = 0; break; //F3
			case 65473: k = 0; break; //F4
			case 65474: k = 0; break; //F5
			case 65475: k = 0; break; //F6
			case 65476: k = 0; break; //F7
			case 65477: k = 0; break; //F8
			case 65478: k = 0; break; //F9
			case 65479: k = 0; break; //F10
			case 65480: k = 0; break; //F11       
			case 65481: k = 0; break; //F12       
			//case : k = 0; break; //Print Screen
			//case : k = 0; break; //Scroll Lock
			case 65299: k = 0; break; //Pause     
			case 96: k = 0; break; //`         
			case 49: k = 0; break; //1         
			case 50: k = 0; break; //2         
			case 51: k = 0; break; //3         
			case 52: k = 0; break; //4         
			case 53: k = 0; break; //5         
			case 54: k = 0; break; //6         
			case 55: k = 0; break; //7         
			case 56: k = 0; break; //8         
			case 57: k = 0; break; //9         
			case 48: k = 0; break; //0         
			case 45: k = 0; break; //-         
			case 61: k = 0; break; //=         
			case 65288: k = 0; break; //Backspace 
			case 65289: k = 0; break; //Tab       
			case 113: k = 0; break; //q         
			case 119: k = 0; break; //w         
			case 101: k = 0; break; //e         
			case 114: k = 0; break; //r         
			case 116: k = 0; break; //t         
			case 121: k = 0; break; //y         
			case 117: k = 0; break; //u         
			case 105: k = 0; break; //i         
			case 111: k = 0; break; //o         
			case 112: k = 0; break; //p         
			case 91: k = 0; break; //[         
			case 93: k = 0; break; //]         
			case 92: k = 0; break; //\         
			//case : k = 0; break; //CapsLock  
			case 97: k = 0; break; //a         
			case 115: k = 0; break; //s         
			case 100: k = 0; break; //d         
			case 102: k = 0; break; //f         
			case 103: k = 0; break; //g         
			case 104: k = 0; break; //h         
			case 106: k = 0; break; //j         
			case 107: k = 0; break; //k         
			case 108: k = 0; break; //l         
			case 59: k = 0; break; //;         
			case 39: k = 0; break; //'         
			case 65293: k = 0; break; //Enter     
			case 65505: k = 0; break; //LShift    
			case 122: k = 0; break; //z         
			case 120: k = 0; break; //x         
			case 99: k = 0; break; //c         
			case 118: k = 0; break; //v         
			case 98: k = 0; break; //b         
			case 110: k = 0; break; //n         
			case 109: k = 0; break; //m         
			case 44: k = 0; break; //,         
			case 46: k = 0; break; //.         
			case 47: k = 0; break; ///         
			//case 65505: k = 0; break; //RShift    
			case 65507: k = 0; break; //LCtrl     
			//case : k = 0; break; //LWinKey
			case 65513: k = 0; break; //LAlt      
			case 32: k = 0; break; //Space     
			case 65514: k = 0; break; //RAlt      
			//case : k = 0; break; //RWinKey   
			case 65383: k = 0; break; //Menu      
			case 65508: k = 0; break; //RCtrl     
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
			case 65379: k = 0; break; //Insert    
			case 65360: k = 0; break; //Home      
			case 65365: k = 0; break; //PageUp    
			case 65535: k = 0; break; //Delete    
			case 65367: k = 0; break; //End       
			case 65366: k = 0; break; //PageDown  
			case 65362: k = 0; break; //Up        
			case 65361: k = 0; break; //Left      
			case 65364: k = 0; break; //Down      
			case 65363: k = 0; break; //Right     
			//case : k = 0; break; //NumLock
			case 65455: k = 0; break; ///         
			case 65450: k = 0; break; //*         
			case 65453: k = 0; break; //-         
			case 65463: k = 0; break; //7         
			case 65464: k = 0; break; //8         
			case 65465: k = 0; break; //9         
			case 65451: k = 0; break; //+         
			case 65460: k = 0; break; //4         
			case 65461: k = 0; break; //5         
			case 65462: k = 0; break; //6         
			case 65457: k = 0; break; //1         
			case 65458: k = 0; break; //2         
			case 65459 : k = 0; break; //3         
			case 65421: k = 0; break; //Enter     
			case 65456: k = 0; break; //0         
			case 65454: k = 0; break; //.         
			default: break;
		}
		DKUtil::StrokeKey((int)k);
	}
}