#include "DK/stdafx.h"
#include <iostream>
#include <fcntl.h>
#include <sstream>
#include <fstream>
#include <archive.h>
#include <archive_entry.h>
#include "DK/DKFile.h"
#include "DKArchive/DKArchive.h"

//////////////////////
bool DKArchive::Init()
{
	DKClass::DKCreate("DKArchiveJS");
	return true;	
}

///////////////////////////////////////////////////////////////////
bool DKArchive::Extract(const DKString& file, const DKString& path)
{
	DKLog("DKArchive::Extract("+file+","+path+")\n", DKDEBUG);
	
	if(!DKFile::PathExists(file)){ return false; }

	DKLog("Extracting "+file+" . . .\n");
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
	if ((r = archive_read_open_filename(a, file.c_str(), 10240))){
		DKLog("r = archive_read_open_filename(a, file.c_str(), 10240)",DKERROR);    
		return false;
	}
     
	for(;;){
		r = archive_read_next_header(a, &entry);
        if(r == ARCHIVE_EOF)
			break;
        if(r != ARCHIVE_OK)
			fprintf(stderr, "%s\n", archive_error_string(a));
		if(r < ARCHIVE_WARN){
			DKLog("r < ARCHIVE_WARN ",DKERROR);  
			return false;
		}
        r = archive_write_header(ext, entry);
        if(r != ARCHIVE_OK)
			fprintf(stderr, "%s\n", archive_error_string(ext));
        else if (archive_entry_size(entry) > 0) {
			copy_data(a, ext);
			if(r != ARCHIVE_OK)
				fprintf(stderr, "%s\n", archive_error_string(ext));
			if(r < ARCHIVE_WARN){
				DKLog("r < ARCHIVE_WARN",DKERROR);    
				return false;
			}
		}
		r = archive_write_finish_entry(ext);
		if(r != ARCHIVE_OK)
			fprintf(stderr, "%s\n", archive_error_string(ext));
		if(r < ARCHIVE_WARN){
			DKLog("r < ARCHIVE_WARN",DKERROR);    
			return false;
		}
	}
    
	archive_read_close(a);
#if !defined(MAC) && !defined(IOS)
    archive_read_free(a);
#endif
    archive_write_close(ext);
#if !defined(MAC) && !defined(IOS)
    archive_write_free(ext);
#endif

	DKLog("Extract Complete: "+file+"\n");
    return true;
}

////////////////////////////////////////////////////////////////////
bool DKArchive::Compress(const DKString& path, const DKString& file)
{
	DKLog("DKArchive::Compress("+path+","+file+")\n", DKDEBUG);
	
	if(!DKFile::PathExists(path)){ return false; }
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
			//DKLog("DKArchive::Compress() " + _path + files[i] + " :compressing recursive not supported \n");
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
#if !defined(MAC) && !defined(IOS)
	archive_write_free(a);
#endif

	return true;
}

////////////////////////////////////////////////////////////////
int DKArchive::copy_data(struct archive *ar, struct archive *aw)
{
	//DKLog("DKArchive::copy_data(struct,struct)\n", DKDEBUG);
	
	int r;
	const void *buff;
	size_t size;
#ifndef ANDROID
#ifdef WIN32
	__int64 offset;
#else 
	off_t offset;
#endif
#else
	int64_t offset;
#endif

	for(;;){
		r = archive_read_data_block(ar, &buff, &size, &offset);
		if (r == ARCHIVE_EOF)
			return (ARCHIVE_OK);
		if (r != ARCHIVE_OK)
			return (r);
		r = archive_write_data_block(aw, buff, size, offset);
		if (r != ARCHIVE_OK) {
			DKLog("archive_write_data_block() - ",DKERROR);
			DKLog(archive_error_string(aw),DKERROR);
			return (r);
		}
	}
}