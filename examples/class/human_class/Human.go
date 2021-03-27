package main
import "fmt"

type Human struct{
	name string
	sex string
}

func (h *Human) sayName() {
	fmt.Println("My name is " + h.name)
}

func (h *Human) saySex() {
	fmt.Println("My sex is " + h.sex)
}

func main() {
    human := Human{name:"FirstName LastName", sex:"male"}
    human.sayName()
	human.saySex()
}
