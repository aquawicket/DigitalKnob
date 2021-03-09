#include "DK/stdafx.h"
#include "DKRocketFile.h"
#include "DKRocket.h"
#include "DKCurl/DKCurl.h"


/////////////////////////////////////////////////////////////////////////////
Rocket::Core::FileHandle DKRocketFile::Open(const Rocket::Core::String& path)
{
	DKDEBUGFUNC("Rocket::Core::String&");

	DKString _url = path.CString();
	if(has(_url,":/")){ //could be http:// , https:// or C:/
		//absolute path
	}
	else if(has(_url,"//")){ //could be //www.site.com/style.css or //site.com/style.css
		_url = DKRocket::Get()->protocol+":"+_url;
		//DKERROR("DKRocket::LoadUrl(): no protocol specified\n"); //absolute path without protocol
		//return false;
	}
	else{
		_url = DKRocket::Get()->_path+_url;
		//DKERROR("DKRocket::LoadUrl(): cannot load relative paths\n");
		//return false;
	}

	if(has(_url,"://")){
		DKFile::MakeDir(DKFile::local_assets+"/Cache");

		DKString filename;
		DKFile::GetFileName(_url, filename);

		//remove everything after ? in the filename if there is one
		int found = filename.rfind("?");
		if(found > 0){
			filename = filename.substr(0,found);
		}

		DKCurl::Get()->Download(_url, DKFile::local_assets+"/Cache/"+filename);
		_url = DKFile::local_assets+"/Cache/"+filename;
	}

	FILE* fp = fopen(_url.c_str(), "rb");
	return (Rocket::Core::FileHandle) fp;
}

/// Closes a previously opened file.
/// @param file The file handle previously opened through Open().
///////////////////////////////////////////////////////
void DKRocketFile::Close(Rocket::Core::FileHandle file)
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
size_t DKRocketFile::Read(void* buffer, size_t size, Rocket::Core::FileHandle file)
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
bool DKRocketFile::Seek(Rocket::Core::FileHandle file, long offset, int origin)
{
	DKDEBUGFUNC(file, offset, origin);
	return fseek((FILE*) file, offset, origin) == 0;
}

/// Returns the current position of the file pointer.
/// @param file The handle of the file to be queried.
/// @return The number of bytes from the origin of the file.
////////////////////////////////////////////////////////
size_t DKRocketFile::Tell(Rocket::Core::FileHandle file)
{
	DKDEBUGFUNC(file);
	return ftell((FILE*) file);
}
