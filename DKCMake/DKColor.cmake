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


# https://en.wikipedia.org/wiki/ANSI_escape_code#Colors
# 
# ←[0m←[37m     if these kinda symbols show up, escape characters are removed and color is not working 

string(ASCII 27 ESC)
set(CLR         "${ESC}[0m")    #reset color
set(ColourBold  "${ESC}[1m")

# Regular Colors
set(black        "${ESC}[30;100m")
set(red          "${ESC}[31m") # error
set(green        "${ESC}[32m")
set(yellow       "${ESC}[33m") # warn
set(blue         "${ESC}[34m") # debug
set(magenta      "${ESC}[35m") # command
set(cyan         "${ESC}[36m") 
set(white        "${ESC}[37m") # info

# Bold
set(B_black      "${ESC}[1;30m")
set(B_red        "${ESC}[1;31m") # assert
set(B_green      "${ESC}[1;32m")
set(B_yellow     "${ESC}[1;33m")
set(B_blue       "${ESC}[1;34m")
set(B_magenta    "${ESC}[1;35m")
set(B_cyan       "${ESC}[1;36m")
set(B_white      "${ESC}[1;37m")

# High Intensity
set(H_black      "${ESC}[0;90m")
set(H_red        "${ESC}[0;91m")
set(H_green      "${ESC}[0;92m")
set(H_yellow     "${ESC}[0;93m")
set(H_blue       "${ESC}[0;94m")
set(H_magenta    "${ESC}[0;95m")
set(H_cyan       "${ESC}[0;96m")
set(H_white      "${ESC}[0;97m")

# High Intensity Bold
set(HB_black     "${ESC}[1;90m")
set(HB_red       "${ESC}[1;91m")
set(HB_green     "${ESC}[1;92m")
set(HB_yellow    "${ESC}[1;93m")
set(HB_blue      "${ESC}[1;94m")
set(HB_magenta   "${ESC}[1;95m")
set(HB_cyan      "${ESC}[1;96m")
set(HB_white     "${ESC}[1;97m")

# Underline
set(U_black      "${ESC}[4;30;100m")
set(U_red        "${ESC}[4;31m")
set(U_green      "${ESC}[4;32m")
set(U_yellow     "${ESC}[4;33m")
set(U_blue       "${ESC}[4;34m")
set(U_magenta    "${ESC}[4;35m")
set(U_cyan       "${ESC}[4;36m")
set(U_white      "${ESC}[4;37m")

# Background
set(BG_black     "${ESC}[40m")
set(BG_red       "${ESC}[41m")
set(BG_green     "${ESC}[30;42m")
set(BG_yellow    "${ESC}[30;43m")
set(BG_blue      "${ESC}[44m")
set(BG_magenta   "${ESC}[45m")
set(BG_cyan      "${ESC}[30;46m")
set(BG_white     "${ESC}[30;47m")

 # High Intensity background
set(HBG_black    "${ESC}[0;30;100m")
set(HBG_red      "${ESC}[0;30;101m")
set(HBG_green    "${ESC}[0;30;102m")
set(HBG_yellow   "${ESC}[0;30;103m")
set(HBG_blue     "${ESC}[0;30;104m")
set(HBG_magenta  "${ESC}[0;30;105m")
set(HBG_cyan     "${ESC}[0;30;106m")
set(HBG_white    "${ESC}[0;30;107m")

# Style Chart
set(ESC_0    "${ESC}[0;37m")
set(ESC_1    "${ESC}[1;37m")
set(ESC_2    "${ESC}[2;37m")
set(ESC_3    "${ESC}[3;37m")
set(ESC_4    "${ESC}[4;37m")
set(ESC_5    "${ESC}[5;37m")
set(ESC_6    "${ESC}[6;37m")
set(ESC_7    "${ESC}[7;37m")
set(ESC_8    "${ESC}[8;37m")
set(ESC_9    "${ESC}[9;37m")
set(ESC_10   "${ESC}[10;37m")
