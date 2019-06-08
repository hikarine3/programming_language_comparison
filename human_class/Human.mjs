export default class Human {
	constructor(opt) {
		this.name = opt["name"];
        this.sex = opt["sex"];
    }

	sayName() {
		console.log("My name is " + this.name);
    }

	saySex() {
		console.log("My sex is " + this.sex);
    }
};

if(!module.parent) {
	let human1 = new Human({"name":"FirstName LastName", "sex":"male"});
	human1.sayName();
	human1.saySex();
}