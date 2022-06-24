#pragma once
#ifndef DKOSGRocketRender_H
#define DKOSGRocketRender_H

#include <Rocket/Core/Core.h>
#include <Rocket/Debugger/Debugger.h>
#include <osg/Group>
#include <osg/Scissor>
#include <osg/Texture2D>
#include <osg/TexMat>
#include <osg/Geometry>

class DKOSGRocketRender : public Rocket::Core::RenderInterface
{
public:
	DKOSGRocketRender();
	~DKOSGRocketRender();

	void setRenderTarget(osg::Group* grp, int w, int h, bool fullscreen);
	osg::Group* getRenderTarget() const;
	virtual void RenderGeometry(Rocket::Core::Vertex* vertices, int num_vertices, int* indices, int num_indices, Rocket::Core::TextureHandle texture, const Rocket::Core::Vector2f& translation);
	virtual void EnableScissorRegion(bool enable);
	virtual void SetScissorRegion(int x, int y, int width, int height);
	void AddTexture(Rocket::Core::TextureHandle& texture_handle, osg::Image* image);
	virtual bool LoadTexture(Rocket::Core::TextureHandle& texture_handle, Rocket::Core::Vector2i& texture_dimensions, const Rocket::Core::String& source);
	virtual bool GenerateTexture(Rocket::Core::TextureHandle& texture_handle, const Rocket::Core::byte* source, const Rocket::Core::Vector2i& source_dimensions);
	virtual void ReleaseTexture(Rocket::Core::TextureHandle texture);
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
    
	std::map<Rocket::Core::TextureHandle, DKString> texture_name; //texture to name map
};
#endif //DKOSGRocketRender_H
