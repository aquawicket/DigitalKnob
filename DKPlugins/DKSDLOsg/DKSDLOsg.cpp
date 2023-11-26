/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/
#include "DK/stdafx.h"
#include "DKSDLOsg/DKSDLOsg.h"
#include "DKSDLWindow/DKSDLWindow.h"


bool DKSDLOsg::Init(){
	DKDEBUGFUNC();
	
	 // init SDL
    /*
    if(SDL_Init(SDL_INIT_VIDEO) < 0)
        return DKERROR("Unable to init SDL \n");
	
	SDL_GL_SetAttribute(SDL_GL_RED_SIZE, 5);
    SDL_GL_SetAttribute(SDL_GL_GREEN_SIZE, 5);
    SDL_GL_SetAttribute(SDL_GL_BLUE_SIZE, 5);
    SDL_GL_SetAttribute(SDL_GL_DEPTH_SIZE, 16);
    SDL_GL_SetAttribute(SDL_GL_DOUBLEBUFFER, 1);
	SDL_GL_SetAttribute(SDL_GL_CONTEXT_EGL, 1);
	SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 2);
    SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 0);
	SDL_GL_SetAttribute(SDL_GL_CONTEXT_EGL, 1);
	
	sdl_window = SDL_CreateWindow("DKSDLOsg", 0, 0, 800, 600, SDL_WINDOW_OPENGL);
    */
    DKClass::DKCreate("DKSDLWindow");
    sdl_window = DKSDLWindow::Get()->window;
	
	// Create an OpenGL context associated with the window.
	SDL_GLContext glcontext = SDL_GL_CreateContext(sdl_window);
	
	// load the scene.
    osg::ref_ptr<osg::Node> loadedModel = createScene();//osgDB::readNodeFile(argv[1]);
	if (!loadedModel)
		return DKERROR("loadedModel invalid! \n");
	
	// set up the surface to render to
    SDL_Surface* screen = SDL_GetWindowSurface(sdl_window);
    if(screen == NULL)
		return DKERROR("screen invalid! \n");
    
    osg_graphicsWindow = osg_viewer.setUpViewerAsEmbeddedInWindow(0, 0, screen->w, screen->h);
    osg_viewer.setSceneData(loadedModel.get());
    osg_viewer.setCameraManipulator(new osgGA::TrackballManipulator);
    osg_viewer.addEventHandler(new osgViewer::StatsHandler);
    osg_viewer.realize();
	
    DKSDLWindow::AddEventFunc(&DKSDLOsg::OnEvent, this);
    DKSDLWindow::AddRenderFunc(&DKSDLOsg::OnRender, this);
    DKSDLWindow::AddUpdateFunc(&DKSDLOsg::OnUpdate, this);
	return true;
}

bool DKSDLOsg::End(){
	DKDEBUGFUNC();
	return true;
}

osg::Node* DKSDLOsg::createScene(){
    DKDEBUGFUNC();
    // create drawable geometry object
    osg::Geometry* pGeo = new osg::Geometry;
 
    // add 3 vertices creating a triangle
    osg::Vec3Array* pVerts = new osg::Vec3Array;
    pVerts->push_back(osg::Vec3(-1, 0, -1));
    pVerts->push_back(osg::Vec3(1, 0, -1));
    pVerts->push_back(osg::Vec3(0, 0, 1));
    pGeo->setVertexArray(pVerts);
 
    // create a primitive set (add index numbers)
    osg::DrawElementsUInt* pPrimitiveSet = new osg::DrawElementsUInt(osg::PrimitiveSet::TRIANGLES, 0);
    pPrimitiveSet->push_back(2);
    pPrimitiveSet->push_back(1);
    pPrimitiveSet->push_back(0);
    pGeo->addPrimitiveSet(pPrimitiveSet);
 
    // create color array data (each corner of our triangle will have one color component)
    osg::Vec4Array* pColors = new osg::Vec4Array;
    pColors->push_back(osg::Vec4(1.0f, 0.0f, 0.0f, 1.0f));
    pColors->push_back(osg::Vec4(0.0f, 1.0f, 0.0f, 1.0f));
    pColors->push_back(osg::Vec4(0.0f, 0.0f, 1.0f, 1.0f));
    pGeo->setColorArray(pColors);
 
    // make sure that our geometry is using one color per vertex
    pGeo->setColorBinding(osg::Geometry::BIND_PER_VERTEX);
 
    // create geometry node that will contain all our drawables
    osg::Geode* pGeode = new osg::Geode;
    osg::StateSet* pStateSet = pGeode->getOrCreateStateSet();
    pStateSet->setMode(GL_LIGHTING, osg::StateAttribute::OFF);
    pGeode->addDrawable(pGeo);
 
    return pGeode;
}

bool DKSDLOsg::OnEvent(SDL_Event* event) {
    switch (event->type) {
        case SDL_MOUSEMOTION:
            osg_graphicsWindow->getEventQueue()->mouseMotion(event->motion.x, event->motion.y);
            return true;
        case SDL_MOUSEBUTTONDOWN:
            osg_graphicsWindow->getEventQueue()->mouseButtonPress(event->button.x, event->button.y, event->button.button);
            return true;
        case SDL_MOUSEBUTTONUP:
            osg_graphicsWindow->getEventQueue()->mouseButtonRelease(event->button.x, event->button.y, event->button.button);
            return true;
        //case SDL_KEYUP:
        //    osg_graphicsWindow->getEventQueue()->keyRelease((osgGA::GUIEventAdapter::KeySymbol) event->key.keysym.unicode);
        //    return true;
        //case SDL_KEYDOWN:
        //    osg_graphicsWindow->getEventQueue()->keyPress((osgGA::GUIEventAdapter::KeySymbol) event->key.keysym.unicode);
        //    return true;
        //case SDL_VIDEORESIZE:
        //    osg_graphicsWindow->getEventQueue()->windowResize(0, 0, event.resize.w, event.resize.h);
        //    return true;
        default:
            break;
    }
    return false; //allow event to continue
}


bool DKSDLOsg::OnRender() {
	SDL_GL_SwapWindow(sdl_window);
    return true;
}

void DKSDLOsg::OnUpdate() {
    osg_viewer.frame(); // draw the new frame
}
