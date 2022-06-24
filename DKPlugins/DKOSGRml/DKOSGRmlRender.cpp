#include "DK/stdafx.h"

#include "DKOSGRocketRender.h"
#include <osg/BlendFunc>
#include <osg/MatrixTransform>
#include <assert.h>
#include <osg/Geode>
#include <osgDB/FileUtils>
#include <osgDB/ReadFile>
#include <osg/ImageStream>
#include <osg/ImageSequence>
#include <Rocket/Core/Texture.h>

#include "DKGLInfo.h"

//#define USE_SHADERS //OpenGL < 1.1

#ifdef USE_SHADERS

std::string uniformName = "LibRocketPosition";

///////////////////////////////////////////////////
DKOSGRocketRender::DKOSGRocketRender():
_scissorsEnabled(false),
_fullScreen(false),
_geode(new osg::Geode()),
_renderTarget(NULL)
{
	_geode->setDataVariance(osg::Object::DYNAMIC);
}

///////////////////////////////////////////////////
DKOSGRocketRender::~DKOSGRocketRender()
{

}

/////////////////////////////////////////////////////////////////////////////////////////////
void DKOSGRocketRender::setRenderTarget(osg::Group* grp, int w, int h, bool fullscreen)
{
	_fullScreen = fullscreen;
	_screenWidth = w;
	_screenHeight = h;

	if(_renderTarget != grp){
		if(_renderTarget != NULL){
			_renderTarget->removeChild(_geode);
		}
		
		_renderTarget = grp;
		_renderTarget->addChild(_geode);
		_renderTargetStateSet = grp->getOrCreateStateSet();
		_renderTargetStateSet->setMode(GL_LIGHTING,osg::StateAttribute::OFF);
		_renderTargetStateSet->setMode(GL_BLEND,osg::StateAttribute::ON);
		_renderTargetStateSet->setMode(GL_DEPTH_TEST,osg::StateAttribute::OFF);

		osg::Program* prg = new osg::Program();

		std::string vertexShader = ""
#ifdef LINUX
			"#version 100 \n"
#endif
			"uniform vec2 LibRocketPosition; \n"
			"varying vec2 texCoord; \n"
			"varying vec4 out_color; \n"
			"\n"
			"void main() { \n"
				"texCoord = vec2(gl_MultiTexCoord0); \n"
				"vec4 pos = gl_Vertex + vec4(LibRocketPosition, 0, 0); \n"
				"gl_Position = gl_ModelViewProjectionMatrix * pos; \n"
				"out_color = gl_Color; \n"
			"} \n";
		osg::Shader* vShader = new osg::Shader(osg::Shader::VERTEX, vertexShader);
		prg->addShader(vShader);

		std::string fragmentShader = ""
#ifdef LINUX
			"#version 100 \n"
#endif
			"uniform sampler2D myTexture; \n"
			"uniform bool is_texture; \n"
#if defined(MAC) || defined(WIN32)
			"varying vec2 texCoord; \n"
			"varying vec4 out_color; \n"
#else
            "varying lowp vec2 texCoord; \n"
            "varying lowp vec4 out_color; \n"
#endif
			"\n"
			"void main() { \n"
				"if(is_texture){ \n"
					"gl_FragColor = out_color * texture2D(myTexture, texCoord); \n"
				"} \n"
				"else{ \n"
					"gl_FragColor = out_color; \n"
				"} \n"
			"} \n";

		osg::Shader* fShader = new osg::Shader(osg::Shader::FRAGMENT,  fragmentShader);
		prg->addShader(fShader);

		_geode->getOrCreateStateSet()->setAttributeAndModes(prg);
	}

	_geode->removeDrawables(0, _geode->getNumDrawables());
}

////////////////////////////////////////////////////////////
osg::Group* DKOSGRocketRender::getRenderTarget() const
{
	return _renderTarget;
}

