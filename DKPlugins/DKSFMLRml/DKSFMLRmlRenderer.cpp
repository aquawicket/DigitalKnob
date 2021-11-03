#include <RmlUi/Core.h>
#include <SFML_image.h>
#include "DK/DK.h"
#include "DK/DKString.h"
#include "DKSFMLRml/DKSFMLRmlRenderer.h"
#include "DKSFMLWindow/DKSFMLWindow.h"

#if !defined(IOS) && !defined(ANDROID)
static PFNGLUSEPROGRAMOBJECTARBPROC glUseProgramObjectARB;
#endif

RmlSFML2Renderer::RmlSFML2Renderer(SFML_Renderer* renderer, SFML_Window* screen) {
	//DKDEBUGFUNC(renderer, screen);
    mRenderer = renderer;
    mScreen = screen;
}

// Called by Rml when it wants to render geometry that it does not wish to optimise.
void RmlSFML2Renderer::RenderGeometry(Rml::Vertex* vertices, int num_vertices, int* indices, int num_indices, const Rml::TextureHandle texture, const Rml::Vector2f& translation) {
	//DKDEBUGFUNC(vertices, num_vertices, indices, num_indices, texture, translation);
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

#if defined(ANDROID) || defined(IOS)
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
#if defined(ANDROID) || defined(IOS)
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
#ifdef USE_SFML2_gif
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
void RmlSFML2Renderer::EnableScissorRegion(bool enable)
{
	//DKDEBUGFUNC(enable);
    if (enable)
        glEnable(GL_SCISSOR_TEST);
    else
        glDisable(GL_SCISSOR_TEST);
}

// Called by Rml when it wants to change the scissor region.
void RmlSFML2Renderer::SetScissorRegion(int x, int y, int width, int height)
{
	//DKDEBUGFUNC(x, y, width, height);
    int w_width, w_height;
    SFML_GetWindowSize(mScreen, &w_width, &w_height);
    glScissor(x, w_height - (y + height), width, height);
}

// Called by Rml when a texture is required by the library.
bool RmlSFML2Renderer::LoadTexture(Rml::TextureHandle& texture_handle, Rml::Vector2i& texture_dimensions, const Rml::String& source)
{
	//DKDEBUGFUNC(texture_handle, texture_dimensions, "Rml::String&");

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

#ifdef USE_SFML2_gif
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

    /*
		SFML_Texture *texture = IMG_LoadTexture_RW(mRenderer, SFML_RWFromMem(buffer, buffer_size), 1);
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
    */
    
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
#ifdef USE_SFML2_gif
	}
    
#endif
    return false;
}

// Called by Rml when a texture is required to be built from an internally-generated sequence of pixels.
bool RmlSFML2Renderer::GenerateTexture(Rml::TextureHandle& texture_handle, const Rml::byte* source, const Rml::Vector2i& source_dimensions)
{
	//DKDEBUGFUNC(texture_handle, source, source_dimensions);
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
void RmlSFML2Renderer::ReleaseTexture(Rml::TextureHandle texture_handle)
{
	//DKDEBUGFUNC(texture_handle);
    SFML_DestroyTexture((SFML_Texture*) texture_handle);
}
