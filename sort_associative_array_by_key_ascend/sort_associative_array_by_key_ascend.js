let example_array = new Map( [ [1, "January"], [12, "December"], [3, "March"] ].sort((a, b) => {a = a[0]; b = b[0]; return a - b;}) );
for (let [key, value] of example_array.entries()) {
  console.log(key + ' => ' + value);
}
