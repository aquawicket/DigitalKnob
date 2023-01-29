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

#include "DK/DK.h"
#include "DK/DKString.h"
#include "DKSFMLRml/DKSFMLRmlRenderer.h"
#include "DKSFMLWindow/DKSFMLWindow.h"

WARNING_DISABLE
#include <RmlUi/Core.h>
//#include <SFML_image.h>
#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>

#if defined RMLUI_PLATFORM_WIN32
#include <gl/Gl.h>
#include <gl/Glu.h>
#elif defined RMLUI_PLATFORM_MACOSX
#include <AGL/agl.h>
#include <OpenGL/gl.h>
#include <OpenGL/glext.h>
#include <OpenGL/glu.h>
#elif defined RMLUI_PLATFORM_UNIX
#include "RmlUi_Include_Xlib.h"
#include <GL/gl.h>
#include <GL/glext.h>
#include <GL/glu.h>
#include <GL/glx.h>
#endif
WARNING_ENABLE


//#if !defined(IOS) && !defined(ANDROID)
//static PFNGLUSEPROGRAMOBJECTARBPROC glUseProgramObjectARB;
//#endif

#ifdef ENABLE_GLEW
class RmlUiSFMLRendererGeometryHandler
{
public:
	GLuint VertexID, IndexID;
	int NumVertices;
	Rml::TextureHandle Texture;
	RmlUiSFMLRendererGeometryHandler() : VertexID(0), IndexID(0), NumVertices(0), Texture(0){};
	~RmlUiSFMLRendererGeometryHandler(){
		if(VertexID)
			glDeleteBuffers(1, &VertexID);
		if(IndexID)
			glDeleteBuffers(1, &IndexID);
		VertexID = IndexID = 0;
	};
};
#endif

struct RmlUiSFMLRendererVertex{
	sf::Vector2f Position, TexCoord;
	sf::Color Color;
};

RmlSFMLRenderer::RmlSFMLRenderer(){
}

void RmlSFMLRenderer::SetWindow(sf::RenderWindow *Window){
	MyWindow = Window;
}

sf::RenderWindow *RmlSFMLRenderer::GetWindow(){
	return MyWindow;
}

// Called by RmlUi when it wants to render geometry that it does not wish to optimise.
void RmlSFMLRenderer::RenderGeometry(Rml::Vertex* vertices, int num_vertices, int* indices, int num_indices, const Rml::TextureHandle texture, const Rml::Vector2f& translation){
	MyWindow->pushGLStates();
	initViewport();

	glTranslatef(translation.x, translation.y, 0);

	Rml::Vector<Rml::Vector2f> Positions(num_vertices);
	Rml::Vector<Rml::Colourb> Colors(num_vertices);
	Rml::Vector<Rml::Vector2f> TexCoords(num_vertices);

	for(int i = 0; i < num_vertices; i++){
		Positions[i] = vertices[i].position;
		Colors[i] = vertices[i].colour;
		TexCoords[i] = vertices[i].tex_coord;
	};

	glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState(GL_COLOR_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);

	glVertexPointer(2, GL_FLOAT, 0, &Positions[0]);
	glColorPointer(4, GL_UNSIGNED_BYTE, 0, &Colors[0]);
	glTexCoordPointer(2, GL_FLOAT, 0, &TexCoords[0]);

	glEnable(GL_BLEND);
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

	sf::Texture *sfTexture = (sf::Texture *)texture;

	if(sfTexture){
		sf::Texture::bind(sfTexture);
	}
	else{
		glDisableClientState(GL_TEXTURE_COORD_ARRAY);
		glBindTexture(GL_TEXTURE_2D, 0);
	};

	glDrawElements(GL_TRIANGLES, num_indices, GL_UNSIGNED_INT, indices);

	glDisableClientState(GL_VERTEX_ARRAY);
	glDisableClientState(GL_COLOR_ARRAY);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);

	glColor4f(1, 1, 1, 1);

	MyWindow->popGLStates();
}

