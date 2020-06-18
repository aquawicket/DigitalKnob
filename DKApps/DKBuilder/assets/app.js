/*
window.addEventListener('error', function(e){
    var errorText = [
        e.message + '\n',
        'URL: ' + e.filename,
        'Line: ' + e.lineno + ', Column: ' + e.colno,
        'Stack: ' + (e.error && e.error.stack || '(no stack trace)')
    ].join('\n');
	console.error(errorText);
});
*/

DKCreate("DKBuild/DKBuildConsole.js", function(){});
//DKCreate("DKUpdate");