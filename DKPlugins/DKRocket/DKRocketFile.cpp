#include "DK/stdafx.h"
#include "DKRocketFile.h"


/////////////////////////////////////////////////////////////////////////////
Rocket::Core::FileHandle DKRocketFile::Open(const Rocket::Core::String& path)
{
	DKDEBUGFUNC("Rocket::Core::String&");
	DKString abspath = path.CString();
	if(!DKFile::VerifyPath(abspath)){
		DKERROR("DKRocketFile::Open("+abspath+") file does not exist.\n");
		return 0;
	}

	FILE* fp = fopen(abspath.c_str(), "rb");
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
