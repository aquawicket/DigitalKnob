#pragma once
#ifndef DKOSGViewer_H
#define DKOSGViewer_H
#include "DK/DK.h"
#include <osgViewer/CompositeViewer>

#if !defined(DKLIB)

#ifdef USE_osgDB
#include <osgDB/Registry>
#include <osgWidget/Util>
#endif

#ifdef USE_osgdb_osg
    USE_OSGPLUGIN(osg)
	USE_OSGPLUGIN(osg2)
#endif
#ifdef USE_osgdb_3dc
    USE_OSGPLUGIN(3dc)
#endif
#ifdef USE_osgdb_3ds
    USE_OSGPLUGIN(3ds)
#endif
#ifdef USE_osgdb_ac
    USE_OSGPLUGIN(ac)
#endif
#ifdef USE_osgdb_bmp
    USE_OSGPLUGIN(bmp)
#endif
#ifdef USE_osgdb_bsp
    USE_OSGPLUGIN(bsp)
#endif
#ifdef USE_osgdb_bvh
    USE_OSGPLUGIN(bvh)
#endif
#ifdef USE_osgdb_cfg
    USE_OSGPLUGIN(cfg)
#endif
#ifdef USE_osgdb_curl
    USE_OSGPLUGIN(curl)
#endif
#ifdef USE_osgdb_dds
    USE_OSGPLUGIN(dds)
#endif
#ifdef USE_osgdb_dot
    USE_OSGPLUGIN(dot)
#endif
#ifdef USE_osgdb_dw
    USE_OSGPLUGIN(dw)
#endif
#ifdef USE_osgdb_dxf
    USE_OSGPLUGIN(dxf)
#endif

/*
#ifdef USE_osgdb_ffmpeg
#ifndef ANDROID
	#include "DKOSGVideo.h"
	DKVIDEO_LOAD_DLLS()
	USE_OSGPLUGIN(ffmpeg)
#endif
#endif
*/

#ifdef USE_osgdb_freetype
    USE_OSGPLUGIN(freetype)
#endif
#ifdef USE_osgdb_gif
    USE_OSGPLUGIN(gif)
#endif
#ifdef USE_osgdb_glsl
    USE_OSGPLUGIN(glsl)
#endif
#ifdef USE_osgdb_gz
    USE_OSGPLUGIN(gz)
#endif
#ifdef USE_osgdb_hdr
    USE_OSGPLUGIN(hdr)
#endif
#ifdef USE_osgdb_imageio
    USE_OSGPLUGIN(imageio)
#endif
#ifdef USE_osgdb_ive
    USE_OSGPLUGIN(ive)
#endif
#ifdef USE_osgdb_jpeg
    USE_OSGPLUGIN(jpeg)
#endif
#ifdef USE_osgdb_ktx
    USE_OSGPLUGIN(ktx)
#endif
#ifdef USE_osgdb_logo
    USE_OSGPLUGIN(logo)
#endif
#ifdef USE_osgdb_lwo
    USE_OSGPLUGIN(lwo)
#endif
#ifdef USE_osgdb_lws
    USE_OSGPLUGIN(lws)
#endif
#ifdef USE_osgdb_md2
    USE_OSGPLUGIN(md2)
#endif
#ifdef USE_osgdb_mdl
    USE_OSGPLUGIN(mdl)
#endif
#ifdef USE_osgdb_normals
    USE_OSGPLUGIN(normals)
#endif
#ifdef USE_osgdb_obj
    USE_OSGPLUGIN(obj)
#endif
#ifdef USE_osgdb_openflight
    USE_OSGPLUGIN(OpenFlight)
#endif
#ifdef USE_osgdb_osc
    USE_OSGPLUGIN(osc)
#endif
#ifdef USE_osgdb_osga
    USE_OSGPLUGIN(osga)
#endif
#ifdef USE_osgdb_osgshadow
    USE_OSGPLUGIN(osgShadow)
#endif
#ifdef USE_osgdb_osgterrain
    USE_OSGPLUGIN(terrain)
#endif
#ifdef USE_osgdb_osgtgz
    USE_OSGPLUGIN(osgtgz)
#endif
#ifdef USE_osgdb_osgviewer
    USE_OSGPLUGIN(osgViewer)
#endif
#ifdef USE_osgdb_p3d
    USE_OSGPLUGIN(p3d)
#endif
#ifdef USE_osgdb_pic
    USE_OSGPLUGIN(pic)
#endif
#ifdef USE_osgdb_ply
    USE_OSGPLUGIN(ply)
#endif
#ifdef USE_osgdb_png
    USE_OSGPLUGIN(png)
#endif
#ifdef USE_osgdb_pnm
    USE_OSGPLUGIN(pnm)
#endif
#ifdef USE_osgdb_pov
    USE_OSGPLUGIN(Povray)
#endif
#ifdef USE_osgdb_pvr
    USE_OSGPLUGIN(pvr)
#endif
#ifdef USE_osgdb_python
    USE_OSGPLUGIN(python)
#endif
#ifdef USE_osgdb_revisions
    USE_OSGPLUGIN(revisions)
#endif
#ifdef USE_osgdb_rgb
    USE_OSGPLUGIN(rgb)
#endif
#ifdef USE_osgdb_rot
    USE_OSGPLUGIN(rot)
