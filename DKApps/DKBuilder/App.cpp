//#ifdef USE_DK
#include "DK/stdafx.h"
#include "assets.h"
#include "App.h"

#ifdef WIN32
#include "conio.h"
#endif
////////////////
// For Doxygen purporses, this is a test.
////////////////

#ifdef LINUX
#include <unistd.h> //for getch()
#include <termios.h> //for getch()
int getch(){
    char buf[5];
    struct termios old = {0};
    fflush(stdout);
    if(tcgetattr(0, &old) < 0)
        return DKERROR("tcsetattr() failed");
    old.c_lflag &= ~ICANON;
    old.c_lflag &= ~ECHO;
    old.c_cc[VMIN] = 1;
    old.c_cc[VTIME] = 0;
    if(tcsetattr(0, TCSANOW, &old) < 0)
        return DKERROR("tcsetattr() ICANON failed");
    if(read(0, &buf, sizeof(buf)) < 0)
        return DKERROR("read() failed");
    old.c_lflag |= ICANON;
    old.c_lflag |= ECHO;
    if(tcsetattr(0, TCSADRAIN, &old) < 0)
        return DKERROR("tcsetattr() ~ICANON failed");
	if(!buf[0])
		return DKERROR("buf invalid");
    int i=0;
    while(i < sizeof(buf) && buf[i])
        i++;
    if(!buf[i-1])
		return DKERROR("buf invalid");
    return buf[i-1];
}
#endif


bool App::Init()
{
	DKINFO("App::Init()\n");
	
    int i = 5;
    while(i){
	    int key = getch();
	    if(key == 0)
	    	key = getch();
	    DKINFO("key = "+toString(key)+"\n");
        i--;
    }
	
	return true;
}

//#endif //USE_DK