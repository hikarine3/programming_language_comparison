/*
Human.class must be compiled earlier and must be put in the path of environmental value CLASSPATH=... or in same directory
*/
import java.util.*;
class Doctor extends Human{
    private String specialty;

    public Doctor(Map<String, String> opt){
        super(opt);
        this.specialty = opt.get("specialty");
    }

    public void saySpecialty() {
        System.out.println("My specialty is " + this.specialty);
    }

    public static void main(String args[]) {
        Map<String, String> opt = new HashMap<String, String>();
        opt.put("name", "FirstName LastName");
        opt.put("sex", "male");
        opt.put("specialty", "cardiology");
        Doctor doctor1 = new Doctor(opt);
        doctor1.sayName();
        doctor1.saySex();
        doctor1.saySpecialty();
    }
}