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

static rfbScreenInfoPtr rfbScreen;
static int bpp = 4;

#ifdef LINUX
static Display *disp;
static Window root;
static XImage *image;
#endif


////////////////////////
static void DrawBuffer()
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
	//https://pastebin.com/r3CZpWDs

	BITMAPINFO info = {0};
	info.bmiHeader.biSize = sizeof(info.bmiHeader);
	info.bmiHeader.biWidth = rfbScreen->width;
	info.bmiHeader.biHeight = rfbScreen->height* -1;
	info.bmiHeader.biPlanes = 1;
	info.bmiHeader.biBitCount = 32;
	info.bmiHeader.biCompression = BI_RGB;
	BYTE* pbBitmap;

	HWND hDesktopWnd = GetDesktopWindow();
	HDC src_dc = GetDC(hDesktopWnd);
	HDC buffer_dc = CreateCompatibleDC(src_dc);
	HBITMAP dest_dc = CreateDIBSection(buffer_dc, &info, DIB_RGB_COLORS, (void**)&pbBitmap, NULL, 0);
	BITMAP screen;
	SelectObject(buffer_dc, dest_dc);
	GetObject(dest_dc, sizeof(BITMAP), &screen);
	int res = BitBlt(buffer_dc, 0, 0, rfbScreen->width, rfbScreen->height, src_dc, 0, 0, SRCCOPY);
	int go = GetObject(dest_dc, sizeof(BITMAP), &screen);
	//Invert
	size_t n = rfbScreen->width*rfbScreen->height * 4;
	int* buffer = (int*)malloc(n);
	int* dest = (int*)rfbScreen->frameBuffer;
	int* src = ((int*)screen.bmBits);
	while(src != ((int*)screen.bmBits) + (rfbScreen->width * rfbScreen->height - 1)){
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
	ReleaseDC(hDesktopWnd, src_dc);
	DeleteDC(src_dc);
	DeleteDC(buffer_dc);
	DeleteObject(dest_dc);
	delete buffer;
#endif
}

/* Here we create a structure so that every client has its own pointer */

typedef struct ClientData {
  rfbBool oldButton;
  int oldx,oldy;
} ClientData;

static void clientgone(rfbClientPtr cl)
{
  free(cl->clientData);
  cl->clientData = NULL;
}

static enum rfbNewClientAction newclient(rfbClientPtr cl)
{
  cl->clientData = (void*)calloc(sizeof(ClientData),1);
  cl->clientGoneHook = clientgone;
  return RFB_CLIENT_ACCEPT;
}

// switch to new framebuffer contents
static void newframebuffer(rfbScreenInfoPtr screen, int width, int height)
{
  char *oldfb, *newfb;
  oldfb = (char*)screen->frameBuffer;
  newfb = (char*)malloc(width * height * bpp);
  rfbNewFramebuffer(screen, (char*)newfb, width, height, 8, 3, bpp);
  free(oldfb);
}


// Here the mouse events are handled
/////////////////////////////////////////////////////////////
static void doptr(int buttonMask,int x,int y,rfbClientPtr cl)
{
   ClientData* cd = (ClientData*)cl->clientData;

   if(x>=0 && y>=0 && x < cl->screen->width && y < cl->screen->height) {
      if(buttonMask) {
	 int i,j,x1,x2,y1,y2;

	 if(cd->oldButton==buttonMask) { /* draw a line */
	    //drawline((unsigned char*)cl->screen->frameBuffer,cl->screen->paddedWidthInBytes,bpp,x,y,cd->oldx,cd->oldy);
	    x1=x; y1=y;
	    if(x1>cd->oldx) x1++; else cd->oldx++;
	    if(y1>cd->oldy) y1++; else cd->oldy++;
	    rfbMarkRectAsModified(cl->screen,x,y,cd->oldx,cd->oldy);
	 } else { /* draw a point (diameter depends on button) */
	    int w=cl->screen->paddedWidthInBytes;
	    x1=x-buttonMask; if(x1<0) x1=0;
	    x2=x+buttonMask; if(x2>cl->screen->width) x2=cl->screen->width;
	    y1=y-buttonMask; if(y1<0) y1=0;
	    y2=y+buttonMask; if(y2>cl->screen->height) y2=cl->screen->height;

	    for(i=x1*bpp;i<x2*bpp;i++)
	      for(j=y1;j<y2;j++)
		cl->screen->frameBuffer[j*w+i]=(char)0xff;
	    rfbMarkRectAsModified(cl->screen,x1,y1,x2,y2);
	 }

      } else{
	cd->oldButton=0;
      }

      cd->oldx=x; cd->oldy=y; cd->oldButton=buttonMask;
   }
   rfbDefaultPtrAddEvent(buttonMask,x,y,cl);
}


