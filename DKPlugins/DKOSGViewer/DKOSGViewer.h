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
#ifndef DKOSGViewer_H
#define DKOSGViewer_H
#include "DK/DK.h"

//WARNING_DISABLE
#include <osgViewer/CompositeViewer>
//WARNING_ENABLE

##if DKAPP
	//WARNING_DISABLE
	#if HAVE_osgDB
	#include <osgDB/Registry>
	#include <osgWidget/Util>
	#endif
	//WARNING_ENABLE

	// osgWrappers
	#if HAVE_osgdb_deprecated_osg
		USE_DOTOSGWRAPPER_LIBRARY(osg)
	#endif
	#if HAVE_osgdb_deprecated_osganimation
		USE_DOTOSGWRAPPER_LIBRARY(osgAnimation)
	#endif
	#if HAVE_osgdb_deprecated_osgfx
		USE_DOTOSGWRAPPER_LIBRARY(osgFX)
	#endif
	#if HAVE_osgdb_deprecated_osgparticle
		USE_DOTOSGWRAPPER_LIBRARY(osgParticle)
	#endif
	#if HAVE_osgdb_deprecated_osgshadow
		USE_DOTOSGWRAPPER_LIBRARY(osgShadow)
	#endif
	#if HAVE_osgdb_deprecated_osgsim
		USE_DOTOSGWRAPPER_LIBRARY(osgSim)
	#endif
	#if HAVE_osgdb_deprecated_osgterrain
		USE_DOTOSGWRAPPER_LIBRARY(osgTerrain)
	#endif
	#if HAVE_osgdb_deprecated_osgtext
		USE_DOTOSGWRAPPER_LIBRARY(osgText)
	#endif
	#if HAVE_osgdb_deprecated_osgviewer
		USE_DOTOSGWRAPPER_LIBRARY(osgViewer)
	#endif
	#if HAVE_osgdb_deprecated_osgvolume
		USE_DOTOSGWRAPPER_LIBRARY(osgVolume)
	#endif
	#if HAVE_osgdb_deprecated_osgwidget
		USE_DOTOSGWRAPPER_LIBRARY(osgWidget)
	#endif
	
	#if HAVE_osgdb_serializers_osg
		USE_SERIALIZER_WRAPPER_LIBRARY(osg)
	#endif
	#if HAVE_osgdb_serializers_osganimation
		USE_SERIALIZER_WRAPPER_LIBRARY(osgAnimation)
	#endif
	#if HAVE_osgdb_serializers_osgfx
		USE_SERIALIZER_WRAPPER_LIBRARY(osgFX)
	#endif
	#if HAVE_osgdb_serializers_osgga
		USE_SERIALIZER_WRAPPER_LIBRARY(osgGA)
	#endif
	#if HAVE_osgdb_serializers_osgmanipulator
		USE_SERIALIZER_WRAPPER_LIBRARY(osgManipulator)
	#endif
	#if HAVE_osgdb_serializers_osgparticle
		USE_SERIALIZER_WRAPPER_LIBRARY(osgParticle)
	#endif
	#if HAVE_osgdb_serializers_osgpresentation
		USE_SERIALIZER_WRAPPER_LIBRARY(osgPresentation)
	#endif
	#if HAVE_osgdb_serializers_osgshadow
		USE_SERIALIZER_WRAPPER_LIBRARY(osgShadow)
	#endif
	#if HAVE_osgdb_serializers_osgterrain
		USE_SERIALIZER_WRAPPER_LIBRARY(osgTerrain)
	#endif 
	#if HAVE_osgdb_serializers_osgtext
		USE_SERIALIZER_WRAPPER_LIBRARY(osgText)
	#endif
	#if HAVE_osgdb_serializers_osgviewer
		USE_SERIALIZER_WRAPPER_LIBRARY(osgviewer)
	#endif
	#if HAVE_osgdb_serializers_osgvolume
		USE_SERIALIZER_WRAPPER_LIBRARY(osgVolume)
	#endif
	
	// osgPlugins
	#if HAVE_osgdb_osg
		USE_OSGPLUGIN(osg)
		USE_OSGPLUGIN(osg2)
	#endif
	#if HAVE_osgdb_3dc
		USE_OSGPLUGIN(3dc)
	#endif
	#if HAVE_osgdb_3ds
		USE_OSGPLUGIN(3ds)
	#endif
	#if HAVE_osgdb_ac
		USE_OSGPLUGIN(ac)
	#endif
	#if HAVE_osgdb_bmp
		USE_OSGPLUGIN(bmp)
	#endif
	#if HAVE_osgdb_bsp
		USE_OSGPLUGIN(bsp)
	#endif
	#if HAVE_osgdb_bvh
		USE_OSGPLUGIN(bvh)
	#endif
	#if HAVE_osgdb_cfg
		USE_OSGPLUGIN(cfg)
	#endif
	#if HAVE_osgdb_curl
		USE_OSGPLUGIN(curl)
	#endif
	#if HAVE_osgdb_dds
		USE_OSGPLUGIN(dds)
	#endif
	#if HAVE_osgdb_dot
		USE_OSGPLUGIN(dot)
	#endif
	#if HAVE_osgdb_dw
		USE_OSGPLUGIN(dw)
	#endif
	#if HAVE_osgdb_dxf
		USE_OSGPLUGIN(dxf)
	#endif
	#if HAVE_osgdb_ffmpeg
		#ifndef ANDROID
			#include "DKOSGVideo.h"
			DKVIDEO_LOAD_DLLS()
			USE_OSGPLUGIN(ffmpeg)
		#endif
	#endif
	#if HAVE_osgdb_freetype
		USE_OSGPLUGIN(freetype)
	#endif
	#if HAVE_osgdb_gif
		USE_OSGPLUGIN(gif)
	#endif
	#if HAVE_osgdb_glsl
		USE_OSGPLUGIN(glsl)
	#endif
	#if HAVE_osgdb_gz
		USE_OSGPLUGIN(gz)
	#endif
	#if HAVE_osgdb_hdr
		USE_OSGPLUGIN(hdr)
	#endif
	#if HAVE_osgdb_imageio
		USE_OSGPLUGIN(imageio)
	#endif
	#if HAVE_osgdb_ive
		USE_OSGPLUGIN(ive)
	#endif
	#if HAVE_osgdb_jpeg
		USE_OSGPLUGIN(jpeg)
	#endif
	#if HAVE_osgdb_ktx
		USE_OSGPLUGIN(ktx)
	#endif
	#if HAVE_osgdb_logo
		USE_OSGPLUGIN(logo)
	#endif
	#if HAVE_osgdb_lwo
		USE_OSGPLUGIN(lwo)
	#endif
	#if HAVE_osgdb_lws
		USE_OSGPLUGIN(lws)
	#endif
	#if HAVE_osgdb_md2
		USE_OSGPLUGIN(md2)
	#endif
	#if HAVE_osgdb_mdl
		USE_OSGPLUGIN(mdl)
	#endif
	#if HAVE_osgdb_normals
		USE_OSGPLUGIN(normals)
	#endif
	#if HAVE_osgdb_obj
		USE_OSGPLUGIN(obj)
	#endif
	#if HAVE_osgdb_openflight
		USE_OSGPLUGIN(OpenFlight)
	#endif
	#if HAVE_osgdb_osc
		USE_OSGPLUGIN(osc)
	#endif
	#if HAVE_osgdb_osga
		USE_OSGPLUGIN(osga)
	#endif
	#if HAVE_osgdb_osgshadow
		USE_OSGPLUGIN(osgShadow)
	#endif
	#if HAVE_osgdb_osgterrain
		USE_OSGPLUGIN(terrain)
	#endif
	#if HAVE_osgdb_osgtgz
		USE_OSGPLUGIN(osgtgz)
	#endif
	#if HAVE_osgdb_osgviewer
		USE_OSGPLUGIN(osgViewer)
	#endif
	#if HAVE_osgdb_p3d
		USE_OSGPLUGIN(p3d)
	#endif
	#if HAVE_osgdb_pic
		USE_OSGPLUGIN(pic)
	#endif
	#if HAVE_osgdb_ply
		USE_OSGPLUGIN(ply)
	#endif
	#if HAVE_osgdb_png
		USE_OSGPLUGIN(png)
	#endif
	#if HAVE_osgdb_pnm
		USE_OSGPLUGIN(pnm)
	#endif
	#if HAVE_osgdb_pov
		USE_OSGPLUGIN(Povray)
	#endif
	#if HAVE_osgdb_pvr
		USE_OSGPLUGIN(pvr)
	#endif
	#if HAVE_osgdb_python
		USE_OSGPLUGIN(python)
	#endif
	#if HAVE_osgdb_revisions
		USE_OSGPLUGIN(revisions)
	#endif
	#if HAVE_osgdb_rgb
		USE_OSGPLUGIN(rgb)
	#endif
	#if HAVE_osgdb_rot
		USE_OSGPLUGIN(rot)
	#endif
	#if HAVE_osgdb_scale
		USE_OSGPLUGIN(scale)
	#endif
	#if HAVE_osgdb_shp
		USE_OSGPLUGIN(shp)
	#endif
	#if HAVE_osgdb_stl
		USE_OSGPLUGIN(stl)
	#endif
	#if HAVE_osgdb_tga
		USE_OSGPLUGIN(tga)
	#endif
	#if HAVE_osgdb_tgz
		USE_OSGPLUGIN(tgz)
	#endif
	#if HAVE_osgdb_tiff
		USE_OSGPLUGIN(tiff)
	#endif
	#if HAVE_osgdb_trans
		USE_OSGPLUGIN(trans)
	#endif
	#if HAVE_osgdb_trk
		USE_OSGPLUGIN(trk)
	#endif
	#if HAVE_osgdb_txf
		USE_OSGPLUGIN(txf)
	#endif
	#if HAVE_osgdb_txp
		USE_OSGPLUGIN(txp)
	#endif
	#if HAVE_osgdb_vtf
		USE_OSGPLUGIN(vtf)
	#endif
	#if HAVE_osgdb_x
		USE_OSGPLUGIN(x)
	#endif
	#if HAVE_osgdb_zeroconf
		USE_OSGPLUGIN(zeroconf)
	#endif
	#if HAVE_osgdb_zip
		USE_OSGPLUGIN(zip)
	#endif

	#if HAVE_osgViewer
		#if WIN
			USE_GRAPHICSWINDOW()
		#endif
		#if MAC
			USE_GRAPICSWINDOW_IMPLEMENTATION(Cocoa)
		#endif
		#if IOS
			USE_GRAPICSWINDOW_IMPLEMENTATION(IOS)
		#endif
		#if LINUX
			USE_GRAPICSWINDOW_IMPLEMENTATION(X11)
		#endif
	#endif //HAVE_osgViewer
#endif //DKAPP


class DKOSGViewer : public DKObjectT<DKOSGViewer>
{
public:
	bool Init();
	bool End();

	bool Realize();
	void DoFrame();
	osg::ref_ptr<osgViewer::CompositeViewer> viewer;
	static bool AppendDataPath(const DKString& datapath);
};
REGISTER_OBJECT(DKOSGViewer, true);


#endif //DKOSGViewer_H