#endif
#ifdef USE_osgdb_scale
    USE_OSGPLUGIN(scale)
#endif
#ifdef USE_osgdb_shp
    USE_OSGPLUGIN(shp)
#endif
#ifdef USE_osgdb_stl
    USE_OSGPLUGIN(stl)
#endif
#ifdef USE_osgdb_tga
    USE_OSGPLUGIN(tga)
#endif
#ifdef USE_osgdb_tgz
    USE_OSGPLUGIN(tgz)
#endif
#ifdef USE_osgdb_tiff
    USE_OSGPLUGIN(tiff)
#endif
#ifdef USE_osgdb_trans
    USE_OSGPLUGIN(trans)
#endif
#ifdef USE_osgdb_trk
    USE_OSGPLUGIN(trk)
#endif
#ifdef USE_osgdb_txf
    USE_OSGPLUGIN(txf)
#endif
#ifdef USE_osgdb_txp
    USE_OSGPLUGIN(txp)
#endif
#ifdef USE_osgdb_vtf
    USE_OSGPLUGIN(vtf)
#endif
#ifdef USE_osgdb_x
    USE_OSGPLUGIN(x)
#endif
#ifdef USE_osgdb_zeroconf
    USE_OSGPLUGIN(zeroconf)
#endif
#ifdef USE_osgdb_zip
    USE_OSGPLUGIN(zip)
#endif
#ifdef USE_osgdb_deprecated_osg
    USE_DOTOSGWRAPPER_LIBRARY(osg)
#endif
#ifdef USE_osgdb_deprecated_osganimation
    USE_DOTOSGWRAPPER_LIBRARY(osgAnimation)
#endif
#ifdef USE_osgdb_deprecated_osgfx
    USE_DOTOSGWRAPPER_LIBRARY(osgFX)
#endif
#ifdef USE_osgdb_deprecated_osgparticle
    USE_DOTOSGWRAPPER_LIBRARY(osgParticle)
#endif
#ifdef USE_osgdb_deprecated_osgshadow
    USE_DOTOSGWRAPPER_LIBRARY(osgShadow)
#endif
#ifdef USE_osgdb_deprecated_osgsim
    USE_DOTOSGWRAPPER_LIBRARY(osgSim)
#endif
#ifdef USE_osgdb_deprecated_osgterrain
    USE_DOTOSGWRAPPER_LIBRARY(osgTerrain)
#endif
#ifdef USE_osgdb_deprecated_osgtext
    USE_DOTOSGWRAPPER_LIBRARY(osgText)
#endif
#ifdef USE_osgdb_deprecated_osgviewer
    USE_DOTOSGWRAPPER_LIBRARY(osgViewer)
#endif
#ifdef USE_osgdb_deprecated_osgvolume
    USE_DOTOSGWRAPPER_LIBRARY(osgVolume)
#endif
#ifdef USE_osgdb_deprecated_osgwidget
    USE_DOTOSGWRAPPER_LIBRARY(osgWidget)
#endif

#ifdef USE_osgdb_serializers_osg
    USE_SERIALIZER_WRAPPER_LIBRARY(osg)
#endif
#ifdef USE_osgdb_serializers_osganimation
    USE_SERIALIZER_WRAPPER_LIBRARY(osgAnimation)
#endif
#ifdef USE_osgdb_serializers_osgfx
    USE_SERIALIZER_WRAPPER_LIBRARY(osgFX)
#endif
#ifdef USE_osgdb_serializers_osgga
    USE_SERIALIZER_WRAPPER_LIBRARY(osgGA)
#endif
#ifdef USE_osgdb_serializers_osgmanipulator
    USE_SERIALIZER_WRAPPER_LIBRARY(osgManipulator)
#endif
#ifdef USE_osgdb_serializers_osgparticle
    USE_SERIALIZER_WRAPPER_LIBRARY(osgParticle)
#endif
#ifdef USE_osgdb_serializers_osgpresentation
    USE_SERIALIZER_WRAPPER_LIBRARY(osgPresentation)
#endif
#ifdef USE_osgdb_serializers_osgshadow
    USE_SERIALIZER_WRAPPER_LIBRARY(osgShadow)
#endif
#ifdef USE_osgdb_serializers_osgterrain
    USE_SERIALIZER_WRAPPER_LIBRARY(osgTerrain)
#endif 
#ifdef USE_osgdb_serializers_osgtext
    USE_SERIALIZER_WRAPPER_LIBRARY(osgText)
#endif
#ifdef USE_osgdb_serializers_osgviewer
    USE_SERIALIZER_WRAPPER_LIBRARY(osgviewer)
#endif
#ifdef USE_osgdb_serializers_osgvolume
    USE_SERIALIZER_WRAPPER_LIBRARY(osgVolume)
#endif
////

#ifdef USE_osgViewer
#ifdef WIN32
    USE_GRAPHICSWINDOW()
#endif
#ifdef MAC
    USE_GRAPICSWINDOW_IMPLEMENTATION(Cocoa)
#endif
#ifdef IOS
    USE_GRAPICSWINDOW_IMPLEMENTATION(IOS)
#endif
#ifdef LINUX
    USE_GRAPICSWINDOW_IMPLEMENTATION(X11)
#endif
#endif //USE_osgViewer

#endif //!DKLIB

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
