#include "DK/stdafx.h"
#include "DKSFMLWindow/DKSFMLWindow.h"
#include <SFML/Graphics.hpp>

std::vector<boost::function<bool(sf::Event& e)> > DKSFMLWindow::event_funcs;
std::vector<boost::function<void()> > DKSFMLWindow::draw_funcs;


////////////////////////
bool DKSFMLWindow::Init()
{
	DKLog("DKSFMLWindow::Init()\n", DKINFO);

	window.create(sf::VideoMode(800, 600), "My window");

	DKApp::AppendLoopFunc(&DKSFMLWindow::Process, this);
	DKSFMLWindow::AddEventFunc(&DKSFMLWindow::handle, this);

	return true;
}

////////////////////////
bool DKSFMLWindow::End()
{
	window.close();
	return true;
}

////////////////////////////
void DKSFMLWindow::Process()
{
	sf::Event e;
	while(window.pollEvent(e)){
		for(unsigned int i = 0; i < event_funcs.size(); ++i){
			if(event_funcs[i](e)){ //Call event functions
				i = event_funcs.size();	//eat the event
			}; 
		}
	}

	// Activate the window for OpenGL rendering
	window.setActive();

	// OpenGL drawing commands go here...

	// End the current frame and display its contents on screen
	window.display();
}

///////////////////////////////////////
bool DKSFMLWindow::handle(sf::Event& e)
{
	if(e.type == sf::Event::Closed){
		DKApp::Exit();
		return false; //allow event to continue
	}
	return false; //allow event to continue
}