/*
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
osg::Object* DKOSGRocketRender::createGeometry(Rocket::Core::Vertex* vertices, int num_vertices, int* indices, int num_indices, Rocket::Core::TextureHandle texture, bool useVBOs)
{
	osg::Geometry* geometry = new osg::Geometry();
	geometry->setUseDisplayList(false);
	geometry->setUseVertexBufferObjects(useVBOs);
	geometry->setDataVariance(osg::Object::DYNAMIC);

	osg::Vec3Array* vertarray = new osg::Vec3Array(num_vertices);
	osg::Vec4Array* colorarray = new osg::Vec4Array(num_vertices);
	osg::ref_ptr<osg::Vec2Array> texcoords = new osg::Vec2Array(num_vertices);

	for(int i = 0; i < num_vertices; ++i){
		Rocket::Core::Vertex* vert = &vertices[i];
		Rocket::Core::Colourb c = vert->colour;
		(*vertarray)[i].set(vert->position.x, vert->position.y, 0);
		(*colorarray)[i].set(c.red / 255.0f, c.green / 255.0f, c.blue / 255.0f, c.alpha / 255.0f);
		(*texcoords)[i].set(vert->tex_coord.x, vert->tex_coord.y);
	}

#ifdef ANDROID
    osg::DrawElementsUShort* elements = new osg::DrawElementsUShort(osg::PrimitiveSet::TRIANGLES, num_indices);
    for(int i = 0; i < num_indices; ++i){
		elements->setElement(i, indices[i]);
    }
#else
    osg::DrawElementsUInt* elements = new osg::DrawElementsUInt(osg::PrimitiveSet::TRIANGLES, num_indices, (const GLuint*)indices, 0);
#endif

	geometry->setVertexArray(vertarray);
	geometry->setColorArray(colorarray);
	geometry->setColorBinding(osg::Geometry::BIND_PER_VERTEX);
	geometry->addPrimitiveSet(elements);

	if(texture != 0){
		osg::Texture* tex = reinterpret_cast<osg::Texture*>(texture);
		geometry->setTexCoordArray(0, texcoords);
		osg::StateSet* ss = geometry->getOrCreateStateSet();
		ss->setTextureAttributeAndModes(0, tex, osg::StateAttribute::ON);

		osg::Uniform* is_texture = new osg::Uniform(osg::Uniform::BOOL, "is_texture");
		geometry->getOrCreateStateSet()->addUniform(is_texture);
		is_texture->set(true);
	}
	else{
		osg::Texture* tex = reinterpret_cast<osg::Texture*>(texture);
		geometry->setTexCoordArray(0, texcoords);
		osg::StateSet* ss = geometry->getOrCreateStateSet();
		ss->setTextureAttributeAndModes(0, tex, osg::StateAttribute::ON);

		osg::Uniform* is_texture = new osg::Uniform(osg::Uniform::BOOL, "is_texture");
		geometry->getOrCreateStateSet()->addUniform(is_texture);
		is_texture->set(false);
	}

		return geometry;
}
*/

/// Called by Rocket when it wants to render geometry that the application does not wish to optimise. Note that
/// Rocket renders everything as triangles.
/// @param[in] vertices The geometry's vertex data.
/// @param[in] num_vertices The number of vertices passed to the function.
/// @param[in] indices The geometry's index data.
/// @param[in] num_indices The number of indices passed to the function. This will always be a multiple of three.
/// @param[in] texture The texture to be applied to the geometry. This may be NULL, in which case the geometry is untextured.
/// @param[in] translation The translation to apply to the geometry.
void DKOSGRocketRender::RenderGeometry(Rocket::Core::Vertex* vertices, int num_vertices, int* indices, int num_indices, Rocket::Core::TextureHandle texture, const Rocket::Core::Vector2f& translation)
{
	osg::Geometry* geometry = static_cast<osg::Geometry*>(createGeometry(vertices, num_vertices, indices, num_indices, texture, false));
	osg::MatrixTransform* trans = new osg::MatrixTransform();
	trans->setMatrix(osg::Matrix::translate(osg::Vec3(translation.x, translation.y, 0)));
	osg::Geode* g = new osg::Geode();
	g->addDrawable(geometry);
	trans->addChild(g);

     if(_scissorsEnabled){
         geometry->getOrCreateStateSet()->setAttributeAndModes(_scissorTest, osg::StateAttribute::ON);
     }

     _renderTarget->addChild(trans);
	_instantGeometryMap.push_back(trans);
}

