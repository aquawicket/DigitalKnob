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


###############################################################################
# dk_printColorChart()
#
#	TODO
#
macro(dk_printColorChart)
	DKDEBUGFUNC(${ARGV})
	message(" ")
	message(      "Regualar")
	message(      "${black}     black          ${CLR}")
	message(        "${red}     red            ${CLR}")
	message(      "${green}     green          ${CLR}")
	message(     "${yellow}     yellow         ${CLR}")
	message(       "${blue}     blue           ${CLR}")
	message(    "${magenta}     magenta        ${CLR}")
	message(       "${cyan}     cyan           ${CLR}")
	message(      "${white}     white          ${CLR}")
	message(" ")
	message(    "Bold")
	message(    "${B_black}     B_black        ${CLR}")
	message(      "${B_red}     B_red          ${CLR}")
	message(    "${B_green}     B_green        ${CLR}")
	message(   "${B_yellow}     B_yellow       ${CLR}")
	message(     "${B_blue}     B_blue         ${CLR}")
	message(  "${B_magenta}     B_magenta      ${CLR}")
	message(     "${B_cyan}     B_cyan         ${CLR}")
	message(    "${B_white}     B_white        ${CLR}")
	message(" ")
	message(    "High Intensity")
	message(    "${H_black}     H_black        ${CLR}")
	message(      "${H_red}     H_red          ${CLR}")
	message(    "${H_green}     H_green        ${CLR}")
	message(   "${H_yellow}     H_yellow       ${CLR}")
	message(     "${H_blue}     H_blue         ${CLR}")
	message(  "${H_magenta}     H_magenta      ${CLR}")
	message(     "${H_cyan}     H_cyan         ${CLR}")
	message(    "${H_white}     H_white        ${CLR}")
	message(" ")
	message(   "High Intensity Bold")
	message(   "${HB_black}     HB_black       ${CLR}")
	message(     "${HB_red}     HB_red         ${CLR}")
	message(   "${HB_green}     HB_green       ${CLR}")
	message(  "${HB_yellow}     HB_yellow      ${CLR}")
	message(    "${HB_blue}     HB_blue        ${CLR}")
	message( "${HB_magenta}     HB_magenta     ${CLR}")
	message(    "${HB_cyan}     HB_cyan        ${CLR}")
	message(   "${HB_white}     HB_white       ${CLR}")
	message(" ")
	message(    "Underline")
	message(    "${U_black}     U_black        ${CLR}")
	message(      "${U_red}     U_red          ${CLR}")
	message(    "${U_green}     U_green        ${CLR}")
	message(   "${U_yellow}     U_yellow       ${CLR}")
	message(     "${U_blue}     U_blue         ${CLR}")
	message(  "${U_magenta}     U_magenta      ${CLR}")
	message(     "${U_cyan}     U_cyan         ${CLR}")
	message(    "${U_white}     U_white        ${CLR}")
	message(" ")
	message(   "Background")
	message(   "${BG_black}     BG_black       ${CLR}")
	message(     "${BG_red}     BG_red         ${CLR}")
	message(   "${BG_green}     BG_green       ${CLR}")
	message(  "${BG_yellow}     BG_yellow      ${CLR}")
	message(    "${BG_blue}     BG_blue        ${CLR}")
	message( "${BG_magenta}     BG_magenta     ${CLR}")
	message(    "${BG_cyan}     BG_cyan        ${CLR}")
	message(   "${BG_white}     BG_white       ${CLR}")
	message(" ")
	message(  "High Intensity Background")
	message(  "${HBG_black}     HBG_black      ${CLR}")
	message(    "${HBG_red}     HBG_red        ${CLR}")
	message(  "${HBG_green}     HBG_green      ${CLR}")
	message( "${HBG_yellow}     HBG_yellow     ${CLR}")
	message(   "${HBG_blue}     HBG_blue       ${CLR}")
	message("${HBG_magenta}     HBG_magenta    ${CLR}")
	message(   "${HBG_cyan}     HBG_cyan       ${CLR}")
	message(  "${HBG_white}     HBG_white      ${CLR}")
	message(" ")
endmacro()


###############################################################################
# dk_printStyleChart()
#
#	TODO
#
macro(dk_printStyleChart)
	DKDEBUGFUNC(${ARGV})
	message(" ")
	message(       "Style Chart")
	message(       "${ESC_0}     ESC_0         ${CLR}")
	message(       "${ESC_1}     ESC_1         ${CLR}")
	message(       "${ESC_2}     ESC_2         ${CLR}")
	message(       "${ESC_3}     ESC_3         ${CLR}")
	message(       "${ESC_4}     ESC_4         ${CLR}")
	message(       "${ESC_5}     ESC_5         ${CLR}")
	message(       "${ESC_6}     ESC_6         ${CLR}")
	message(       "${ESC_7}     ESC_7         ${CLR}")
	message(       "${ESC_8}     ESC_8         ${CLR}")
	message(       "${ESC_9}     ESC_9         ${CLR}")
	message(      "${ESC_10}     ESC_10        ${CLR}")
endmacro()
