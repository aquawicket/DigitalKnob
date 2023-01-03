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
* The above copyright noticeand this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/
#include "DK/stdafx.h"
#include "DKRml/DKRmlFile.h"
#include "DKRml/DKRml.h"
#ifdef HAVE_DKCurl
	#include "DKCurl/DKCurl.h"
#endif


Rml::FileHandle DKRmlFile::Open(const Rml::String& path){
	DKDEBUGFUNC("path");
	if(path.empty())
		return DKERROR("path invalid");

	DKString _url = path;
	
	if (has(_url, ":/")) { //could be http:// , https:// or C:/
		//absolute path
	}
	else if(has(_url,"//")){ //could be //www.site.com/style.css or //site.com/style.css
		//_url = DKRml::Get()->protocol+":"+_url;
		return DKERROR("DKRml::LoadUrl(): no protocol specified\n"); //absolute path without protocol
	}
	else{
		if(DKFile::PathExists(DKRml::Get()->workingPath+_url))
			_url = DKRml::Get()->workingPath+_url;
		else if(!DKFile::VerifyPath(_url)){
			return DKERROR("could not locate path ("+_url+")");
		}
		//if(_url.find("/home") == std::string::npos) //url may have unix home directory
		//	_url = DKRml::Get()->workingPath+_url;
		//return DKERROR("DKRml::LoadUrl(): cannot load relative paths\n");
	}
	if(has(_url,"://")){
		DKFile::MakeDir(DKFile::local_assets+"Cache");
		DKString filename;
		DKFile::GetFileName(_url, filename);
		//remove everything after ? in the filename if there is one
		std::string::size_type found = filename.rfind("?");
		if(found > 0)
			filename = filename.substr(0,found);
#ifdef HAVE_DKCurl
		DKCurl::Get()->Download(_url, DKFile::local_assets+"Cache/"+filename);
		_url = DKFile::local_assets+"Cache/"+filename;
#endif
	}

	FILE* fp = fopen(_url.c_str(), "rb");
	return (Rml::FileHandle) fp;
}

/// Closes a previously opened file.
/// @param file The file handle previously opened through Open().
void DKRmlFile::Close(Rml::FileHandle file){
	DKDEBUGFUNC(file);
	fclose((FILE*) file);
}

/// Reads data from a previously opened file.
/// @param buffer The buffer to be read into.
/// @param size The number of bytes to read into the buffer.
/// @param file The handle of the file.
/// @return The total number of bytes read into the buffer.
size_t DKRmlFile::Read(void* buffer, size_t size, Rml::FileHandle file){
	DKDEBUGFUNC(buffer, size, file);
	return fread(buffer, 1, size, (FILE*) file);
}

/// Seeks to a point in a previously opened file.
/// @param file The handle of the file to seek.
/// @param offset The number of bytes to seek.
/// @param origin One of either SEEK_SET (seek from the beginning of the file), SEEK_END (seek from the end of the file) or SEEK_CUR (seek from the current file position).
/// @return True if the operation completed successfully, false otherwise.
bool DKRmlFile::Seek(Rml::FileHandle file, long offset, int origin){
	DKDEBUGFUNC(file, offset, origin);
	return fseek((FILE*) file, offset, origin) == 0;
}

/// Returns the current position of the file pointer.
/// @param file The handle of the file to be queried.
/// @return The number of bytes from the origin of the file.
size_t DKRmlFile::Tell(Rml::FileHandle file){
	DKDEBUGFUNC(file);
	return ftell((FILE*) file);
}
