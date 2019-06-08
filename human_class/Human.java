// javac -d . Human.java;
// java jp.co.firstclass.Human;
// package jp.co.firstclass;
import java.util.*;

public class Human {
    private String name;
    private String sex;

    public Human(Map<String, String> opt){
        this.name = opt.get("name");
        this.sex = opt.get("sex");
    }

    public void sayName() {
        System.out.println("My name is " + this.name);
    }

    public void saySex() {
        System.out.println("My sex is " + this.sex);
    }

    public static void main(String args[]) {
        Map<String, String> opt = new HashMap<String, String>();
        opt.put("name", "FirstName LastName");
        opt.put("sex", "male");
        Human human = new Human(opt);
        human.sayName();
        human.saySex();
    }
}
