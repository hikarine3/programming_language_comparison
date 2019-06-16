let example_array = new Map( [ ["January", 1], ["December", 12], ["March", 3] ].sort((a, b) => {a = a[1]; b = b[1]; return a - b;}) );
for (let [key, value] of example_array.entries()) {
  console.log(key + ' => ' + value);
}
