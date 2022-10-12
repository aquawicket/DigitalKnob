# https://github.com/openscenegraph/OpenSceneGraph


### DEPEND ###
# some depends are located below for individual osg plugins
dk_depend(libxml2)
dk_depend(msinttypes)
dk_depend(opengl)
dk_depend(sdl)
dk_depend(zlib)


### IMPORT ###
dk_import(https://github.com/openscenegraph/OpenSceneGraph.git)
dk_set(OSG_GL2 ${3RDPARTY}/${OPENSCENEGRAPH_NAME}-GL2)
dk_set(OSG_PLUGINS osgPlugins-3.7.0)
if(OpenGL2)
	dk_set(OSG OSG_GL2)
endif(OpenGL2)


### LINK ###
dk_include					(${OPENSCENEGRAPH}/include)
WIN32_dk_include			(${OPENSCENEGRAPH}/${OS}/include)
WIN64_dk_include			(${OPENSCENEGRAPH}/${OS}/include)
MAC_dk_include				(${OPENSCENEGRAPH}/${OS}/include)
MAC_dk_include				(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/include)
IOS_dk_include				(${OPENSCENEGRAPH}/${OS}/include)
IOSSIM_dk_include			(${OPENSCENEGRAPH}/${OS}/include)
LINUX_DEBUG_dk_include		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/include)
LINUX_RELEASE_dk_include	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/include)
RASPBERRY_DEBUG_dk_include	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/include)
RASPBERRY_RELEASE_dk_include(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/include)
ANDROID_DEBUG_dk_include	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/include)
ANDROID_RELEASE_dk_include	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/include)

dk_enable(ALL_LIBS)
if(ALL_LIBS)
	dk_enable(OpenThreads)
	dk_enable(osg)
	dk_enable(osgAnimation)
	dk_enable(osgDB)
	dk_enable(osgFX)
	dk_enable(osgGA)					# broken on WINDOWS
	dk_enable(osgManipulator)
	dk_enable(osgParticle)
	dk_enable(osgPresentation)
	dk_enable(osgShadow)
	dk_enable(osgSim)
	dk_enable(osgTerrain)
	dk_enable(osgText)
	dk_enable(osgUtil)
	dk_enable(osgViewer)
	dk_enable(osgVolume)
	dk_enable(osgWidget)
	
	dk_enable(osgdb_3dc)
	if(NOT ANDROID)
		dk_enable(osgdb_3ds)
	endif()
	dk_enable(osgdb_ac)
	dk_enable(osgdb_bmp)
	dk_enable(osgdb_bsp)
	dk_enable(osgdb_bvh)
	dk_enable(osgdb_cfg)
	if(NOT LINUX AND NOT RASPBERRY)
		dk_enable(osgdb_curl)				# broken on LINUX, RASPBERRY
	endif()
	dk_enable(osgdb_dds)
	dk_enable(osgdb_deprecated_osg)
	dk_enable(osgdb_deprecated_osganimation)
	dk_enable(osgdb_deprecated_osgfx)
	dk_enable(osgdb_deprecated_osgparticle)
	dk_enable(osgdb_deprecated_osgshadow)
	dk_enable(osgdb_deprecated_osgsim)
	dk_enable(osgdb_deprecated_osgterrain)
	dk_enable(osgdb_deprecated_osgtext)
	dk_enable(osgdb_deprecated_osgviewer)
	dk_enable(osgdb_deprecated_osgvolume)
	dk_enable(osgdb_deprecated_osgwidget)
	dk_enable(osgdb_dot)
	if(NOT MAC AND NOT LINUX)
		dk_enable(osgdb_dw)					# broken on MAC, LINUX
	endif()
	dk_enable(osgdb_dxf)
	if(NOT MAC AND NOT LINUX)
		dk_enable(osgdb_gif)				# broken on MAC, LINUX
	endif()
	dk_enable(osgdb_ive)
	dk_enable(osgdb_ffmpeg)
	dk_enable(osgdb_freetype)
	dk_enable(osgdb_glsl)
	dk_enable(osgdb_hdr)
	dk_enable(osgdb_jpeg)
	dk_enable(osgdb_ktx)
	dk_enable(osgdb_logo)
	dk_enable(osgdb_lwo)
	dk_enable(osgdb_lws)
	dk_enable(osgdb_md2)
	dk_enable(osgdb_mdl)
	dk_enable(osgdb_normals)
	dk_enable(osgdb_obj)
	dk_enable(osgdb_openflight)
	dk_enable(osgdb_osc)
	dk_enable(osgdb_osg)
	dk_enable(osgdb_osga)
	dk_enable(osgdb_osgshadow)
	dk_enable(osgdb_osgterrain)
	dk_enable(osgdb_osgtgz)
	dk_enable(osgdb_osgviewer)
	dk_enable(osgdb_p3d)
	dk_enable(osgdb_pic)
	dk_enable(osgdb_ply)
	if(NOT MAC)
		dk_enable(osgdb_png)			# broken on MAC
	endif()
	dk_enable(osgdb_pnm)
	dk_enable(osgdb_pov)
	dk_enable(osgdb_pvr)
	dk_enable(osgdb_revisions)
	dk_enable(osgdb_rgb)
	dk_enable(osgdb_rot)
	dk_enable(osgdb_scale)
	dk_enable(osgdb_serializers_osg)
	dk_enable(osgdb_serializers_osganimation)
	dk_enable(osgdb_serializers_osgfx)
	dk_enable(osgdb_serializers_osgga)
	dk_enable(osgdb_serializers_osgmanipulator)
	dk_enable(osgdb_serializers_osgparticle)
	dk_enable(osgdb_serializers_osgshadow)
	dk_enable(osgdb_serializers_osgsim)
	dk_enable(osgdb_serializers_osgterrain)
	dk_enable(osgdb_serializers_osgtext)
	dk_enable(osgdb_serializers_osgviewer)
	dk_enable(osgdb_serializers_osgvolume)	
	dk_enable(osgdb_shp)
	dk_enable(osgdb_stl)
	dk_enable(osgdb_tiff)
	dk_enable(osgdb_txp)
	dk_enable(osgdb_txf)
	dk_enable(osgdb_trans)
	dk_enable(osgdb_trk)
	dk_enable(osgdb_tga)
	dk_enable(osgdb_tgz)
	dk_enable(osgdb_vtf)
	dk_enable(osgdb_x)
endif()


if(OpenThreads)
	dk_define				(OSG_LIBRARY_STATIC)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/OpenThreadsd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/OpenThreads.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libOpenThreadsd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libOpenThreads.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libOpenThreadsd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libOpenThreads.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libOpenThreadsd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libOpenThreads.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libOpenThreadsd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libOpenThreads.a)
