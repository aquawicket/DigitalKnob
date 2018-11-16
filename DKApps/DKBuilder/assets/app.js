window.addEventListener('error', function(e){
    var errorText = [
        e.message + '\n',
        'URL: ' + e.filename,
        'Line: ' + e.lineno + ', Column: ' + e.colno,
        'Stack: ' + (e.error && e.error.stack || '(no stack trace)')
    ].join('\n');
	console.error(errorText);
});

DKDuktape_Create("DKBuild/DKBuildConsole.js");
//DKCreate("DKUpdate");