#pragma once
#ifndef dk_copy_h
#define dk_copy_h

#include "DK.h"
#include "dk_info.h"
#include "dk_pathExists.h"
#include "dk_error.h"
#include "dk_delete.h"
#include "dk_dirname.h"
#include "dk_makeDirectory.h"
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <stdbool.h>

//################################################################################
//# dk_copy()
//#
int dk_copy(char* _from_, char* _to_, bool OVERWRITE){
	
	dk_info("Copying %s _to_ %s\n", _from_, _to_);
	if(dk_pathExists(_from_) != 0){ dk_error("dk_copy: %s not found\n", _from_); }
	
	if(dk_pathExists(_to_) == 1){
        if(OVERWRITE != true){
            dk_error("dk_copy Cannot copy file. Destiantion already exists and OVERWRITE is not set");
        }
        dk_delete(_to_);
    }
	
	// the base directory of the %_to_% path must exist.
	char* _dirname_;
    dk_dirname(_to_, _dirname_);
    dk_makeDirectory(_dirname_);
	
	//###### C copy file code ######
	//### https://stackoverflow.com/a/2180788
    int fd_to, fd_from;
    char buf[4096];
    ssize_t nread;
    int saved_errno;

    fd_from = open(_from_, O_RDONLY);
    if (fd_from < 0)
        return -1;

    fd_to = open(_to_, O_WRONLY | O_CREAT | O_EXCL, 0666);
    if (fd_to < 0)
        goto out_error;

    while (nread = read(fd_from, buf, sizeof buf), nread > 0) {
        char *out_ptr = buf;
        ssize_t nwritten;

        do {
            nwritten = write(fd_to, out_ptr, nread);

            if (nwritten >= 0){
                nread -= nwritten;
                out_ptr += nwritten;
            }
            else if (errno != EINTR)
            {
                goto out_error;
            }
        } while (nread > 0);
    }

    if (nread == 0) {
        if (close(fd_to) < 0) {
            fd_to = -1;
            goto out_error;
        }
        close(fd_from);

        /* Success! */
        return 0;
    }

  out_error:
    saved_errno = errno;

    close(fd_from);
    if (fd_to >= 0)
        close(fd_to);

    errno = saved_errno;
    return -1;	
};


#endif //dk_copy_h