endif(OpenThreads)

if(osg)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/osgd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/osg.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosg.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosg.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosg.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosg.a)
endif(osg)

if(osgUtil)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/osgUtild.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/osgUtil.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgUtild.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgUtil.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgUtild.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgUtil.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgUtild.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgUtil.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgUtild.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgUtil.a)
endif(osgUtil)

if(osgDB)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/osgDBd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/osgDB.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgDBd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgDB.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgDBd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgDB.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgDBd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgDB.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgDBd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgDB.a)
endif(osgDB)

if(osgGA)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/osgGAd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/osgGA.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgGAd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgGA.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgGAd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgGA.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgGAd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgGA.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgGAd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgGA.a)
endif(osgGA)

if(osgText)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/osgTextd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/osgText.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgTextd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgText.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgTextd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgText.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgTextd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgText.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgTextd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgText.a)
endif(osgText)

if(osgViewer)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/osgViewerd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/osgViewer.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgViewerd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgViewer.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgViewerd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgViewer.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgViewerd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgViewer.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgViewerd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgViewer.a)
endif(osgViewer)

if(osgAnimation)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/osgAnimationd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/osgAnimation.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgAnimationd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgAnimation.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgAnimationd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgAnimation.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgAnimationd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgAnimation.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgAnimationd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgAnimation.a)
endif(osgAnimation)

if(osgFX)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/osgFXd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/osgFX.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgFXd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgFX.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgFXd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgFX.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgFXd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgFX.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgFXd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgFX.a)
endif(osgFX)

if(osgManipulator)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/osgManipulatord.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/osgManipulator.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgManipulatord.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgManipulator.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgManipulatord.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgManipulator.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgManipulatord.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgManipulator.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgManipulatord.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgManipulator.a)
endif(osgManipulator)

if(osgParticle)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/osgParticled.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/osgParticle.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgParticled.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgParticle.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgParticled.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgParticle.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgParticled.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgParticle.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgParticled.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgParticle.a)
endif(osgParticle)

if(osgVolume)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/osgVolumed.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/osgVolume.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgVolumed.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgVolume.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgVolumed.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgVolume.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgVolumed.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgVolume.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgVolumed.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgVolume.a)
endif(osgVolume)

if(osgWidget)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/osgWidgetd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/osgWidget.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgWidgetd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgWidget.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgWidgetd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgWidget.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgWidgetd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgWidget.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgWidgetd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgWidget.a)
endif(osgWidget)

if(osgPresentation)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/osgPresentationd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/osgPresentation.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgPresentationd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgPresentation.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgPresentationd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgPresentation.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgPresentationd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgPresentation.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgPresentationd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgPresentation.a)
endif(osgPresentation)

if(osgShadow)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/osgShadowd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/osgShadow.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgShadowd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgShadow.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgShadowd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgShadow.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgShadowd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgShadow.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgShadowd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgShadow.a)
endif(osgShadow)

if(osgSim)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/osgSimd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/osgSim.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgSimd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgSim.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgSimd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgSim.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgSimd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgSim.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgSimd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgSim.a)
endif(osgSim)

if(osgTerrain)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/osgTerraind.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/osgTerrain.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgTerraind.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgTerrain.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgTerraind.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgTerrain.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgTerraind.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgTerrain.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgTerraind.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgTerrain.a)
endif(osgTerrain)

if(osgdb_deprecated_osg)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_deprecated_osgd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_deprecated_osg.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_deprecated_osgd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_deprecated_osg.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_deprecated_osgd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_deprecated_osg.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_deprecated_osgd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_deprecated_osg.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_deprecated_osgd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_deprecated_osg.a)
endif(osgdb_deprecated_osg)

if(osgdb_serializers_osgparticle)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_serializers_osgparticled.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_serializers_osgparticle.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_serializers_osgparticled.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_serializers_osgparticle.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_serializers_osgparticled.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_serializers_osgparticle.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_serializers_osgparticled.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_serializers_osgparticle.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_serializers_osgparticled.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_serializers_osgparticle.a)
endif(osgdb_serializers_osgparticle)
	
if(osgdb_serializers_osg)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_serializers_osgd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_serializers_osg.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_serializers_osgd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_serializers_osg.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_serializers_osgd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_serializers_osg.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_serializers_osgd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_serializers_osg.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_serializers_osgd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_serializers_osg.a)
endif(osgdb_serializers_osg)
	
if(osgdb_trans)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_transd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_trans.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_transd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_trans.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_transd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_trans.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_transd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_trans.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_transd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_trans.a)
endif(osgdb_trans)
	
if(osgdb_normals)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_normalsd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_normals.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_normalsd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_normals.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_normalsd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_normals.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_normalsd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_normals.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_normalsd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_normals.a)
endif(osgdb_normals)
	
if(osgdb_scale)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_scaled.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_scale.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_scaled.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_scale.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_scaled.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_scale.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_scaled.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_scale.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_scaled.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_scale.a)
endif(osgdb_scale)
	
if(osgdb_rot)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_rotd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_rot.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_rotd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_rot.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_rotd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_rot.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_rotd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_rot.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_rotd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_rot.a)
endif(osgdb_rot)
	
if(osgdb_x)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_xd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_x.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_xd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_x.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_xd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_x.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_xd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_x.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_xd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_x.a)
endif(osgdb_x)
	
if(osgdb_stl)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_stld.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_stl.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_stld.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_stl.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_stld.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_stl.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_stld.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_stl.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_stld.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_stl.a)
endif(osgdb_stl)
	
if(osgdb_shp)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_shpd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_shp.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_shpd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_shp.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_shpd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_shp.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_shpd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_shp.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_shpd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_shp.a)
endif(osgdb_shp)
	
if(osgdb_osg)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_osgd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_osg.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_osgd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_osg.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_osgd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_osg.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_osgd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_osg.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_osgd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_osg.a)
endif(osgdb_osg)
	
if(osgdb_openflight)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_openflightd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_openflight.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_openflightd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_openflight.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_openflightd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_openflight.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_openflightd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_openflight.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_openflightd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_openflight.a)
endif(osgdb_openflight)
	
if(osgdb_obj)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_objd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_obj.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_objd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_obj.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_objd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_obj.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_objd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_obj.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_objd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_obj.a)
endif(osgdb_obj)
	
if(osgdb_md2)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_md2d.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_md2.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_md2d.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_md2.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_md2d.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_md2.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_md2d.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_md2.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_md2d.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_md2.a)
endif(osgdb_md2)
	
if(osgdb_lws)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_lwsd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_lws.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_lwsd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_lws.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_lwsd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_lws.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_lwsd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_lws.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_lwsd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_lws.a)
endif(osgdb_lws)
	
