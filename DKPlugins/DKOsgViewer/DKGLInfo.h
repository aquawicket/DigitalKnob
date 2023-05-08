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
#ifndef DKGLInfo_H
#define DKGLInfo_H

#include "DK/DK.h"

WARNING_DISABLE
	#include <osg/Uniform>
	#include <osg/Texture>
WARNING_ENABLE


class DKGLInfo : public DKObjectT<DKGLInfo>
{
public:
	bool Init();
	bool End();
	
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
