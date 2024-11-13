/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2024 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

// called from index.html

//var url = "DKWebTest/index.html"
//var url = "DKCodeRunner/index.html"
//var url = "DKCodeRunner.html"
//location.href = url
var globalThis = (function () {  
    return this || (1, eval)('this');  
}());  

var MyApp = function() {};
var myapp = new MyApp;

myapp.loadFiles = function myapp_loadFiles() {
	//alert("myapp_loadFiles()");
	
	DKPlugin("DK/DKTrace.js", "singleton")
    DKPlugin("DK/DKErrorHandler.js", "singleton")
    DKPlugin("DK/DKPhp.js", "singleton")
    DKPlugin("DK/DKJson.js", "singleton")
    DKPlugin("DKFile/DKFile.js", "singleton")
    //DKPlugin("DK/DKValidate.js", "singleton")
    DKPlugin("DK/DKTime.js", "singleton")
    //DKPlugin("DK/DKMqtt.js")
    //DKPlugin("DK/DKNotifications.js")
    DKPlugin("DKDebug/DKDebug.js", "singleton")
    DKPlugin("DKAudio/DKAudio.js")
    DKPlugin("DKGui/DKConsole.js", "singleton")
    DKPlugin("DKGui/DKGui.js", "singleton")
    DKPlugin("DKGui/DKFrame.js")
    //DKPlugin("DKGui/DKMenu.js")
    DKPlugin("DKGui/DKMessageBox.js")
    DKPlugin("DKGui/DKDrag.js")
    //DKPlugin("DKGui/DKResize.js")
    DKPlugin("DKGui/DKClipboard.js", "singleton")
    DKPlugin("DKGui/DKTable.js")
    DKPlugin("DKDevTools/DKDevToolsButton.js", "singleton")
    DKPlugin("DKChart/DKChart.js")
    //DKPlugin("DKCodeMirror/DKCodeMirror.js")
    DKPlugin("DKTasmota/DKTasmota.js", "singleton")
    DKPlugin("DKTasmota/Automation.js")
    //DKPlugin("DKTasmota/VPDCalculator.js")
    DKPlugin("DKTasmota/Chart.js")
}
myapp.loadFiles();

myapp.loadApp = function myapp_loadApp() {
	alert("myapp_loadApp()");
}