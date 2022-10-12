#pragma once
#ifndef DKOSGRmlRender_H
#define DKOSGRmlRender_H

#include <Rml/Core/Core.h>
#include <Rml/Debugger/Debugger.h>
#include <osg/Group>
#include <osg/Scissor>
#include <osg/Texture2D>
#include <osg/TexMat>
#include <osg/Geometry>

class DKOSGRmlRender : public Rml::Core::RenderInterface
{
public:
	DKOSGRmlRender();
	~DKOSGRmlRender();

	void setRenderTarget(osg::Group* grp, int w, int h, bool fullscreen);
	osg::Group* getRenderTarget() const;
	virtual void RenderGeometry(Rml::Core::Vertex* vertices, int num_vertices, int* indices, int num_indices, Rml::Core::TextureHandle texture, const Rml::Core::Vector2f& translation);
	virtual void EnableScissorRegion(bool enable);
	virtual void SetScissorRegion(int x, int y, int width, int height);
	void AddTexture(Rml::Core::TextureHandle& texture_handle, osg::Image* image);
	virtual bool LoadTexture(Rml::Core::TextureHandle& texture_handle, Rml::Core::Vector2i& texture_dimensions, const Rml::Core::String& source);
	virtual bool GenerateTexture(Rml::Core::TextureHandle& texture_handle, const Rml::Core::byte* source, const Rml::Core::Vector2i& source_dimensions);
	virtual void ReleaseTexture(Rml::Core::TextureHandle texture);
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
    
	std::map<Rml::Core::TextureHandle, DKString> texture_name; //texture to name map
};

#endif //DKOSGRmlRender_H