if(osgdb_lwo)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_lwod.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_lwo.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_lwod.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_lwo.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_lwod.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_lwo.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_lwod.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_lwo.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_lwod.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_lwo.a)
endif(osgdb_lwo)
	
if(osgdb_logo)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_logod.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_logo.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_logod.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_logo.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_logod.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_logo.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_logod.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_logo.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_logod.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_logo.a)
endif(osgdb_logo)
	
if(osgdb_ive)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_ived.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_ive.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_ived.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_ive.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_ived.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_ive.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_ived.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_ive.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_ived.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_ive.a)
endif(osgdb_ive)
	
if(osgdb_dxf)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_dxfd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_dxf.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_dxfd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_dxf.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_dxfd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_dxf.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_dxfd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_dxf.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_dxfd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_dxf.a)
endif(osgdb_dxf)
	
if(osgdb_dw)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_dwd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_dw.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_dwd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_dw.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_dwd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_dw.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_dwd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_dw.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_dwd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_dw.a)
endif(osgdb_dw)
	
if(osgdb_bsp)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_bspd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_bsp.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_bspd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_bsp.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_bspd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_bsp.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_bspd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_bsp.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_bspd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_bsp.a)
endif(osgdb_bsp)
	
if(osgdb_ac)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_acd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_ac.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_acd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_ac.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_acd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_ac.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_acd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_ac.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_acd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_ac.a)
endif(osgdb_ac)
	
if(osgdb_3ds)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_3dsd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_3ds.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_3dsd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_3ds.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_3dsd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_3ds.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_3dsd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_3ds.a)
	#ANDROID_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_3dsd.a)
	#ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_3ds.a)
endif(osgdb_3ds)
	
if(osgdb_3dc)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_3dcd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_3dc.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_3dcd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_3dc.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_3dcd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_3dc.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_3dcd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_3dc.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_3dcd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_3dc.a)
endif(osgdb_3dc)
	
if(osgdb_deprecated_osgwidget)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_deprecated_osgwidgetd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_deprecated_osgwidget.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_deprecated_osgwidgetd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_deprecated_osgwidget.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_deprecated_osgwidgetd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_deprecated_osgwidget.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_deprecated_osgwidgetd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_deprecated_osgwidget.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_deprecated_osgwidgetd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_deprecated_osgwidget.a)
endif(osgdb_deprecated_osgwidget)
	
if(osgdb_ffmpeg)
	dk_depend(ffmpeg-dev)
	dk_depend(ffmpeg-shared)
	dk_depend(ffmpeg-static)
	#dk_enable(ffmpeg)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_ffmpegd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_ffmpeg.lib)
	#APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_ffmpegd.a)
	#APPLE_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_ffmpeg.a)
	#LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_ffmpegd.a)
	#LINUX_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_ffmpeg.a)
	#RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_ffmpegd.a)
	#RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_ffmpeg.a)
	#ANDROID_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_ffmpegd.a)
	#ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_ffmpeg.a)
endif(osgdb_ffmpeg)

if(osgdb_tga)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_tgad.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_tga.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_tgad.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_tga.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_tgad.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_tga.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_tgad.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_tga.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_tgad.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_tga.a)
endif(osgdb_tga)

if(osgdb_tiff)
	dk_depend(tiff)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_tiffd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_tiff.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_tiffd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_tiff.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_tiffd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_tiff.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_tiffd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_tiff.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_tiffd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_tiff.a)
endif(osgdb_tiff)
	
if(osgdb_png)
	dk_depend(libpng)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_pngd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_png.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_pngd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_png.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_pngd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_png.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_pngd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_png.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_pngd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_png.a)
endif(osgdb_png)
	
if(osgdb_jpeg)
	dk_depend(libjpeg-turbo)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_jpegd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_jpeg.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_jpegd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_jpeg.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_jpegd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_jpeg.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_jpegd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_jpeg.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_jpegd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_jpeg.a)
endif(osgdb_jpeg)
	
if(osgdb_gif)
	dk_depend(giflib)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_gifd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_gif.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_gifd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_gif.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_gifd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_gif.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_gifd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_gif.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_gifd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_gif.a)
endif(osgdb_gif)
	
if(osgdb_freetype)
	dk_depend(freetype)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_freetyped.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_freetype.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_freetyped.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_freetype.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_freetyped.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_freetype.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_freetyped.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_freetype.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_freetyped.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_freetype.a)
endif(osgdb_freetype)
	
if(osgdb_bmp)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_bmpd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_bmp.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_bmpd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_bmp.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_bmpd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_bmp.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_bmpd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_bmp.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_bmpd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_bmp.a)
endif(osgdb_bmp)
	
if(osgdb_vtf)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_vtfd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_vtf.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_vtfd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_vtf.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_vtfd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_vtf.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_vtfd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_vtf.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_vtfd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_vtf.a)
endif(osgdb_vtf)

if(osgdb_txp)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_txpd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_txp.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_txpd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_txp.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_txpd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_txp.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_txpd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_txp.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_txpd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_txp.a)
endif(osgdb_txp)
	
if(osgdb_txf)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_txfd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_txf.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_txfd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_txf.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_txfd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_txf.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_txfd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_txf.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_txfd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_txf.a)
endif(osgdb_txf)
	
if(osgdb_trk)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_trkd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_trk.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_trkd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_trk.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_trkd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_trk.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_trkd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_trk.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_trkd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_trk.a)
endif(osgdb_trk)
	
if(osgdb_tgz)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_tgzd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_tgz.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_tgzd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_tgz.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_tgzd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_tgz.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_tgzd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_tgz.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_tgzd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_tgz.a)
endif(osgdb_tgz)
	
if(osgdb_serializers_osgvolume)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_serializers_osgvolumed.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_serializers_osgvolume.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_serializers_osgvolumed.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_serializers_osgvolume.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_serializers_osgvolumed.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_serializers_osgvolume.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_serializers_osgvolumed.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_serializers_osgvolume.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_serializers_osgvolumed.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_serializers_osgvolume.a)
endif(osgdb_serializers_osgvolume)
	
if(osgdb_serializers_osgviewer)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_serializers_osgviewerd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_serializers_osgviewer.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_serializers_osgviewerd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_serializers_osgviewer.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_serializers_osgviewerd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_serializers_osgviewer.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_serializers_osgviewerd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_serializers_osgviewer.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_serializers_osgviewerd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_serializers_osgviewer.a)
endif(osgdb_serializers_osgviewer)
	
if(osgdb_serializers_osgtext)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_serializers_osgtextd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_serializers_osgtext.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_serializers_osgtextd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_serializers_osgtext.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_serializers_osgtextd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_serializers_osgtext.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_serializers_osgtextd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_serializers_osgtext.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_serializers_osgtextd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_serializers_osgtext.a)
endif(osgdb_serializers_osgtext)

