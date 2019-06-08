class Human
    def initialize(opt)
        @name = opt["name"]
        @sex = opt["sex"]
    end

    def sayName
        puts "My name is " + @name.to_s
    end

    def saySex
        puts "My sex is " + @sex.to_s
    end
end

if $0 == __FILE__
    person1 = Human.new({"name" => "FirstName LastName", "sex" => "male"})
    person1.sayName
    person1.saySex
end
