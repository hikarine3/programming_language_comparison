import Human from '../human_class/Human.mjs';
export default class Doctor extends Human {
	constructor(opt) {
		super(opt);
        this.specialty = opt["specialty"];
    }

	saySpecialty() {
        console.log("My specialty is " + this.specialty);
    }
}

if(!module.parent) {
    let doctor1 = new Doctor({"name":"FirstName LastName", "sex":"male", "specialty":"cardiology"});
    doctor1.sayName();
    doctor1.saySex();
    doctor1.saySpecialty();
}