/*
/// Called by Rocket when it wants to compile geometry it believes will be static for the forseeable future.
/// If supported, this should be return a pointer to an optimised, application-specific version of the data. If
/// not, do not override the function or return NULL; the simpler RenderGeometry() will be called instead.
/// @param[in] vertices The geometry's vertex data.
/// @param[in] num_vertices The number of vertices passed to the function.
/// @param[in] indices The geometry's index data.
/// @param[in] num_indices The number of indices passed to the function. This will always be a multiple of three.
/// @param[in] texture The texture to be applied to the geometry. This may be NULL, in which case the geometry is untextured.
/// @return The application-specific compiled geometry. Compiled geometry will be stored and rendered using RenderCompiledGeometry() in future calls, and released with ReleaseCompiledGeometry() when it is no longer needed.
Rocket::Core::CompiledGeometryHandle DKOSGRocketRender::CompileGeometry(Rocket::Core::Vertex* vertices, int num_vertices, int* indices, int num_indices, Rocket::Core::TextureHandle texture)
{
	osg::Geometry* node = static_cast<osg::Geometry*>(createGeometry(vertices, num_vertices, indices, num_indices, texture, true));
	node->ref();
	osg::Uniform* posuni = new osg::Uniform(osg::Uniform::FLOAT_VEC2, uniformName);
	node->getOrCreateStateSet()->addUniform(posuni);
	return reinterpret_cast<Rocket::Core::CompiledGeometryHandle>(node);
}

/// Called by Rocket when it wants to render application-compiled geometry.
/// @param[in] geometry The application-specific compiled geometry to render.
/// @param[in] translation The translation to apply to the geometry.
void DKOSGRocketRender::RenderCompiledGeometry(Rocket::Core::CompiledGeometryHandle geo, const Rocket::Core::Vector2f& translation)
{
	osg::Geometry* geometry = reinterpret_cast<osg::Geometry*>(geo);
	osg::StateSet* ss = geometry->getOrCreateStateSet();
	osg::Uniform* uni = ss->getUniform(uniformName);
	assert(uni);
	assert(uni->getType() == osg::Uniform::FLOAT_VEC2);
	uni->set(osg::Vec2(translation.x, translation.y));

	if(_scissorsEnabled){
		geometry->getOrCreateStateSet()->setAttributeAndModes(_scissorTest, osg::StateAttribute::ON);
	}
	else{
		if(ss){
			geometry->getOrCreateStateSet()->removeAttribute(_scissorTest);
		}
	}

	if(geometry->getNumParents() == 0){
		_geode->addDrawable(geometry);
	}

}

/// Called by Rocket when it wants to release application-compiled geometry.
/// @param[in] geometry The application-specific compiled geometry to release.
void DKOSGRocketRender::ReleaseCompiledGeometry(Rocket::Core::CompiledGeometryHandle geo)
{
	osg::Geometry* geometry = reinterpret_cast<osg::Geometry*>(geo);

	if(geometry->getNumParents() != 0){
		assert(geometry->getNumParents() == 1);
		_geode->removeDrawable(geometry);
		assert(geometry->getNumParents() == 0);
	}
	
	geometry->unref();
}
*/

/// Called by Rocket when it wants to enable or disable scissoring to clip content.
/// @param[in] enable True if scissoring is to enabled, false if it is to be disabled.
void DKOSGRocketRender::EnableScissorRegion(bool enable)
{
	// cannot use scissors when rendering to in-scene geometry
	if(_fullScreen){
		_scissorsEnabled = enable;
	}
}

/// Called by Rocket when it wants to change the scissor region.
/// @param[in] x The left-most pixel to be rendered. All pixels to the left of this should be clipped.
/// @param[in] y The top-most pixel to be rendered. All pixels to the top of this should be clipped.
/// @param[in] width The width of the scissored region. All pixels to the right of (x + width) should be clipped.
/// @param[in] height The height of the scissored region. All pixels to below (y + height) should be clipped.
void DKOSGRocketRender::SetScissorRegion(int x, int y, int width, int height)
{
	_scissorTest = new osg::Scissor(x, _screenHeight - y - height, width, height);
}