// Called by RmlUi when it wants to compile geometry it believes will be static for the forseeable future.		
Rml::CompiledGeometryHandle RmlSFMLRenderer::CompileGeometry(Rml::Vertex* vertices, int num_vertices, int* indices, int num_indices, const Rml::TextureHandle texture)
{
#ifdef ENABLE_GLEW
	Rml::Vector<RmlUiSFMLRendererVertex> Data(num_vertices);

	for(std::size_t i = 0; i < Data.size(); i++){
		Data[i].Position = sf::Vector2f(vertices[i].position.x, vertices[i].position.y);
		Data[i].TexCoord = sf::Vector2f(vertices[i].tex_coord.x, vertices[i].tex_coord.y);
		Data[i].Color = sf::Color(vertices[i].colour.red, vertices[i].colour.green,
			vertices[i].colour.blue, vertices[i].colour.alpha);
	};

	RmlUiSFMLRendererGeometryHandler *Geometry = new RmlUiSFMLRendererGeometryHandler();
	Geometry->NumVertices = num_indices;

	glGenBuffers(1, &Geometry->VertexID);
	glBindBuffer(GL_ARRAY_BUFFER, Geometry->VertexID);
	glBufferData(GL_ARRAY_BUFFER, sizeof(RmlUiSFMLRendererVertex) * num_vertices, &Data[0],
		GL_STATIC_DRAW);

	glGenBuffers(1, &Geometry->IndexID);
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, Geometry->IndexID);
	glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(int) * num_indices, indices, GL_STATIC_DRAW);

	glBindBuffer(GL_ARRAY_BUFFER, 0);

	Geometry->Texture = texture;

	return (Rml::CompiledGeometryHandle)Geometry;
#else
	return (Rml::CompiledGeometryHandle)nullptr;
#endif
}

// Called by RmlUi when it wants to render application-compiled geometry.		
void RmlSFMLRenderer::RenderCompiledGeometry(Rml::CompiledGeometryHandle geometry, const Rml::Vector2f& translation){
#ifdef ENABLE_GLEW
	RmlUiSFMLRendererGeometryHandler *RealGeometry = (RmlUiSFMLRendererGeometryHandler *)geometry;

	MyWindow->pushGLStates();
	initViewport();

	glTranslatef(translation.x, translation.y, 0);
	glEnable(GL_BLEND);
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

	sf::Texture *texture = (sf::Texture *)RealGeometry->Texture;

	if(texture){
		sf::Texture::bind(texture);
	}
	else{
		glBindTexture(GL_TEXTURE_2D, 0);
	};

	glEnable(GL_VERTEX_ARRAY);
	glEnable(GL_TEXTURE_COORD_ARRAY);
	glEnable(GL_COLOR_ARRAY);

	glBindBuffer(GL_ARRAY_BUFFER, RealGeometry->VertexID);
	glVertexPointer(2, GL_FLOAT, sizeof(RmlUiSFMLRendererVertex), (const void*)0);
	glTexCoordPointer(2, GL_FLOAT, sizeof(RmlUiSFMLRendererVertex), (const void*)sizeof(sf::Vector2f));
	glColorPointer(4, GL_UNSIGNED_BYTE, sizeof(RmlUiSFMLRendererVertex), (const void*)sizeof(sf::Vector2f[2]));

	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, RealGeometry->IndexID);
	glDrawElements(GL_TRIANGLES, RealGeometry->NumVertices, GL_UNSIGNED_INT, (const void*)0);

	glBindBuffer(GL_ARRAY_BUFFER, 0);

	glDisable(GL_COLOR_ARRAY);
	glDisable(GL_TEXTURE_COORD_ARRAY);
	glDisable(GL_VERTEX_ARRAY);

	glColor4f(1, 1, 1, 1);

	MyWindow->popGLStates();
#else
	RMLUI_ASSERT(false);
#endif
}

// Called by RmlUi when it wants to release application-compiled geometry.		
void RmlSFMLRenderer::ReleaseCompiledGeometry(Rml::CompiledGeometryHandle geometry){
#ifdef ENABLE_GLEW
	delete (RmlUiSFMLRendererGeometryHandler *)geometry;
#else
	RMLUI_ASSERT(false);
#endif
}

// Called by RmlUi when it wants to enable or disable scissoring to clip content.		
void RmlSFMLRenderer::EnableScissorRegion(bool enable){
	if (enable)
		glEnable(GL_SCISSOR_TEST);
	else
		glDisable(GL_SCISSOR_TEST);
}

// Called by RmlUi when it wants to change the scissor region.		
void RmlSFMLRenderer::SetScissorRegion(int x, int y, int width, int height){
	glScissor(x, MyWindow->getSize().y - (y + height), width, height);
}

