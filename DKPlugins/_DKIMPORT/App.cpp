/*
#ifdef HAVE_DK
#include "DK/stdafx.h"
#include "assets.h"
#include "App.h"

////////////////
// For Doxygen purporses, this is a test.
////////////////
bool App::Init()
{
	DKINFO("App::Init()\n");
	return true;
}

#endif //HAVE_DK
*/

#include "DK/stdafx.h"
#include "DK/DKApp.h"
#include "assets.h"

int main(int argc, char **argv)
{
	DKApp dkapp(argc, argv);
	DKApp::Init();
	DKApp::Loop();
	return 0;
}