/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2022 Digitalknob Team, and contributors
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

//WARNING_DISABLE
#include <iostream>
#include <fcntl.h>
#include <sstream>
#include <fstream>
#include <archive.h>
#include <archive_entry.h>
// WARNING_ENABLE

#include "DK/DKFile.h"
#include "DKArchive/DKArchive.h"

bool DKArchive::Init(){
	DKDEBUGFUNC();
	DKClass::DKCreate("DKArchiveJS");
	DKClass::DKCreate("DKArchiveV8");
	return true;
}

bool DKArchive::End(){
	DKDEBUGFUNC();
	DKClass::DKClose("DKArchiveJS");
	DKClass::DKClose("DKArchiveV8");
	return true;
}

bool DKArchive::Extract(const DKString& file, const DKString& path){
	DKDEBUGFUNC(file, path);
	if(!DKFile::PathExists(file))
		return DKERROR("path does not exist ("+file+")\n");
	DKINFO("Extracting "+file+" . . .\n");
	DKFile::MakeDir(path);
	DKFile::ChDir(path);
    struct archive *a;
    struct archive *ext;
    struct archive_entry *entry;
    int flags;
    int r;
    /* Select which attributes we want to restore. */
    flags = ARCHIVE_EXTRACT_TIME;
    flags |= ARCHIVE_EXTRACT_PERM;
    flags |= ARCHIVE_EXTRACT_ACL;
    flags |= ARCHIVE_EXTRACT_FFLAGS;
    //flags |= ARCHIVE_EXTRACT_NO_OVERWRITE;
    //flags |= ARCHIVE_EXTRACT_NO_OVERWRITE_NEWER;
    a = archive_read_new();
	archive_read_support_format_all(a);
#if !defined(MAC) && !defined(IOS)
	archive_read_support_filter_all(a);
#endif
    ext = archive_write_disk_new();
    archive_write_disk_set_options(ext, flags);
    archive_write_disk_set_standard_lookup(ext);
	if ((/*r = */archive_read_open_filename(a, file.c_str(), 10240)))
		return DKERROR("r = archive_read_open_filename(a, file.c_str(), 10240)");    
	for(;;){
		r = archive_read_next_header(a, &entry);
        if(r == ARCHIVE_EOF)
			break;
        if(r != ARCHIVE_OK)
			return DKERROR("!ARCHIVE_OK: "+toString(archive_error_string(a))+"\n");
		if(r < ARCHIVE_WARN)
			return DKERROR("r < ARCHIVE_WARN: "+toString(archive_error_string(a))+"\n");  
        r = archive_write_header(ext, entry);
        if(r != ARCHIVE_OK){
			return DKERROR("!ARCHIVE_OK: "+toString(archive_error_string(ext))+"\n");
		}
        else if (archive_entry_size(entry) > 0) {
			copy_data(a, ext);
			if(r != ARCHIVE_OK)
				return DKERROR("!ARCHIVE_OK: "+toString(archive_error_string(ext))+"\n");
			if(r < ARCHIVE_WARN)
				return DKERROR("r < ARCHIVE_WARN "+toString(archive_error_string(ext))+"\n");
		}
		r = archive_write_finish_entry(ext);
		if(r != ARCHIVE_OK)
			return DKERROR("!ARCHIVE_OK: "+toString(archive_error_string(ext))+"\n");
		if(r < ARCHIVE_WARN)
			return DKERROR("r < ARCHIVE_WARN "+toString(archive_error_string(ext))+"\n");
	}
	archive_read_close(a);
#if !defined(MAC) && !defined(IOS)
    archive_read_free(a);
#endif
    archive_write_close(ext);
#if !defined(MAC) && !defined(IOS)
    archive_write_free(ext);
#endif
    return DKINFO("Extract Complete: "+file+"\n");
}

bool DKArchive::Compress(const DKString& path, const DKString& file){
	DKDEBUGFUNC(path, file);

#	ifdef ANDROID
		return DKERROR("not implemented on Android\n")
#	endif //ANDROID

	if(!DKFile::PathExists(path))
		return DKERROR("path does not exist ("+path+")\n");
	DKStringArray files;
	DKString _path;
	if(DKFile::IsDirectory(path)){
		_path = path +"/";
		DKFile::GetDirectoryContents(path, files);
	}
	else{
		DKFile::GetFilePath(path, _path);
		DKString filename;
		DKFile::GetFileName(path, filename);
		files.push_back(filename);
	}
	struct archive *a;
	struct archive_entry *entry;
	struct stat st;
	std::ifstream input;
	a = archive_write_new();
	archive_write_set_compression_none(a);
	archive_write_set_format_zip(a);
	archive_write_open_filename(a, file.c_str());
	for(unsigned int i=0; i<files.size(); ++i){
		if(DKFile::IsDirectory(_path+files[i])){
			DKStringArray subfiles;
			DKFile::GetDirectoryContents(_path+files[i], subfiles);
			for (unsigned int s = 0; s < subfiles.size(); ++s){
				files.push_back(files[i]+"/"+subfiles[s]);
			}
			//DKINFO(_path + files[i] + " :compressing recursive not supported\n");
			continue; //can't compress inner folders at the moment
		} 
		stat((_path+files[i]).c_str(), &st);
		entry = archive_entry_new(); 
		archive_entry_set_pathname(entry, files[i].c_str());
		//archive_entry_copy_stat(entry, &st);
		archive_entry_set_size(entry, st.st_size);
		archive_entry_set_filetype(entry, AE_IFREG);
		archive_entry_set_perm(entry, 0644);
		archive_write_header(a, entry);
		input.open((_path+files[i]).c_str(), std::ios::binary);
		// get length of file:
		input.seekg (0, input.end);
		long long length = input.tellg();
		input.seekg (0, input.beg);
		char* buffer = new char [(unsigned long)length];
		input.read(buffer, length);
		archive_write_data(a, buffer, (unsigned int)length);
		input.close();
		archive_entry_free(entry);
	}
	archive_write_close(a);
#	if !defined(MAC) && !defined(IOS)
		archive_write_free(a);
#	endif //!defined(MAC) && !defined(IOS)
	return true;
}

int DKArchive::copy_data(struct archive* ar, struct archive* aw){
	//DKDEBUGFUNC(ar, aw);	
	la_ssize_t r;
	const void *buff;
	size_t size;
//#ifndef ANDROID
//#ifdef WIN32
//	__int64 offset;
//#endif 
//#ifdef RASPBERRY
//	long long int offset; //Fix for Raspberry Pi
//#elif defined(LINUX)
//	long int offset; //Lubuntu Linux64
//#endif
//FIXME: These were left where without notes. Mac or iPhone maybe
//#ifdef WHICH_OS
	//off_t offset;
	int64_t offset;
//#endif
//#endif
	for(;;){
		r = archive_read_data_block(ar, &buff, &size, &offset);
		if (r == ARCHIVE_EOF)
			return (ARCHIVE_OK);
		if (r != ARCHIVE_OK)
			return (r);
		r = archive_write_data_block(aw, buff, size, offset);
		if (r != ARCHIVE_OK) {
			DKERROR("archive_write_data_block() - "+DKString(archive_error_string(aw)));
			return (r);
		}
	}
}
