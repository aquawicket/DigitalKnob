#include "assets.h"
#include "DK/DKApp.h"

int main(int argc, char **argv)
{
	DKApp dkapp(argc, argv);
	DKApp::Init();
	DKApp::Loop();
}
