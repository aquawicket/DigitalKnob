/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2025 Digitalknob Team, and contributors
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

//#if USE_DKSdlRMLOPENGL

#include "DK/DK.h"
#include "DK/DKString.h"
#include "DKSdlRmlDocument/DKSdlRmlOpenGL.h"
#include "DKSDLWindow/DKSDLWindow.h"

WARNING_DISABLE
#include <RmlUi/Core.h>
#include <SDL_image.h>
WARNING_ENABLE


#if !defined(IOS) && !defined(ANDROID)
static PFNGLUSEPROGRAMOBJECTARBPROC glUseProgramObjectARB;
#endif

DKSdlRmlOpenGL::DKSdlRmlOpenGL(SDL_Renderer* renderer, SDL_Window* screen){
	DKDEBUGFUNC(renderer, screen);
    DKINFO("Using DKSdlRmlOpenGL\n");
    mRenderer = renderer;
    mScreen = screen;
}

// Called by Rml when it wants to render geometry that it does not wish to optimise.
void DKSdlRmlOpenGL::RenderGeometry(Rml::Vertex* vertices, int num_vertices, int* indices, int num_indices, const Rml::TextureHandle texture, const Rml::Vector2f& translation){
	//DKDEBUGFUNC(vertices, num_vertices, indices, num_indices, texture, translation);  //EXCESSIVE LOGGING
#if !defined(IOS) && !defined(ANDROID)
    // DISABLE SDL Shaders
	//DKSDLWindow* dkSdlWindow = DKSDLWindow::Instance("DKSDLWindow0");
	//if(!has(DKSDLWindow::Instance("DKSDLWindow0")->gl_vendor, "Microsoft")){
		glUseProgramObjectARB = (PFNGLUSEPROGRAMOBJECTARBPROC) SDL_GL_GetProcAddress("glUseProgramObjectARB");
		glUseProgramObjectARB(0);  //FIXME: this crashes on Microsoft Generic GDI drivers
	//}
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

    SDL_Texture* sdl_texture = NULL;
    if(texture){
        glEnableClientState(GL_TEXTURE_COORD_ARRAY);
        sdl_texture = (SDL_Texture*)texture;

		//Cef
		//The id is mapped to the texture in texture_name
		//If the id contains [CEF] , it is a cef image
		//Update the texture with DKSdlCef::GetTexture(id);
		///////////////////////////////////////////////////////////
        if (has(texture_name[texture], "[CEF]")){
			DKString id = texture_name[texture];
            replace(id, "[CEF]", "");
			struct DKTexture{ SDL_Texture* texture; };
			DKTexture output;
            if (DKClass::CallFunc("DKSdlCef::GetTexture", &id, &output))
                sdl_texture = output.texture;
		}
		if(!sdl_texture)
            return;
        if(SDL_GL_BindTexture(sdl_texture, &texw, &texh) == -1)
			DKREDINFO("SDL_GL_BindTexture: "+DKString(SDL_GetError())+"\n");
    }
 
    for(int  i = 0; i < num_vertices; i++){
        Positions[i] = vertices[i].position;
        Colors[i] = vertices[i].colour;
        if(sdl_texture){
            TexCoords[i].x = vertices[i].tex_coord.x * texw;
            TexCoords[i].y = vertices[i].tex_coord.y * texh;
        }
        else TexCoords[i] = vertices[i].tex_coord;
    };

#if ANDROID || IOS
	unsigned short newIndicies[num_indices];
    for (int i = 0; i < num_indices; i++){
      newIndicies[i] = (unsigned short) indices[i];
    }
#endif
    glEnableClientState(GL_VERTEX_ARRAY);
    glEnableClientState(GL_COLOR_ARRAY);
    glVertexPointer(2, GL_FLOAT, 0, &Positions[0]);
    glColorPointer(4, GL_UNSIGNED_BYTE, 0, &Colors[0]);
    glTexCoordPointer(2, GL_FLOAT, 0, &TexCoords[0]);
    glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
    glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
    if(sdl_texture){
        SDL_BlendMode bm;
        SDL_GetTextureBlendMode(sdl_texture, &bm);
        if(bm == SDL_BLENDMODE_BLEND || has(texture_name[texture],".gif")){
            glEnable(GL_BLEND);
            glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
        }
    }
#if ANDROID || IOS
	glDrawElements(GL_TRIANGLES, num_indices, GL_UNSIGNED_SHORT, newIndicies);
#else
    glDrawElements(GL_TRIANGLES, num_indices, GL_UNSIGNED_INT, indices);
#endif
    glDisableClientState(GL_VERTEX_ARRAY);
    glDisableClientState(GL_COLOR_ARRAY);
    if(sdl_texture){
        SDL_GL_UnbindTexture(sdl_texture);
        glDisableClientState(GL_TEXTURE_COORD_ARRAY);
    }
    glColor4f(1.0, 1.0, 1.0, 1.0);
    glPopMatrix();
#if USE_SDL2_gif
	for(unsigned int i=0; i<animations.size(); ++i){
		SDL_GIFAnimAuto(animations[i]);
	}
#endif
	// Reset blending and draw a fake point just outside the screen to let SDL know that it needs to reset its state in case it wants to render a texture 
    glDisable(GL_BLEND);
    SDL_SetRenderDrawBlendMode(mRenderer, SDL_BLENDMODE_NONE);
    SDL_RenderDrawPoint(mRenderer, -1, -1);
}


