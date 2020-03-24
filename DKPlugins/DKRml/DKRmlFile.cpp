#include "DK/stdafx.h"
#include "DKRmlFile.h"
#include "DKRml.h"
#include "DKCurl/DKCurl.h"


/////////////////////////////////////////////////////////////////////////////
Rml::Core::FileHandle DKRmlFile::Open(const Rml::Core::String& path)
{
	DKDEBUGFUNC("Rml::Core::String&");

	DKString _url = path;//.CString();
	if(has(_url,":/")){ //could be http:// , https:// or C:/
		//absolute path
	}
	else if(has(_url,"//")){ //could be //www.site.com/style.css or //site.com/style.css
		_url = DKRml::Get()->protocol+":"+_url;
		//DKERROR("DKRml::LoadUrl(): no protocol specified\n"); //absolute path without protocol
		//return false;
	}
	else{
		_url = DKRml::Get()->_path+_url;
		//DKERROR("DKRml::LoadUrl(): cannot load relative paths\n");
		//return false;
	}

	if(has(_url,"://")){
		DKFile::MakeDir(DKFile::local_assets+"Cache");

		DKString filename;
		DKFile::GetFileName(_url, filename);

		//remove everything after ? in the filename if there is one
		int found = filename.rfind("?");
		if(found > 0){
			filename = filename.substr(0,found);
		}

		DKCurl::Get()->Download(_url, DKFile::local_assets+"Cache/"+filename);
		_url = DKFile::local_assets+"Cache/"+filename;
	}

	FILE* fp = fopen(_url.c_str(), "rb");
	return (Rml::Core::FileHandle) fp;
}

/// Closes a previously opened file.
/// @param file The file handle previously opened through Open().
///////////////////////////////////////////////////////
void DKRmlFile::Close(Rml::Core::FileHandle file)
{
	DKDEBUGFUNC(file);
	fclose((FILE*) file);
}

/// Reads data from a previously opened file.
/// @param buffer The buffer to be read into.
/// @param size The number of bytes to read into the buffer.
/// @param file The handle of the file.
/// @return The total number of bytes read into the buffer.
///////////////////////////////////////////////////////////////////////////////////
size_t DKRmlFile::Read(void* buffer, size_t size, Rml::Core::FileHandle file)
{
	DKDEBUGFUNC(buffer, size, file);
	return fread(buffer, 1, size, (FILE*) file);
}

/// Seeks to a point in a previously opened file.
/// @param file The handle of the file to seek.
/// @param offset The number of bytes to seek.
/// @param origin One of either SEEK_SET (seek from the beginning of the file), SEEK_END (seek from the end of the file) or SEEK_CUR (seek from the current file position).
/// @return True if the operation completed successfully, false otherwise.
///////////////////////////////////////////////////////////////////////////////
bool DKRmlFile::Seek(Rml::Core::FileHandle file, long offset, int origin)
{
	DKDEBUGFUNC(file, offset, origin);
	return fseek((FILE*) file, offset, origin) == 0;
}

/// Returns the current position of the file pointer.
/// @param file The handle of the file to be queried.
/// @return The number of bytes from the origin of the file.
////////////////////////////////////////////////////////
size_t DKRmlFile::Tell(Rml::Core::FileHandle file)
{
	DKDEBUGFUNC(file);
	return ftell((FILE*) file);
}
