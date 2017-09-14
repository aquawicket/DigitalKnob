#include "DK/stdafx.h"
#ifdef LINUX
#include "DKLinux.h"
#include "DKLog.h"
#include <stdio.h>
#include <stdlib.h>
#include <X11/Xlib.h>
#include <X11/XKBlib.h>
#include <alsa/asoundlib.h>

/////////////////////////////////////////
bool DKLinux::GetMousePos(int& x, int& y)
{
	//Compile with:
    //cc -Wall -I/usr/X11R6/include -L/usr/X11R6/lib -lXm -o xquerypointer xquerypointer.c
	//or on solaris:
    //cc -I/usr/openwin/include xquerypointer.c -L/usr/openwin/lib -lX11
	
	Display *dpy;
	Window root;
	Window ret_root;
	Window ret_child;
	int root_x;
	int root_y;
	int win_x;
	int win_y;
	unsigned int mask;
 
	dpy = XOpenDisplay(NULL);
	root = XDefaultRootWindow(dpy);
 
	if(XQueryPointer(dpy, root, &ret_root, &ret_child, &root_x, &root_y, &win_x, &win_y, &mask)){
		// original version
		//    printf("root loc: %4d,%4d win loc: %3d,%3d mask: 0x%08X\n", root_x, root_y, win_x, win_y, mask);
		// This returns in -geometry format
		// I added \n so it actually shows something so people who test it know it works.
		x = root_x;
		y = root_y;
		return true;
	}
	
	x = 0;
	y = 0;
	return false;
}

//////////////////////////////////////////
bool DKLinux::Run(const DKString& command)
{
	DKString cmd = command;
	cmd = "xdg-open "+cmd+" &";
	system(cmd.c_str());
	//execl(cmd.c_str(), (char*)0);
	return true;
}

//////////////////////////////
bool DKLinux::KeyIsDown(int& key)
{
	//TODO - character keys
	DKLog("DKLinux::KeyIsDown("+toString(key)+")\n", DKDEBUG);
	
	XkbStateRec r;
    Display* d = XOpenDisplay(NULL);
    XkbGetState(d, XkbUseCoreKbd, &r);
    //printf("mod: 0x%x\n", r.mods);
	if((r.mods & 0x01) && key == 16){ //Shift
		return true;
	}
	if((r.mods & 0x04) && key == 17){ //Ctrl
		return true;
	}
	if((r.mods & 0x08) && key == 18){ //Alt
		return true;
	}
    XCloseDisplay(d);
	return false;
}

////////////////////////
bool DKLinux::GetClipboard(DKString& text)
{
	//TODO
	DKLog("DKLinux::GetClipboard()\n", DKINFO);
	DKClass::CallFunc("DKSDLWindow::GetClipboard", NULL, &text);
	return true;
}

///////////////////////
bool DKLinux::SetClipboard(DKString& text)
{
	//TODO
	DKLog("DKLinux::SetClipboard("+text+")\n", DKINFO);
	DKClass::CallFunc("DKSDLWindow::SetClipboard", &text, NULL);
	return false;
}

bool DKLinux::ChangeVolume(double nVolume)
{
	DKLog("DKLinux::ChangeVolume("+toString(nVolume)+")\n", DKINFO);
	long min, max;
	snd_mixer_t *handle;
	snd_mixer_selem_id_t *sid;
	const char *card = "default";
	const char *selem_name = "Master";

	snd_mixer_open(&handle, 0);
	snd_mixer_attach(handle, card);
	snd_mixer_selem_register(handle, NULL, NULL);
	snd_mixer_load(handle);

	snd_mixer_selem_id_alloca(&sid);
	snd_mixer_selem_id_set_index(sid, 0);
	snd_mixer_selem_id_set_name(sid, selem_name);
	snd_mixer_elem_t* elem = snd_mixer_find_selem(handle, sid);

	snd_mixer_selem_get_playback_volume_range(elem, &min, &max);
	snd_mixer_selem_set_playback_volume_all(elem, nVolume/* * max / 100*/);

	snd_mixer_close(handle);
	return true;
}

bool DKLinux::GetVolume(float& volume)
{
	//DKLog("DKLinux::GetVolume()\n", DKINFO);
	long min, max;
	snd_mixer_t *handle;
	snd_mixer_selem_id_t *sid;
	const char *card = "default";
	const char *selem_name = "Master";

	snd_mixer_open(&handle, 0);
	snd_mixer_attach(handle, card);
	snd_mixer_selem_register(handle, NULL, NULL);
	snd_mixer_load(handle);

	snd_mixer_selem_id_alloca(&sid);
	snd_mixer_selem_id_set_index(sid, 0);
	snd_mixer_selem_id_set_name(sid, selem_name);
	snd_mixer_elem_t* elem = snd_mixer_find_selem(handle, sid);

	snd_mixer_selem_get_playback_volume_range(elem, &min, &max);
	DKLog("DKLinux::GetVolume(): min="+toString(min)+" max="+toString(max)+"\n", DKINFO);
	long int vol;
	snd_mixer_selem_get_playback_volume(elem, SND_MIXER_SCHN_FRONT_LEFT, &vol);
	volume = vol;

	DKLog("DKLinux::GetVolume(): returned "+toString(volume)+"\n", DKINFO);
	snd_mixer_close(handle);
	return true;
}


#endif //LINUX