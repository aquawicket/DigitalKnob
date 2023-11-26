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
#pragma once
#ifndef DKOSGWindow_H
#define DKOSGWindow_H

//WARNING_DISABLE
	#if WIN
		#include <osgViewer/api/Win32/GraphicsHandleWin32>
	#endif
	#if IOS
		#include <osgViewer/api/IOS/GraphicsWindowIOS>
	#endif
	#include <osgViewer/CompositeViewer>
	#include <osgViewer/Viewer>
	#include <osgViewer/ViewerEventHandlers>
	#include <osg/PositionAttitudeTransform>
	#include <osgGA/EventQueue>
	#include <osgDB/ReadFile>
//WARNING_ENABLE

#include "DK/DK.h"
#include "DK/DKLog.h"
#include "DK/DKString.h"
#include "DK/DKApp.h"
#include "DKOSGViewer/DKOSGViewer.h"


class DKOSGWindow : public osgGA::GUIEventHandler, public DKObjectT<DKOSGWindow>
{
public:
	bool Init();
	//bool End();
	
	bool TestInt(const void* input, void* output);
	bool TestString(const void* input, void* output);
	bool TestReturnInt(const void* input, void* output);
	bool TestReturnString(const void* input, void* output);

	//Functions registered to function table
	bool GetX(const void* input, void* output);
	bool GetY(const void* input, void* output);
	bool SetX(const void* input, void* output);
	bool SetY(const void* input, void* output);
	bool GetWidth(const void* input, void* output);
	bool GetHeight(const void* input, void* output);
	bool SetWidth(const void* input, void* output);
	bool SetHeight(const void* input, void* output);
	bool GetScreenWidth(const void* input, void* output);
	bool GetScreenHeight(const void* input, void* output);
	bool GetMouseX(const void* input, void* output);
	bool GetMouseY(const void* input, void* output);
	bool GetHwnd(const void* input, void* output);

	DKOSGViewer* dkOsgViewer;
	osg::ref_ptr<osg::GraphicsContext> gc;
	osg::ref_ptr<osg::GraphicsContext::Traits> traits;
	osg::ref_ptr<osg::Group> root;
	osg::ref_ptr<osgViewer::Viewer> view;
	osg::ref_ptr<osg::Group> world;
	bool SetTitle(const DKString& title);
	bool CreateWin(const DKString& title, const int& x, const int& y, const int& w, const int& h);
	bool handle(const osgGA::GUIEventAdapter& ea);
	double resizeTime;
	unsigned int glVersionMajor;
	unsigned int glVersionMinor;

	static std::map<int,int> osgKeyCode;
	static std::map<int,int> osgCharCode;
	static std::map<int,int> osgShiftCharCode;
	static std::map<int,int> osgMouse;
	void MapInputs();

	DKString mTitle;
	int winX;
	int winY;
	int width;
	int height;

#if WIN
	bool SetHwnd();
	HWND hwnd;
#endif
	
private:
	//bool CreatePIP(const int& x, const int& y, const int& w, const int& h, DKOSGWindow* parent);
	int lastMouseX;
	int lastMouseY;
	virtual bool handle(const osgGA::GUIEventAdapter& ea,osgGA::GUIActionAdapter&);
	bool CreateView();
	bool SetIcon(const DKString& file);
	int getNumScreens();
	osg::ref_ptr<osg::GraphicsContext::WindowingSystemInterface> wsi;
};

REGISTER_OBJECT(DKOSGWindow, true)
#endif //DKOSGWindow_H