if(osgdb_serializers_osgterrain)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_serializers_osgterraind.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_serializers_osgterrain.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_serializers_osgterraind.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_serializers_osgterrain.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_serializers_osgterraind.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_serializers_osgterrain.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_serializers_osgterraind.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_serializers_osgterrain.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_serializers_osgterraind.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_serializers_osgterrain.a)
endif(osgdb_serializers_osgterrain)
	
if(osgdb_serializers_osgsim)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_serializers_osgsimd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_serializers_osgsim.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_serializers_osgsimd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_serializers_osgsim.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_serializers_osgsimd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_serializers_osgsim.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_serializers_osgsimd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_serializers_osgsim.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_serializers_osgsimd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_serializers_osgsim.a)
endif(osgdb_serializers_osgsim)
	
if(osgdb_serializers_osgshadow)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_serializers_osgshadowd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_serializers_osgshadow.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_serializers_osgshadowd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_serializers_osgshadow.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_serializers_osgshadowd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_serializers_osgshadow.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_serializers_osgshadowd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_serializers_osgshadow.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_serializers_osgshadowd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_serializers_osgshadow.a)
endif(osgdb_serializers_osgshadow)
	
if(osgdb_serializers_osgmanipulator)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_serializers_osgmanipulatord.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_serializers_osgmanipulator.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_serializers_osgmanipulatord.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_serializers_osgmanipulator.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_serializers_osgmanipulatord.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_serializers_osgmanipulator.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_serializers_osgmanipulatord.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_serializers_osgmanipulator.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_serializers_osgmanipulatord.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_serializers_osgmanipulator.a)
endif(osgdb_serializers_osgmanipulator)
	
if(osgdb_serializers_osgga)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_serializers_osggad.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_serializers_osgga.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_serializers_osggad.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_serializers_osgga.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_serializers_osggad.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_serializers_osgga.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_serializers_osggad.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_serializers_osgga.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_serializers_osggad.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_serializers_osgga.a)
endif(osgdb_serializers_osgga)
	
if(osgdb_serializers_osgfx)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_serializers_osgfxd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_serializers_osgfx.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_serializers_osgfxd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_serializers_osgfx.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_serializers_osgfxd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_serializers_osgfx.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_serializers_osgfxd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_serializers_osgfx.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_serializers_osgfxd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_serializers_osgfx.a)
endif(osgdb_serializers_osgfx)
	
if(osgdb_serializers_osganimation)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_serializers_osganimationd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_serializers_osganimation.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_serializers_osganimationd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_serializers_osganimation.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_serializers_osganimationd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_serializers_osganimation.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_serializers_osganimationd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_serializers_osganimation.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_serializers_osganimationd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_serializers_osganimation.a)
endif(osgdb_serializers_osganimation)
	
if(osgdb_rgb)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_rgbd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_rgb.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_rgbd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_rgb.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_rgbd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_rgb.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_rgbd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_rgb.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_rgbd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_rgb.a)
endif(osgdb_rgb)
	
if(osgdb_revisions)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_revisionsd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_revisions.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_revisionsd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_revisions.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_revisionsd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_revisions.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_revisionsd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_revisions.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_revisionsd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_revisions.a)
endif(osgdb_revisions)
	
if(osgdb_pvr)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_pvrd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_pvr.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_pvrd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_pvr.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_pvrd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_pvr.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_pvrd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_pvr.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_pvrd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_pvr.a)
endif(osgdb_pvr)
	
if(osgdb_pov)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_povd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_pov.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_povd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_pov.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_povd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_pov.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_povd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_pov.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_povd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_pov.a)
endif(osgdb_pov)
	
if(osgdb_pnm)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_pnmd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_pnm.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_pnmd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_pnm.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_pnmd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_pnm.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_pnmd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_pnm.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_pnmd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_pnm.a)
endif(osgdb_pnm)
	
if(osgdb_ply)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_plyd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_ply.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_plyd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_ply.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_plyd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_ply.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_plyd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_ply.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_plyd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_ply.a)
endif(osgdb_ply)
	
if(osgdb_pic)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_picd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_pic.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_picd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_pic.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_picd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_pic.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_picd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_pic.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_picd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_pic.a)
endif(osgdb_pic)
	
if(osgdb_p3d)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_p3dd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_p3d.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_p3dd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_p3d.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_p3dd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_p3d.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_p3dd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_p3d.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_p3dd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_p3d.a)
endif(osgdb_p3d)
	
if(osgdb_osgviewer)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_osgviewerd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_osgviewer.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_osgviewerd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_osgviewer.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_osgviewerd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_osgviewer.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_osgviewerd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_osgviewer.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_osgviewerd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_osgviewer.a)
endif(osgdb_osgviewer)
	
if(osgdb_osgtgz)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_osgtgzd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_osgtgz.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_osgtgzd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_osgtgz.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_osgtgzd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_osgtgz.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_osgtgzd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_osgtgz.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_osgtgzd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_osgtgz.a)
endif(osgdb_osgtgz)
	
if(osgdb_osgterrain)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_osgterraind.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_osgterrain.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_osgterraind.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_osgterrain.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_osgterraind.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_osgterrain.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_osgterraind.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_osgterrain.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_osgterraind.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_osgterrain.a)
endif(osgdb_osgterrain)
	
if(osgdb_osgshadow)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_osgshadowd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_osgshadow.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_osgshadowd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_osgshadow.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_osgshadowd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_osgshadow.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_osgshadowd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_osgshadow.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_osgshadowd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_osgshadow.a)
endif(osgdb_osgshadow)
	
if(osgdb_osga)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_osgad.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_osga.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_osgad.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_osga.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_osgad.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_osga.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_osgad.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_osga.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_osgad.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_osga.a)
endif(osgdb_osga)
	
if(osgdb_osc)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_oscd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_osc.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_oscd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_osc.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_oscd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_osc.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_oscd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_osc.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_oscd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_osc.a)
endif(osgdb_osc)
	
if(osgdb_mdl)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_mdld.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_mdl.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_mdld.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_mdl.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_mdld.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_mdl.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_mdld.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_mdl.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_mdld.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_mdl.a)
endif(osgdb_mdl)
	
if(osgdb_ktx)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_ktxd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_ktx.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_ktxd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_ktx.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_ktxd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_ktx.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_ktxd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_ktx.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_ktxd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_ktx.a)
endif(osgdb_ktx)
	
if(osgdb_hdr)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_hdrd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_hdr.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_hdrd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_hdr.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_hdrd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_hdr.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_hdrd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_hdr.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_hdrd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_hdr.a)
endif(osgdb_hdr)
	
