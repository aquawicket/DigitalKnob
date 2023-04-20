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
#ifndef DKOsgRmlRender_H
#define DKOsgRmlRender_H

WARNING_DISABLE
#include <RmlUi/Core.h>
#include <RmlUi/Debugger.h>
#include <osg/Group>
#include <osg/Scissor>
#include <osg/Texture2D>
#include <osg/TexMat>
#include <osg/Geometry>
WARNING_ENABLE


class DKOsgRmlRender : public Rml::RenderInterface
{
public:
	DKOsgRmlRender();
	~DKOsgRmlRender();

	void setRenderTarget(osg::Group* grp, int w, int h, bool fullscreen);
	osg::Group* getRenderTarget() const;
	virtual void RenderGeometry(Rml::Vertex* vertices, int num_vertices, int* indices, int num_indices, Rml::TextureHandle texture, const Rml::Vector2f& translation);
	virtual void EnableScissorRegion(bool enable);
	virtual void SetScissorRegion(int x, int y, int width, int height);
	void AddTexture(Rml::TextureHandle& texture_handle, osg::Image* image);
	virtual bool LoadTexture(Rml::TextureHandle& texture_handle, Rml::Vector2i& texture_dimensions, const Rml::String& source);
	virtual bool GenerateTexture(Rml::TextureHandle& texture_handle, const Rml::byte* source, const Rml::Vector2i& source_dimensions);
	virtual void ReleaseTexture(Rml::TextureHandle texture);
	virtual void Release();

private:
	osg::ref_ptr<osg::Group> _renderTarget;
	osg::ref_ptr<osg::StateSet> _renderTargetStateSet;
	osg::ref_ptr<osg::Geode> _geode;
	osg::ref_ptr<osg::Scissor> _scissorTest;

	bool _scissorsEnabled;
	int _screenWidth;
	int _screenHeight;
    bool _fullScreen;
    
	std::map<Rml::TextureHandle, DKString> texture_name; //texture to name map
};

#endif //DKOsgRmlRender_H