// Called by Rml when it wants to enable or disable scissoring to clip content.
void DKSdlRmlOpenGL::EnableScissorRegion(bool enable){
	//DKDEBUGFUNC(enable);  //EXCESSIVE LOGGING
    if (enable)
        glEnable(GL_SCISSOR_TEST);
    else
        glDisable(GL_SCISSOR_TEST);
}

// Called by Rml when it wants to change the scissor region.
void DKSdlRmlOpenGL::SetScissorRegion(int x, int y, int width, int height){
	//DKDEBUGFUNC(x, y, width, height);  //EXCESSIVE LOGGING
    int w_width, w_height;
    SDL_GetWindowSize(mScreen, &w_width, &w_height);
    glScissor(x, w_height - (y + height), width, height);
}

// Called by Rml when a texture is required by the library.
bool DKSdlRmlOpenGL::LoadTexture(Rml::TextureHandle& texture_handle, Rml::Vector2i& texture_dimensions, const Rml::String& source){
	DKDEBUGFUNC(texture_handle, texture_dimensions, source);

	//CEF Texture
	//The source variable is the id of the iframe. It will contain [CEF] in it's id.
	//We will map that id to the texture handle for later use. 
    if (has(source, "[CEF]")){
		texture_handle = reinterpret_cast<Rml::TextureHandle>(&source);
		texture_name[texture_handle] = source;
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

#if USE_SDL2_gif
	std::string src = source;
	if(has(src,".gif")){
		animations.push_back(SDL_GIFAnimLoad_RW(SDL_RWFromMem(buffer, buffer_size), mRenderer));
		SDL_Texture *texture = SDL_GIFTexture(animations[animations.size()-1]);
		SDL_GIFLoopMode(animations[animations.size()-1], GIF_REPEAT_FOR);
		if(texture){
		    texture_handle = (Rml::TextureHandle) texture;
			int w, h;
			SDL_QueryTexture(texture, NULL, NULL, &w, &h);
		    texture_dimensions = Rml::Vector2i(w, h);
		}
		else{
			return false;
		}
		texture_name[texture_handle] = source;
		return true;
	}
	else{
#endif

    /*
		SDL_Texture *texture = IMG_LoadTexture_RW(mRenderer, SDL_RWFromMem(buffer, buffer_size), 1);
	    if(texture){
		    texture_handle = (Rml::TextureHandle) texture;
			int w, h;
			SDL_QueryTexture(texture, NULL, NULL, &w, &h);
		    texture_dimensions = Rml::Vector2i(w, h);
		}
		else{
			return false;
		}
		texture_name[texture_handle] = source;
		return true;
    */
    
    size_t i;
    for (i = source.length() - 1; i > 0; i--){
    if (source[i] == '.')
        break;
    }
    Rml::String extension = source.substr(i + 1, source.length() - i);
    SDL_Surface* surface = IMG_LoadTyped_RW(SDL_RWFromMem(buffer, int(buffer_size)), 1, extension.c_str());
    if (surface){
        SDL_Texture* texture = SDL_CreateTextureFromSurface(mRenderer, surface);
        if (texture){
            texture_handle = (Rml::TextureHandle)texture;
            texture_dimensions = Rml::Vector2i(surface->w, surface->h);
            SDL_FreeSurface(surface);
        }
        else{
            return false;
        }
        //texture_name[texture_handle] = source;
        return true;
    }
#if USE_SDL2_gif
	}
    
#endif
    return false;
}

// Called by Rml when a texture is required to be built from an internally-generated sequence of pixels.
bool DKSdlRmlOpenGL::GenerateTexture(Rml::TextureHandle& texture_handle, const Rml::byte* source, const Rml::Vector2i& source_dimensions){
	//DKDEBUGFUNC(texture_handle, source, source_dimensions);  //EXCESSIVE LOGGING
    #if SDL_BYTEORDER == SDL_BIG_ENDIAN
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

    SDL_Surface *surface = SDL_CreateRGBSurfaceFrom ((void*) source, source_dimensions.x, source_dimensions.y, 32, source_dimensions.x*4, rmask, gmask, bmask, amask);
    SDL_Texture *texture = SDL_CreateTextureFromSurface(mRenderer, surface);
    SDL_SetTextureBlendMode(texture, SDL_BLENDMODE_BLEND);
    SDL_FreeSurface(surface);
    texture_handle = (Rml::TextureHandle) texture;
    return true;
}

// Called by Rml when a loaded texture is no longer required.
void DKSdlRmlOpenGL::ReleaseTexture(Rml::TextureHandle texture_handle){
	DKDEBUGFUNC(texture_handle);
    SDL_DestroyTexture((SDL_Texture*) texture_handle);
}

//#endif //USE_DKSdlRMLOPENGL