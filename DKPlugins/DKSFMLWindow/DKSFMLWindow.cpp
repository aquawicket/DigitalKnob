#include "DK/stdafx.h"
#include "DKSFMLWindow/DKSFMLWindow.h"

//std::vector<boost::function<bool(SFML_Event *event)> > DKSFMLWindow::event_funcs;
std::vector<boost::function<void()> > DKSFMLWindow::draw_funcs;


////////////////////////
bool DKSFMLWindow::Init()
{
	DKLog("DKSFMLWindow::Init()\n", DKINFO);

	DKApp::AppendLoopFunc(&DKSFMLWindow::Process, this);
	//DKSFMLWindow::AddEventFunc(&DKSFMLWindow::handle, this);

	return true;
}

////////////////////////
bool DKSFMLWindow::End()
{
	return true;
}

////////////////////////////
void DKSFMLWindow::Process()
{

}

/*
////////////////////////////////////////////
bool DKSFMLWindow::handle(SFML_Event *event)
{

}
*/

