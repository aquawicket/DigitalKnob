console.log("////// DKBuildInterfaces.js //////\n");

const path = require('path');
const fs = require('fs');

// remove temp.txt
fs.unlink('temp.txt', (err) => {
	if (err) throw err;
	//console.log('temp.txt was deleted');
}); 


// set directoryPath
const directoryPath = path.join(__dirname, '/ed/idlnames');

//passsing directoryPath and callback function
fs.readdir(directoryPath, function (err, files) {
    if (err) {
        return console.log('Unable to scan directory: ' + err);
    } 
    files.forEach(function (file) {
        console.log(file); 
		fs.appendFile("temp.txt", file+"\n", (err) => {
			if (err) console.log(err);
			//console.log("Successfully Written to File.");
		});
    });
});
