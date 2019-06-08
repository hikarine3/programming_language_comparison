require_relative "../human_class/Human.rb"

class Doctor < Human
    def initialize(opt)
        super
        @specialty = opt["specialty"]
    end

    def saySpecialty
        puts "My specialty is " + @specialty.to_s
    end
end

if $0 == __FILE__
    doctor1 = Doctor.new({"name" => "FirstName LastName", "sex" => "male", "specialty" => "cardiology"})
    doctor1.sayName
    doctor1.saySex
    doctor1.saySpecialty
end
