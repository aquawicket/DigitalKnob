console.log("////// DKBuildInterfaces.js //////\n");

const path = require('path');
const fs = require('fs');

/*
const readline = require('readline');
async function processLineByLine(file) {
	console.log('\n//////'+file)
  const fileStream = fs.createReadStream(file);

  const rl = readline.createInterface({
    input: fileStream,
    crlfDelay: Infinity
  });
  // Note: we use the crlfDelay option to recognize all instances of CR LF
  // ('\r\n') in input.txt as a single line break.

  for await (const line of rl) {
    // Each line in input.txt will be successively available here as `line`.
    console.log(`Line from file: ${line}`);
  }
}
*/



if (fs.existsSync('temp.txt')) {
    // remove temp.txt
	fs.unlink('temp.txt', (err) => {
		if (err) throw err;
		//console.log('temp.txt was deleted');
	}); 
}
  



// set directoryPath
const directoryPath = path.join(__dirname, '/ed/idlnames');

//passsing directoryPath and callback function
fs.readdir(directoryPath, function (err, files) {
    if (err) {
        return console.log('Unable to scan directory: ' + err);
    } 
    files.forEach(function (file) {
		var filepath = directoryPath+'/'+file
        
		/*
		fs.appendFile("temp.txt", file+"\n", (err) => {
			if (err) console.log(err);
			//console.log("Successfully Written to File.");
		});
		*/
		
		// print file lines
		fs.readFile(filepath, 'utf-8', (err, data) => {
			console.log('\n////// '+file+' //////'); 
			const lines = data.split('\n')
			for (let line of lines)
				console.log(line)
		});
    });
});
