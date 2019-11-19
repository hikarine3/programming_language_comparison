const example_array = {"January":1, "December":12, "March":3};
var keys=[];
for(var key in example_array) {
  keys.push(key);
}
keys.sort((a,b)=>{return example_array[b]-example_array[a];});
for(var key of keys) {
  console.log(key + " => " + example_array[key] );
}