#include "stdafx.h"
#ifdef LINUX
#include "DKLinux.h"
#include <stdio.h>
#include <stdlib.h>
#include <X11/Xlib.h>

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
	//https://cboard.cprogramming.com/linux-programming/79686-linux-equivalent-win32-shellexecute.html
	//http://www.linuxquestions.org/questions/programming-9/is-there-something-like-shellexecute-in-linux-213725/
	
	/*
	// sh_cmd() - executes a command in the background
	// returns TRUE is command was executed  (not the result of the command though..)
	//NO GLOBALS
	static gint sh_cmd (gchar * path, gchar * cmd, gchar * args)
	{
		gchar     cmd_line[256];
		gchar   **argv;
		gint      argp;
		gint      rc = 0;

		if (cmd == NULL)
			return FALSE;

		if (cmd[0] == '\0')
			return FALSE;

		if (path != NULL)
			chdir (path);

		snprintf (cmd_line, sizeof (cmd_line), "%s %s", cmd, args);

		rc = g_shell_parse_argv (cmd_line, &argp, &argv, NULL);
		if(!rc){
			g_strfreev (argv);
			return rc;
		}

		rc = g_spawn_async (path, argv, NULL, G_SPAWN_STDOUT_TO_DEV_NULL | G_SPAWN_SEARCH_PATH, NULL, NULL, NULL, NULL);
		g_strfreev (argv);
		return rc;
	}
	*/

	return false;
}

#endif //LINUX