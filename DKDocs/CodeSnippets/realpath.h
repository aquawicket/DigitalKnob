#ifndef MY_REALPATH_H_
#define MY_REALPATH_H_

// https://insanecoding.blogspot.com/2007/11/implementing-realpath-in-c.html

void relative_dir_base_split(const std::string& path, std::string& dir, std::string& base){
  std::string::size_type slash_pos = path.rfind("/"); //Find the last slash
  if (slash_pos != std::string::npos) //If there is a slash
  {
    slash_pos++;
    dir = path.substr(0, slash_pos); //Directory is before slash
    base = path.substr(slash_pos); //And obviously, the file is after
  }
  else //Otherwise, there is no directory present
  {
    dir.clear(); 
    base = path;
  }
}

bool chdir_getcwd(const std::string& dir, std::string& path){
  bool success = false;
  int start_fd = open(".", O_RDONLY); //Open current directory so we can save a handle to it
  if (start_fd != -1)
  {
    if (!chdir(dir.c_str())) //Change to directory
    {
      success = getcwd(path); //And get its path
      fchdir(start_fd); //And change back of course
    }
    close(start_fd);
  }
  return(success);
}

static inline bool realpath_file(const std::string& path, std::string& resolved_path){
	bool success = false;
	std::string dir;
	std::string base;
	relative_dir_base_split(path, dir, base);

	//If there is a directory, get the realpath() for it, otherwise the current directory
	if (dir.size() ? chdir_getcwd(dir, resolved_path) : getcwd(resolved_path)){
		resolved_path += base;
		success = true;
	}
	  return(success);
}

bool readlink_internal(const std::string& path, std::string& buffer, ssize_t length)
{
  bool success = false;
  if (length > 0)
  {
    char *buf = new(nothrow) char[length+1]; //Room for Null
    if (buf)
    {
      ssize_t amount = ::readlink(path.c_str(), buf, length+1); //Give room for failure
      if ((amount > 0) && (amount <= length)) //If > length, it was modified mid check
      {
        buf[amount] = 0;
        buffer = buf;
        success = true;
      }
      delete[] buf;
    }
  }
  return(success);
}


void build_path_base_swap(std::string &path, const std::string& newbase)
{
  string dir;
  string base;
  relative_dir_base_split(path, dir, base);

  if (dir.size())
  {
    path = dir + newbase;
  }
  else
  {
    path = newbase;
  }
}

bool symlink_resolve(const std::string& start, std::string& end)
{
  typedef std::pair<dev_t, ino_t> file_id;

  bool success = false;
  if (start.size())
  {
    std::string path = start; //Need a modifyable copy
    struct stat sb;
    std::set<file_id> seen_links;

    bool resolved_link;
    do //The symlink resolve loop
    {
      resolved_link = false;
      if (!lstat(path.c_str(), &sb))
      {
        file_id current_id(sb.st_dev, sb.st_ino);
        if (seen_links.find(current_id) == seen_links.end()) //Not a link we've seen
        {
          seen_links.insert(current_id); //Add to our set

          if (S_ISLNK(sb.st_mode)) //Another link
          {
            std::string newpath;
            if (readlink_internal(path, newpath, sb.st_size))
            {
              if (newpath[0] == '/') //Absolute
              {
                path = newpath;
              }
              else //We need to calculate the relative path in relation to the current
              {
                build_path_base_swap(path, newpath);
              }
              resolved_link = true;
            } //Else, Link can't be read, time to quit
          }
          else //Yay, it's not a link! got to the last part finally!
          {
            success = realpath_file(path, end);
          }
        } //Else, Nice try, someone linked a link back into a previous link during the scan to try to trick us into an infinite loop
      } //Else, Dangling link, can't resolve
    } while (resolved_link);
  }
  return(success);
}

bool realpath(const std::string& path, std::string& resolved_path, bool resolve_link = true)
{
  bool success = false;
  if (path.size())
  {
    struct stat sb;
    if (!stat(path.c_str(), &sb))
    {
      bool (*rp)(const std::string&, std::string&) = resolve_link ? symlink_resolve : realpath_file;
      success = S_ISDIR(sb.st_mode) ? chdir_getcwd(path, resolved_path) : rp(path, resolved_path);
    }
  }
  return(success);
}


#endif //MY_REALPATH_H_