////////////////////////////////////////////////////////////////////////////////////////////////
void DKOSGRocketRender::AddTexture(Rocket::Core::TextureHandle& texture_handle, osg::Image* image)
{
	osg::ref_ptr<osg::Texture2D> texture = new osg::Texture2D();
	texture->setResizeNonPowerOfTwoHint(false);
	texture->setImage(image);
	texture->setWrap(osg::Texture::WRAP_S, osg::Texture::CLAMP_TO_EDGE);
	texture->setWrap(osg::Texture::WRAP_T, osg::Texture::CLAMP_TO_EDGE);

	if(_fullScreen){
		texture->setFilter(osg::Texture::MIN_FILTER, osg::Texture::NEAREST);
		texture->setFilter(osg::Texture::MAG_FILTER, osg::Texture::NEAREST);
	}
	else{
		texture->setFilter(osg::Texture::MIN_FILTER, osg::Texture::LINEAR);
		texture->setFilter(osg::Texture::MAG_FILTER, osg::Texture::LINEAR);
	}
	
	texture_handle = reinterpret_cast<Rocket::Core::TextureHandle>(texture.get());
	texture->ref();
}

/// Called by Rocket when a texture is required by the library.
/// @param[out] texture_handle The handle to write the texture handle for the loaded texture to.
/// @param[out] texture_dimensions The variable to write the dimensions of the loaded texture.
/// @param[in] source The application-defined image source, joined with the path of the referencing document.
/// @return True if the load attempt succeeded and the handle and dimensions are valid, false if not.
bool DKOSGRocketRender::LoadTexture(Rocket::Core::TextureHandle& texture_handle, Rocket::Core::Vector2i& texture_dimensions, const Rocket::Core::String& source)
{
	std::string src = source.CString();

	// Hack: Sometimes libRocket attaches that string to paths, sometimes it doesn't (when cloning elements)
    /*
	if(src.substr(0, 10) != "LibRocket/"){
         src = "LibRocket/" + src;
    }
	*/

	std::string path = osgDB::findDataFile(src);
	if(path.empty()){
		return false;
	}
	
	osg::ref_ptr<osg::Image> img = osgDB::readImageFile(path);
	if(!img.valid()){
		return false;
	}

	if(!has(path,".gif")){
		img->flipVertical();
	}

	if(img == NULL) return false;

	texture_dimensions.x = img->s();
	texture_dimensions.y = img->t();

	AddTexture(texture_handle, img);

	if(has(path,".gif")){
		osg::ImageStream* imagestream = dynamic_cast<osg::ImageStream*>(img.get());
		if(imagestream){
			imagestream->play();
		}
	}

	return true;
}

/// Called by Rocket when a texture is required to be built from an internally-generated sequence of pixels.
/// @param[out] texture_handle The handle to write the texture handle for the generated texture to.
/// @param[in] source The raw 8-bit texture data. Each pixel is made up of four 8-bit values, indicating red, green, blue and alpha in that order.
/// @param[in] source_dimensions The dimensions, in pixels, of the source data.
/// @return True if the texture generation succeeded and the handle is valid, false if not.
bool DKOSGRocketRender::GenerateTexture(Rocket::Core::TextureHandle& texture_handle, const Rocket::Core::byte* source, const Rocket::Core::Vector2i& source_dimensions)
{
	osg::ref_ptr<osg::Image> img = new osg::Image();
	int w = source_dimensions.x;
	int h = source_dimensions.y;
	img->allocateImage(w, h, 1, GL_RGBA, GL_UNSIGNED_BYTE);
	memcpy(img->data(), source, w * h * 4 * sizeof(Rocket::Core::byte));
	AddTexture(texture_handle, img);
	return true;
}

/// Called by Rocket when a loaded texture is no longer required.
/// @param texture The texture handle to release.
void DKOSGRocketRender::ReleaseTexture(Rocket::Core::TextureHandle th)
{
	osg::Texture2D* texture = reinterpret_cast<osg::Texture2D*>(th);
	texture->unref();
}

/// Called when this render interface is released.
void DKOSGRocketRender::Release()
{

}































