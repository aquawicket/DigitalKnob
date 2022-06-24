#pragma once
#ifndef DKOSGWindow_H
#define DKOSGWindow_H

#include "DK/DK.h"
#include "DK/DKLog.h"
#include "DK/DKString.h"
#include "DK/DKApp.h"
#include "DKOSGViewer.h" //FIXME

#ifdef WIN32
#include <osgViewer/api/Win32/GraphicsHandleWin32>
#endif
#ifdef IOS
#include <osgViewer/api/IOS/GraphicsWindowIOS>
#endif

#include <osgViewer/CompositeViewer>
#include <osgViewer/Viewer>
#include <osgViewer/ViewerEventHandlers>
#include <osg/PositionAttitudeTransform>
#include <osgGA/EventQueue>

class DKOSGWindow : public osgGA::GUIEventHandler, public DKObjectT<DKOSGWindow>
{
public:
	bool Init();
	bool End(){}

	//Functions registered to function table
	void* GetX(void*);
	void* GetY(void*);
	void* SetX(void* x);
	void* SetY(void* y);
	void* GetWidth(void*);
	void* GetHeight(void*);
	void* SetWidth(void* width);
	void* SetHeight(void* height);
	void* GetScreenWidth(void*);
	void* GetScreenHeight(void*);
	void* GetMouseX(void*);
	void* GetMouseY(void*);
	void* GetHwnd(void*);

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
	unsigned int width;
	unsigned int height;

#ifdef WIN32
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
