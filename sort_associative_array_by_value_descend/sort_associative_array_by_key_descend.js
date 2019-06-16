const example_array = [ ["January", 1], ["December", 12], ["March", 3] ];
const sorted_array = new Map( example_array.sort((a, b) => {a = a[1]; b = b[1]; return b - a;}) );
for (const [key, value] of sorted_array.entries()) {
  console.log(key + ' => ' + value);
}