#else //!USE_SHADERS
//////////////////////////////////////////////////
DKOSGRocketRender::DKOSGRocketRender()
: _scissorsEnabled(false), _fullScreen(false)
{

}

///////////////////////////////////////////////////
DKOSGRocketRender::~DKOSGRocketRender()
{
	//delete _renderTarget;
	//delete _renderTargetStateSet;
}

///////////////////////////////////////////////////////////////////////////////////////
void DKOSGRocketRender::setRenderTarget(osg::Group* grp, int w, int h, bool fullscreen)
{
	//DKLog("DKOSGRocketRender::setRenderTarget() width:"+toString(w)+" height:"+toString(h),DKINFO);

	_fullScreen = fullscreen;
	_screenWidth = w;
	_screenHeight = h;
    
	unsigned int i = 0;
	while(i < grp->getNumChildren()){
		osg::Node* node = grp->getChild(i);
		if(node->referenceCount() == 2){
			grp->removeChild(i);
			node->unref();
		}
		else{
			node->unref();
			++i;
		}
	}

	if(_renderTarget != grp){
		 _renderTarget = grp;
		 _renderTargetStateSet = grp->getOrCreateStateSet();
		 _renderTargetStateSet->setMode(GL_LIGHTING,osg::StateAttribute::OFF);
		 _renderTargetStateSet->setMode(GL_BLEND,osg::StateAttribute::ON);
		 _renderTargetStateSet->setMode(GL_DEPTH_TEST,osg::StateAttribute::OFF);
	}
}

////////////////////////////////////////////////////////////
osg::Group* DKOSGRocketRender::getRenderTarget() const
{
	return _renderTarget;
}