if(osgdb_glsl)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_glsld.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_glsl.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_glsld.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_glsl.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_glsld.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_glsl.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_glsld.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_glsl.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_glsld.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_glsl.a)
endif(osgdb_glsl)
	
if(osgdb_dot)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_dotd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_dot.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_dotd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_dot.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_dotd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_dot.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_dotd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_dot.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_dotd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_dot.a)
endif(osgdb_dot)
	
if(osgdb_deprecated_osgvolume)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_deprecated_osgvolumed.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_deprecated_osgvolume.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_deprecated_osgvolumed.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_deprecated_osgvolume.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_deprecated_osgvolumed.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_deprecated_osgvolume.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_deprecated_osgvolumed.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_deprecated_osgvolume.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_deprecated_osgvolumed.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_deprecated_osgvolume.a)
endif(osgdb_deprecated_osgvolume)
	
if(osgdb_deprecated_osgviewer)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_deprecated_osgviewerd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_deprecated_osgviewer.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_deprecated_osgviewerd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_deprecated_osgviewer.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_deprecated_osgviewerd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_deprecated_osgviewer.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_deprecated_osgviewerd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_deprecated_osgviewer.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_deprecated_osgviewerd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_deprecated_osgviewer.a)
endif(osgdb_deprecated_osgviewer)

if(osgdb_deprecated_osgtext)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_deprecated_osgtextd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_deprecated_osgtext.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_deprecated_osgtextd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_deprecated_osgtext.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_deprecated_osgtextd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_deprecated_osgtext.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_deprecated_osgtextd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_deprecated_osgtext.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_deprecated_osgtextd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_deprecated_osgtext.a)
endif(osgdb_deprecated_osgtext)
	
if(osgdb_deprecated_osgterrain)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_deprecated_osgterraind.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_deprecated_osgterrain.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_deprecated_osgterraind.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_deprecated_osgterrain.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_deprecated_osgterraind.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_deprecated_osgterrain.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_deprecated_osgterraind.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_deprecated_osgterrain.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_deprecated_osgterraind.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_deprecated_osgterrain.a)
endif(osgdb_deprecated_osgterrain)
	
if(osgdb_deprecated_osgsim)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_deprecated_osgsimd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_deprecated_osgsim.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_deprecated_osgsimd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_deprecated_osgsim.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_deprecated_osgsimd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_deprecated_osgsim.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_deprecated_osgsimd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_deprecated_osgsim.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_deprecated_osgsimd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_deprecated_osgsim.a)
endif(osgdb_deprecated_osgsim)
	
if(osgdb_deprecated_osgshadow)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_deprecated_osgshadowd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_deprecated_osgshadow.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_deprecated_osgshadowd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_deprecated_osgshadow.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_deprecated_osgshadowd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_deprecated_osgshadow.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_deprecated_osgshadowd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_deprecated_osgshadow.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_deprecated_osgshadowd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_deprecated_osgshadow.a)
endif(osgdb_deprecated_osgshadow)
	
if(osgdb_deprecated_osgparticle)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_deprecated_osgparticled.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_deprecated_osgparticle.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_deprecated_osgparticled.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_deprecated_osgparticle.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_deprecated_osgparticled.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_deprecated_osgparticle.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_deprecated_osgparticled.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_deprecated_osgparticle.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_deprecated_osgparticled.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_deprecated_osgparticle.a)
endif(osgdb_deprecated_osgparticle)
	
if(osgdb_deprecated_osgfx)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_deprecated_osgfxd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_deprecated_osgfx.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_deprecated_osgfxd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_deprecated_osgfx.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_deprecated_osgfxd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_deprecated_osgfx.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_deprecated_osgfxd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_deprecated_osgfx.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_deprecated_osgfxd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_deprecated_osgfx.a)
endif(osgdb_deprecated_osgfx)
	
if(osgdb_deprecated_osganimation)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_deprecated_osganimationd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_deprecated_osganimation.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_deprecated_osganimationd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_deprecated_osganimation.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_deprecated_osganimationd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_deprecated_osganimation.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_deprecated_osganimationd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_deprecated_osganimation.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_deprecated_osganimationd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_deprecated_osganimation.a)
endif(osgdb_deprecated_osganimation)
	
if(osgdb_dds)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_ddsd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_dds.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_ddsd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_dds.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_ddsd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_dds.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_ddsd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_dds.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_ddsd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_dds.a)
endif(osgdb_dds)
	
if(osgdb_cfg)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_cfgd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_cfg.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_cfgd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_cfg.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_cfgd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_cfg.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_cfgd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_cfg.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_cfgd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_cfg.a)
endif(osgdb_cfg)
	
if(osgdb_bvh)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_bvhd.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_bvh.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_bvhd.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_bvh.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_bvhd.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_bvh.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_bvhd.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_bvh.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_bvhd.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_bvh.a)
endif(osgdb_bvh)
	
