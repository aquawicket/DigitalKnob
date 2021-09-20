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
    char buf = 0;
    struct termios old = {0};
    fflush(stdout);
    if(tcgetattr(0, &old) < 0)
        perror("tcsetattr()");
    old.c_lflag &= ~ICANON;
    old.c_lflag &= ~ECHO;
    old.c_cc[VMIN] = 1;
    old.c_cc[VTIME] = 0;
    if(tcsetattr(0, TCSANOW, &old) < 0)
        perror("tcsetattr ICANON");
    if(read(0, &buf, 1) < 0)
        perror("read()");
    old.c_lflag |= ICANON;
    old.c_lflag |= ECHO;
    if(tcsetattr(0, TCSADRAIN, &old) < 0)
        perror("tcsetattr ~ICANON");
    return buf;
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