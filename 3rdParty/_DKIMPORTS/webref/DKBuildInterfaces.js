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
	fs.unlinkSync('temp.txt')
}
  


// set directoryPath
const directoryPath = path.join(__dirname, '/ed/idlnames');

var interfaces = {}

var files = fs.readdirSync(directoryPath);

files.forEach(file => {
	let fileStat = fs.statSync(directoryPath + '/' + file).isDirectory();
	if(!fileStat) {
		var filepath = directoryPath+'/'+file
		var interface = file.slice(0, -4);

		var data = fs.readFileSync(filepath, 'utf-8')
		const lines = data.split('\n')
		for (let line of lines){
				if(!line.includes('interface'))
					continue;
				if(!line.includes(interface))
					continue;
				if(line.includes(':'))
					continue;
				if(line.includes('partial'))
					continue;
				if(line.includes('mixin'))
					continue;
				if(line.includes('//'))
					continue;
				if(line.includes('*'))
					continue;
				
				interfaces[interface] = {};	
			}
	}
});


var interfaces_string = JSON.stringify(interfaces);
console.log("interfaces_string = "+interfaces_string)


