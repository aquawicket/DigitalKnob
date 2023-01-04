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
* The above copyright noticeand this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/
#include "DK/stdafx.h"
#include "DKSDLOsg/DKSDLOsg.h"

//WARNING_DISABLE
//#include "???.h"
//WARNING_ENABLE


bool DKSDLOsg::Init(){
	DKDEBUGFUNC();
	
	 // init SDL
    if(SDL_Init(SDL_INIT_VIDEO) < 0 )
        return DKERROR("Unable to init SDL \n");
	
	SDL_GL_SetAttribute( SDL_GL_RED_SIZE, 5 );
    SDL_GL_SetAttribute( SDL_GL_GREEN_SIZE, 5 );
    SDL_GL_SetAttribute( SDL_GL_BLUE_SIZE, 5 );
    SDL_GL_SetAttribute( SDL_GL_DEPTH_SIZE, 16 );
    SDL_GL_SetAttribute( SDL_GL_DOUBLEBUFFER, 1 );
	SDL_GL_SetAttribute(SDL_GL_CONTEXT_EGL, 1);
	SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 2);
    SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 0);
	SDL_GL_SetAttribute(SDL_GL_CONTEXT_EGL, 1);
	
	SDL_Window* window = SDL_CreateWindow("ContextWindow", 0, 0, 800, 600, SDL_WINDOW_OPENGL );//| SDL_WINDOW_FULLSCREEN
	// Create an OpenGL context associated with the window.
	SDL_GLContext glcontext = SDL_GL_CreateContext(window);
	
	// load the scene.
    osg::ref_ptr<osg::Node> loadedModel = createScene();//osgDB::readNodeFile(argv[1]);
	
	if (!loadedModel)
		return DKERROR("loadedModel invalid! \n");

	// Starting with SDL 1.2.10, passing in 0 will use the system's current resolution.
    unsigned int windowWidth = 0;
    unsigned int windowHeight = 0;

    // Passing in 0 for bitdepth also uses the system's current bitdepth. This works before 1.2.10 too.
    unsigned int bitDepth = 0;
	
	// set up the surface to render to
    SDL_Surface* screen = SDL_GetWindowSurface(window);
    if ( screen == NULL )
		return DKERROR("screen invalid! \n");

    // If we used 0 to set the fields, query the values so we can pass it to osgViewer
    windowWidth = screen->w;
    windowHeight = screen->h;
    
    osgViewer::Viewer viewer;
    gw = viewer.setUpViewerAsEmbeddedInWindow(0, 0, windowWidth, windowHeight);
    viewer.setSceneData(loadedModel.get());
    viewer.setCameraManipulator(new osgGA::TrackballManipulator);
    viewer.addEventHandler(new osgViewer::StatsHandler);
    viewer.realize();
	
	DKApp::AppendLoopFunc(&DKSDLOsg::Process, this);
	
	return true;
}

bool DKSDLOsg::End(){
	DKDEBUGFUNC();
	return true;
}

osg::Node* DKSDLOsg::createScene(){
    // create drawable geometry object
    osg::Geometry* pGeo = new osg::Geometry;
 
    // add 3 vertices creating a triangle
    osg::Vec3Array* pVerts = new osg::Vec3Array;
    pVerts->push_back( osg::Vec3( -1, 0, -1 ) );
    pVerts->push_back( osg::Vec3( 1, 0, -1 ) );
    pVerts->push_back( osg::Vec3( 0, 0, 1 ) );
    pGeo->setVertexArray( pVerts );
 
    // create a primitive set (add index numbers)
    osg::DrawElementsUInt* pPrimitiveSet =
        new osg::DrawElementsUInt( osg::PrimitiveSet::TRIANGLES, 0 );
    pPrimitiveSet->push_back( 2 );
    pPrimitiveSet->push_back( 1 );
    pPrimitiveSet->push_back( 0 );
    pGeo->addPrimitiveSet( pPrimitiveSet );
 
    // create color array data (each corner of our triangle will have one color component)
    osg::Vec4Array* pColors = new osg::Vec4Array;
    pColors->push_back( osg::Vec4( 1.0f, 0.0f, 0.0f, 1.0f ) );
    pColors->push_back( osg::Vec4( 0.0f, 1.0f, 0.0f, 1.0f ) );
    pColors->push_back( osg::Vec4( 0.0f, 0.0f, 1.0f, 1.0f ) );
    pGeo->setColorArray( pColors );
 
    // make sure that our geometry is using one color per vertex
    pGeo->setColorBinding( osg::Geometry::BIND_PER_VERTEX );
 
    // create geometry node that will contain all our drawables
    osg::Geode* pGeode = new osg::Geode;
    osg::StateSet* pStateSet = pGeode->getOrCreateStateSet();
    pStateSet->setMode( GL_LIGHTING, osg::StateAttribute::OFF );
    pGeode->addDrawable( pGeo );
 
    return pGeode;
}

void DKSDLOsg::Process(){
	SDL_Event event;
	while(SDL_PollEvent(&event)){
        // pass the SDL event into the viewers event queue
        convertEvent(event, *(gw->getEventQueue()));

        switch(event.type) {
			/* case SDL_VIDEORESIZE:
				SDL_SetVideoMode(event.resize.w, event.resize.h, bitDepth, SDL_OPENGL | SDL_RESIZABLE);
                gw->resized(0, 0, event.resize.w, event.resize.h );
                break;*/
            case SDL_KEYUP:
                if (event.key.keysym.sym==SDLK_ESCAPE) 
					done = true;
                /*if (event.key.keysym.sym=='f') 
                {
					SDL_WM_ToggleFullScreen(screen);
                    gw->resized(0, 0, screen->w, screen->h );
                }*/
                break;
            case SDL_QUIT:
                done = true;
        }
    }
	
    // draw the new frame
    viewer.frame();

    // Swap Buffers
	SDL_GL_SwapWindow(window);
}

bool DKSDLOsg::convertEvent(SDL_Event& event, osgGA::EventQueue& eventQueue){
    switch(event.type){
        case SDL_MOUSEMOTION:
            eventQueue.mouseMotion(event.motion.x, event.motion.y);
            return true;
        case SDL_MOUSEBUTTONDOWN:
            eventQueue.mouseButtonPress(event.button.x, event.button.y, event.button.button);
            return true;
        case SDL_MOUSEBUTTONUP:
            eventQueue.mouseButtonRelease(event.button.x, event.button.y, event.button.button);
            return true;
        case SDL_KEYUP:
            eventQueue.keyRelease( (osgGA::GUIEventAdapter::KeySymbol) event.key.keysym.unicode);
            return true;
        case SDL_KEYDOWN:
            eventQueue.keyPress( (osgGA::GUIEventAdapter::KeySymbol) event.key.keysym.unicode);
            return true;
        //case SDL_VIDEORESIZE:
        //    eventQueue.windowResize(0, 0, event.resize.w, event.resize.h );
            return true;
        default:
            break;
    }
    return false;
}
