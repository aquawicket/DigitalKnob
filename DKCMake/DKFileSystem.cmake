# This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
#
# For the latest information, see https://github.com/aquawicket/DigitalKnob
#
# Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files(the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions :
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
include_guard()
message(STATUS "****** LOADING: ${CMAKE_CURRENT_LIST_FILE} ******")


#     dk.filesystem.js - %DIGITALKNOB_DIR%/Development/Api/filesystem/filesystem.js
#    dk.filesystem.cpp - %DIGITALKNOB_DIR%/Development/Api/filesystem/filesystem.cpp
#   DKBatch filesystem - %DIGITALKNOB_DIR%/DKBatch/filesystem
#    DKBash filesystem - %DIGITALKNOB_DIR%/DKBash/filesystem
#   DKCMake filesystem - %DIGITALKNOB_DIR%/DKCMake/filesystem/DKFileSystem.cmake
#      javascript FSAA - https://developer.mozilla.org/en-US/docs/Web/API/filesystem
#       Php filesystem - https://www.php.net/manual/en/book.filesystem.php
#    NodeJS filesystem - https://nodejs.org/api/fs.html
#      std::filesystem - https://en.cppreference.com/w/cpp/filesystem
#    boost::filesystem - https://www.boost.org/doc/libs/1_34_1/libs/filesystem/doc/index.htm#:~:text=The%20Boost%20filesystem%20Library%20provides,operations%20from%20within%20C%2B%2B%20programs
#       Win 32 FileApi - https://docs.microsoft.com/en-us/windows/win32/api/fileapi/
#   Android filesystem - https://developer.android.com/reference/java/nio/file/filesystem
#    Apple File System - https://developer.apple.com/documentation/foundation/file_system
#   Apple NSfilesystem - https://developer.apple.com/documentation/foundation/nsfilemanager
# Liunx GNU filesystem - https://www.gnu.org/software/libc/manual/html_node/File-System-Interface.html
#           CMake File - https://cmake.org/cmake/help/latest/command/file.html