// Here the key events are handled
/////////////////////////////////////////////////////////////
static void dokey(rfbBool down,rfbKeySym key,rfbClientPtr cl)
{
  if(down) {
    if(key==XK_Escape)
      rfbCloseClient(cl);
    else if(key==XK_F12)
      rfbShutdownServer(cl->screen,TRUE); // close down server, disconnecting clients
    else if(key==XK_F11)
      rfbShutdownServer(cl->screen,FALSE); //close down server, but wait for all clients to disconnect
    else if(key==XK_Page_Up) {
      rfbMarkRectAsModified(cl->screen,0,0,cl->screen->width,cl->screen->height);
    } else if (key == XK_Up) {
      if (cl->screen->width < 1024) {
        if (cl->screen->width < 800) {
          //newframebuffer(cl->screen, 800, 600);
        } else {
          //ewframebuffer(cl->screen, 1024, 768);
        }
      }
    } else if(key==XK_Down) {
      if (cl->screen->width > 640) {
        if (cl->screen->width > 800) {
          //newframebuffer(cl->screen, 800, 600);
        } else {
          //newframebuffer(cl->screen, 640, 480);
        }
      }
    } 
      /*
      else if(key>=' ' && key<0x100) {
      ClientData* cd=cl->clientData;
      int x1=cd->oldx,y1=cd->oldy,x2,y2;
      cd->oldx+=rfbDrawCharWithClip(cl->screen,&radonFont,cd->oldx,cd->oldy,(char)key,0,0,cl->screen->width,cl->screen->height,0x00ffffff,0x00ffffff);
      rfbFontBBox(&radonFont,(char)key,&x1,&y1,&x2,&y2);
      rfbMarkRectAsModified(cl->screen,x1,y1,x2-1,y2-1);
    }
    */
  }
}

////////////////////////
void DKVncServer::Init()
{
#ifdef LINUX
    disp = XOpenDisplay(NULL);
    root = DefaultRootWindow(disp);
    XMapWindow(disp, root);
#endif

    // Get width and height of the display
    int windowWidth = 800;//XDisplayWidth(disp, 0);
    int windowHeight = 600;//XDisplayHeight (disp, 0);
    
  rfbScreen = rfbGetScreen(&DKApp::argc,DKApp::argv,windowWidth,windowHeight,8,3,bpp);
  if(!rfbScreen){
    return;
  }
  rfbScreen->desktopName = "DKVncServer";
  rfbScreen->frameBuffer = (char*)malloc(windowHeight*windowWidth*bpp);
  rfbScreen->alwaysShared = TRUE;
  rfbScreen->ptrAddEvent = doptr;
  rfbScreen->kbdAddEvent = dokey;
  rfbScreen->newClientHook = newclient;
  rfbScreen->httpDir = (char*)DKFile::local_assets.c_str(); //+"DKVncServer";
  rfbScreen->httpEnableProxyConnect = TRUE;
  
  //initBuffer(rfbScreen->frameBuffer, windowWidth, windowHeight);
  rfbDrawString(rfbScreen,&radonFont,10,10,"DKVncServer",0xffffff);
  
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
	rfbProcessEvents(rfbScreen,100000);
	DrawBuffer();
}