// Called by RmlUi when a texture is required by the library.		
bool RmlSFMLRenderer::LoadTexture(Rml::TextureHandle& texture_handle, Rml::Vector2i& texture_dimensions, const Rml::String& source){
	Rml::FileInterface* file_interface = Rml::GetFileInterface();
	Rml::FileHandle file_handle = file_interface->Open(source);
	if (!file_handle)
		return false;
	
	file_interface->Seek(file_handle, 0, SEEK_END);
	size_t buffer_size = file_interface->Tell(file_handle);
	file_interface->Seek(file_handle, 0, SEEK_SET);

	char* buffer = new char[buffer_size];
	file_interface->Read(buffer, buffer_size, file_handle);
	file_interface->Close(file_handle);

	sf::Texture *texture = new sf::Texture();

	if(!texture->loadFromMemory(buffer, buffer_size)){
		delete[] buffer;
		delete texture;
		return false;
	};
	delete[] buffer;

	texture_handle = (Rml::TextureHandle) texture;
	texture_dimensions = Rml::Vector2i(texture->getSize().x, texture->getSize().y);

	return true;
}

// Called by RmlUi when a texture is required to be built from an internally-generated sequence of pixels.
bool RmlSFMLRenderer::GenerateTexture(Rml::TextureHandle& texture_handle, const Rml::byte* source, const Rml::Vector2i& source_dimensions){
	sf::Texture *texture = new sf::Texture();

	if (!texture->create(sf::Vector2u(source_dimensions.x, source_dimensions.y))) {
		delete texture;
		return false;
	}

	//texture->update(source, sf::Vector2u(source_dimensions.x, source_dimensions.y)));  # FIXME
	texture_handle = (Rml::TextureHandle)texture;

	return true;
}

// Called by RmlUi when a loaded texture is no longer required.		
void RmlSFMLRenderer::ReleaseTexture(Rml::TextureHandle texture_handle){
	delete (sf::Texture *)texture_handle;
}

void RmlSFMLRenderer::initViewport(){
	glViewport(0, 0, MyWindow->getSize().x, MyWindow->getSize().y);

	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();

	glOrtho(0, MyWindow->getSize().x, MyWindow->getSize().y, 0, -1, 1);
	glMatrixMode(GL_MODELVIEW);
}

























