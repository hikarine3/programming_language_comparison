const example_array = [ [1, "January"], [12, "December"], [3, "March"] ];
const sorted_array = new Map( example_array.sort((a, b) => {a = a[0]; b = b[0]; return a - b;}) );
for (const [key, value] of sorted_array.entries()) {
  console.log(key + ' => ' + value);
}
