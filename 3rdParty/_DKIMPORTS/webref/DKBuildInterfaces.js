console.log("////// DKBuildInterfaces.js //////\n");

const glob = require("glob");
const fs = require("fs");

glob("*.js", (error, filesWithJs)=>{
  if(error){
    console.log(error)
  }
  console.log(filesWithJs)
}