/*
RmlSFMLRenderer::RmlSFMLRenderer(SFML_Renderer* renderer, SFML_Window* screen) {
	//DKDEBUGFUNC(renderer, screen);
    mRenderer = renderer;
    mScreen = screen;
}

// Called by Rml when it wants to render geometry that it does not wish to optimise.
void RmlSFMLRenderer::RenderGeometry(Rml::Vertex* vertices, int num_vertices, int* indices, int num_indices, const Rml::TextureHandle texture, const Rml::Vector2f& translation) {
	//DKDEBUGFUNC(vertices, num_vertices, indices, num_indices, texture, translation);  //EXCESSIVE LOGGING
#if !defined(IOS) && !defined(ANDROID)
    // DISABLE SFML Shaders
	DKSFMLWindow* dkSfmlWindow = DKSFMLWindow::Instance("DKSFMLWindow0");
	if(!has(dkSfmlWindow->gl_vendor, "Microsoft")){
		glUseProgramObjectARB = (PFNGLUSEPROGRAMOBJECTARBPROC) SFML_GL_GetProcAddress("glUseProgramObjectARB");
		glUseProgramObjectARB(0);  //FIXME: this crashes on Microsoft Generic GDI drivers
	}
#endif 

    glPushMatrix();
    glTranslatef(translation.x, translation.y, 0);
 
    std::vector<Rml::Vector2f> Positions(num_vertices);
    std::vector<Rml::Colourb> Colors(num_vertices);
    std::vector<Rml::Vector2f> TexCoords(num_vertices);
    float texw = 0.0f;
    float texh = 0.0f;
 
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);    
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR); 

    SFML_Texture* sfml_texture = NULL;
    if(texture){
        glEnableClientState(GL_TEXTURE_COORD_ARRAY);
        sfml_texture = (SFML_Texture*)texture;

		//Cef
		//The id is mapped to the texture in texture_name
		//If the id contains iframe_ , it is a cef image
		//Update the texture with DKSFMLCef::GetTexture(id);
		///////////////////////////////////////////////////////////
		if(has(texture_name[texture],"iframe_")){
			DKString id = texture_name[texture];
			replace(id,"iframe_","");
			
			struct DKTexture{ SFML_Texture* texture; };
			DKTexture output;
			if(!DKClass::CallFunc("DKSFMLCef::GetTexture", &id, &output))
                return;
			sfml_texture = output.texture;
		}
        
		if(!sfml_texture){ return; }
        if(SFML_GL_BindTexture(sfml_texture, &texw, &texh) == -1)
			DKERROR("SFML_GL_BindTexture: "+DKString(SFML_GetError())+"\n");
    }
 
    for(int  i = 0; i < num_vertices; i++) {
        Positions[i] = vertices[i].position;
        Colors[i] = vertices[i].colour;
        if(sfml_texture){
            TexCoords[i].x = vertices[i].tex_coord.x * texw;
            TexCoords[i].y = vertices[i].tex_coord.y * texh;
        }
        else TexCoords[i] = vertices[i].tex_coord;
    };

#if ANDROID || IOS
	unsigned short newIndicies[num_indices];
    for (int i = 0; i < num_indices; i++)
    {
      newIndicies[i] = (unsigned short) indices[i];
    }
#endif
    glEnableClientState(GL_VERTEX_ARRAY);
    glEnableClientState(GL_COLOR_ARRAY);
    glVertexPointer(2, GL_FLOAT, 0, &Positions[0]);
    glColorPointer(4, GL_UNSIGNED_BYTE, 0, &Colors[0]);
    glTexCoordPointer(2, GL_FLOAT, 0, &TexCoords[0]);
    glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
#if ANDROID || IOS
	glDrawElements(GL_TRIANGLES, num_indices, GL_UNSIGNED_SHORT, newIndicies);
#else
    glDrawElements(GL_TRIANGLES, num_indices, GL_UNSIGNED_INT, indices);
#endif
    glDisableClientState(GL_VERTEX_ARRAY);
    glDisableClientState(GL_COLOR_ARRAY);
    if(sfml_texture){
        SFML_GL_UnbindTexture(sfml_texture);
        glDisableClientState(GL_TEXTURE_COORD_ARRAY);
    }
    glColor4f(1.0, 1.0, 1.0, 1.0);
    glPopMatrix();
#ifdef USE_SFML_gif
	for(unsigned int i=0; i<animations.size(); ++i){
		SFML_GIFAnimAuto(animations[i]);
	}
#endif
	// Reset blending and draw a fake point just outside the screen to let SFML know that it needs to reset its state in case it wants to render a texture 
    glDisable(GL_BLEND);
    SFML_SetRenderDrawBlendMode(mRenderer, SFML_BLENDMODE_NONE);
    SFML_RenderDrawPoint(mRenderer, -1, -1);
}


// Called by Rml when it wants to enable or disable scissoring to clip content.
void RmlSFMLRenderer::EnableScissorRegion(bool enable){
	//DKDEBUGFUNC(enable);  //EXCESSIVE LOGGING
    if (enable)
        glEnable(GL_SCISSOR_TEST);
    else
        glDisable(GL_SCISSOR_TEST);
}

// Called by Rml when it wants to change the scissor region.
void RmlSFMLRenderer::SetScissorRegion(int x, int y, int width, int height){
	//DKDEBUGFUNC(x, y, width, height);  //EXCESSIVE LOGGING
    int w_width, w_height;
    SFML_GetWindowSize(mScreen, &w_width, &w_height);
    glScissor(x, w_height - (y + height), width, height);
}

// Called by Rml when a texture is required by the library.
bool RmlSFMLRenderer::LoadTexture(Rml::TextureHandle& texture_handle, Rml::Vector2i& texture_dimensions, const Rml::String& source){
	DKDEBUGFUNC(texture_handle, texture_dimensions, "Rml::String&");

	//CEF Texture
	//The source variable is the id of the iframe. It will contain iframe_ in it's id.
	//We will map that id to the texture handle for later use. 
	if(has(source,"iframe_")){//.CString()
		texture_handle = reinterpret_cast<Rml::TextureHandle>(&source);
		texture_name[texture_handle] = source;//.CString();
		return true;
	}

	Rml::FileInterface* file_interface = Rml::GetFileInterface();
    Rml::FileHandle file_handle = file_interface->Open(source);
    if (!file_handle)
        return false;

    file_interface->Seek(file_handle, 0, SEEK_END);
    size_t buffer_size = file_interface->Tell(file_handle);
    file_interface->Seek(file_handle, 0, SEEK_SET);

    char* buffer = new char[buffer_size];
    file_interface->Read(buffer, buffer_size, file_handle);
    file_interface->Close(file_handle);

#ifdef USE_SFML_gif
	std::string src = source;//.CString();
	if(has(src,".gif")){
		animations.push_back(SFML_GIFAnimLoad_RW(SFML_RWFromMem(buffer, buffer_size), mRenderer));
		SFML_Texture *texture = SFML_GIFTexture(animations[animations.size()-1]);
		SFML_GIFLoopMode(animations[animations.size()-1], GIF_REPEAT_FOR);
		if(texture){
		    texture_handle = (Rml::TextureHandle) texture;
			int w, h;
			SFML_QueryTexture(texture, NULL, NULL, &w, &h);
		    texture_dimensions = Rml::Vector2i(w, h);
		}
		else{
			return false;
		}

		texture_name[texture_handle] = source;//.CString();
		return true;
	}
	else{
#endif

		//SFML_Texture *texture = IMG_LoadTexture_RW(mRenderer, SFML_RWFromMem(buffer, buffer_size), 1);
	    //if(texture){
		//    texture_handle = (Rml::TextureHandle) texture;
		//	int w, h;
		//	SFML_QueryTexture(texture, NULL, NULL, &w, &h);
		//   texture_dimensions = Rml::Vector2i(w, h);
		//}
		//else{
		//	return false;
		//}
		//texture_name[texture_handle] = source;//.CString();
		//return true;
   
    
    size_t i;
    for (i = source.length() - 1; i > 0; i--){
    if (source[i] == '.')
        break;
    }
    Rml::String extension = source.substr(i + 1, source.length() - i);
    SFML_Surface* surface = IMG_LoadTyped_RW(SFML_RWFromMem(buffer, int(buffer_size)), 1, extension.c_str());
    if (surface) {
        SFML_Texture* texture = SFML_CreateTextureFromSurface(mRenderer, surface);
        if (texture) {
            texture_handle = (Rml::TextureHandle)texture;
            texture_dimensions = Rml::Vector2i(surface->w, surface->h);
            SFML_FreeSurface(surface);
        }
        else{
            return false;
        }
        return true;
    }
#ifdef USE_SFML_gif
	}
    
#endif
    return false;
}

// Called by Rml when a texture is required to be built from an internally-generated sequence of pixels.
bool RmlSFMLRenderer::GenerateTexture(Rml::TextureHandle& texture_handle, const Rml::byte* source, const Rml::Vector2i& source_dimensions){
	//DKDEBUGFUNC(texture_handle, source, source_dimensions); //EXCESSIVE LOGGING
    #if SFML_BYTEORDER == SFML_BIG_ENDIAN
        Uint32 rmask = 0xff000000;
        Uint32 gmask = 0x00ff0000;
        Uint32 bmask = 0x0000ff00;
        Uint32 amask = 0x000000ff;
    #else
        Uint32 rmask = 0x000000ff;
        Uint32 gmask = 0x0000ff00;
        Uint32 bmask = 0x00ff0000;
        Uint32 amask = 0xff000000;
    #endif

    SFML_Surface *surface = SFML_CreateRGBSurfaceFrom ((void*) source, source_dimensions.x, source_dimensions.y, 32, source_dimensions.x*4, rmask, gmask, bmask, amask);
    SFML_Texture *texture = SFML_CreateTextureFromSurface(mRenderer, surface);
    SFML_SetTextureBlendMode(texture, SFML_BLENDMODE_BLEND);
    SFML_FreeSurface(surface);
    texture_handle = (Rml::TextureHandle) texture;
    return true;
}

// Called by Rml when a loaded texture is no longer required.
void RmlSFMLRenderer::ReleaseTexture(Rml::TextureHandle texture_handle){
	DKDEBUGFUNC(texture_handle);
    SFML_DestroyTexture((SFML_Texture*) texture_handle);
}
*/