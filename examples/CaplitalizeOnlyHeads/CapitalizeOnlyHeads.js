class CapitalizeOnlyHeads {
	constructor(opt) {
	}
	convert(str = "") {
		return str.split(' ').map(word => word.charAt(0).toUpperCase() + word.slice(1)).join(' ');
  }
};
module.exports = CapitalizeOnlyHeads;

if(!module.parent) {
  let capitalizer = new CapitalizeOnlyHeads();
  const str = " can you caplitalize?";
	console.log(capitalizer.convert(str));
}