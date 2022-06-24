#pragma once
#ifndef DKGLInfo_H
#define DKGLInfo_H

#include <osg/Uniform>
#include <osg/Texture>
#include "DK/DK.h"

class DKGLInfo : public DKObjectT<DKGLInfo>
{
public:
	void Init();
	osg::ref_ptr<osg::GraphicsContext> _gc;
	int  _maxFFPTextureUnits;
	int  _maxGPUTextureUnits;
	int  _maxGPUTextureCoordSets;
	int  _maxGPUAttribs;
	int  _maxTextureSize;
	int  _maxFastTextureSize;
	int  _maxLights;
	int  _depthBits;
	bool _supportsGLSL;
	float _GLSLversion;
	bool _supportsTextureArrays;
	bool _supportsTexture3D;
	bool _supportsMultiTexture;
	bool _supportsStencilWrap;
	bool _supportsTwoSidedStencil;
	bool _supportsTexture2DLod;
	bool _supportsMipmappedTextureUpdates;
	bool _supportsDepthPackedStencilBuffer;
	bool _supportsOcclusionQuery;
	bool _supportsDrawInstanced;
	bool _supportsUniformBufferObjects;
	bool _supportsNonPowerOfTwoTextures;
	int  _maxUniformBlockSize;
	bool _preferDLforStaticGeom;
	int  _numProcessors;
	bool _supportsFragDepthWrite;
	DKString _vendor;
	DKString _renderer;
	DKString _version;
	bool _supportsS3TC;
	bool _supportsPVRTC;
	bool _supportsARBTC;
	bool _supportsETC;
	bool _supportsRGTC;
	bool _isGLES;
	bool _supportsTextureBuffer;
	int  _maxTextureBufferSize;
};

REGISTER_OBJECT(DKGLInfo, true);
#endif //DKGLInfo_H