if(osgdb_curl)
	dk_depend(curl)
	WIN_dk_libDebug			(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_curld.lib)
	WIN_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/${OSG_PLUGINS}/osgdb_curl.lib)
	APPLE_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_curld.a)
	APPLE_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/lib/libosgdb_curl.a)
	LINUX_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_curld.a)
	LINUX_dk_libRelease		(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_curl.a)
	RASPBERRY_dk_libDebug	(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/lib/libosgdb_curld.a)
	RASPBERRY_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/lib/libosgdb_curl.a)
	ANDROID_dk_libDebug		(${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/armeabi-v7a/lib/libosgdb_curld.a)
	ANDROID_dk_libRelease	(${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR}/armeabi-v7a/lib/libosgdb_curl.a)
endif(osgdb_curl)



### GENERATE ###
dk_setPath				(${OPENSCENEGRAPH}/${BUILD_DIR})

string(REPLACE "/std:c++17" "" OPENCV_BUILD "${DKCMAKE_BUILD}")
string(REPLACE "  " " " OPENCV_BUILD "${OPENCV_BUILD}")
WIN_dk_queueCommand	(${OPENCV_BUILD}
	"-DCMAKE_CXX_FLAGS=/D__STDC_CONSTANT_MACROS /I${ZLIB}/${OS} /I${LIBPNG} /I${LIBPNG}/${OS} /I${TIFF}/${OS}/libtiff /I${LIBJPEG-TURBO}/${OS}" 
	-DBUILD_OSG_APPLICATIONS=OFF 
	-DDYNAMIC_OPENTHREADS=OFF 
	-DDYNAMIC_OPENSCENEGRAPH=OFF 
	-DOSG_GL_DISPLAYLISTS_AVAILABLE=OFF 
	-DOSG_GL_MATRICES_AVAILABLE=ON 
	-DOSG_GL_VERTEX_FUNCS_AVAILABLE=ON 
	-DOSG_GL_VERTEX_ARRAY_FUNCS_AVAILABLE=ON 
	-DOSG_GL_FIXED_FUNCTION_AVAILABLE=ON 
	-DOSG_CPP_EXCEPTIONS_AVAILABLE=ON 
	-DOSG_GL1_AVAILABLE=ON 
	-DOSG_GL2_AVAILABLE=ON 
	-DOSG_GL3_AVAILABLE=OFF 
	-DOSG_GLES1_AVAILABLE=OFF 
	-DOSG_GLES2_AVAILABLE=OFF 
	-DOSG_GL_LIBRARY_STATIC=OFF 
	-DOSG_MSVC_VERSIONED_DLL=OFF 
	-DOSG_USE_QT=OFF 
	-DUSE_3RDPARTY_BIN=OFF 
	-DOSG_MSVC_GENERATE_PLUGINS_AND_WRAPPERS_MANIFESTS=OFF 
	${CURL_CMAKE} 
	${FREETYPE_CMAKE} 
	${LIBJPEG-TURBO_CMAKE} 
	${GIFLIB_CMAKE}
	${TIFF_CMAKE} 
	${ZLIB_CMAKE} 
	${LIBPNG_CMAKE}
	${BOOST_CMAKE} 
	${FFMPEG_CMAKE} 
	${OPENSCENEGRAPH})

string(REPLACE "-std=c++17" "" OPENCV_BUILD "${DKCMAKE_BUILD}")
string(REPLACE "  " " " OPENCV_BUILD "${OPENCV_BUILD}")
MAC_dk_queueCommand(${OPENCV_BUILD} 
	"-DCMAKE_CXX_FLAGS=-I${ZLIB}/${OS} -I${LIBPNG}/${OS} -I${TIFF}/${OS}/libtiff -I${LIBJPEG-TURBO}/${OS}"
	-DAV_FOUNDATION_INCLUDE_DIR=OFF 
	-DBUILD_OSG_APPLICATIONS=OFF 
	-DDYNAMIC_OPENTHREADS=OFF 
	-DDYNAMIC_OPENSCENEGRAPH=OFF 
	-DOSG_GL_DISPLAYLISTS_AVAILABLE=OFF 
	-DOSG_GL_MATRICES_AVAILABLE=ON 
	-DOSG_GL_VERTEX_FUNCS_AVAILABLE=ON 
	-DOSG_GL_VERTEX_ARRAY_FUNCS_AVAILABLE=ON 
	-DOSG_GL_FIXED_FUNCTION_AVAILABLE=ON 
	-DOSG_CPP_EXCEPTIONS_AVAILABLE=ON 
	-DOSG_GL1_AVAILABLE=ON 
	-DOSG_GL2_AVAILABLE=ON 
	-DOSG_GL3_AVAILABLE=OFF 
	-DOSG_GLES1_AVAILABLE=OFF 
	-DOSG_GLES2_AVAILABLE=OFF 
	-DOSG_GL_LIBRARY_STATIC=OFF 
	-DOSG_MSVC_VERSIONED_DLL=OFF 
	-DOSG_USE_QT=OFF 
	${CURL_CMAKE} 
	${FREETYPE_CMAKE} 
	${LIBJPEG-TURBO_CMAKE}
	${GIFLIB_CMAKE}
	${TIFF_CMAKE} 
	${ZLIB_CMAKE} 
	${LIBPNG_CMAKE}
	${BOOST_CMAKE} 
	${FFMPEG_CMAKE} 
	${OPENSCENEGRAPH})

#IOS_dk_removeSubstring("-std=c++17" "${DKCMAKE_BUILD}" OPENCV_BUILD)
string(REPLACE "-std=c++17" "" OPENCV_BUILD "${DKCMAKE_BUILD}")
string(REPLACE "  " " " OPENCV_BUILD "${OPENCV_BUILD}")
IOS_dk_queueCommand(${OPENCV_BUILD} 
	"-DCMAKE_CXX_FLAGS=-I${ZLIB}/${OS} -I${LIBPNG}/${OS} -I${TIFF}/${OS}/libtiff -I${LIBJPEG-TURBO}/${OS}" 
	-DBUILD_OSG_APPLICATIONS=OFF 
	-DDYNAMIC_OPENTHREADS=OFF 
	-DDYNAMIC_OPENSCENEGRAPH=OFF 
	-DOSG_GL_DISPLAYLISTS_AVAILABLE=OFF 
	-DOSG_GL_MATRICES_AVAILABLE=ON 
	-DOSG_GL_VERTEX_FUNCS_AVAILABLE=ON 
	-DOSG_GL_VERTEX_ARRAY_FUNCS_AVAILABLE=ON 
	-DOSG_GL_FIXED_FUNCTION_AVAILABLE=ON 
	-DOSG_CPP_EXCEPTIONS_AVAILABLE=ON 
	-DOSG_GL1_AVAILABLE=OFF 
	-DOSG_GL2_AVAILABLE=OFF 
	-DOSG_GL3_AVAILABLE=OFF 
	-DOSG_GLES1_AVAILABLE=ON 
	-DOSG_GLES2_AVAILABLE=OFF 
	-DOSG_GLES3_AVAILABLE=OFF 
	-DOSG_GL_LIBRARY_STATIC=OFF 
	-DOPENGL_PROFILE=GLES1 
	-DOSG_MSVC_VERSIONED_DLL=OFF 
	-DOSG_USE_QT=OFF 
	${CURL_CMAKE} 
	${FREETYPE_CMAKE} 
	${LIBJPEG-TURBO_CMAKE}
	${GIFLIB_CMAKE}
	${TIFF_CMAKE} 
	${ZLIB_CMAKE} 
	${LIBPNG_CMAKE}
	${BOOST_CMAKE} 
	${FFMPEG_CMAKE} 
	${OPENSCENEGRAPH})

string(REPLACE "-std=c++17" "" OPENCV_BUILD "${DKCMAKE_BUILD}")
string(REPLACE "  " " " OPENCV_BUILD "${OPENCV_BUILD}")
IOSSIM_dk_queueCommand(${OPENCV_BUILD} 
	"-DCMAKE_CXX_FLAGS=-I${ZLIB}/${OS} -I${LIBPNG}/${OS} -I${TIFF}/${OS}/libtiff -I${LIBJPEG-TURBO}/${OS}" 
	-DOSG_CXX_LANGUAGE_STANDARD=C++98 
	-DBUILD_OSG_APPLICATIONS=OFF 
	-DDYNAMIC_OPENTHREADS=OFF 
	-DDYNAMIC_OPENSCENEGRAPH=OFF 
	-DOSG_GL_DISPLAYLISTS_AVAILABLE=OFF 
	-DOSG_GL_MATRICES_AVAILABLE=ON 
	-DOSG_GL_VERTEX_FUNCS_AVAILABLE=ON 
	-DOSG_GL_VERTEX_ARRAY_FUNCS_AVAILABLE=ON 
	-DOSG_GL_FIXED_FUNCTION_AVAILABLE=ON 
	-DOSG_CPP_EXCEPTIONS_AVAILABLE=ON 
	-DOSG_GL1_AVAILABLE=OFF 
	-DOSG_GL2_AVAILABLE=OFF 
	-DOSG_GL3_AVAILABLE=OFF 
	-DOSG_GLES1_AVAILABLE=ON 
	-DOSG_GLES2_AVAILABLE=OFF 
	-DOSG_GLES3_AVAILABLE=OFF 
	-DOSG_GL_LIBRARY_STATIC=OFF 
	-DOPENGL_PROFILE=GLES1 
	-DOSG_MSVC_VERSIONED_DLL=OFF 
	-DOSG_USE_QT=OFF 
	${CURL_CMAKE} 
	${FREETYPE_CMAKE} 
	${LIBJPEG-TURBO_CMAKE}
	${TIFF_CMAKE} 
	${ZLIB_CMAKE} 
	${LIBPNG_CMAKE} 
	${GIFLIB_CMAKE}
	${BOOST_CMAKE} 
	-DAV_FOUNDATION_INCLUDE_DIR=OFF 
	-DAV_FOUNDATION_LIBRARY=OFF 
	-DOSG_BUILD_PLATFORM_IPHONE_SIMULATOR=ON 
	${OPENSCENEGRAPH})

string(REPLACE "-std=c++17" "" OPENCV_BUILD "${DKCMAKE_BUILD}")
string(REPLACE "  " " " OPENCV_BUILD "${OPENCV_BUILD}")
LINUX_DEBUG_dk_queueCommand(${OPENCV_BUILD} 
	"-DCMAKE_CXX_FLAGS=-I${ZLIB}/${OS}/Debug -I${LIBPNG}/${OS}/Debug -I${TIFF}/${OS}/Debug/libtiff -I${LIBJPEG-TURBO}/${OS}/Debug" 
	-DCMAKE_BUILD_TYPE=DEBUG 
	-DBUILD_OSG_APPLICATIONS=OFF 
	-DDYNAMIC_OPENTHREADS=OFF 
	-DDYNAMIC_OPENSCENEGRAPH=OFF 
	-DOSG_GL_DISPLAYLISTS_AVAILABLE=OFF 
	-DOSG_GL_MATRICES_AVAILABLE=ON 
	-DOSG_GL_VERTEX_FUNCS_AVAILABLE=ON 
	-DOSG_GL_VERTEX_ARRAY_FUNCS_AVAILABLE=ON 
	-DOSG_GL_FIXED_FUNCTION_AVAILABLE=ON 
	-DOSG_CPP_EXCEPTIONS_AVAILABLE=ON 
	-DOSG_GL1_AVAILABLE=ON 
	-DOSG_GL2_AVAILABLE=ON 
	-DOSG_GL3_AVAILABLE=OFF 
	-DOSG_GLES1_AVAILABLE=OFF 
	-DOSG_GLES2_AVAILABLE=OFF 
	-DOSG_GL_LIBRARY_STATIC=OFF 
	-DOSG_MSVC_VERSIONED_DLL=OFF 
	-DOSG_USE_QT=OFF 
	${CURL_CMAKE} 
	${FREETYPE_CMAKE} 
	${ZLIB_CMAKE} 
	${LIBPNG_CMAKE}
	${LIBJPEG-TURBO_CMAKE}
	${TIFF_CMAKE} 
	${GIFLIB_CMAKE}
	${BOOST_CMAKE} 
	${OPENSCENEGRAPH})
	
LINUX_RELEASE_dk_queueCommand(${OPENCV_BUILD} 
	"-DCMAKE_CXX_FLAGS=-I${ZLIB}/${OS}/Release -I${LIBPNG}/${OS}/Release -I${TIFF}/${OS}/Release/libtiff -I${LIBJPEG-TURBO}/${OS}/Release" 
	-DCMAKE_BUILD_TYPE=RELEASE
	-DBUILD_OSG_APPLICATIONS=OFF 
	-DDYNAMIC_OPENTHREADS=OFF 
	-DDYNAMIC_OPENSCENEGRAPH=OFF 
	-DOSG_GL_DISPLAYLISTS_AVAILABLE=OFF 
	-DOSG_GL_MATRICES_AVAILABLE=ON 
	-DOSG_GL_VERTEX_FUNCS_AVAILABLE=ON 
	-DOSG_GL_VERTEX_ARRAY_FUNCS_AVAILABLE=ON 
	-DOSG_GL_FIXED_FUNCTION_AVAILABLE=ON 
	-DOSG_CPP_EXCEPTIONS_AVAILABLE=ON 
	-DOSG_GL1_AVAILABLE=ON 
	-DOSG_GL2_AVAILABLE=ON 
	-DOSG_GL3_AVAILABLE=OFF 
	-DOSG_GLES1_AVAILABLE=OFF 
	-DOSG_GLES2_AVAILABLE=OFF 
	-DOSG_GL_LIBRARY_STATIC=OFF 
	-DOSG_MSVC_VERSIONED_DLL=OFF 
	-DOSG_USE_QT=OFF 
	${CURL_CMAKE} 
	${FREETYPE_CMAKE} 
	${ZLIB_CMAKE} 
	${LIBPNG_CMAKE}
	${LIBJPEG-TURBO_CMAKE}
	${TIFF_CMAKE} 
	${GIFLIB_CMAKE}
	${BOOST_CMAKE} 
	${OPENSCENEGRAPH})

string(REPLACE "-std=c++17" "" OPENCV_BUILD "${DKCMAKE_BUILD}")
string(REPLACE "  " " " OPENCV_BUILD "${OPENCV_BUILD}")
RASPBERRY_DEBUG_dk_queueCommand(${OPENCV_BUILD} 
	"-DCMAKE_CXX_FLAGS=-I${ZLIB}/${OS}/Debug -I${LIBPNG}/${OS}/Debug -I${TIFF}/${OS}/Debug/libtiff -I${LIBJPEG-TURBO}/${OS}/Debug" 
	-DCMAKE_BUILD_TYPE=DEBUG 
	-DBUILD_OSG_APPLICATIONS=OFF 
	-DDYNAMIC_OPENTHREADS=OFF 
	-DDYNAMIC_OPENSCENEGRAPH=OFF 
	-DOSG_GL_DISPLAYLISTS_AVAILABLE=OFF 
	-DOSG_GL_MATRICES_AVAILABLE=ON 
	-DOSG_GL_VERTEX_FUNCS_AVAILABLE=ON 
	-DOSG_GL_VERTEX_ARRAY_FUNCS_AVAILABLE=ON 
	-DOSG_GL_FIXED_FUNCTION_AVAILABLE=ON 
	-DOSG_CPP_EXCEPTIONS_AVAILABLE=ON 
	-DOSG_GL1_AVAILABLE=ON 
	-DOSG_GL2_AVAILABLE=ON 
	-DOSG_GL3_AVAILABLE=OFF 
	-DOSG_GLES1_AVAILABLE=OFF 
	-DOSG_GLES2_AVAILABLE=OFF 
	-DOSG_GL_LIBRARY_STATIC=OFF 
	-DOSG_MSVC_VERSIONED_DLL=OFF 
	-DOSG_USE_QT=OFF 
	${CURL_CMAKE} 
	${FREETYPE_CMAKE} 
	${ZLIB_CMAKE} 
	${LIBPNG_CMAKE}
	${LIBJPEG-TURBO_CMAKE} 
	${TIFF_CMAKE} 
	${GIFLIB_CMAKE}
	${BOOST_CMAKE} 
	${OPENSCENEGRAPH})
	
RASPBERRY_RELEASE_dk_queueCommand(${OPENCV_BUILD} 
	"-DCMAKE_CXX_FLAGS=-I${ZLIB}/${OS}/Release -I${LIBPNG}/${OS}/Release -I${TIFF}/${OS}/Release/libtiff -I${LIBJPEG-TURBO}/${OS}/Release" 
	-DCMAKE_BUILD_TYPE=DEBUG 
	-DBUILD_OSG_APPLICATIONS=OFF 
	-DDYNAMIC_OPENTHREADS=OFF 
	-DDYNAMIC_OPENSCENEGRAPH=OFF 
	-DOSG_GL_DISPLAYLISTS_AVAILABLE=OFF 
	-DOSG_GL_MATRICES_AVAILABLE=ON 
	-DOSG_GL_VERTEX_FUNCS_AVAILABLE=ON 
	-DOSG_GL_VERTEX_ARRAY_FUNCS_AVAILABLE=ON 
	-DOSG_GL_FIXED_FUNCTION_AVAILABLE=ON 
	-DOSG_CPP_EXCEPTIONS_AVAILABLE=ON 
	-DOSG_GL1_AVAILABLE=ON 
	-DOSG_GL2_AVAILABLE=ON 
	-DOSG_GL3_AVAILABLE=OFF 
	-DOSG_GLES1_AVAILABLE=OFF 
	-DOSG_GLES2_AVAILABLE=OFF 
	-DOSG_GL_LIBRARY_STATIC=OFF 
	-DOSG_MSVC_VERSIONED_DLL=OFF 
	-DOSG_USE_QT=OFF 
	${CURL_CMAKE} 
	${FREETYPE_CMAKE} 
	${ZLIB_CMAKE} 
	${LIBPNG_CMAKE}
	${LIBJPEG-TURBO_CMAKE} 
	${TIFF_CMAKE} 
	${GIFLIB_CMAKE}
	${BOOST_CMAKE} 
	${OPENSCENEGRAPH})

string(REPLACE "-std=c++17" "" OPENCV_BUILD "${DKCMAKE_BUILD}")
string(REPLACE "  " " " OPENCV_BUILD "${OPENCV_BUILD}")
ANDROID_dk_queueCommand(${OPENCV_BUILD} 
	"-DCMAKE_CXX_FLAGS=-I${LIBJPEG-TURBO}/${OS}/${DEBUG_DIR}/jni -I${FREETYPE}/include -I${LIBPNG}/${OS}/${DEBUG_DIR}/jni -I${TIFF}/${OS}/libtiff -I${ZLIB}/${OS}/${DEBUG_DIR}/jni" 
	-DOSG_BUILD_PLATFORM_ANDROID=ON 
	-DDYNAMIC_OPENTHREADS=OFF 
	-DDYNAMIC_OPENSCENEGRAPH=OFF 
	-DOSG_GL_DISPLAYLISTS_AVAILABLE=OFF 
	-DOSG_GL_MATRICES_AVAILABLE=ON 
	-DOSG_GL_VERTEX_FUNCS_AVAILABLE=ON 
	-DOSG_GL_VERTEX_ARRAY_FUNCS_AVAILABLE=ON 
	-DOSG_GL_FIXED_FUNCTION_AVAILABLE=ON 
	-DOSG_CPP_EXCEPTIONS_AVAILABLE=ON 
	-DOSG_GL1_AVAILABLE=OFF 
	-DOSG_GL2_AVAILABLE=OFF 
	-DOSG_GL3_AVAILABLE=OFF 
	-DOSG_GLES1_AVAILABLE=ON 
	-DOSG_GLES2_AVAILABLE=OFF 
	-DOSG_GL_LIBRARY_STATIC=OFF 
	-DOPENGL_PROFILE=GLES1 
	-DCMAKE_TOOLCHAIN_FILE=${OPENSCENEGRAPH}/PlatformSpecifics/Android/android.toolchain.cmake 
	-DCMAKE_INSTALL_PREFIX=${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR}/install 
	-DANDROID_NDK=${ANDROID_NDK} 
	-DANDROID_TOOLCHAIN_NAME=arm-linux-androideabi-4.8 
	-DANDROID_STL=gnustl_static 
	-DANDROID_NATIVE_API_LEVEL=15 
	-DANDROID_PLATFORM=android-15 
	-DANDROID_ABI=armeabi-v7a 
	-DANDROID_OPTIM_NEON=OFF 
	-DANDROID_OPTIM_ARM32=OFF 
	${FREETYPE_CMAKE} 
	${GIFLIB_CMAKE}
	${LIBJPEG-TURBO_CMAKE}
	${LIBPNG_CMAKE}
	${TIFF_CMAKE} 
	${CURL_CMAKE}
	${ZLIB_CMAKE} 
	-DBUILD_OSG_APPLICATIONS=OFF 
	-DOSG_USE_QT=OFF 
	-DBoost_INCLUDE_DIR=OFF 
	-DJ=8 
	-DANDROID_DEBUG=OFF 
	${OPENSCENEGRAPH})


### COMPILE ###
dk_visualStudio		(${OPENSCENEGRAPH_FOLDER}) # windows, android
dk_xcode			(${OPENSCENEGRAPH_FOLDER}) # mac, ios, iossim
dk_make				(${OPENSCENEGRAPH_FOLDER}) # linux, raspberry