/// Called by Rocket when it wants to render geometry that the application does not wish to optimise. Note that
/// Rocket renders everything as triangles.
/// @param[in] vertices The geometry's vertex data.
/// @param[in] num_vertices The number of vertices passed to the function.
/// @param[in] indices The geometry's index data.
/// @param[in] num_indices The number of indices passed to the function. This will always be a multiple of three.
/// @param[in] texture The texture to be applied to the geometry. This may be NULL, in which case the geometry is untextured.
/// @param[in] translation The translation to apply to the geometry.
void DKOSGRocketRender::RenderGeometry(Rocket::Core::Vertex* vertices, int num_vertices, int* indices, int num_indices, Rocket::Core::TextureHandle texture, const Rocket::Core::Vector2f& translation)
{

	//Cef
	///////////////////////////////////////////////////////////
	if(has(texture_name[texture],"iframe_")){
		//return;
		osg::Image* cef_image = static_cast<osg::Image*>(DKClass::CallFunc("DKOSGCef::GetTexture"));
		if(!cef_image){ return; }

		osg::ref_ptr<osg::Texture2D> cef_texture = new osg::Texture2D();//LEAK
		cef_texture->setResizeNonPowerOfTwoHint(false);
		cef_texture->setImage(cef_image);
		cef_texture->setWrap(osg::Texture::WRAP_S, osg::Texture::CLAMP_TO_EDGE);
		cef_texture->setWrap(osg::Texture::WRAP_T, osg::Texture::CLAMP_TO_EDGE);
		if(_fullScreen){
			cef_texture->setFilter(osg::Texture::MIN_FILTER, osg::Texture::NEAREST);
			cef_texture->setFilter(osg::Texture::MAG_FILTER, osg::Texture::NEAREST);
		}
		else{
			cef_texture->setFilter(osg::Texture::MIN_FILTER, osg::Texture::LINEAR);
			cef_texture->setFilter(osg::Texture::MAG_FILTER, osg::Texture::LINEAR);
		}
		osg::StateSet* ss = new osg::StateSet();//LEAK
		ss->setTextureAttributeAndModes(0, cef_texture, osg::StateAttribute::ON);
		//ss->ref();
		texture = reinterpret_cast<Rocket::Core::TextureHandle>(ss);

		//AddTexture(texture, cef_image);
	}

	osg::ref_ptr<osg::Geometry> geometry = new osg::Geometry();//LEAK
	geometry->setUseDisplayList(false);
	geometry->setUseVertexBufferObjects(false);
	geometry->setDataVariance(osg::Object::DYNAMIC);

	osg::ref_ptr<osg::Vec3Array> vertarray = new osg::Vec3Array(num_vertices);//LEAK
	osg::ref_ptr<osg::Vec4Array> colorarray = new osg::Vec4Array(num_vertices);//LEAK
	osg::ref_ptr<osg::Vec2Array> texcoords = new osg::Vec2Array(num_vertices);

	for(int i = 0; i < num_vertices; ++i){
		Rocket::Core::Vertex vert = vertices[i];
		Rocket::Core::Colourb c = vert.colour;
		(*vertarray)[i].set(vert.position.x, vert.position.y, 0);
		(*colorarray)[i].set(c.red / 255.0f, c.green / 255.0f, c.blue / 255.0f, c.alpha / 255.0f);
		
		if(texture != 0 && num_vertices == 4 && !texture_name[texture].empty()){ //ignore text
			vert.tex_coord.y = 1.0f - vert.tex_coord.y; //flip
		}
			
		(*texcoords)[i].set(vert.tex_coord.x, vert.tex_coord.y);
	}

#if defined(ANDROID)// || defined (IOS)
    osg::DrawElementsUShort* elements = new osg::DrawElementsUShort(osg::PrimitiveSet::TRIANGLES, num_indices);
    for(int i = 0; i < num_indices; ++i){
		elements->setElement(i, indices[i]);
    }
#else
	//LEAK
    osg::ref_ptr<osg::DrawElementsUInt> elements = new osg::DrawElementsUInt(osg::PrimitiveSet::TRIANGLES, num_indices, (const GLuint*)indices, 0);
#endif
	geometry->setVertexArray(vertarray);
	geometry->setColorArray(colorarray);
	geometry->setColorBinding(osg::Geometry::BIND_PER_VERTEX);

	geometry->addPrimitiveSet(elements);

	if(texture != 0){
		osg::ref_ptr<osg::StateSet> ss = reinterpret_cast<osg::StateSet*>(texture);//LEAK
		geometry->setTexCoordArray(0, texcoords);
		geometry->setStateSet(ss); 
	}

	osg::ref_ptr<osg::Geode> geode = new osg::Geode();
    geode->setCullingActive(false);
    geode->setDataVariance(osg::Object::DYNAMIC);
    geode->addDrawable(geometry);//LEAK

	osg::ref_ptr<osg::MatrixTransform> mt = new osg::MatrixTransform(); 
    mt->addChild(geode);
    mt->setCullingActive(false);
    mt->setDataVariance(osg::Object::DYNAMIC);

	mt->setMatrix(osg::Matrix::translate(osg::Vec3(translation.x, translation.y, 0)));

    if(_scissorsEnabled){
	    mt->getOrCreateStateSet()->setAttributeAndModes(_scissorTest, osg::StateAttribute::ON);
    }
	
	_renderTarget->addChild(mt);
	mt->ref();
}

/// Called by Rocket when it wants to enable or disable scissoring to clip content.
/// @param[in] enable True if scissoring is to enabled, false if it is to be disabled.
void DKOSGRocketRender::EnableScissorRegion(bool enable)
{
	if(_fullScreen){
		_scissorsEnabled = enable;
	}
}

/// Called by Rocket when it wants to change the scissor region.
/// @param[in] x The left-most pixel to be rendered. All pixels to the left of this should be clipped.
/// @param[in] y The top-most pixel to be rendered. All pixels to the top of this should be clipped.
/// @param[in] width The width of the scissored region. All pixels to the right of (x + width) should be clipped.
/// @param[in] height The height of the scissored region. All pixels to below (y + height) should be clipped.
void DKOSGRocketRender::SetScissorRegion(int x, int y, int width, int height)
{
	_scissorTest = new osg::Scissor(x, _screenHeight - y - height, width, height);
}

