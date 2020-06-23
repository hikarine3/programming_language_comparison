class Human:
	def __init__(self, opt):
		self.name = opt["name"]
		self.sex = opt["sex"]

	def sayName(self):
		print("My name is " + self.name)

	def saySex(self):
		print("My sex is " + self.sex)

if __name__ == "__main__":
	person1 = Human({"name":"FirstName LastName", "sex":"male"})
	person1.sayName()
	person1.saySex()

