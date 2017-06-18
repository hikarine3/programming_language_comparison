// javac -d . Human.java;
// java jp.co.firstclass.Human;

package jp.co.firstclass;

public class Human {
    private String name;
    private String sex;

    public Human(String name, String sex){
	this.name = name;
	this.sex = sex;
    }

    public void sayName() {
        System.out.println("My name is " + this.name);
    }

    public void saySex() {
        System.out.println("My sex is " + this.sex);
    }

    public static void main(String args[]) {
        Human human = new Human("FirstName LastName", "Male");
	human.sayName();
	human.saySex();
    }
}