//////////////////////////////////////////////////////////////////////////////////////////////////
void DKOSGRocketRender::AddTexture(Rocket::Core::TextureHandle& texture_handle, osg::Image* image)
{
	osg::ref_ptr<osg::Texture2D> texture = new osg::Texture2D();//LEAK
	texture->setResizeNonPowerOfTwoHint(false);
	texture->setImage(image);
	texture->setWrap(osg::Texture::WRAP_S, osg::Texture::CLAMP_TO_EDGE);
	texture->setWrap(osg::Texture::WRAP_T, osg::Texture::CLAMP_TO_EDGE);
	if(_fullScreen){
		texture->setFilter(osg::Texture::MIN_FILTER, osg::Texture::NEAREST);
		texture->setFilter(osg::Texture::MAG_FILTER, osg::Texture::NEAREST);
	}
	else{
		texture->setFilter(osg::Texture::MIN_FILTER, osg::Texture::LINEAR);
		texture->setFilter(osg::Texture::MAG_FILTER, osg::Texture::LINEAR);
	}
	osg::StateSet* ss = new osg::StateSet();//LEAK
	ss->setTextureAttributeAndModes(0, texture, osg::StateAttribute::ON);
	ss->ref();
	texture_handle = reinterpret_cast<Rocket::Core::TextureHandle>(ss);
}

/// Called by Rocket when a texture is required by the library.
/// @param[out] texture_handle The handle to write the texture handle for the loaded texture to.
/// @param[out] texture_dimensions The variable to write the dimensions of the loaded texture.
/// @param[in] source The application-defined image source, joined with the path of the referencing document.
/// @return True if the load attempt succeeded and the handle and dimensions are valid, false if not.
bool DKOSGRocketRender::LoadTexture(Rocket::Core::TextureHandle& texture_handle, Rocket::Core::Vector2i& texture_dimensions, const Rocket::Core::String& source)
{
	DKString src = source.CString();

	//CEF Texture
	if(has(src,"iframe_")){
		texture_handle = (Rocket::Core::TextureHandle)src.c_str();
		texture_name[texture_handle] = src;
		return true;
	}
	
    std::string path = osgDB::findDataFile(src);
    if(path.empty()){
         return false;
    }

	//Gif images crash when OpenGL drivers are not installed
	if (has(DKGLInfo::Instance("DKGLInfo")->_renderer, "GDI") && has(path, ".gif")){
		return false;
	}

    osg::ref_ptr<osg::Image> img = osgDB::readImageFile(path);
    if(!img.valid()){
		return false;
    }
	
    if(img == NULL) return false;

	texture_dimensions.x = img->s();
	texture_dimensions.y = img->t();

	AddTexture(texture_handle, img);

	if (has(path, ".gif")){
		osg::ImageStream* imagestream = dynamic_cast<osg::ImageStream*>(img.get());
		if (imagestream){
			imagestream->play();
		}
	}

	texture_name[texture_handle] = path;
	return true;
}

/// Called by Rocket when a texture is required to be built from an internally-generated sequence of pixels.
/// @param[out] texture_handle The handle to write the texture handle for the generated texture to.
/// @param[in] source The raw 8-bit texture data. Each pixel is made up of four 8-bit values, indicating red, green, blue and alpha in that order.
/// @param[in] source_dimensions The dimensions, in pixels, of the source data.
/// @return True if the texture generation succeeded and the handle is valid, false if not.
bool DKOSGRocketRender::GenerateTexture(Rocket::Core::TextureHandle& texture_handle, const Rocket::Core::byte* source, const Rocket::Core::Vector2i& source_dimensions)
{
	osg::ref_ptr<osg::Image> img = new osg::Image();//LEAK
	int w = source_dimensions.x;
	int h = source_dimensions.y;
	img->allocateImage(w, h, 1, GL_RGBA, GL_UNSIGNED_BYTE);
	memcpy(img->data(), source, w * h * 4 * sizeof(Rocket::Core::byte));

	AddTexture(texture_handle, img);
	return true;
}

/// Called by Rocket when a loaded texture is no longer required.
/// @param texture The texture handle to release.
void DKOSGRocketRender::ReleaseTexture(Rocket::Core::TextureHandle th)
{
	osg::Texture2D* texture = reinterpret_cast<osg::Texture2D*>(th);
	texture->unref();
}

/// Called when this render interface is released.
void DKOSGRocketRender::Release()
{

}

#endif //USE_Shaders
