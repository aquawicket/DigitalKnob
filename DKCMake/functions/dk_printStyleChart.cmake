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
# The above copyright noticeand this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
include_guard()


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
