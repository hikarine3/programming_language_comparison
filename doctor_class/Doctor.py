import sys
sys.path.append('./human_class')
from Human import Human

class Doctor(Human):
	def __init__(self, opt):
		super(Doctor, self).__init__(opt)
		self.specialty = opt["specialty"]

	def saySpecialty(self):
		print("My specialty is " + self.specialty)

if __name__ == "__main__":
	doctor1 = Doctor({"name":"FirstName LastName", "sex":"male", "specialty":"cardiology"})
	doctor1.sayName()
	doctor1.saySex()
	doctor1.saySpecialty()
