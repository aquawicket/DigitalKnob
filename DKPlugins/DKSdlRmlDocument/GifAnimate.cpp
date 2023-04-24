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
#include "DK/DKFile.h"
#include "DKRmlDocument/DKRmlDocument.h"
#ifdef HAVE_DKCurl
    #include "DKCurl/DKCurl.h"
#endif
//#include "FileInterface.h"

WARNING_DISABLE
#include "GifAnimate.h"
WARNING_ENABLE


bool LoadGifAnimation(SDL_Renderer* renderer, const Rml::String& source, Rml::TextureHandle& texture_handle, Rml::Vector2i& texture_dimensions) {
    size_t i;
    for (i = source.length() - 1; i > 0; i--){
        if (source[i] == '.')
            break;
    }
    Rml::String extension = source.substr(i + 1, source.length() - i);
    if (extension != "gif")
        return false;

    GifData gif_data;        

    DKString _url = source;
    if (has(_url, ":/")) { //could be http:// , https:// or C:/
        //absolute path
    }
    else if (has(_url, "//")) { //could be //www.site.com/style.css or //site.com/style.css
        //_url = DKRmlDocument::Get()->protocol+":"+_url;
        return DKERROR("DKRmlDocument::LoadUrl(): no protocol specified\n"); //absolute path without protocol
    }
    else {
        if (DKFile::PathExists(DKRmlDocument::Get()->workingPath + _url))
            _url = DKRmlDocument::Get()->workingPath + _url;
        else if (!DKFile::VerifyPath(_url))
            return DKERROR("could not locate path (" + _url + ")");
    }
    //if(_url.find("/home") == std::string::npos) //url may have unix home directory
    //	_url = DKRmlDocument::Get()->workingPath+_url;
    //return DKERROR("DKRmlDocument::LoadUrl(): cannot load relative paths\n");

    if (has(_url, "://")) {
        #ifdef HAVE_DKCurl
            DKFile::MakeDir(DKFile::local_assets + "Cache");
            DKString filename;
            DKFile::GetFileName(_url, filename);
            //remove everything after ? in the filename if there is one
            std::string::size_type found = filename.rfind("?");
            if (found > 0)
                filename = filename.substr(0, found);
            DKCurl::Get()->Download(_url, DKFile::local_assets + "Cache/" + filename);
            _url = DKFile::local_assets + "Cache/" + filename;
        #else
            return DKERROR("DKCurl unavailable! \n");
        #endif
    }

    gif_data.anim = IMG_LoadAnimation( (_url).c_str() );
    if (!gif_data.anim)
        return DKERROR("Couldn't load " + _url + ": " + SDL_GetError());

    gif_data.textures = (SDL_Texture**)SDL_calloc(gif_data.anim->count, sizeof(*gif_data.textures));
    if (!gif_data.textures) {
        IMG_FreeAnimation(gif_data.anim);
        return DKERROR("Couldn't allocate textures\n");
    }

    for (int n = 0; n < gif_data.anim->count; ++n)
        gif_data.textures[n] = SDL_CreateTextureFromSurface(renderer, gif_data.anim->frames[n]);

    texture_handle = (Rml::TextureHandle)gif_data.textures[0];
    texture_dimensions = Rml::Vector2i(gif_data.anim->w, gif_data.anim->h);
    gif_data.current_frame = 0;
    gif_data.lastTime = 0;
    gif_data.currentTime = 0;
    gif_data.delay = 1000;
    gif_map[texture_handle] = gif_data;
    return true;
}

SDL_Texture* GetGifAnimation(const Rml::TextureHandle texture) {
    if (gif_map.find(texture) != gif_map.end()) {
        GifData* g = &gif_map[texture];
        SDL_Texture* sdl_texture = (SDL_Texture*)g->textures[g->current_frame];
        g->delay = g->anim->delays[g->current_frame];
        g->currentTime = SDL_GetTicks();  //FIXME: USE SDL_GetTicks64 if avalable

		// FIXME: imprecise timer arithmetic here. Causing animations to drop to half speed
		// on slower systems. The animation should not slow, but appear choppy at the same relative speed.
        if (g->currentTime > g->lastTime + g->delay) {
            g->lastTime = g->currentTime;
            g->current_frame = (g->current_frame + 1) % g->anim->count;
        }
        return sdl_texture;
    }
    return nullptr; //(SDL_Texture*)rml_textureHandle;
}
