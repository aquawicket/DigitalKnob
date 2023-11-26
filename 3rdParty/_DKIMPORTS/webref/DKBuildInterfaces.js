console.log("////// DKBuildInterfaces.js //////\n");

const path = require('path');
const fs = require('fs');


if (fs.existsSync('temp.txt')) {
	fs.unlinkSync('temp.txt')
}
  


// set directoryPath
const directoryPath = path.join(__dirname, '/ed/idlnames');

var interfaces = {}

var files = fs.readdirSync(directoryPath);

// add base interfaces
files.forEach(file => {
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
		
		// remove file from array
		const index = files.indexOf(file);
		if (index > -1) { // only splice array when item is found
			files.splice(index, 1); // 2nd parameter means remove one item only
		}
	}
});

// add inherited interfaces
files.forEach(file => {
	var filepath = directoryPath+'/'+file
	var interface = file.slice(0, -4);

	var data = fs.readFileSync(filepath, 'utf-8')
	const lines = data.split('\n')
	for (let line of lines){
		if(!line.includes('interface'))
			continue;
		if(!line.includes(interface))
			continue;
		if(!line.includes(':'))
			continue;	

		// get the parent name
		let start = line.indexOf(":");
		let end = line.indexOf("{");
		let parent = line.substring(start+2, end-1);
		
		//console.log('['+parent+']')
		if(!interfaces[parent])
			continue;
		
		

		interfaces[parent][interface] = {};	
		
		
		

		
		// remove file from array
		const index = files.indexOf(file);
		if (index > -1) { // only splice array when item is found
			files.splice(index, 1); // 2nd parameter means remove one item only
		}
	}
});

/*	
for (const [key, value] of Object.entries(interfaces)) {
	console.log(`${key}: ${value}`);
}
*/


var interfaces_string = JSON.stringify(interfaces);
console.log("interfaces_string = "+interfaces_string)


