#include "DK/DKApp.h"
#include "assets.h"

int main(int argc, char **argv)
{
	DKApp dkapp(argc, argv);
	DKApp::Init();
	DKApp::Loop();
}
