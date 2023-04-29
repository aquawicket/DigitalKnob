console.log("////// DKBuildInterfaces.js //////\n");

const glob = require("glob");

glob("*.js", (error, filesWithJs)=>{
  if(error){
    console.log(error)
  }
  console.log(filesWithJs)
}