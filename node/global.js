const path = require("path");
console.log(__dirname)
console.log(__filename)
console.log(`This is the file name ${path.basename(__filename)}`);

console.log(process.pid);
console.log(process.versions.node);
console.log(process.argv);