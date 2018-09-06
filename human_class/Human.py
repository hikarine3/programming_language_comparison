class Human:
	def __init__(self, opt):
		self.name = opt["name"]
		self.sex = opt["sex"]

	def sayName(self):
		print(self.name)

	def saySex(self):
		print(self.sex)

if __name__ == "__main__":
	person1 = Human({"name":"First Last", "sex":"Male"})
	person1.sayName()
	person1.saySex()

