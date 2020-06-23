const example_array = {1:"January", 12:"December", 3:"March"};
var keys=[];
for(var key in example_array) {
  keys.push(key);
}
keys.sort((a,b)=>{return b-a;});
for(var key of keys) {
  console.log(key + " => " + example_array[key]);
}